#include <gb/gb.h>
#include <stdio.h>
#include "sprites/alfi.c"

void main() {
    UINT8 totalSpriteFrames = 2;
    UINT8 currSpriteFrame = 0;

    UINT16 RATE = 4190 / 2;
    UINT8 FPS = 60;
    UINT16 CURRENT_TICK = 0;

    printf("ABJECT\n");
    set_sprite_data(0, 2, alfi);
    set_sprite_tile(0, 0);
    move_sprite(0, 88, 78);
    SHOW_SPRITES;

    while (1) {
        if (CURRENT_TICK == RATE - 1) {
            currSpriteFrame = (currSpriteFrame + 1) % totalSpriteFrames;
            set_sprite_tile(0, currSpriteFrame);
        }
        move_sprite(0, CURRENT_TICK % 160, CURRENT_TICK % 144);
        CURRENT_TICK = (CURRENT_TICK + 1) % RATE;
    }
}
