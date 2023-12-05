;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
	.globl _bgPalette
	.globl _spritePalette
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:22: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-19
;main.c:24: UINT8 currSpriteFrame = 0;
	ldhl	sp,	#18
	ld	(hl), #0x00
;main.c:26: int ANIM_WALK_SIDE[] = { 10, 11 };
	ldhl	sp,	#2
	ld	a, #0x0a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, #0x0b
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:27: int* CURRENT_ANIM = ANIM_WALK_SIDE;
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;main.c:29: UINT8 x_pos = 88;
	ld	a, b
	ld	(hl+), a
;main.c:30: UINT8 y_pos = 78;
	ld	a, #0x58
	ld	(hl+), a
;main.c:34: UINT16 CURRENT_TICK = 0;
	ld	a, #0x4e
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:37: set_bkg_data(0, 118, logo_set);
	ld	de, #_logo_set
	push	de
	ld	hl, #0x7600
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:38: set_bkg_tiles(0, 0, 20, 6, logo);
	ld	de, #_logo
	push	de
	ld	hl, #0x614
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:40: set_bkg_palette(0, 1, &bgPalette[0]);
	ld	de, #_bgPalette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;main.c:41: set_sprite_palette(0, 1, &spritePalette[0]);
	ld	de, #_spritePalette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;main.c:43: set_sprite_data(0, totalSpriteFrames, alfi);
	ld	de, #_alfi
	push	de
	ld	hl, #0x1100
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\users\aidan\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:\users\aidan\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\users\aidan\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;c:\users\aidan\gbdk\include\gb\gb.h:1850: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x00
;main.c:49: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:50: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:51: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:53: while (1) {
00115$:
;main.c:55: int input = joypad();
	call	_joypad
	ld	c, a
;main.c:57: int h_axis = ((input & J_LEFT) != 0) ? -1 : ((input & J_RIGHT) != 0) ? 1 : 0;
	bit	1, c
	jr	Z, 00126$
	ld	de, #0xffff
	jr	00127$
00126$:
	bit	0, c
	jr	Z, 00128$
	ld	de, #0x0001
	jr	00129$
00128$:
	ld	de, #0x0000
00129$:
00127$:
	ldhl	sp,	#12
	ld	(hl), e
	inc	hl
	ld	(hl), d
;main.c:58: int v_axis = ((input & J_DOWN) != 0) ? 1 : ((input & J_UP) != 0) ? -1 : 0;
	bit	3, c
	jr	Z, 00130$
	ld	bc, #0x0001
	jr	00131$
00130$:
	bit	2, c
	jr	Z, 00132$
	ldhl	sp,	#16
	ld	(hl), #0xff
	inc	hl
	ld	(hl), #0xff
	jr	00133$
00132$:
	xor	a, a
	ldhl	sp,	#16
	ld	(hl+), a
	ld	(hl), a
00133$:
	ldhl	sp,	#16
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
00131$:
	ldhl	sp,	#14
	ld	(hl), c
	inc	hl
	ld	(hl), b
;main.c:61: switch(joypad()) {
	call	_joypad
	cp	a, #0x01
	jr	Z, 00104$
	sub	a, #0x02
	jr	NZ, 00107$
;c:\users\aidan\gbdk\include\gb\gb.h:1850: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x20
;main.c:66: if (CURRENT_ANIM != ANIM_WALK_SIDE) {
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00225$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00107$
00225$:
;main.c:67: CURRENT_ANIM = ANIM_WALK_SIDE;
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;main.c:68: currSpriteFrame = CURRENT_ANIM[0];
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl), a
;main.c:70: break;
	jr	00107$
;main.c:71: case J_RIGHT:
00104$:
;c:\users\aidan\gbdk\include\gb\gb.h:1850: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x00
;main.c:75: if (CURRENT_ANIM != ANIM_WALK_SIDE) {
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00226$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00107$
00226$:
;main.c:76: CURRENT_ANIM = ANIM_WALK_SIDE;
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;main.c:77: currSpriteFrame = CURRENT_ANIM[0];
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl), a
;main.c:80: }
00107$:
;main.c:82: if (CURRENT_TICK % (CLOCK_RATE / FPS) == 0) {
	ld	bc, #0x008b
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__moduint
	ldhl	sp,	#16
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#17
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00111$
;main.c:87: if (currSpriteFrame >= ANIM_LENGTH + 1) {
	inc	hl
	inc	hl
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00109$
;main.c:88: currSpriteFrame = 0;
	ld	(hl), #0x00
00109$:
;main.c:91: set_sprite_tile(0, CURRENT_ANIM[currSpriteFrame]);
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
	pop	de
	push	de
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;c:\users\aidan\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 2)
;main.c:92: currSpriteFrame++;
	ld	a, (hl+)
	ld	(de), a
	inc	(hl)
00111$:
;main.c:95: if (CURRENT_TICK % (CLOCK_RATE / 200) == 0) {
	ld	bc, #0x000a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__moduint
	ldhl	sp,	#16
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#17
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00113$
;main.c:97: x_pos += h_axis;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ld	a, (hl+)
	add	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;main.c:98: y_pos += v_axis;
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#9
	ld	c, (hl)
	add	a, c
	ld	(hl), a
00113$:
;c:\users\aidan\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:\users\aidan\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	(bc), a
	inc	bc
;main.c:102: CURRENT_TICK = (CURRENT_TICK + 1) % CLOCK_RATE;
	ld	a, (hl+)
	inc	hl
	ld	(bc), a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	de
	ld	bc, #0x082f
	call	__moduint
	ldhl	sp,	#10
	ld	(hl), c
	inc	hl
	ld	(hl), b
	jp	00115$
;main.c:105: }
	add	sp, #19
	ret
_spritePalette:
	.dw #0x7bde
	.dw #0x6e31
	.dw #0x0000
	.dw #0x7fff
_bgPalette:
	.dw #0x7fff
	.dw #0x22e7
	.dw #0x19c4
	.dw #0x0000
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
