#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdio.h>
#include "sprites/alfi.h"
#include "sprites/logo.h"
#include "sprites/logo_set.h"

const UWORD spritePalette[] = {
    alfiCGBPal0c0,
    alfiCGBPal0c1,
    alfiCGBPal0c2,
    alfiCGBPal0c3,
};

const UWORD bgPalette[] = {
    logo_setCGBPal0c0,
    logo_setCGBPal0c1,
    logo_setCGBPal0c2,
    logo_setCGBPal0c3
};

void main() {
    UINT8 totalSpriteFrames = 17;
    UINT8 currSpriteFrame = 0;

    int ANIM_WALK_SIDE[] = { 10, 11 };
    int* CURRENT_ANIM = ANIM_WALK_SIDE;

    UINT8 x_pos = 88;
    UINT8 y_pos = 78;

    UINT16 FPS = 15;
    UINT16 CLOCK_RATE = 4190 / 2;
    UINT16 CURRENT_TICK = 0;

    // setup background
    set_bkg_data(0, 118, logo_set);
    set_bkg_tiles(0, 0, 20, 6, logo);

    set_bkg_palette(0, 1, &bgPalette[0]);
    set_sprite_palette(0, 1, &spritePalette[0]);

    set_sprite_data(0, totalSpriteFrames, alfi);
    set_sprite_tile(0, 0);

    move_sprite(0, 88, 78);
    set_sprite_prop(0, 0);

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    while (1) {
        // get input bitfield
        int input = joypad();
        // set up input axes
        int h_axis = ((input & J_LEFT) != 0) ? -1 : ((input & J_RIGHT) != 0) ? 1 : 0;
        int v_axis = ((input & J_DOWN) != 0) ? 1 : ((input & J_UP) != 0) ? -1 : 0;

        // flip sprite based on direction
        switch(joypad()) {
            case J_LEFT:
                // facing left
                set_sprite_prop(0, S_FLIPX);
                // set anim
                if (CURRENT_ANIM != ANIM_WALK_SIDE) {
                    CURRENT_ANIM = ANIM_WALK_SIDE;
                    currSpriteFrame = CURRENT_ANIM[0];
                }
                break;
            case J_RIGHT:
                // facing right
                set_sprite_prop(0, 0);
                // set anim
                if (CURRENT_ANIM != ANIM_WALK_SIDE) {
                    CURRENT_ANIM = ANIM_WALK_SIDE;
                    currSpriteFrame = CURRENT_ANIM[0];
                }
                break;
        }

        if (CURRENT_TICK % (CLOCK_RATE / FPS) == 0) {
            int ANIM_LENGTH = sizeof(*CURRENT_ANIM) / sizeof(int);

            // int firstFrame = CURRENT_ANIM[0];
            // int lastFrame = CURRENT_ANIM[0] + (ANIM_LENGTH - 1);
            if (currSpriteFrame >= ANIM_LENGTH + 1) {
                currSpriteFrame = 0;
            }

            set_sprite_tile(0, CURRENT_ANIM[currSpriteFrame]);
            currSpriteFrame++;
        }
        
        if (CURRENT_TICK % (CLOCK_RATE / 200) == 0) {
            // move character
            x_pos += h_axis;
            y_pos += v_axis;
        }

        move_sprite(0, x_pos, y_pos);
        CURRENT_TICK = (CURRENT_TICK + 1) % CLOCK_RATE;
        // printf("tick %d", CURRENT_TICK);
    }
}
