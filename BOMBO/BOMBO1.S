

	;********************************************************;
	;*****         © by Mehmet Kartalbas in 1990        *****;
	;*****               Programmed from                *****;
        ;*****          25.07.1990 - 03.09.1990             *****;
	;********************************************************;



		;*************************;
		;**  CUSTOM - REGISTERS **;
		;*************************;

		CIAAPRA:	equ     $BFE001
		CIAASDR:	equ	$BFEC01

		CUSTOM:		equ     $DFF000

		VPOSR:		equ     $004
		VHPOSR:		equ     $006

		POTGOR:		equ	$016

		DMACONR:	equ     $002
		DMACON:		equ     $096

		INTENA:		equ     $09A
		INTREQ:		equ     $09C
		INTREQR:	equ     $01E

		JOYTEST:	equ	$036
		JOY0DAT:	equ     $00A
		JOY1DAT:	equ     $00C

		BLTCON0:	equ     $040
		BLTCON1:	equ     $042
		BLTAFWM:	equ     $044
		BLTCPTH:	equ     $048
		BLTBPTH:	equ     $04C
		BLTAPTH:	equ     $050
		BLTDPTH:	equ     $054
		BLTSIZE:	equ     $058
		BLTCMOD:	equ     $060
		BLTBMOD:	equ     $062
		BLTAMOD:	equ     $064
		BLTDMOD:	equ     $066

		COP1LCH:	equ     $080
		COPJMP1:	equ     $088

		DIWSTRT:	equ     $08E
		DIWSTOP:	equ     $090
		DDFSTRT:	equ     $092
		DDFSTOP:	equ     $094
		BPL1PTH:	equ     $0E0
		BPLCON0:	equ     $100
		BPLCON1:	equ     $102
		BPLCON2:	equ     $104
		BPL1MOD:	equ     $108
		BPL2MOD:	equ     $10A

		AUD0LCH:	equ	$0A0
		AUD0LEN:	equ	$0A4
		AUD0PER:	equ	$0A6
		AUD0VOL:	equ	$0A8

		AUD1LCH:	equ	$0B0
		AUD1LEN:	equ	$0B4
		AUD1PER:	equ	$0B6
		AUD1VOL:	equ	$0B8

		AUD2LCH:	equ	$0C0
		AUD2LEN:	equ	$0C4
		AUD2PER:	equ	$0C6
		AUD2VOL:	equ	$0C8

		AUD3LCH:	equ	$0D0
		AUD3LEN:	equ	$0D4
		AUD3PER:	equ	$0D6
		AUD3VOL:	equ	$0D8

		SPR0PTH:	equ     $120
		SPR0PTL:	equ     $122
		SPR0POS:	equ     $140
		SPR0CTL:	equ     $142
		SPR0DATA:	equ     $144
		SPR0DATB:	equ     $146

		COLOR00:	equ     $180


		;*************************;
		;*****  EXEC-Offsets *****;
		;*************************;

		;*****  EXEC.LIBRARY   *****;

		EXECBASE:	equ     $0004
		OPENLIBRARY:	equ     -408
		CLOSELIBRARY:	equ     -414

		;*****   DOS.LIBRARY   *****;

		OPEN:		equ	-030
		CLOSE:		equ	-036
		READ:		equ	-042
		WRITE:		equ	-048

		MODE_OLD:	equ	1005
		MODE_NEW:	equ	1006

		;***************************;

		TRAP0_VECT:	equ	$0080

;-----------------------------------------------------------------------;

		SOUND:		equ	$30000
		INIT_SONG:	equ	SOUND
		PLAY_SONG:	equ	SOUND+4
		SOUND_END:	equ	SOUND+8710

		>EXTERN "SOUNDS/SOUND",SOUND,8708

;-----------------------------------------------------------------------;


		;*************************;
		;** Screen Deffinations **;
		;*************************;

		X_OFFS:		equ	8
		Y_OFFS:		equ	64

		COLORS:		equ	16
		DEPTH:		equ	4
		GAME_WBYTES:	equ	X_OFFS+40+X_OFFS
		GAME_HEIGHT:	equ	Y_OFFS+224+Y_OFFS
		PLANE_SIZE:	equ	GAME_WBYTES*GAME_HEIGHT
		GAME_SIZE:	equ	PLANE_SIZE*DEPTH
		PLANE_OFFS:	equ	[GAME_WBYTES*DEPTH*Y_OFFS]+X_OFFS


		;*************************;
		;** Board Deffinations  **;
		;*************************;

		BOARD_WBYTES:	equ     40
		BOARD_HEIGHT:	equ     32
		BOARD_SIZE:	equ     BOARD_WBYTES*BOARD_HEIGHT*DEPTH


		;*************************;
		;*** Bob Deffinations  ***;
		;*************************;

		PANZER_AMOUNT:	equ	2-1
		PANZERS:	equ	8	; In einer Reihe
		PANZER_WBYTE:	equ     2+2
		PANZER_WBYTES:	equ     PANZERS*PANZER_WBYTE
		PANZER_HEIGHT:	equ     16
		PANZER_SIZE:	equ     DEPTH*PANZER_WBYTES*PANZER_HEIGHT

		;*************************;


		SCHUSS_AMOUNT:	equ	2-1
		SCHUSSE:	equ	3
		SCHUSS_WBYTE:	equ	2+2
		SCHUSS_WBYTES:	equ	SCHUSSE*SCHUSS_WBYTE
		SCHUSS_HEIGHT:	equ	16
		SCHUSS_SIZE:	equ	DEPTH*SCHUSS_WBYTE*SCHUSS_HEIGHT
		SCHUESSE_SIZE:	equ	DEPTH*SCHUSS_WBYTES*SCHUSS_HEIGHT


		;*************************;

		CHAR_HEIGHT:	equ	8
		CHAR_WBYTES:	equ	80


		;*************************;
		;* User Memory Pointers **;
		;*************************;

		BITPLANES1:	equ     $40000
		BITPLANES2:	equ     BITPLANES1+GAME_SIZE
		BITPLANES3:	equ     BITPLANES2+GAME_SIZE
		BOARD:		equ	BITPLANES3+GAME_SIZE


		;*************************;
		;*****   Bob Masks   *****;
		;*************************;

		PANZER_MASK:	equ     BOARD+BOARD_SIZE
		SCHUESSE_MASK:	equ	PANZER_MASK+PANZER_SIZE


		;*************************;
		;***** Now the rest ******;
		;*************************;

		GAME_COPPER:	equ     SCHUESSE_MASK+SCHUESSE_SIZE
		GAME_LEVELS:	equ	GAME_COPPER+4096
		GAME_MEM_END:	equ	GAME_LEVELS+[300*10]


		;*************************;
		;*****   CHIP DATAS   ****;
		;*************************;

		PANZER:		equ     SOUND_END
		SCHUESSE:	equ     PANZER+PANZER_SIZE
		CHARSET:	equ	SCHUESSE+SCHUESSE_SIZE
		SHOOT_SOUND:	equ	CHARSET+[80*8]
		DRIVE_SOUND:	equ	SHOOT_SOUND+1400
		GAME_GFX_END:	equ	DRIVE_SOUND+1000


		;******************************;

		>EXTERN "GRAPH_BPL/PANZER",PANZER,PANZER_SIZE
		>EXTERN "GRAPH_BPL/SCHUESSE",SCHUESSE,SCHUESSE_SIZE
		>EXTERN "GRAPH_BPL/CHARSET",CHARSET,80*8
		>EXTERN "SOUNDS/SHOOT_SOUND",SHOOT_SOUND,1400
		>EXTERN "SOUNDS/DRIVE_SOUND",DRIVE_SOUND,1000


;-----------------------------------------------------------------------;

		;******************************;
		;** LAND-Screen Deffinations **;
		;******************************;

		LAND_COLORS:	equ	16
		LAND_DEPTH:	equ     4
		LAND_WBYTES:	equ     40
		LAND_HEIGHT:	equ     224
		LAND_SIZE:	equ	LAND_WBYTES*LAND_HEIGHT*LAND_DEPTH


		;******************************;

		;***** MAUER Deffinations *****;
		;******************************;

		MAUER_WBYTE:	equ	2
		MAUER_WBYTES:	equ	MAUER_WBYTE*20
		MAUER_HEIGHT:	equ	16
		MAUER_HEIGHTS:	equ	MAUER_HEIGHT*2
		MAUER_OBJ_SIZE:	equ	MAUER_HEIGHT*MAUER_WBYTE*LAND_DEPTH
		MAUER_SIZE:	equ	MAUER_HEIGHTS*MAUER_WBYTES*LAND_DEPTH

		;******************************;

		LEVEL_SIZE:	equ	[LAND_WBYTES/MAUER_WBYTE]*[LAND_HEIGHT/MAUER_HEIGHT]
		MAUS_SIZE:	equ	72
		LEVELS_END:	equ	LEVEL_SIZE*10


		;******************************;
		;***** LAND-Screen Memory *****;
		;******************************;

		LAND:		equ	$40000


		;******************************;
		;*****  LAND-GFX Memory   *****;
		;******************************;

		MAUER_SAWN:	equ	LAND+LAND_SIZE
		TAKE_BUFFER:	equ	MAUER_SAWN+MAUER_SIZE
		MAUER_BUFFER:	equ	TAKE_BUFFER+MAUER_OBJ_SIZE
		LAND_COPPER:	equ	MAUER_BUFFER+MAUER_OBJ_SIZE


		;******************************;

		MAUER:		equ	GAME_GFX_END
		GAME_COLORS:	equ	MAUER+MAUER_SIZE
		LEVELS:		equ	MAUER+MAUER_SIZE+[COLORS*2]
		MAUS:		equ	LEVELS+LEVELS_END
		MAUS_COLORS:	equ	MAUS+MAUS_SIZE
		EDITOR_GFX_END:	equ	MAUS_COLORS+8


		;******************************;

		>EXTERN	"GRAPH_BPL/MAUER",MAUER,MAUER_SIZE+[COLORS*2]
		>EXTERN	"GRAPH_BPL/MAUS",MAUS,72+8
		>EXTERN "LEVELS",LEVELS,LEVEL_SIZE*10


;-----------------------------------------------------------------------;

		;******************************;
		;** LAND-Screen Deffinations **;
		;******************************;

		INTRO_DEPTH:	equ     4
		INTRO_WBYTES:	equ     40
		INTRO_HEIGHT:	equ     256
		INTRO_PLANE_SIZE:equ	INTRO_WBYTES*INTRO_HEIGHT
		INTRO_SIZE:	equ	INTRO_PLANE_SIZE*INTRO_DEPTH


		;******************************;

		INTRO_BITPLANES:equ	$40000
		SCROLL_BPL:	equ	INTRO_BITPLANES+INTRO_SIZE+46
		STAR_XYZ:	equ	SCROLL_BPL+[10*46]
		OLD_STAR_XYZ:	equ	STAR_XYZ+[2*400*3]
		INTRO_COPPER:	equ	OLD_STAR_XYZ+[2*400]
		CYCLE_COLORS1:	equ	INTRO_COPPER+[4*1024]

		PROGRAM_MEM:	equ	$38700


;-----------------------------------------------------------------------;

	;	org	EDITOR_GFX_END
	;	load	*

;***********************************************************************;
;*************************** I N T R O *********************************;
;***********************************************************************;



		;-------------------------------;
		START:
		;-------------------------------;

		moveq	#1,d0
		jsr	INIT_SONG
		bsr	INIT_PROGRAM
		jsr	INTRO_START1

		bra	EXIT


		;-------------------------------;
		INTRO_START1:
		;-------------------------------;

	INTRO_START:
		bsr	CLR_MEMORY
		bsr	INIT_CYCLE_COLORS
		bsr	PRINT_INTRO_MES
		bsr	INV_INTRO_MES
		bsr	INIT_INTRO_VIEW


		;-------------------------------;
		INTRO_MAIN:
		;-------------------------------;

		move.l	VPOSR(a0),d0
		and.l	#$001FF00,d0
		cmp.l	#$0000100,d0
		bne	INTRO_MAIN

		;move.w	#$0F0F,COLOR00(a0)

		jsr	PLAY_SONG
		bsr	COLOR_CYCLING
		bsr	MOVE_STARS
		bsr	SCROLL_LINE

		bsr	JOYSTICK_MESSAGE
		bsr	MOVE_MOUSE_JOY
		bsr	MOVE_MOUSE

		bsr	CTRL_MOUSE_FLAGS
		bsr	EXECUTE_MOUSE_FLAGS

		;move.w	#$0000,COLOR00(a0)

		btst	#10,POTGOR(a0)
		bne	INTRO_MAIN
		btst	#6,CIAAPRA
		bne	INTRO_MAIN

		RTS


;-----------------------------------------------------------------------;
;		;***** Maus routine *****;				;
;-----------------------------------------------------------------------;

		;----------------------;
		; Sprung : MOVE_MOUSE  ;
		; X-POS  : MOUSE_X     ;
		; Y-POS  : MOUSE_Y     ;
		;----------------------;

		OLD_MOUSE_Y_F:	equ	0
		OLD_MOUSE_X_F:	equ	OLD_MOUSE_Y_F+1
		MOUSE_X_F:	equ	OLD_MOUSE_X_F+1
		MOUSE_Y_F:	equ	MOUSE_X_F+2

		MOUSE_FLAGS:
		OLD_Y:		dc.b	0
		OLD_X:		dc.b	0
		MOUSE_X:	dc.w	0
		MOUSE_Y:	dc.w	0


		;-------------------------------;
		MOVE_MOUSE:
		;-------------------------------;

		lea	MAUS,a1
		lea	MOUSE_FLAGS,a2


		;****************************;
		;***   X und Y ablesen    ***;
		;****************************;

		move.w	JOY0DAT(a0),d2
		move.w	d2,d0
		move.w	d2,d1


		;****************************;
		;*** OldY - NewY = SpeedY ***;
		;****************************;

		lsr.w	#8,d1		; Y
		sub.b	OLD_MOUSE_Y_F(a2),d1
		ext.w	d1


		;****************************;
		;*** OldX - NewX = SpeedX ***;
		;****************************;

		sub.b	OLD_MOUSE_X_F(a2),d0	; X
		ext.w	d0

		move.w	d2,OLD_MOUSE_Y_F(a2)	; NewXY -> OldXY


		;****************************;
		;**** Begrenzung  rechts ****;
		;****************************;

		add.w	MOUSE_X_F(a2),d0
		bpl	LEFT_OK
		moveq	#0,d0		; X = 0
LEFT_OK:	cmp.w	#320,d0		;  ->|
		blo	RIGHT_OK
		move.w	#319,d0		; |->|
RIGHT_OK:	move.w	d0,MOUSE_X_F(a2)	; NewX


		;****************************;
		;****  Begrenzung links  ****;		
		;****************************;

		add.w	MOUSE_Y_F(a2),d1
		bpl	UP_OK
		moveq	#0,d1
UP_OK:		cmp.w	#256,d1
		blo	DOWN_OK
		move.w	#255,d1
DOWN_OK:	move.w	d1,MOUSE_Y_F(a2)	; NewY


		;****************************;
		;*** Fuer Pixelweise in X ***;
		;****************************;

		add.w	#127,d0
		add.w	#44,d1
		moveq	#0,d2

		lsr.w	#1,d0		; X/2
		bcc	HORIZON_POS_OK
		bset	#0,d2


		;****************************;
		;*** Ueber 256 Pixel in Y ***;
		;****************************;

HORIZON_POS_OK:	lsl.w	#8,d1
		bcc	VSTART_OK
		bset	#1,d2		; Weiss wer warum ???
		bset	#2,d2

VSTART_OK:	or.w	d1,d0
		add.w	#$1000,d1	; Y1 + 16
		bcc	VSTOP_OK
		bset	#1,d2


		;****************************;
		;*** Sprite Coords setzen ***;
		;****************************;

VSTOP_OK:	or.w	d2,d1
		move.w	d0,(a1)
		move.w	d1,2(a1)
		rts

;-----------------------------------------------------------------------;
;		;***** Maus routine ENDE *****;				;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
;		;***** Scroll Line routine *****;			;
;-----------------------------------------------------------------------;

		;*********************************;
		;** CHARSET	->	$xxxxxx	**; z.B. $FC90F4 (K1.2)
		;** SCROLL_BPL	->	$xxxxxx **;
		;** BITPLANES	->	$xxxxxx **;
		;*********************************;

		;*********************************;
		;*****      Preferences      *****;
		;*********************************;

		SCR_WBYTES:	equ	46
		SCROLL_Y_POS:	equ	110


		;-------------------------------;
		SCROLL_LINE:
		;-------------------------------;

		;**************************;
		;***** Scroll the Line ****;
		;**************************;

		lea	SCROLL_BPL,a1		;Scrolling_Buffer
		lea	SCR_WBYTES-2(a1),a2	; Printing_Pos
		move.l	a2,CHAR_POS

		move.l	#-1,BLTAFWM(a0)
		clr.w	BLTAMOD(a0)
		clr.w	BLTDMOD(a0)
		move.l	#$E9F00000,BLTCON0(a0)

		move.l	a1,BLTAPTH(a0)
		subq.l	#2,a1
		move.l	a1,BLTDPTH(a0)
		move.w	#[9*64]+[SCR_WBYTES/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER


		;**************************;
		;***** Blt from Buffer ****;
		;**************************;

		lea	SCROLL_BPL,a1
		lea	INTRO_BITPLANES+INTRO_PLANE_SIZE,a2
		lea	SIN_PTR(pc),a3


		;**************************;
		;*** Naechster SIN-wert ***;
		;**************************;

		cmp.l	#SIN_TAB+20,(a3)
		bne	NO_SIN_END
		move.l	#SIN_TAB,(a3)

NO_SIN_END:	move.l	(a3),a4
		addq.l	#1,(a3)


		;**************************;
		;*** Alte Pos. loeschen ***;
		;**************************;

		move.w	#INTRO_WBYTES-2,BLTDMOD(a0)
		move.l	#$01000000,BLTCON0(a0)

		moveq	#0,d6
		moveq	#20-1,d7

		move.l	a4,a3
		subq.l	#1,a3
		move.l	a2,a5

CLR_FORM_LOOP:	moveq	#0,d0
		move.b	(a3)+,d0
		add.l	#SCROLL_Y_POS,d0
		mulu	#INTRO_WBYTES,d0
		lea	(a5,d0.l),a6

		move.l	a6,BLTDPTH(a0)
		move.w	#[9*64]+[2/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER

		addq.l	#2,a5
		dbra	d7,CLR_FORM_LOOP


		;**************************;
		;***** Neue Pos BLT'en ****;
		;**************************;

		move.w	#SCR_WBYTES-2,BLTAMOD(a0)
		move.w	#INTRO_WBYTES-2,BLTDMOD(a0)
		move.l	#$09F00000,BLTCON0(a0)

		moveq	#0,d6
		moveq	#20-1,d7

BLT_FORM_LOOP:	moveq	#0,d0
		move.b	(a4)+,d0
		add.l	#SCROLL_Y_POS,d0
		mulu	#INTRO_WBYTES,d0
		lea	(a2,d0.l),a3

		move.l	a1,BLTAPTH(a0)
		move.l	a3,BLTDPTH(a0)
		move.w	#[9*64]+[2/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER

		addq.l	#2,a1
		addq.l	#2,a2
		dbra	d7,BLT_FORM_LOOP


		;**************************;
		;*****  TST SCR_OFFS  *****;
		;**************************;

		lea	SCROLL_OFFS(pc),a4
		cmp.b	#3,(a4)
		beq	CONT_MESSAGE1
		addq.b	#1,(a4)
		rts


SIN_PTR:	dc.l	SIN_TAB

SIN_TAB:	dc.b	1,2,3,5,7,9,12,15,19
		dc.b	19
		dc.b	19,15,12,9,7,5,3,2,1

		dc.b	1,2,3,5,7,9,12,15,19
		dc.b	19
		dc.b	19,15,12,9,7,5,3,2,1
		EVEN

CHAR_POS:	dc.l	0
CHAR_OFFS:	dc.l	0
SCROLL_OFFS:	dc.b	0
		EVEN


		;**************************;
		;***** Print the char *****;
		;**************************;

CONT_MESSAGE1:	clr.b	(a4)

		lea	MESSAGE(pc),a1
		move.l	CHAR_POS(pc),a2
		lea	CHARSET,a3
		lea	CHAR_OFFS(pc),a6

		moveq	#0,d0
		add.l	(a6),a1
		addq.l	#1,(a6)
		move.b	(a1),d0

		cmp.b	#-1,d0
		bne	CONT_MESSAGE2
		clr.l	(a6)
		moveq	#0,d0
		bra	CONT_MESSAGE1

CONT_MESSAGE2:	sub.b	#" ",d0
		add.l	d0,a3
		moveq	#CHAR_HEIGHT-1,d2

COPY_LOOP:	move.b	(a3),(a2)
		lea	SCR_WBYTES(a2),a2
		lea	CHAR_WBYTES(a3),a3
		dbra	d2,COPY_LOOP
		rts

MESSAGE:	dc.b	" HALLO LEUTE !! "
		dc.b	" DAS AMIGA-MAGAZIN  ( MARKT & TECHNIK )"
		dc.b	" PRAESENTIERT DAS NEUE SPIEL"
		dc.b	"    >>> BOMBOLERO <<<   "
		dc.b	" PROGRAMMIERT VON"
		dc.b	"    >>> MEHMET KARTALBAS <<<   "
		dc.b	" GEMALT VON "
		dc.b	"    >>> MEHMET K. UND EROL PUERLUE <<< "
		dc.b	"                                     "
		dc.b	"                                     ",-1
		EVEN

;-----------------------------------------------------------------------;
;		;***** Scroll Line routine ENDE *****;			;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
;		;***** Joystick Routine ****;				;
;-----------------------------------------------------------------------;

		;**************************;
		;***** Joystick Prefs *****;
		;**************************;

		RIGHT_F:	equ	0
		LEFT_F:		equ	RIGHT_F+1
		DOWN_F:		equ	LEFT_F+1
		UP_F:		equ	DOWN_F+1
		FIRE_F:		equ	UP_F+1


		;**************************;
		;***** Joystick Flags *****;
		;**************************;

		JOY_PORT_1:
		JOY_RIGHT_F1:	dc.b	0
		JOY_LEFT_F1:	dc.b	0
		JOY_DOWN_F1:	dc.b	0
		JOY_UP_F1:	dc.b	0
		JOY_FIRE_1:	dc.b	0


		;**************************;

		JOY_PORT_2:
		JOY_RIGHT_F2:	dc.b	0
		JOY_LEFT_F2:	dc.b	0
		JOY_DOWN_F2:	dc.b	0
		JOY_UP_F2:	dc.b	0
		JOY_FIRE_2:	dc.b	0


		;-------------------------------;
		JOYSTICK_MESSAGE:
		;-------------------------------;

		;***** Port 1 *****;

		lea	JOY_PORT_1(pc),a1
		move.w	JOY0DAT(a0),d0
		bsr	CHECK_JOY_PORT


		;***** Port 2 *****;

		lea	JOY_PORT_2(pc),a1
		move.w	JOY1DAT(a0),d0
		bsr	CHECK_JOY_PORT


		;***** Fire 1/2 *****;

		lea	JOY_PORT_1(pc),a1
		lea	JOY_PORT_2(pc),a2
		bsr	CHECK_FIRE
		rts


		;-------------------------------;
		CHECK_FIRE:
		;-------------------------------;

		btst	#6,CIAAPRA
		bne	NO_FIRE_1
		st	FIRE_F(a1)

NO_FIRE_1:	btst	#7,CIAAPRA
		bne	NO_FIRE_2
		st	FIRE_F(a2)

NO_FIRE_2:	rts


		;-------------------------------;
		CHECK_JOY_PORT:
		;-------------------------------;

		move.l	d1,-(sp)

		btst	#1,d0
		beq	NO_JOY_RIGHT
		st	RIGHT_F(a1)

NO_JOY_RIGHT:	btst	#9,d0
		beq	NO_JOY_LEFT
		st	LEFT_F(a1)

NO_JOY_LEFT:	move.w	d0,d1
		lsr.w	#1,d1
		eor.w	d0,d1
		btst	#0,d1
		beq	NO_JOY_DOWN
		st	DOWN_F(a1)

NO_JOY_DOWN:	btst	#8,d1
		beq	NO_JOY_UP
		st	UP_F(a1)

NO_JOY_UP:	move.l	(sp)+,d1
		rts


;-----------------------------------------------------------------------;
;		;***** Joystick Routine ENDE *****;
;-----------------------------------------------------------------------;

		;-------------------------------;
		MOVE_MOUSE_JOY:
		;-------------------------------;

		lea	MOUSE_FLAGS(pc),a1
		lea	JOY_PORT_2(pc),a2

		tst.b	RIGHT_F(a2)
		beq	NO_JOY2_RIGHT
		sf	RIGHT_F(a2)
		addq.w	#2,MOUSE_X_F(a1)

NO_JOY2_RIGHT:	tst.b	LEFT_F(a2)
		beq	NO_JOY2_LEFT
		sf	LEFT_F(a2)
		subq.w	#2,MOUSE_X_F(a1)

NO_JOY2_LEFT:	tst.b	UP_F(a2)
		beq	NO_JOY2_UP
		sf	UP_F(a2)
		subq.w	#2,MOUSE_Y_F(a1)

NO_JOY2_UP:	tst.b	DOWN_F(a2)
		beq	NO_JOY2_DOWN
		sf	DOWN_F(a2)
		addq.w	#2,MOUSE_Y_F(a1)

NO_JOY2_DOWN:	rts


;-----------------------------------------------------------------------;
;		;*****    Sterneroutine    *****;			;
;-----------------------------------------------------------------------;

		;-------------------------------;
		MOVE_STARS:
		;-------------------------------;

		lea	STAR_XYZ,a4
		lea	INTRO_BITPLANES,a5
		lea	OLD_STAR_XYZ,a6

		move.w	#210,a2
		move.w	#320,a3
		move.w	#INTRO_WBYTES,d6
		move.l	#INTRO_PLANE_SIZE,d7

		move.w	#100-1,d3
STAR_LOOP:	move.w	(a4)+,d4
		move.w	(a4)+,d5
		move.w	(a4),d2
		subq.w	#8,(a4)+
		bmi	GET_COORDS

		ext.l	d4
		ext.l	d5
		divs	d2,d4
		divs	d2,d5
		add.w	#160,d4
		add.w	#128,d5

		cmp.w	#10,d4
		bls	GET_COORDS
		cmp.w	#50,d5
		bls	GET_COORDS
		cmp.w	a3,d4
		bhs	GET_COORDS
		cmp.w	a2,d5
		bhs	GET_COORDS

		moveq	#0,d0
		move.w	(a6),d0
		move.w	d4,(a6)+
		move.w	(a6),d1
		move.w	d5,(a6)+

		mulu	d6,d1
		divu	#8,d0
		add.w	d0,d1
		swap	d0
		not.b	d0
		lea	(a5,d1.l),a1
		bclr	d0,(a1)
		add.w	d7,a1
		bclr	d0,(a1)

		moveq	#0,d0
		move.w	d4,d0
		move.w	d5,d1
		mulu	d6,d1
		divu	#8,d0
		add.w	d0,d1
		swap	d0
		not.b	d0

		cmp.w	#400,d2
		ble	NOT_COLOR_1 
		lea	(a5,d1.l),a1
		bset	d0,(a1)
		bra	NEXT_STAR
NOT_COLOR_1:	cmp.w	#200,d2
		ble	NOT_COLOR_2 
		lea	(a5,d7.l),a1
		add.w	d1,a1
		bset	d0,(a1)
		bra	NEXT_STAR
NOT_COLOR_2:	lea	(a5,d1.l),a1
		bset	d0,(a1)
		add.w	d7,a1
		bset	d0,(a1)

NEXT_STAR:	dbra	d3,STAR_LOOP
		rts


		;-------------------------------;
		GET_COORDS:
		;-------------------------------;

		subq.l	#6,a4
		bsr	GET_RND
		move.w	d0,(a4)+
		bsr	GET_RND
		move.w	d0,(a4)+
		move.w	#600,(a4)+
		bra	NEXT_STAR


		;-------------------------------;
		GET_RND:
		;-------------------------------;

		move.w	VHPOSR(a0),d0
		move.b	$BFD800,d1
		move.b	$BFD801,d2
		asl.w	d2,d1
		mulu	200(sp),d0
		eor.w	d1,d0
		eor.w	#$feef,d0
		move.w	d0,200(sp)
		rts


;-----------------------------------------------------------------------;
;		;*****    Sterneroutine    ENDE  *****;			;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
;		;***** Ctrl Mouse Pointer *****;			;
;-----------------------------------------------------------------------;

		;-------------------------------;
		CTRL_MOUSE_FLAGS:
		;-------------------------------;

		bra	CONTROL_MOUSE


		;*************************;

		GAME_F:		equ	0
		EDITOR_F:	equ	GAME_F+1
		MUSIC_F:	equ	EDITOR_F+1
		SCREEN_F:	equ	MUSIC_F+1
		TIME_F:		equ	SCREEN_F+1
		SHOOT_F:	equ	TIME_F+1


		;*************************;

	MOUSE_TST_FLAGS:
		GAME_FLAG:	dc.b	0
		EDITOR_FLAG:	dc.b	0
		MUSIC_FLAG:	dc.b	0
		SCREEN_FLAG:	dc.b	0
		TIME_FLAG:	dc.b	0
		SHOOT_FLAG:	dc.b	0
		EVEN


		;*************************;

	TST_QUADRATE:
		TST_AMOUNT:	dc.w	6-1
		GAME_FLAG_TST:	dc.w	$59,$F0,$45+00,$4C+00
		EDITOR_FLAG_TST:dc.w	$59,$F0,$45+08,$4C+08
		MUSIC_FLAG_TST:	dc.w	$59,$F0,$9D+00,$A4+00
		SCREEN_FLAG_TST:dc.w	$59,$F0,$9D+08,$A4+08
		TIME_FLAG_TST:	dc.w	$59,$F0,$9D+16,$A4+16
		SHOOT_FLAG_TST:	dc.w	$59,$F0,$9D+24,$A4+24


		;*************************;


CONTROL_MOUSE:	btst	#6,CIAAPRA
		beq	CTRL_MOUSE_NOW

		btst	#7,CIAAPRA
		beq	CTRL_MOUSE_NOW
		rts

CTRL_MOUSE_NOW:	lea	MOUSE_FLAGS(pc),a1
		lea	MOUSE_TST_FLAGS(pc),a2
		lea	TST_QUADRATE(pc),a3

		move.w	MOUSE_X_F(a1),d0
		move.w	MOUSE_Y_F(a1),d1

		move.w	(a3)+,d7

CTRL_MOUSE_LOOP:cmp.w	(a3)+,d0
		blo	NEXT_CTRL_MOUSE
		cmp.w	(a3)+,d0
		bhi	NEXT_CTRL_MOUSE
		cmp.w	(a3)+,d1
		blo	NEXT_CTRL_MOUSE
		cmp.w	(a3)+,d1
		bhi	NEXT_CTRL_MOUSE
		st	(a2)
NEXT_CTRL_MOUSE:addq.l	#1,a2
		dbra	d7,CTRL_MOUSE_LOOP
		rts


;-----------------------------------------------------------------------;
;		;***** Ctrl Mouse Pointer  ENDE *****;			;
;-----------------------------------------------------------------------;


		;-------------------------------;
		EXECUTE_MOUSE_FLAGS:
		;-------------------------------;

		lea	MOUSE_TST_FLAGS(pc),a1


		;************************;
		;***** Start Game ? *****;
		;************************;

		tst.b	GAME_F(a1)
		beq	NO_START_GAME
		sf	GAME_F(a1)
		addq.l	#4,sp

		lea	PROGRAM_MEM+[INTRO_END-START],a1
		lea	GAME_START,a2

		move.w	#GAME_END-GAME_START-1,d7
COPY_GAME:	move.b	(a1)+,(a2)+
		dbra	d7,COPY_GAME

		move.w	#$200,DMACON(a0)
		clr.w	COLOR00(a0)

		move.b	TIME_POS(pc),TIME_POS2

		jmp	GAME_START

	NO_START_GAME:

		;**************************;
		;***** Start Editor ? *****;
		;**************************;

		tst.b	EDITOR_F(a1)
		beq	NO_START_EDITOR
		sf	EDITOR_F(a1)
		addq.l	#4,sp

		lea	PROGRAM_MEM+[GAME_END-START],a1
		lea	GAME_START,a2

		move.w	#EDITOR_END-EDITOR_START-1,d7
COPY_EDITOR:	move.b	(a1)+,(a2)+
		dbra	d7,COPY_EDITOR

		move.w	#$200,DMACON(a0)
		clr.w	COLOR00(a0)

		jmp	EDITOR_START


	NO_START_EDITOR:

		;**************************;
		;***** Music On/Off ? *****;
		;**************************;

		lea	MUSIC_ON_OFF(pc),a2

		tst.b	MUSIC_F(a1)
		beq	NO_CHANGE_MUSIC
		sf	MUSIC_F(a1)

		tst.b	1(a2)
		bne	NO_CHANGE_MUSIC2

		st	1(a2)

		tst.b	(a2)
		beq	SET_MUSIC_OFF
		sf	(a2)

		lea	INTRO_MES3(pc),a2
		bsr	PRINT_LINE
		lea	INTRO_MES3(pc),a2
		bsr	INV_LINE
		rts		

SET_MUSIC_OFF:	tst.b	(a2)
		bne	NO_CHANGE_MUSIC2
		st	(a2)

		lea	INTRO_MES4(pc),a2
		bsr	PRINT_LINE
		lea	INTRO_MES4(pc),a2
		bsr	INV_LINE
		rts

MUSIC_ON_OFF:	dc.b	0
OLD_MUSIC_F:	dc.b	0


	NO_CHANGE_MUSIC:
		sf	1(a2)
	NO_CHANGE_MUSIC2:


		;***************************;
		;***** Screen Number ? *****;
		;***************************;

		lea	SCREEN_POS(pc),a2

		tst.b	SCREEN_F(a1)
		beq	NO_CHANGE_SCREEN2
		sf	SCREEN_F(a1)

		tst.b	1(a2)
		bne	NO_CHANGE_SCREEN
		st	1(a2)

		addq.b	#1,(a2)
		cmp.b	#10,(a2)
		bne	NO_SCREEN_POS_END
		clr.b	(a2)

NO_SCREEN_POS_END:
		lea	SCREEN_POS_PTR(pc),a3

		moveq	#0,d0
		moveq	#0,d1

		move.b	(a2),d0
		move.b	d0,d1

		and.b	#$0F,d0
		add.b	#$30,d0
		move.b	d0,(a3)

		lea	INTRO_MES5(pc),a2
		bsr	PRINT_LINE
		lea	INTRO_MES5(pc),a2
		bsr	INV_LINE

		rts

	NO_CHANGE_SCREEN2:
		sf	1(a2)
	NO_CHANGE_SCREEN:


		;***************************;
		;*****  Time  Number ? *****;
		;***************************;

		lea	TIME_POS(pc),a2

		tst.b	TIME_F(a1)
		beq	NO_CHANGE_TIME2
		sf	TIME_F(a1)

		tst.b	1(a2)
		bne	NO_CHANGE_TIME
		st	1(a2)

		addq.b	#1,(a2)
		cmp.b	#10,(a2)
		bne	NO_TIME_POS_END
		move.b	#1,(a2)

NO_TIME_POS_END:lea	TIME_POS_PTR(pc),a3

		moveq	#0,d0
		moveq	#0,d1

		move.b	(a2),d0
		move.b	d0,d1

		and.b	#$0F,d0
		add.b	#$30,d0
		move.b	d0,(a3)

		lea	INTRO_MES6(pc),a2
		bsr	PRINT_LINE
		lea	INTRO_MES6(pc),a2
		bsr	INV_LINE

		rts

	NO_CHANGE_TIME2:
		sf	1(a2)
	NO_CHANGE_TIME:


		;***************************;
		;*****  Shoot Number ? *****;
		;***************************;

		lea	SHOOT_POS(pc),a2

		tst.b	SHOOT_F(a1)
		beq	NO_CHANGE_SHOOT2
		sf	SHOOT_F(a1)

		tst.b	1(a2)
		bne	NO_CHANGE_SHOOT
		st	1(a2)

		addq.b	#1,(a2)
		cmp.b	#100,(a2)
		bne	NO_SHOOT_POS_END
		clr.b	(a2)

NO_SHOOT_POS_END:
		lea	SHOOT_POS_PTR(pc),a3

		moveq	#0,d0
		move.b	(a2),d0

		divu	#10,d0		; Zehner ausfiltern
		move.l	d0,d1
		add.b	#$30,d0
		move.b	d0,(a3)

		swap	d1
		add.b	#$30,d1
		move.b	d1,1(a3)

		lea	INTRO_MES7(pc),a2
		bsr	PRINT_LINE
		lea	INTRO_MES7(pc),a2
		bsr	INV_LINE

		rts

	NO_CHANGE_SHOOT2:
		sf	1(a2)
	NO_CHANGE_SHOOT:

		rts

SHOOT_AMOUNT:	equ	50

TIME_POS:	dc.b	2
OLD_TIME_F:	dc.b	0

SCREEN_POS:	dc.b	0
OLD_SCREEN_F:	dc.b	0

SHOOT_POS:	dc.b	SHOOT_AMOUNT
OLD_SHOOT_F:	dc.b	0


		;-------------------------------;
		COLOR_CYCLING:
		;-------------------------------;


		;***** Cycle Color 1 *****;

		move.l	COLOR_CYCLE_ONE(pc),a1
		lea	CYCLE_PTR_ONE(pc),a2

		move.l	(a2),a3
		moveq	#13-1,d2

CYCLE_LOOP1:	addq.l	#2+2+2,a1
		move.w	(a3)+,(a1)+
		dbra	d2,CYCLE_LOOP1

		subq.l	#2,(a2)
		cmp.l	#CYCLE_COLORS1,(a2)
		bne	EXIT_COLOR_CYCLE1
		move.l	#CYCLE_COLORS1+[96*2],(a2)


EXIT_COLOR_CYCLE1:

		;***** Cycle Color 2 *****;

		move.l	COLOR_CYCLE_TWO(pc),a1
		lea	CYCLE_PTR_TWO(pc),a2

		move.l	(a2),a3
		moveq	#13-1,d2

CYCLE_LOOP2:	addq.l	#2+2+2,a1
		move.w	(a3)+,(a1)+
		dbra	d2,CYCLE_LOOP2

		addq.l	#2,(a2)
		cmp.l	#CYCLE_COLORS1+[96*2],(a2)
		bne	EXIT_COLOR_CYCLE2
		move.l	#CYCLE_COLORS1,(a2)

EXIT_COLOR_CYCLE2:
		rts


CYCLE_PTR_ONE:	dc.l	CYCLE_COLORS1+[96*2]
CYCLE_PTR_TWO:	dc.l	CYCLE_COLORS1


		;-------------------------------;
		CLR_MEMORY:
		;-------------------------------;

		lea	MOUSE_FLAGS(pc),a1
		clr.w	(a1)+
		clr.l	(a1)


;-----------------------------------------------------------------------;
;		;***** LoeschRoutine mit Blitter *****;			;
;-----------------------------------------------------------------------;

		;-------------------------------;
		CLEAR_CHIP:
		;-------------------------------;


		;*************************;
		;** Clr ab $40000-$80000 *;
		;*************************;

		move.w	#[1024*64]+[126/2],d0	; 126Kbyte
		move.l	#BITPLANES1,d1
		bsr	CLR_CHIP

		move.w	#[1024*64]+[126/2],d0	; 126Kbyte
		move.l	#BITPLANES1+[126*1024],d1
		bsr	CLR_CHIP

		move.w	#[102*64]+[40/2],d0	; 4Kbyte
		move.l	#BITPLANES1+[126*1024*2],d1
	;	bsr	CLR_CHIP
	;	rts


		;-------------------------------;
		CLR_CHIP:
		;-------------------------------;

		lea	CUSTOM,a0
		move.w	#$4000,INTENA(a0)
		move.w	DMACONR(a0),d7
		move.w	#$8240,DMACON(a0)

		move.l	#-1,BLTAFWM(a0)
		move.l	#$01000000,BLTCON0(a0)
		clr.w	BLTDMOD(a0)

		move.l	d1,BLTDPTH(a0)
		move.w	d0,BLTSIZE(a0)
		bsr	WAIT_BLITTER

		or.w	#$8200,d7
		move.w	d7,DMACON(a0)
		rts


;-----------------------------------------------------------------------;
;		;***** LoeschRoutine mit Blitter ENDE *****;		;
;-----------------------------------------------------------------------;


		;-------------------------------;
		INIT_CYCLE_COLORS:
		;-------------------------------;

		lea	CYCLE_COLORS1,a1
		lea	RAINBOW_TABLE1(pc),a2
		bsr	BUILD_RAINBOW
		rts


RAINBOW_TABLE1:	dc.w	$100,$000
		dc.w	-$100,$F00
		dc.w	$010,$000
		dc.w	-$010,$0F0
		dc.w	$001,$000
		dc.w	-$001,$00F
	
		dc.w	$100,$000
		dc.w	-$100,$F00
		dc.w	$010,$000
		dc.w	-$010,$0F0
		dc.w	$001,$000
		dc.w	-$001,$00F
		dc.w	0


		;-------------------------------;
		BUILD_RAINBOW:
		;-------------------------------;


BUILD_RAINBOW1:	move.w	(a2)+,d0
		move.w	(a2)+,d1
		tst.w	d0
		beq	EXIT_BUILD_RAINBOW

		moveq	#16-1,d7
BUILD_RAINBOW2:	move.w	d1,(a1)+
		add.w	d0,d1
		dbra	d7,BUILD_RAINBOW2

		bra	BUILD_RAINBOW1
EXIT_BUILD_RAINBOW:
		rts


		;-------------------------------;
		INV_INTRO_MES:
		;-------------------------------;

		lea	INTRO_MES1(pc),a2
		bsr	INV_LINE

		lea	INTRO_MES2(pc),a2
		bsr	INV_LINE

		lea	INTRO_MES3(pc),a2
		bsr	INV_LINE

		lea	INTRO_MES5(pc),a2
		bsr	INV_LINE

		lea	INTRO_MES6(pc),a2
		bsr	INV_LINE

		lea	INTRO_MES7(pc),a2
		bsr	INV_LINE
		rts


		;-------------------------------;
		INV_LINE:
		;-------------------------------;

		move.l	8(a2),a1
		add.l	4(a2),a1
		lea	19(a1),a1
		moveq	#0,d1

INV_LINE_LOOP:	cmp.w	#20-1,d1
		beq	INV_LINE_EXIT

		moveq	#CHAR_HEIGHT-1,d0
INV_CHAR_I:	not.b	(a1)
	;	and.b	#$fe,(a1)
		lea	INTRO_WBYTES(a1),a1
		dbra	d0,INV_CHAR_I

		addq.l	#1,d1
		lea	-[[CHAR_HEIGHT*INTRO_WBYTES]-1](a1),a1
		bra	INV_LINE_LOOP

INV_LINE_EXIT:	rts


		;-------------------------------;
		PRINT_INTRO_MES:
		;-------------------------------;

		lea	INTRO_MES1(pc),a2
		bsr	PRINT_LINE

		lea	INTRO_MES2(pc),a2
		bsr	PRINT_LINE

		lea	INTRO_MES3(pc),a2
		bsr	PRINT_LINE

		lea	INTRO_MES5(pc),a2
		bsr	PRINT_LINE

		lea	INTRO_MES6(pc),a2
		bsr	PRINT_LINE

		lea	INTRO_MES7(pc),a2
		bsr	PRINT_LINE
		rts


INTRO_MES1:	dc.l	18,[11*INTRO_WBYTES*CHAR_HEIGHT]
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"        GAME        ",-1
		EVEN

INTRO_MES2:	dc.l	18,[12*INTRO_WBYTES*CHAR_HEIGHT]+INTRO_WBYTES
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"       EDITOR       ",-1
		EVEN


INTRO_MES3:	dc.l	18,[22*INTRO_WBYTES*CHAR_HEIGHT]
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"      MUSIC  ON     ",-1
		EVEN

INTRO_MES4:	dc.l	18,[22*INTRO_WBYTES*CHAR_HEIGHT]
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"      MUSIC OFF     ",-1
		EVEN

INTRO_MES5:	dc.l	18,[23*INTRO_WBYTES*CHAR_HEIGHT]+INTRO_WBYTES
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"      SCREEN  "
SCREEN_POS_PTR:	dc.b	"0      ",-1
		EVEN

INTRO_MES6:	dc.l	18,[24*INTRO_WBYTES*CHAR_HEIGHT]+[INTRO_WBYTES*2]
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"      TIME    "
TIME_POS_PTR:	dc.b	"2      ",-1
		EVEN

INTRO_MES7:	dc.l	18,[25*INTRO_WBYTES*CHAR_HEIGHT]+[INTRO_WBYTES*3]
		dc.l	INTRO_BITPLANES+PLANE_SIZE
		dc.b	"      SHOOT  "
SHOOT_POS_PTR:	dc.b	"50      ",-1
		EVEN


		;-------------------------------;
		PRINT_LINE:
		;-------------------------------;

		move.l	8(a2),a1
		add.l	(a2)+,a1
		add.l	(a2)+,a1
		addq.l	#4,a2

PRINT_LINE_LOOP:moveq	#0,d0
		move.b	(a2)+,d0
		cmp.b	#-1,d0
		beq	PRINT_LINE_EXIT
		sub.b	#32,d0
		lea	CHARSET,a3
		add.l	d0,a3

		moveq	#CHAR_HEIGHT-1,d0
PRINT_CHAR_I:	move.b	(a3),(a1)
		lea	CHAR_WBYTES(a3),a3
		lea	INTRO_WBYTES(a1),a1
		dbra	d0,PRINT_CHAR_I

		lea	-[[CHAR_HEIGHT*INTRO_WBYTES]-1](a1),a1
		bra	PRINT_LINE_LOOP

PRINT_LINE_EXIT:rts

		;-------------------------------;
		INIT_PROGRAM:
		;-------------------------------;

		lea	START,a1
		lea	PROGRAM_MEM,a2

		move.w	#EDITOR_END-START,d7
COPY_PRG:	move.b	(a1)+,(a2)+
		dbra	d7,COPY_PRG
		rts


		;-------------------------------;
		INIT_INTRO_VIEW:
		;-------------------------------;

		lea	CUSTOM,a0
		move.w	#$4000,INTENA(a0)


		;*************************;
		;*** Build Copperlist  ***;
		;*************************;

		lea	INTRO_COPPER,a1
		lea	INTRO_COPPERLIST(pc),a2

		moveq	#[[INTRO_COPPERLIST_END-INTRO_COPPERLIST]/2]-1,d0
INTRO_COPLST_CHIP:
		move.w	(a2)+,(a1)+
		dbra	d0,INTRO_COPLST_CHIP


		;***************************;
		;*****  Screen Colors  *****;
		;***************************;

		lea	INTRO_COLORS,a2
		move.w	#COLOR00,d0
		moveq	#COLORS-1,d1

COLORS_INTRO:	move.w	d0,(a1)+
		addq.w	#2,d0
		move.w	(a2)+,(a1)+
		dbra	d1,COLORS_INTRO


		;***************************;
		;*****  Sprite Colors  *****;
		;***************************;

		lea	MAUS_COLORS,a2
		move.w	#COLOR00+[16*2],d0
		moveq	#COLORS-1,d1

COLORS_MAUS_I:	move.w	d0,(a1)+
		addq.w	#2,d0
		move.w	(a2)+,(a1)+
		dbra	d1,COLORS_MAUS_I
		

		;*************************;
		;** Build SpriteCopList **;
		;*************************;

		lea	MAUS,a2
		move.l	#$2C403C00,(a2)

		move.l	a2,d0
		move.w	#SPR0PTH,d1
		bsr	MAKE_SPRITE_COPPER

		moveq	#0,d0		; SprPTR's -> $0000
		moveq	#8-1-1,d7
SPRITE_DUMMY_LOOP_I:
		bsr	MAKE_SPRITE_COPPER
		dbra	d7,SPRITE_DUMMY_LOOP_I


		;***************************;
		;**** Screen for INTRO  ****;
		;***************************;

		move.l	#INTRO_BITPLANES,d1
		move.w	#BPL1PTH,d3

		moveq	#INTRO_DEPTH-1,d0
INTRO_VIEW_COPPER_LOOP:
		move.w	d3,(a1)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a1)+
		move.w	d3,(a1)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a1)+
		add.l	#INTRO_PLANE_SIZE,d1
		dbra	d0,INTRO_VIEW_COPPER_LOOP


		;*************************;
		;** ColorCycling Colors **;
		;*************************;

		move.l	a1,COLOR_CYCLE_ONE
		lea	SIN_TAB_OBEN(pc),a2

		moveq	#13-1,d3

PUT_CYCLE1_COPPER:
		moveq	#0,d4
		move.b	(a2)+,d4
		add.b	#14,d4
		lsl.w	#8,d4
		or.w	#$000F,d4
		move.w	d4,d0

		move.w	d0,(a1)+
		move.w	#$FFFE,(a1)+
		move.w	#COLOR00,(a1)+
		clr.w	(a1)+

		dbra	d3,PUT_CYCLE1_COPPER


		;*************************;

		move.l	#$5E0FFFFE,d0
		move.w	#$0AAA,d1
		moveq	#11-1,d3

HORIZ_ONE:	move.l	d0,(a1)+
		move.w	#COLOR00,(a1)+
		move.w	d1,(a1)+
		sub.w	#$0111,d1
		add.l	#$01000000,d0
		dbra	d3,HORIZ_ONE


		;*************************;

		move.l	a1,BACK_COLOR_PTR

		sub.l	#$01000000,d0		; $690FFFFE = d0
		lea	CYCLE_COLORS1,a2
		move.w	#$F00,d1
		move.w	#$0FF,d2
		move.w	#140-1,d3

BUILD_BACK_COL:	move.l	d0,(a1)+
		add.l	#$01000000,d0
		move.w	#COLOR00+08,(a1)+
		move.w	d2,(a1)+
		move.w	#COLOR00+10,(a1)+
		move.w	d2,(a1)+
		move.w	#COLOR00+12,(a1)+
		move.w	d2,(a1)+
		move.w	#COLOR00+14,(a1)+
		move.w	d2,(a1)+
		dbra	d3,BUILD_BACK_COL

		move.l	BACK_COLOR_PTR(pc),a2
		lea	6(a2),a2

		lea	20*9(a2),a2

		move.w	#$055,d1
		moveq	#10-1,d3

BACK_ONE:	move.w	d1,(a2)
		move.w	d1,4(a2)
		move.w	d1,8(a2)
		move.w	d1,12(a2)
		lea	20(a2),a2
		add.w	#$011,d1
		dbra	d3,BACK_ONE


		move.l	BACK_COLOR_PTR(pc),a2
		lea	6(a2),a2

		lea	20*[15*8]+[20*2](a2),a2

		move.w	#$0FF,d1
		moveq	#10-1,d3

BACK_TWO:	move.w	d1,(a2)
		move.w	d1,4(a2)
		move.w	d1,8(a2)
		move.w	d1,12(a2)
		lea	20(a2),a2
		sub.w	#$011,d1
		dbra	d3,BACK_TWO


		;*************************;

		move.l	#$F50FFFFE,d0
		moveq	#0,d1
		moveq	#11-1,d3

HORIZ_TWO:	move.l	d0,(a1)+
		move.w	#COLOR00,(a1)+
		move.w	d1,(a1)+
		add.w	#$0111,d1
		add.l	#$01000000,d0
		dbra	d3,HORIZ_TWO


		;*************************;

		move.l	#$FFDFFFFE,(a1)+

		move.l	a1,COLOR_CYCLE_TWO
		lea	SIN_TAB_UNTEN(pc),a2

		moveq	#13-1,d3

PUT_CYCLE2_COPPER:
		moveq	#0,d4
		move.b	(a2)+,d4
		lsl.w	#8,d4
		or.w	#$000F,d4
		move.w	d4,d0

		move.w	d0,(a1)+
		move.w	#$FFFE,(a1)+
		move.w	#COLOR00,(a1)+
		clr.w	(a1)+

		dbra	d3,PUT_CYCLE2_COPPER

		move.l	#$FFFFFFFF,(a1)


		;*************************;
		;*** Take Maschines ON ***;
		;*************************;

		lea	CUSTOM,a0
		move.w	#$0000,JOYTEST(a0)
		move.w	#$100,DMACON(a0)
		move.l	#INTRO_COPPER,COP1LCH(a0)
		clr.w	COPJMP1(a0)
		move.w	#$87E0,DMACON(a0)
		move.l	#$FFFFFFFF,BLTAFWM(a0)

		clr.l	CHAR_POS
		clr.l	CHAR_OFFS
		clr.b	SCROLL_OFFS
		rts

SIN_TAB_OBEN:	dc.b	0,10,20,29,38,46,54,61,66,71,75,77,78
SIN_TAB_UNTEN:	dc.b	0,1,3,7,12,17,24,32,40,49,58,68,78

BACK_COLOR_PTR:	dc.l	0
COLOR_CYCLE_ONE:dc.l	0
COLOR_CYCLE_TWO:dc.l	0


		;*************************;
		;***  Copper for View  ***;
		;*************************;

INTRO_COPPERLIST:dc.w	DIWSTRT,$2C81,DIWSTOP,$2CC1
		dc.w	DDFSTRT,$0038,DDFSTOP,$00D0
		dc.w	BPLCON0,[LAND_DEPTH*$1000]+$200
		dc.w	BPLCON1,$0000,BPLCON2,$0024
		dc.w	BPL1MOD,$0000,BPL2MOD,$0000
INTRO_COPPERLIST_END:
		; Continue Copper in COPPER (chip-mem)

INTRO_COLORS:	dc.w	$0000,$0550,$0AA0,$0FF0
		dc.w	$0F0F,$0F0F,$0F0F,$0F0F
		dc.w	$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000


		;-------------------------------;
		EXIT:	
		;-------------------------------;

		move.l	EXECBASE,a6
		lea	GFXNAME,a1
		jsr     OPENLIBRARY(a6)
		move.l	d0,a4
		lea	CUSTOM,a0
		move.w	#$0100,DMACON(a0)
		move.l	38(a4),COP1LCH(a0)
		clr.w	COPJMP1(a0)
		move.w	#$83E0,DMACON(a0)

		moveq	#1,d0
		jsr	INIT_SONG

		moveq	#0,d0
		RTS

GFXNAME:	dc.b	"graphics.library",0
		even

INTRO_END:


;***********************************************************************;
;*************************** G A M E ***********************************;
;***********************************************************************;

		;-------------------------------;
		GAME_START:	
		;-------------------------------;

		bsr	CLR_MEMORY
		bsr	COPY_LEVELS
		bsr	INIT_LEVELS
		bsr	CALC_MASKS
		bsr	CALC_PANZER_POSNS
		bsr	INIT_GAME_VIEW
		bsr	INIT_GAME_PLF
		bsr	INIT_BOARD
		bsr	INIT_SOUNDS


		;-------------------------------;
		GAME_MAIN:	
		;-------------------------------;

		move.l	VPOSR(a0),d0
		and.l	#$001FF00,d0
		cmp.l	#$0000100,d0
		bne	GAME_MAIN

		;********************************;
		;*****       Copy BOBS      *****;
		 bsr	BLT_BOBS		 ;
		;********************************;

		;********************************;
		;*****    Ports Message     *****;
		 bsr	JOYSTICK_MESSAGE	 ;
		;********************************;

		;********************************;
		;*****   Controll Panzers   *****;
		 bsr	MOVE_PANZER		 ;
		 bsr	OPEN_UP_DOWN_AGAIN	 ;
		 bsr	IMPROVE_GAME_BORDERS	 ;
		 bsr	CHECK_PANZER_COLLISION	 ;
		 bsr	EXECUTE_PANZER_COLLISION ;
		;********************************;

		;********************************;
		;*****   Controll Shoots    *****;
		 bsr	SHOOT_PANZER		 ;
		 bsr	CHECK_SHOOT_COLLISION	 ;
		 bsr	EXECUTE_SHOOT_COLLISION	 ;
	 	 bsr	CHECK_BOBS_COLLISION	 ;
		 bsr	EXECUTE_BOBS_COLLISION	 ;
		;********************************;

		;********************************;
		;*****     Other things     *****;
		 bsr	CONTROL_SOUNDS		 ;
		 bsr	CONTROL_POINTS		 ;
		 bsr	CONTROL_GAME_OVER	 ;
		;********************************;

		lea	GAME_OVER(pc),a1
		tst.b	(a1)
		bne	GAME_OVER_

		btst	#10,POTGOR(a0)
		bne	GAME_MAIN

		;********************************;


GAME_OVER_:	sf	(a1)
		sf	MUSIC_ON_OFF

		move.w	#$4000,INTENA(a0)
		move.w	#$200,DMACON(a0)
		clr.w	COLOR00(a0)

		bra	INTRO_START


		;-------------------------------;
		CONTROL_SOUNDS:
		;-------------------------------;

		lea	MUSIC_ON_OFF(pc),a1

		tst.b	(a1)
 		beq	PLAY_MUSIC

		bsr	PLAY_SAMPLE
		bra	CTRL_SHOOT_SOUND	

PLAY_MUSIC:	jmp	PLAY_SONG


		;-------------------------------;
		INIT_SOUNDS:
		;-------------------------------;

		lea	MUSIC_ON_OFF(pc),a1

		tst.b	(a1)
		bne	INIT_AUDIOS

INIT_MUSIC:	moveq	#1,d0
		jmp	INIT_SONG


;-----------------------------------------------------------------------;
;		;***** Bob Routine *****;				;
;-----------------------------------------------------------------------;

		;-------------------------------;
		BLT_BOBS:	
		;-------------------------------;

		lea	BOB_STRUCTS(pc),a1
		moveq	#PANZER_AMOUNT+SCHUSS_AMOUNT+1,d2
		bsr	BLT_BOB
		rts


		;******************************;
		;** BOB_STRUCT_PREFERENCES  ***;
		;******************************;

		BOB_F:		equ	0		; BOB  Pointer
		BOB_MASK_F:	equ	BOB_F+4		; MASK Pointer
		BOB_BLTSIZE_F:	equ	BOB_MASK_F+4	; for BLTSIZE
		BOB_BLTAMOD_F:	equ	BOB_BLTSIZE_F+2	; for BLTAMOD
		BOB_BLTDMOD_F:	equ	BOB_BLTAMOD_F+2	; for BLTDMOD
		BOB_OLD_X_F:	equ	BOB_BLTDMOD_F+2	; Old x
		BOB_OLD_Y_F:	equ	BOB_OLD_X_F+2	; Old y
		BOB_NEW_X_F:	equ	BOB_OLD_Y_F+2	; New x
		BOB_NEW_Y_F:	equ	BOB_NEW_X_F+2	; New y
		BOB_STRUCT_SIZE:equ	BOB_NEW_Y_F+2	; How many STRUCTS


		;******************************;
		;***      BOB_STRUCTS       ***;
		;******************************;


;Syntax :	dc.l	*Bob
;              	dc.l	*Bob_Mask
;              	dc.w	Blitsize
;              	dc.w	BLTaMOD
;              	dc.w	BLTdMOD
;              	dc.w	OLD_X, OLD_Y
;		dc.w	NEW_X, NEW_Y


		;************************************;

		BOB_STRUCTS:

		SCHUSS_STRUCTS:
SCHUSS_STRUCT1:	dc.l	SCHUESSE
		dc.l	SCHUESSE_MASK
		dc.w	[DEPTH*SCHUSS_HEIGHT*64]+[SCHUSS_WBYTE/2]
		dc.w	SCHUSS_WBYTES-SCHUSS_WBYTE
		dc.w	GAME_WBYTES-SCHUSS_WBYTE
		dc.w	0,0
		dc.w	0,0

SCHUSS_STRUCT2:	dc.l	SCHUESSE
		dc.l	SCHUESSE_MASK
		dc.w	[DEPTH*SCHUSS_HEIGHT*64]+[SCHUSS_WBYTE/2]
		dc.w	SCHUSS_WBYTES-SCHUSS_WBYTE
		dc.w	GAME_WBYTES-SCHUSS_WBYTE
		dc.w	0,0
		dc.w	0,0


		;************************************;

		PANZER_STRUCTS:	
PANZER_STRUCT1:	dc.l	PANZER+[PANZER_WBYTE*2]
		dc.l	PANZER_MASK+[PANZER_WBYTE*2]
		dc.w	[DEPTH*PANZER_HEIGHT*64]+[PANZER_WBYTE/2]
		dc.w	PANZER_WBYTES-PANZER_WBYTE
		dc.w	GAME_WBYTES-PANZER_WBYTE
		dc.w	64+32,64+128
		dc.w	64+32,64+128

PANZER_STRUCT2:	dc.l	PANZER+[PANZER_WBYTE*6]
		dc.l	PANZER_MASK+[PANZER_WBYTE*6]
		dc.w	[DEPTH*PANZER_HEIGHT*64]+[PANZER_WBYTE/2]
		dc.w	PANZER_WBYTES-PANZER_WBYTE
		dc.w	GAME_WBYTES-PANZER_WBYTE
		dc.w	64+290,64+128+30
		dc.w	64+290,64+128+30


		;************************************;


		;-------------------------------;
		BLT_BOB:	
		;-------------------------------;

		;******************************;
		;**    Double buffering     ***;
		;******************************;

		lea	HOW_SCREEN(pc),a2
		lea	BITPLANES_PTR(pc),a3

		tst.b	(a2)
		bne	NO_BITPLANES1
		st      (a2)
		move.l	#BITPLANES2+PLANE_OFFS,d1
		move.l	#BITPLANES1,(a3)
		bra	ACTIVE_PLANES

NO_BITPLANES1:	sf      (a2)
		move.l	#BITPLANES1+PLANE_OFFS,d1
		move.l	#BITPLANES2,(a3)
		
ACTIVE_PLANES:	move.l	GAME_COPPER_PTR(pc),a3
		move.w	#BPL1PTH,d3
		moveq	#DEPTH-1,d0
ACTIVE_PLANES_LOOP:
		move.w	d3,(a3)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a3)+
		move.w	d3,(a3)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a3)+
		add.l	#GAME_WBYTES,d1
		dbra	d0,ACTIVE_PLANES_LOOP


		;******************************;
		;** Put BUFFER to old place ***;
		;******************************;

		move.l	BITPLANES_PTR(pc),a4
		lea	BITPLANES3,a5
		move.l	a1,a6

		move.l	d2,d7
		move.w	#GAME_WBYTES*DEPTH,d3
		moveq	#16,d4		; BltScrollAcc

		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

PUT_BACK_LOOP:	move.l	a4,a2
		move.l	a5,a3
		moveq	#0,d0
		moveq	#0,d1
		move.w	BOB_OLD_X_F(a1),d0
		sub.w	#16,d0
		move.w	BOB_OLD_Y_F(a1),d1
		subq.w	#6,d1

		mulu    d3,d1	; ( d3 = WBYTES * DEPTH ) X - POSITION
		add.l	d1,a2	; ( a2 = BITPLANESx )
		add.l	d1,a3	; ( a3 = BITPLANES3 )
		moveq	#0,d1

		divu    d4,d0	; ( d4 = 16 ) Y - POSITION
		move.w	d0,d1
		lsl.w	#1,d1
		add.l	d1,a2
		add.l	d1,a3

		move.w	#GAME_WBYTES-PANZER_WBYTE-2-2,BLTAMOD(a0)
		move.w	#GAME_WBYTES-PANZER_WBYTE-2-2,BLTDMOD(a0)

		move.l	a3,BLTAPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	#[[[6+PANZER_HEIGHT+6]*DEPTH]*64]+[[2+PANZER_WBYTE+2]/2],BLTSIZE(a0)

WAIT_BLITTER1:	btst    #14,DMACONR(a0)
		bne	WAIT_BLITTER1

		lea	BOB_STRUCT_SIZE(a1),a1
		dbra	d7,PUT_BACK_LOOP


		;******************************;
		;***  Blt BOB to BITPLANES  ***;
		;******************************;

		move.l	d2,d7
		move.l	a6,a1
		move.l	BITPLANES_PTR(pc),a4

BLT_BOB_LOOP:	move.l	a4,a2
		moveq	#0,d0
		moveq	#0,d1
		move.w	BOB_NEW_X_F(a1),d0
		move.w	BOB_NEW_Y_F(a1),d1

		mulu    d3,d1                   ; X - POSITION
		add.l	d1,a2
		moveq	#0,d1

		divu    d4,d0                   ; Y - POSITION
		move.w	d0,d1
		lsl.w	#1,d1
		add.l	d1,a2
		clr.w	d0
		swap    d0
		lsl.w	#8,d0
		lsl.w	#4,d0

		move.w	d0,BLTCON1(a0)
		or.w	#$0FCA,d0
		move.w	d0,BLTCON0(a0)

		move.w	BOB_BLTAMOD_F(a1),BLTAMOD(a0)
		move.w	BOB_BLTAMOD_F(a1),BLTBMOD(a0)
		move.w	BOB_BLTDMOD_F(a1),BLTCMOD(a0)
		move.w	BOB_BLTDMOD_F(a1),BLTDMOD(a0)

		move.l	BOB_MASK_F(a1),BLTAPTH(a0)
		move.l	BOB_F(a1),BLTBPTH(a0)
		move.l	a2,BLTCPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	BOB_BLTSIZE_F(a1),BLTSIZE(a0)

WAIT_BLITTER2:	btst    #14,DMACONR(a0)
		bne	WAIT_BLITTER2

		lea	BOB_STRUCT_SIZE(a1),a1
		dbra	d7,BLT_BOB_LOOP
		rts

HOW_SCREEN:	dc.l	0
BITPLANES_PTR:	dc.l	0


;-----------------------------------------------------------------------;
;		;***** Bob Routine ENDE *****;				;
;-----------------------------------------------------------------------;


		PLATTE:		equ	23

		;-------------------------------;
		CALC_PANZER_POSNS:
		;-------------------------------;

		movem.l	a0-a6/d0-d7,-(sp)

		move.l	LEVEL_STRUCT_GAME1+LAND_LEVELS_F(pc),a3
		lea	LEVEL_SIZE+1(a3),a4


		;*****************************;
		;***** Calc for Panzer 1 *****;
		;*****************************;

		moveq	#0,d0

CALC_PANZER_ONE:cmp.b	#PLATTE,(a3)+
		beq	FOUND_PLACE_ONE
		addq.w	#1,d0
		cmp.w	#LEVEL_SIZE,d0
		bne	CALC_PANZER_ONE
		bra	CALC_SECOND_PLACE

FOUND_PLACE_ONE:lea	PANZER_STRUCT1(pc),a1
		bsr	CALC_PANZER_PLACE


		;*****************************;
		;***** Calc for Panzer 1 *****;
		;*****************************;

CALC_SECOND_PLACE:
		move.l	#LEVEL_SIZE,d0
CALC_PANZER_TWO:cmp.b	#PLATTE,-(a4)
		beq	FOUND_PLACE_TWO
		subq.w	#1,d0
		bne	CALC_PANZER_TWO
		bra	CALC_PLACE_EXIT

FOUND_PLACE_TWO:lea	PANZER_STRUCT2(pc),a1
		bsr	CALC_PANZER_PLACE

CALC_PLACE_EXIT:movem.l	(sp)+,a0-a6/d0-d7
		rts


		;*****************************;
		;*****  Calc the place   *****;
		;*****************************;

CALC_PANZER_PLACE:
		divu	#MAUER_WBYTES/2,d0
		move.l	d0,d1

		mulu	#MAUER_HEIGHT,d0
		add.w	#64,d0
		move.w	d0,BOB_NEW_Y_F(a1)
		move.w	d0,BOB_OLD_Y_F(a1)

		swap	d1
		mulu	#MAUER_HEIGHT,d1
		add.w	#64,d1
		move.w	d1,BOB_NEW_X_F(a1)
		move.w	d1,BOB_OLD_X_F(a1)
		rts


;-----------------------------------------------------------------------;
;		;***** SampleRoutine with Interupt *****;		;
;-----------------------------------------------------------------------;

		;***********************************;
		;***** Einmal zu 'INIT_AUDIOS' *****;
		;***** Im VB  zu 'PLAY_SAMPLE' *****;
		;***********************************;


		;***** AudioPrefs *****;

		AUD_LOCATE_F:	equ	0
		AUD_LENGTH_F:	equ	AUD_LOCATE_F+4
		AUD_PERIODE_F:	equ	AUD_LENGTH_F+2
		AUD_VOLUME_F:	equ	AUD_PERIODE_F+2
		AUD_SIZE_F:	equ	AUD_VOLUME_F+2


		;---------------------------------------;
		; AudSyntax:	dc.l	*Sound		;
		;		dc.w	Length		;
		;		dc.w	Periode		;
		;		dc.w	Volume		;
		;---------------------------------------;


		;***** SampleStructs *****;

	AUD0_STRUCT:
		dc.l	DRIVE_SOUND
		dc.w	600,400,20

	AUD1_STRUCT:
		dc.l	DRIVE_SOUND
		dc.w	600,400,20

	AUD2_STRUCT:
		dc.l	SHOOT_SOUND
		dc.w	400,1000,0

	AUD3_STRUCT:
		dc.l	SHOOT_SOUND
		dc.w	400,1000,0


		;-------------------------------;
		PLAY_SAMPLE:
		;-------------------------------;


		;***** Audio 2 Interupt *****;

		move.w	INTREQR(a0),d0
		and.w	#$0200,d0
		beq	NO_AUD2_INTERUPT
		move.w	#$0200,INTREQ(a0)

		clr.l	AUD2LCH(a0)
		clr.w	AUD2PER(a0)
		clr.w	AUD2VOL(a0)


		;***** Audio 3 Interupt *****;

	NO_AUD2_INTERUPT:
		move.w	INTREQR(a0),d0
		and.w	#$0400,d0
		beq	NO_AUD3_INTERUPT
		move.w	#$0400,INTREQ(a0)

		clr.l	AUD3LCH(a0)
		clr.w	AUD3PER(a0)
		clr.w	AUD3VOL(a0)

	NO_AUD3_INTERUPT:
		rts


		;-------------------------------;
		INIT_AUDIOS:
		;-------------------------------;

		;***** Interrupt & DMA OFF *****;

		lea	CUSTOM,a0
		move.w	#$000F,DMACON(a0)
		move.w	#$0780,INTREQ(a0)


		;***** Init Audios *****;

		lea	AUD0LCH(a0),a1
		lea	AUD0_STRUCT(pc),a2
		moveq	#4-1,d7

	PUT_AUD_DATAS:
		move.l	(a2)+,(a1)+
		move.w	(a2)+,(a1)+
		move.w	(a2)+,(a1)+
		move.w	(a2)+,(a1)+
		addq.l	#6,a1
		dbra	d7,PUT_AUD_DATAS


		;***** Interrupt & DMA ON *****;

		move.w	DMACONR(a0),d0
		or.w	#$820F,d0
		move.w	d0,DMACON(a0)
		rts


;-----------------------------------------------------------------------;
;		;***** SampleRoutine with Interupt ENDE  *****;		;
;-----------------------------------------------------------------------;


		;-------------------------------;
		CTRL_SHOOT_SOUND:
		;-------------------------------;

		lea	JOY_PORT_1(pc),a1
		lea	SOUND_FLAG1(pc),a2
		lea	AUD2_STRUCT(pc),a3
		bsr	CTRL_SOUND

		lea	JOY_PORT_2(pc),a1
		lea	SOUND_FLAG2(pc),a2
		lea	AUD3_STRUCT(pc),a3
	;	bsr	CTRL_SOUND


CTRL_SOUND:	tst.b	FIRE_F(a1)
		beq	NO_FIRED

		tst.b	(a2)
		bne	NO_FIRED

		move.w	#$0200,INTREQ(a0)
		move.l	AUD_LOCATE_F(a3),AUD2LCH(a0)
		move.w	AUD_PERIODE_F(a3),AUD2PER(a0)
		move.w	#64,AUD2VOL(a0)

		st	(a2)

NO_FIRED:	tst.b	FIRE_F(a1)
		bne	FIRE_SOUND_EXIT
		sf	(a2)

FIRE_SOUND_EXIT:rts

SOUND_FLAG1:	dc.b	0
SOUND_FLAG2:	dc.b	0


		;-------------------------------;
		IMPROVE_GAME_BORDERS:
		;-------------------------------;

		lea	PANZER_STRUCT1(pc),a1
		bsr	IMPROVE_BORDERS

		lea	PANZER_STRUCT2(pc),a1
		bsr	IMPROVE_BORDERS
		rts


		;-------------------------------;
		IMPROVE_BORDERS:
		;-------------------------------;

		cmp.w	#64-32,BOB_NEW_X_F(a1)
		bhi	NO_BORDER_LEFT
		move.w	#64+320+64-32,BOB_NEW_X_F(a1)
		move.w	#64+320+64-32,BOB_OLD_X_F(a1)
		rts

NO_BORDER_LEFT:	cmp.w	#64+320+64-32,BOB_NEW_X_F(a1)
		blo	NO_BORDER_RIGHT
		move.w	#64-32,BOB_NEW_X_F(a1)
		move.w	#64-32,BOB_OLD_X_F(a1)
		rts

NO_BORDER_RIGHT:cmp.w	#64-16,BOB_NEW_Y_F(a1)
		bhs	NO_BORDER_UP
		move.w	#64+224+64-16,BOB_NEW_Y_F(a1)
		move.w	#64+224+64-16,BOB_OLD_Y_F(a1)

NO_BORDER_UP:	cmp.w	#64+224+64-16,BOB_NEW_Y_F(a1)
		bls	NO_BORDER_DOWN
		move.w	#64-16,BOB_NEW_Y_F(a1)
		move.w	#64-16,BOB_OLD_Y_F(a1)

NO_BORDER_DOWN:	rts

		

		;-------------------------------;
		MOVE_PANZER:
		;-------------------------------;

		lea	AUD0PER(a0),a0
		lea	PANZER_STRUCT1(pc),a1
		lea	RICHTUNGS_PTR1(pc),a2
		lea	OLD_JOY_MESSAGE_1(pc),a3
		lea	CLOSE_UP_DOWN_1(pc),a4
		lea	UP_DOWN_1(pc),a5
		lea	JOY_PORT_1(pc),a6
		bsr	MOVE_BOB
		lea	CUSTOM,a0

		lea	AUD1PER(a0),a0
		lea	PANZER_STRUCT2(pc),a1
		lea	RICHTUNGS_PTR2(pc),a2
		lea	CLOSE_UP_DOWN_2(pc),a4
		lea	OLD_JOY_MESSAGE_2(pc),a3
		lea	UP_DOWN_2(pc),a5
		lea	JOY_PORT_2(pc),a6
		bsr	MOVE_BOB
		lea	CUSTOM,a0
		rts


	;*****************************************;

		CLOSE_UP_F:	equ	0
		CLOSE_DOWN_F:	equ	CLOSE_UP_F+1

	CLOSE_UP_DOWN_1:
		CLOSE_UP_1:	dc.b	0
		CLOSE_DOWN_1:	dc.b	0

	CLOSE_UP_DOWN_2:
		CLOSE_UP_2:	dc.b	0
		CLOSE_DOWN_2:	dc.b	0


	;*****************************************;

		OLD_RIGHT_F:	equ	0
		OLD_LEFT_F:	equ	OLD_RIGHT_F+1

	OLD_JOY_MESSAGE_1:
		OLD_RIGHT_1:	dc.b	0
		OLD_LEFT_1:	dc.b	0

	OLD_JOY_MESSAGE_2:
		OLD_RIGHT_2:	dc.b	0
		OLD_LEFT_2:	dc.b	0


;-----------------------------------------------------------------------;
;		;***** Move Bob in 8 Himmelsrichtungen ****;		;
;-----------------------------------------------------------------------;

		SPEED:		equ	1

RICHTUNGS_PTR1:	dc.l	RICHTUNGS_TAB+[4*2]
RICHTUNGS_PTR2:	dc.l	RICHTUNGS_TAB+[4*6]

RICHTUNGS_TAB:	dc.w	     0,-SPEED
		dc.w	 SPEED,-SPEED
		dc.w	 SPEED,     0
		dc.w	 SPEED, SPEED
		dc.w	     0, SPEED
		dc.w	-SPEED, SPEED
		dc.w	-SPEED,     0
		dc.w	-SPEED,-SPEED

UP_DOWN_1:	dc.b	0
UP_DOWN_2:	dc.b	0
		even


		;-------------------------------;
		MOVE_BOB:
		;-------------------------------;

		tst.b	RIGHT_F(a6)
		bne	MOVE_PANZER_RIGHT
		sf	OLD_RIGHT_F(a3)

		tst.b	LEFT_F(a6)
		bne	MOVE_PANZER_LEFT
		sf	OLD_LEFT_F(a3)

		tst.b	UP_F(a6)
		bne	MOVE_PANZER_UP

		tst.b	DOWN_F(a6)
		bne	MOVE_PANZER_DOWN

		tst.b	MUSIC_ON_OFF
		beq	NO_SAMPLE1
		move.w	#400,(a0)
NO_SAMPLE1:	bra	MOVE_EXIT


		;**********************;
		;***** Move Right *****;
		;**********************;

MOVE_PANZER_RIGHT:
		sf	RIGHT_F(a6)

		tst.b	OLD_RIGHT_F(a3)
		bne	EXIT_RIGHT
		st	OLD_RIGHT_F(a3)

		addq.l	#PANZER_WBYTE,BOB_F(a1)
		addq.l	#PANZER_WBYTE,BOB_MASK_F(a1)
		addq.l	#4,(a2)

		cmp.l	#PANZER+[PANZERS*PANZER_WBYTE],BOB_F(a1)
		bne	MOVE_EXIT

		move.l	#PANZER,BOB_F(a1)
		move.l	#PANZER_MASK,BOB_MASK_F(a1)
		move.l	#RICHTUNGS_TAB,(a2)

EXIT_RIGHT:	bra	MOVE_EXIT


		;**********************;
		;***** Move Left  *****;
		;**********************;

MOVE_PANZER_LEFT:
		sf	LEFT_F(a6)

		tst.b	OLD_LEFT_F(a3)
		bne	EXIT_LEFT
		st	OLD_LEFT_F(a3)

		subq.l	#PANZER_WBYTE,BOB_F(a1)
		subq.l	#PANZER_WBYTE,BOB_MASK_F(a1)
		subq.l	#4,(a2)

		cmp.l	#PANZER-PANZER_WBYTE,BOB_F(a1)
		bne	MOVE_EXIT

		move.l	#PANZER+[PANZERS*PANZER_WBYTE]-PANZER_WBYTE,BOB_F(a1)
		move.l	#PANZER_MASK+[PANZERS*PANZER_WBYTE]-PANZER_WBYTE,BOB_MASK_F(a1)
		move.l	#RICHTUNGS_TAB+[PANZERS*4]-4,(a2)

EXIT_LEFT:	bra	MOVE_EXIT


		;**********************;
		;*****  Move Up   *****;
		;**********************;

MOVE_PANZER_UP:	sf	UP_F(a6)

		tst.b	CLOSE_UP_F(a4)
		bne	MOVE_EXIT

		st	(a5)		; UpDownFlag

		tst.b	MUSIC_ON_OFF
		beq	NO_SAMPLE2
		move.w	#300,(a0)

NO_SAMPLE2:	move.l	(a2),a3
		movem.w	(a3),d0/d1

		add.w	d0,BOB_NEW_X_F(a1)
		add.w	d0,BOB_OLD_X_F(a1)

		add.w	d1,BOB_NEW_Y_F(a1)
		add.w	d1,BOB_OLD_Y_F(a1)

		bra	MOVE_EXIT


		;**********************;
		;***** Move Down  *****;
		;**********************;

MOVE_PANZER_DOWN:
		sf	DOWN_F(a6)

		tst.b	CLOSE_DOWN_F(a4)
		bne	MOVE_EXIT

		sf	(a5)		; UpDownFlag

		tst.b	MUSIC_ON_OFF
		beq	NO_SAMPLE3
		move.w	#300,(a0)

NO_SAMPLE3:	move.l	(a2),a3
		movem.w	(a3),d0/d1

		sub.w	d0,BOB_NEW_X_F(a1)
		sub.w	d0,BOB_OLD_X_F(a1)

		sub.w	d1,BOB_NEW_Y_F(a1)
		sub.w	d1,BOB_OLD_Y_F(a1)

MOVE_EXIT:	rts


;-----------------------------------------------------------------------;
;		;***** Move Bob in 8 Himmelsrichtungen ENDE ****;	;
;-----------------------------------------------------------------------;


;-----------------------------------------------------------------------;
;		;***** Collision mit dem Hintergrund ****;		;
;-----------------------------------------------------------------------;


		;-------------------------------;
		CHECK_SHOOT_COLLISION:
		;-------------------------------;

		;***** CheckColl Shoot *****;

		lea	SCHUSS_STRUCT1(pc),a1
		lea	MAUER_SHOOT_FLAGS1(pc),a2
		lea	COLL_SHOOT_OFFS(pc),a3
		bsr	CHECK_PANZER_COLL

		lea	SCHUSS_STRUCT2(pc),a1
		lea	MAUER_SHOOT_FLAGS2(pc),a2
		lea	COLL_SHOOT_OFFS(pc),a3
		bsr	CHECK_PANZER_COLL
		rts


		SHOOT_SEITE:	equ	8

COLL_SHOOT_OFFS:
		dc.w	          8,8
		dc.w	SHOOT_SEITE,8
		dc.w	          8,SHOOT_SEITE
		dc.w	SHOOT_SEITE,SHOOT_SEITE


		;-------------------------------;
		CHECK_PANZER_COLLISION:
		;-------------------------------;

		;***** CheckColl Panzer *****;

		lea	PANZER_STRUCT1(pc),a1
		lea	MAUER_PANZER_FLAGS1(pc),a2
		lea	COLL_PANZER_OFFS(pc),a3
		bsr	CHECK_PANZER_COLL

		lea	PANZER_STRUCT2(pc),a1
		lea	MAUER_PANZER_FLAGS2(pc),a2
		lea	COLL_PANZER_OFFS(pc),a3
		bsr	CHECK_PANZER_COLL
		rts


		PANZER_SEITE:	equ	15

COLL_PANZER_OFFS:
		dc.w	           1,1
		dc.w	PANZER_SEITE,1
		dc.w	           1,PANZER_SEITE
		dc.w	PANZER_SEITE,PANZER_SEITE


		;-------------------------------;
		CHECK_PANZER_COLL:
		;-------------------------------;

		move.w	(a2)+,d7	; Leer, nur so.
		move.l	a2,a4

		moveq	#4-1,d7		; Weil Vier Ecken zu pruefen sind

CHECK_COLL_LOOP:moveq	#0,d0
		move.w	BOB_NEW_X_F(a1),d0
		add.w	(a3)+,d0	; X

		moveq	#0,d1
		move.w	BOB_NEW_Y_F(a1),d1
		add.w	(a3)+,d1	; Y

		bsr	CHECK_QUADRAT_CODE
		move.l	a4,a2
		dbra	d7,CHECK_COLL_LOOP
		rts


		;-------------------------------;
		; **** CHECK_QUADRAT_CODE ****  ;
		;-------------------------------;

		;**********************;
		;***** MauerCodes *****;
		;**********************;

		;***** Mauer *****;

	MAUER_KAPUTT_C:		equ	3
	MAUER_PLATTE_C:		equ	23

	MAUER_VERT_C:		equ	0	; ( MauerVerticalCode)
	MAUER_HORI_C:		equ	20
	MAUER_OBEN_C:		equ	1
	MAUER_UNTEN_C:		equ	21
	MAUER_LINKS_C:		equ	2
	MAUER_RECHTS_C:		equ	22


		;***** Ufer & See *****;

	UFER_KAPUTT_C:		equ	26

	UFER_UNTEN_C: 		equ	24
	UFER_OBEN_C: 	 	equ	25
	UFER_LINKS_C: 		equ	4
	SEE_C:			equ	5
	UFER_RECHTS_C:		equ	6


		;*****    Gras    *****;

	GRAS_KAPUTT_C:		equ	11

	GRAS_UNTEN_C:		equ	7
	GRAS_OBEN_C:		equ	27
	GRAS_RECHTS_C:		equ	8
	GRAS_LINKS_C:		equ	28
	GRAS_LINKS_OBEN_C:	equ	9
	GRAS_RECHTS_OBEN_C:	equ	10
	GRAS_UNTEN_LINKS_C:	equ	29
	GRAS_UNTEN_RECHTS_C:	equ	30


		;*****  Futures   *****;


		;**********************;

	CHECK_AMOUNT:	equ	19

		;**********************;


MAUER_CODES_TAB:dc.w	CHECK_AMOUNT-1		; How many ?

		dc.b	MAUER_VERT_C		; Alles fuer Compare
		dc.b	MAUER_HORI_C
		dc.b	MAUER_OBEN_C
		dc.b	MAUER_UNTEN_C
		dc.b	MAUER_LINKS_C
		dc.b	MAUER_RECHTS_C

		dc.b	UFER_UNTEN_C
		dc.b	UFER_OBEN_C
		dc.b	UFER_LINKS_C
		dc.b	UFER_RECHTS_C
		dc.b	SEE_C

		dc.b	GRAS_UNTEN_C
		dc.b	GRAS_OBEN_C
		dc.b	GRAS_RECHTS_C
		dc.b	GRAS_LINKS_C
		dc.b	GRAS_LINKS_OBEN_C
		dc.b	GRAS_RECHTS_OBEN_C
		dc.b	GRAS_UNTEN_LINKS_C
		dc.b	GRAS_UNTEN_RECHTS_C
		EVEN


	;*****************************************;

		;**********************;


	MAUER_PANZER_FLAGS1:	dc.w	CHECK_AMOUNT-1
		MAUER_VERT1:	dc.b	0
		MAUER_HORI1:	dc.b	0
		MAUER_OBEN1:	dc.b	0
		MAUER_UNTEN1:	dc.b	0
		MAUER_LINKS1:	dc.b	0
		MAUER_RECHTS1:	dc.b	0

		SEE_GRAS_UNTEN1:dc.b	0
		SEE_GRAS_OBEN1:	dc.b	0
		SEE_GRAS_LINKS1:dc.b	0
		SEE_GRAS_RECHTS1:dc.b	0
		SEE1:		dc.b	0

		GRAS_UNTEN1:	dc.b	0
		GRAS_OBEN1:	dc.b	0
		GRAS_RECHTS1:	dc.b	0
		GRAS_LINKS1:	dc.b	0
		GRAS_LINKS_OBEN1:dc.b	0
		GRAS_RECHTS_OBEN1:dc.b	0
		GRAS_UNTEN_LINKS1:dc.b	0
		GRAS_UNTEN_RECHTS1:dc.b	0
		EVEN


		;**********************;


	MAUER_PANZER_FLAGS2:	dc.w	CHECK_AMOUNT-1
		MAUER_VERT2:	dc.b	0
		MAUER_HORI2:	dc.b	0
		MAUER_OBEN2:	dc.b	0
		MAUER_UNTEN2:	dc.b	0
		MAUER_LINKS2:	dc.b	0
		MAUER_RECHTS2:	dc.b	0

		SEE_GRAS_UNTEN2:dc.b	0
		SEE_GRAS_OBEN2:	dc.b	0
		SEE_GRAS_LINKS2:dc.b	0
		SEE_GRAS_RECHTS2:dc.b	0
		SEE2:		dc.b	0

		GRAS_UNTEN2:	dc.b	0
		GRAS_OBEN2:	dc.b	0
		GRAS_RECHTS2:	dc.b	0
		GRAS_LINKS2:	dc.b	0
		GRAS_LINKS_OBEN2:dc.b	0
		GRAS_RECHTS_OBEN2:dc.b	0
		GRAS_UNTEN_LINKS2:dc.b	0
		GRAS_UNTEN_RECHTS2:dc.b	0
		EVEN


	;********************************************;
		
	MAUER_SHOOT_FLAGS1:	dc.w	CHECK_AMOUNT-1
		MAUER_VERT3:	dc.b	0
		MAUER_HORI3:	dc.b	0
		MAUER_OBEN3:	dc.b	0
		MAUER_UNTEN3:	dc.b	0
		MAUER_LINKS3:	dc.b	0
		MAUER_RECHTS3:	dc.b	0

		SEE_GRAS_UNTEN3:dc.b	0
		SEE_GRAS_OBEN3:	dc.b	0
		SEE_GRAS_LINKS3:dc.b	0
		SEE_GRAS_RECHTS3:dc.b	0
		SEE3:		dc.b	0

		GRAS_UNTEN3:	dc.b	0
		GRAS_OBEN3:	dc.b	0
		GRAS_RECHTS3:	dc.b	0
		GRAS_LINKS3:	dc.b	0
		GRAS_LINKS_OBEN3:dc.b	0
		GRAS_RECHTS_OBEN3:dc.b	0
		GRAS_UNTEN_LINKS3:dc.b	0
		GRAS_UNTEN_RECHTS3:dc.b	0
		EVEN


		;************************;

	MAUER_SHOOT_FLAGS2:	dc.w	CHECK_AMOUNT-1
		MAUER_VERT4:	dc.b	0
		MAUER_HORI4:	dc.b	0
		MAUER_OBEN4:	dc.b	0
		MAUER_UNTEN4:	dc.b	0
		MAUER_LINKS4:	dc.b	0
		MAUER_RECHTS4:	dc.b	0

		SEE_GRAS_UNTEN4:dc.b	0
		SEE_GRAS_OBEN4:	dc.b	0
		SEE_GRAS_LINKS4:dc.b	0
		SEE_GRAS_RECHTS4:dc.b	0
		SEE4:		dc.b	0

		GRAS_UNTEN4:	dc.b	0
		GRAS_OBEN4:	dc.b	0
		GRAS_RECHTS4:	dc.b	0
		GRAS_LINKS4:	dc.b	0
		GRAS_LINKS_OBEN4:dc.b	0
		GRAS_RECHTS_OBEN4:dc.b	0
		GRAS_UNTEN_LINKS4:dc.b	0
		GRAS_UNTEN_RECHTS4:dc.b	0
		EVEN


		;-------------------------------;
		CHECK_QUADRAT_CODE:
		;-------------------------------;

		movem.l	d2/d7/a3,-(sp)


		;*************************;
		;** Calc Panzer Quadrat **;
		;*************************;

		sub.w	#[X_OFFS*8],d0
		lsr.w	#4,d0	; X / 16

		sub.w	#Y_OFFS,d1
		lsr.w	#4,d1	; Y / 16


		;*************************;

		cmp.w	#20,d0	; Rechter Rand erreicht ?

		bhs	CHECK_COLL_EXIT

		cmp.w	#14,d1	; Unten erreicht ?
		bhs	CHECK_COLL_EXIT


		;*************************;
		;***** Take the Code *****;
		;*************************;

		mulu	#MAUER_WBYTES/MAUER_WBYTE,d1	; Reihe * Y
		add.w	d0,d1				; + X = ....

		move.l	LAND_LEVELS_F+LEVEL_STRUCT_GAME1(pc),a6	; LEVEL
		move.b	(a6,d1.l),d2	; d2 = GFXCode


		;*************************;
		;***** Check it now  *****;
		;*************************;

		lea	MAUER_CODES_TAB(pc),a3

		move.w	(a3)+,d7

CHECK_GFX_CODE_LOOP:
		cmp.b	(a3)+,d2
		bne	CHECK_NEXT_GFX_CODE
		st	(a2)
		bra	CHECK_COLL_EXIT
CHECK_NEXT_GFX_CODE:
		addq.l	#1,a2
		dbra	d7,CHECK_GFX_CODE_LOOP

CHECK_COLL_EXIT:movem.l	(sp)+,d2/d7/a3
		rts


;-----------------------------------------------------------------------;
;		;***** Collision mit dem Hintergrund ENDE ****;		;
;-----------------------------------------------------------------------;

		;-------------------------------;
		OPEN_UP_DOWN_AGAIN:
		;-------------------------------;

		lea	MAUER_PANZER_FLAGS1(pc),a1
		lea	CLOSE_UP_DOWN_1(pc),a2
		bsr	OPEN_UP_DOWN

		lea	MAUER_PANZER_FLAGS2(pc),a1
		lea	CLOSE_UP_DOWN_2(pc),a2
		bsr	OPEN_UP_DOWN
		rts


		;-------------------------------;
		OPEN_UP_DOWN:
		;-------------------------------;

		moveq	#0,d6
		move.w	(a1)+,d7

OPEN_UP_DOWN_LOOP:
		tst.b	(a1)+
		beq	NEXT_UP_DOWN
		st	d6
NEXT_UP_DOWN:	dbra	d7,OPEN_UP_DOWN_LOOP

		tst.b	d6
		bne	CLOSE_UP_DOWN_AGAIN

		sf	CLOSE_UP_F(a2)
		sf	CLOSE_DOWN_F(a2)

CLOSE_UP_DOWN_AGAIN:
		rts


		;-------------------------------;
		EXECUTE_SHOOT_COLLISION:
		;-------------------------------;

		;*****************************;

		lea	MAUER_SHOOT_FLAGS1(pc),a1
		lea	EXECUTE_SHOOT_TAB(pc),a2

		lea	SCHUSS_STRUCT1(pc),a3
		lea	SHOOT_FLAGS_1(pc),a4
		bsr	EXECUTE_BACK_COLLISION


		;*****************************;

		lea	MAUER_SHOOT_FLAGS2(pc),a1
		lea	EXECUTE_SHOOT_TAB(pc),a2

		lea	SCHUSS_STRUCT2(pc),a3
		lea	SHOOT_FLAGS_2(pc),a4
		bsr	EXECUTE_BACK_COLLISION
		rts


EXECUTE_SHOOT_TAB:
		dc.l	EXECUTE_MAUER_KAPUTT
		dc.l	EXECUTE_MAUER_KAPUTT
		dc.l	EXECUTE_MAUER_KAPUTT
		dc.l	EXECUTE_MAUER_KAPUTT
		dc.l	EXECUTE_MAUER_KAPUTT
		dc.l	EXECUTE_MAUER_KAPUTT

		dc.l	EXECUTE_UFER_KAPUTT
		dc.l	EXECUTE_UFER_KAPUTT
		dc.l	EXECUTE_UFER_KAPUTT
		dc.l	EXECUTE_UFER_KAPUTT
		dc.l	EXECUTE_LASSEN

		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT
		dc.l	EXECUTE_GRAS_KAPUTT


		;-------------------------------;
		EXECUTE_PANZER_COLLISION:
		;-------------------------------;

		;*****************************;

		lea	MAUER_PANZER_FLAGS1(pc),a1
		lea	EXECUTE_PANZER_TAB(pc),a2

		lea	CLOSE_UP_DOWN_1(pc),a3
		lea	UP_DOWN_1(pc),a4
		lea	PANZER_STRUCT1(pc),a5
		lea	RICHTUNGS_PTR1(pc),a6
		bsr	EXECUTE_BACK_COLLISION


		;*****************************;

		lea	MAUER_PANZER_FLAGS2(pc),a1
		lea	EXECUTE_PANZER_TAB(pc),a2

		lea	CLOSE_UP_DOWN_2(pc),a3
		lea	UP_DOWN_2(pc),a4
		lea	PANZER_STRUCT2(pc),a5
		lea	RICHTUNGS_PTR2(pc),a6
		bsr	EXECUTE_BACK_COLLISION
		rts


EXECUTE_PANZER_TAB:
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP

		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP

		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP
		dc.l	EXECUTE_PANZER_BUMP


		;-------------------------------;
		EXECUTE_BACK_COLLISION:
		;-------------------------------;

		move.w	(a1)+,d7
EXECUTE_COLL_BACK_LOOP:
		tst.b	(a1)
		beq	NEXT_EXECUTE_BACK
		sf	(a1)
		move.l	(a2),a2
		jmp	(a2)
NEXT_EXECUTE_BACK:
		addq.l	#1,a1
		addq.l	#4,a2
		dbra	d7,EXECUTE_COLL_BACK_LOOP
		rts


	;************************************************;
	;*****          Excutes for Panzer          *****;
	;************************************************;

		;*******************************;
		;***** Execute Panzer BUMP *****;
		;*******************************;

	EXECUTE_PANZER_BUMP:

		move.l	(a6),a6
		movem.w	(a6),d0/d1

		tst.b	(a4)
		bne	CLOSING_UP

		st	CLOSE_DOWN_F(a3)

		add.w	d0,BOB_NEW_X_F(a5)
		add.w	d1,BOB_NEW_Y_F(a5)
		add.w	d0,BOB_OLD_X_F(a5)
		add.w	d1,BOB_OLD_Y_F(a5)
		rts

CLOSING_UP:	st	CLOSE_UP_F(a3)

		sub.w	d0,BOB_NEW_X_F(a5)
		sub.w	d1,BOB_NEW_Y_F(a5)
		sub.w	d0,BOB_OLD_X_F(a5)
		sub.w	d1,BOB_OLD_Y_F(a5)
		rts


	;************************************************;
	;*****          Excutes for Shoots          *****;
	;************************************************;


		;*******************************;
		;***** Execute Shoot BUMP  *****;
		;*******************************;

	EXECUTE_MAUER_KAPUTT:
		lea	MAUER+[MAUER_KAPUTT_C*2],a5
		moveq	#MAUER_KAPUTT_C,d7
		bra	MAKE_KAPUTT

	EXECUTE_UFER_KAPUTT:
		lea	MAUER+[[UFER_KAPUTT_C-20]*2]+[MAUER_HEIGHT*MAUER_WBYTES*DEPTH],a5
		moveq	#UFER_KAPUTT_C,d7
		bra	MAKE_KAPUTT

	EXECUTE_GRAS_KAPUTT:
		lea	MAUER+[GRAS_KAPUTT_C*2],a5
		moveq	#GRAS_KAPUTT_C,d7
	;	bra	MAKE_KAPUTT


MAKE_KAPUTT:	lea	BITPLANES1,a2
		bsr	CALC_BROKEN_POS
		bsr	BLT_BROKEN_POS

		lea	BITPLANES2,a2
		bsr	CALC_BROKEN_POS
		bsr	BLT_BROKEN_POS

		lea	BITPLANES3,a2
		bsr	CALC_BROKEN_POS
		bsr	BLT_BROKEN_POS


		;*******************************;

		lea	BITPLANES1,a2
		bsr	CALC_BROKEN_POS
		move.l	a2,a6
		sub.l	#BITPLANES1,a6
		add.l	#BITPLANES3,a6
		sub.l	#[GAME_WBYTES*DEPTH*16]+1,a2
		sub.l	#[GAME_WBYTES*DEPTH*16]+1,a6
		bsr	BLT_IMPROVE_POS

		lea	BITPLANES2,a2
		bsr	CALC_BROKEN_POS
		move.l	a2,a6
		sub.l	#BITPLANES2,a6
		add.l	#BITPLANES3,a6
		sub.l	#[GAME_WBYTES*DEPTH*16]+1,a2
		sub.l	#[GAME_WBYTES*DEPTH*16]+1,a6
		bsr	BLT_IMPROVE_POS


		;*************************;
		;** Calc Panzer Quadrat **;
		;*************************;

		moveq	#0,d0
		move.w	BOB_NEW_X_F(a3),d0
		sub.w	#[X_OFFS*8],d0
		addq.w	#8,d0
		lsr.w	#4,d0	; X / 16

		moveq	#0,d1
		move.w	BOB_NEW_Y_F(a3),d1
		sub.w	#Y_OFFS,d1
		addq.w	#8,d1
		lsr.w	#4,d1	; Y / 16

		mulu	#MAUER_WBYTES/MAUER_WBYTE,d1	; Reihe * Y
		add.w	d0,d1				; + X = ....

		move.l	LAND_LEVELS_F+LEVEL_STRUCT_GAME1(pc),a6	; LEVEL
		move.b	d7,(a6,d1.l)	; d2 = Boden


		;*******************************;

		clr.w	BOB_NEW_X_F(a3)
		clr.w	BOB_NEW_Y_F(a3)
		clr.w	BOB_OLD_X_F(a3)
		clr.w	BOB_OLD_Y_F(a3)

EXECUTE_LASSEN:	rts


		;*******************************;

	CALC_BROKEN_POS:
		moveq	#0,d0
		moveq	#0,d1

		move.w	BOB_NEW_X_F(a3),d0
		addq.w	#8,d0
		lsr.w	#4,d0	; X / 16
		lsl.w	#1,d0	; X * 02
		add.l	d0,a2

		move.w	BOB_NEW_Y_F(a3),d1
		addq.w	#8,d1
		lsr.w	#4,d1	; Y / 16
		lsl.w	#4,d1	; Y * 16
		mulu	#GAME_WBYTES*DEPTH,d1
		add.l	d1,a2
		rts


		;*******************************;

	BLT_BROKEN_POS:
		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

		move.w	#MAUER_WBYTES-MAUER_WBYTE,BLTAMOD(a0)
		move.w	#GAME_WBYTES-MAUER_WBYTE,BLTDMOD(a0)

		move.l	a5,BLTAPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER
		rts


		;*******************************;

	BLT_IMPROVE_POS:
		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

		move.w	#GAME_WBYTES-[MAUER_WBYTE*3],BLTAMOD(a0)
		move.w	#GAME_WBYTES-[MAUER_WBYTE*3],BLTDMOD(a0)

		move.l	a6,BLTAPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	#[[16+MAUER_HEIGHT+16]*DEPTH*64]+[[MAUER_WBYTE*3]/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER
		rts


		;*******************************;
		;*****  Execute Oel/See    *****;
		;*******************************;

	EXECUTE_SHOOT_HOHL:
		rts


;-----------------------------------------------------------------------;


		;-------------------------------;
		CHECK_BOBS_COLLISION:
		;-------------------------------;

		;***** Panzer 1 mit Schuss 2 *****;

		lea	SCHUSS_STRUCT2(pc),a1
		lea	SCHUSS_WIDTH(pc),a2

		lea	PANZER_STRUCT1(pc),a3
		lea	PANZER_WIDTH(pc),a4

		lea	PANZER1_SHOOT2(pc),a5

		lea	ENERGY_FLAG1(pc),a6
		lea	HOHL_FLAG(pc),a0
		bsr	CHECK_BOBS_COLL


		;***** Panzer 2 mit Schuss 1 *****;

		lea	SCHUSS_STRUCT1(pc),a1
		lea	SCHUSS_WIDTH(pc),a2

		lea	PANZER_STRUCT2(pc),a3
		lea	PANZER_WIDTH(pc),a4

		lea	PANZER2_SHOOT1(pc),a5

		lea	ENERGY_FLAG2(pc),a6
		lea	HOHL_FLAG(pc),a0
		bsr	CHECK_BOBS_COLL


		;***** Panzer 1 mit Panzer 2 *****;

		lea	PANZER_STRUCT1(pc),a1
		lea	PANZER_WIDTH(pc),a2

		lea	PANZER_STRUCT2(pc),a3
		lea	PANZER_WIDTH(pc),a4

		lea	PANZER1_PANZER2(pc),a5

		lea	HOHL_FLAG(pc),a0
		lea	HOHL_FLAG(pc),a6
		bsr	CHECK_BOBS_COLL


		;***** Panzer 2 mit Panzer 1 *****;

		lea	PANZER_STRUCT2(pc),a1
		lea	PANZER_WIDTH(pc),a2

		lea	PANZER_STRUCT1(pc),a3
		lea	PANZER_WIDTH(pc),a4

		lea	PANZER2_PANZER1(pc),a5

		lea	HOHL_FLAG(pc),a0
		lea	HOHL_FLAG(pc),a6
		bsr	CHECK_BOBS_COLL

		lea	CUSTOM,a0
		rts


		;***** CollBobsPrefs *****;

		PANZER1_SHOOT2_F:	equ	0
		PANZER2_SHOOT1_F:	equ	PANZER1_SHOOT2_F+1
		PANZER1_PANZER2_F:	equ	PANZER2_SHOOT1_F+1
		PANZER2_PANZER1_F:	equ	PANZER1_PANZER2_F+1


		;*************************;

	COLL_BOBS_FLAGS:
		COLL_BOBS_AMOUNT:	dc.w	4-1
		PANZER1_SHOOT2:		dc.b	0
		PANZER2_SHOOT1:		dc.b	0
		PANZER1_PANZER2:	dc.b	0
		PANZER2_PANZER1:	dc.b	0


		;*************************;

	WIDTH_BOBS:
		SCHUSS_WIDTH:		dc.w	16
		PANZER_WIDTH:		dc.w	16


;-----------------------------------------------------------------------;
;		;***** Collision mit zwei BOBS *****;
;-----------------------------------------------------------------------;
		
		;-------------------------------;
		CHECK_BOBS_COLL:
		;-------------------------------;

		;***** Check x1 and x2 *****;

		move.w	BOB_NEW_X_F(a1),d0
		move.w	BOB_NEW_X_F(a3),d1

		move.w	d1,d3
		add.w	(a4),d3
		cmp.w	d3,d0
		bhi	EXIT_CHECK_BOTH

		move.w	d0,d2
		add.w	(a2),d2
		cmp.w	d1,d2
		blo	EXIT_CHECK_BOTH

		;***** Check y1 and y2 *****;

		move.w	BOB_NEW_Y_F(a1),d0
		move.w	BOB_NEW_Y_F(a3),d1

		move.w	d1,d3
		add.w	(a4),d3
		cmp.w	d3,d0
		bhi	EXIT_CHECK_BOTH

		move.w	d0,d2
		add.w	(a2),d2
		cmp.w	d1,d2
		blo	EXIT_CHECK_BOTH


		;*****    Getroffen    *****;

		st	(a5)	; Collision erfolgt !!

		tst.b	(a6)
		beq	EXIT_CHECK_BOTH
		subq.b	#1,(a6)

		tst.b	(a0)
		beq	EXIT_CHECK_BOTH
		subq.b	#1,(a0)

EXIT_CHECK_BOTH:rts


;-----------------------------------------------------------------------;
;		;***** Collision mit zwei BOBS ENDE *****;
;-----------------------------------------------------------------------;

		;-------------------------------;
		EXECUTE_BOBS_COLLISION:
		;-------------------------------;

		lea	COLL_BOBS_FLAGS(pc),a1
		lea	EXECUTE_BOBS_TAB(pc),a2
		bsr	EXECUTE_BOBS_COLL
		rts


	RICHTUNGS_COUNTER1:
		dc.w	0
	RICHTUNGS_COUNTER2:
		dc.w	0

	EXECUTE_BOBS_TAB:
		dc.l	PANZER1_SHOOT2_HIT
		dc.l	PANZER2_SHOOT1_HIT
		dc.l	PANZER1_SHOOT2_HIT
		dc.l	PANZER2_SHOOT1_HIT


		;-------------------------------;
		EXECUTE_BOBS_COLL:
		;-------------------------------;

		move.w	(a1)+,d7
EXECUTE_BOBS_COLL_LOOP:
		tst.b	(a1)
		beq	NEXT_EXECUTE_BOB
		movem.l	a1/a2/d7,-(sp)
		move.l	(a2),a2
		jsr	(a2)
		movem.l	(sp)+,a1/a2/d7
NEXT_EXECUTE_BOB:
		addq.l	#1,a1
		addq.l	#4,a2
		dbra	d7,EXECUTE_BOBS_COLL_LOOP
		rts


		;*******************************;
		;***** Exe. Panzer & Shoot *****;
		;*******************************;

	PANZER1_SHOOT2_HIT:

		lea	RICHTUNGS_PTR1(pc),a3
		lea	RICHTUNGS_COUNTER1(pc),a4
		lea	PANZER_STRUCT1(pc),a5

		;***** Bob Richtung veraender *****;

		addq.l	#PANZER_WBYTE,BOB_F(a5)
		addq.l	#PANZER_WBYTE,BOB_MASK_F(a5)
		addq.l	#4,(a3)

		cmp.l	#PANZER+[PANZERS*PANZER_WBYTE],BOB_F(a5)
		bne	CHANGE_RICHTUNG_CONT1

		move.l	#PANZER,BOB_F(a5)
		move.l	#PANZER_MASK,BOB_MASK_F(a5)
		move.l	#RICHTUNGS_TAB,(a3)


		;***** Der Zahler dafuer *****;

CHANGE_RICHTUNG_CONT1:
		addq.w	#1,(a4)

		cmp.w	#8-1,(a4)
		bne	EXIT_CHANGE_RICHTUNG1
		sf	(a1)
		clr.w	(a4)

EXIT_CHANGE_RICHTUNG1:
		rts


		;*******************************;
		;**** Exe. Panzer2 & Shoot1 ****;
		;*******************************;

	PANZER2_SHOOT1_HIT:

		lea	RICHTUNGS_PTR2(pc),a3
		lea	RICHTUNGS_COUNTER2(pc),a4
		lea	PANZER_STRUCT2(pc),a5

		;***** Bob Richtung veraender *****;

		addq.l	#PANZER_WBYTE,BOB_F(a5)
		addq.l	#PANZER_WBYTE,BOB_MASK_F(a5)
		addq.l	#4,(a3)

		cmp.l	#PANZER+[PANZERS*PANZER_WBYTE],BOB_F(a5)
		bne	CHANGE_RICHTUNG_CONT2

		move.l	#PANZER,BOB_F(a5)
		move.l	#PANZER_MASK,BOB_MASK_F(a5)
		move.l	#RICHTUNGS_TAB,(a3)


		;***** Der Zahler dafuer *****;

CHANGE_RICHTUNG_CONT2:
		addq.w	#1,(a4)

		cmp.w	#8-1,(a4)
		bne	EXIT_CHANGE_RICHTUNG2
		sf	(a1)
		clr.w	(a4)

EXIT_CHANGE_RICHTUNG2:
		rts


		;-------------------------------;
		SHOOT_PANZER:
		;-------------------------------;

		lea	SHOOT_COUNT_FLAGS1(pc),a0
		lea	PANZER_STRUCT1(pc),a1
		lea	SCHUSS_STRUCT1(pc),a2
		lea	JOY_PORT_1(pc),a3
		lea	RICHTUNGS_PTR1(pc),a4
		lea	SHOOT_FLAGS_1(pc),a5
		lea	CLOSE_UP_DOWN_1(pc),a6
		move.l	SHOOT_1(pc),d0
		move.l	SHOOT_2(pc),d1
		bsr	SHOOT

		lea	SHOOT_COUNT_FLAGS2(pc),a0
		lea	PANZER_STRUCT2(pc),a1
		lea	SCHUSS_STRUCT2(pc),a2
		lea	JOY_PORT_2(pc),a3
		lea	RICHTUNGS_PTR2(pc),a4
		lea	SHOOT_FLAGS_2(pc),a5
		lea	CLOSE_UP_DOWN_2(pc),a6
		move.l	SHOOT_2(pc),d0
		move.l	SHOOT_1(pc),d1
		bsr	SHOOT

		lea	CUSTOM,a0
		rts


		;-------------------------------;
		;****** For SHOOT Routine ******;
		;-------------------------------;

		RAND_RECHTS:	equ	64-32
		RAND_LINKS:	equ	64+320+32
		RAND_OBEN:	equ	64-32
		RAND_UNTEN:	equ	64+224+32


		;*******************************;

		SHOOT_SPEED_F:	equ	0
		OLD_RICHTUNG_X_F:equ	SHOOT_SPEED_F+2
		OLD_RICHTUNG_Y_F:equ	OLD_RICHTUNG_X_F+2
		SHOT_F:		equ	OLD_RICHTUNG_Y_F+2
		BACK_F:		equ	SHOT_F+1
		BACK_COUNT_F:	equ	BACK_F+1


		;***** For Panzer 1 *****;

	SHOOT_FLAGS_1:
		SHOOT_SPEED_1:	dc.w	4-1
		OLD_RICHTUNG_X1:dc.w	0
		OLD_RICHTUNG_Y1:dc.w	0
		SHOT1:		dc.b	0
		BACK1:		dc.b	0
		BACK_COUNT1:	dc.b	0
		EVEN


		;***** For Panzer 2 *****;

	SHOOT_FLAGS_2:
		SHOOT_SPEED_2:	dc.w	4-1
		OLD_RICHTUNG_X2:dc.w	0
		OLD_RICHTUNG_Y2:dc.w	0
		SHOT2:		dc.b	0
		BACK2:		dc.b	0
		BACK_COUNT2:	dc.b	0
		EVEN


		;***** Schussanzahl *****;

		SHOOT_X_F:	equ	0		; Bei Board XPos
		SHOOT_Y_F:	equ	SHOOT_X_F+4
		SHOOT_COUNT_F:	equ	SHOOT_Y_F+4


		;************************;

	SHOOT_COUNT_FLAGS1:	dc.l	08,10
		SHOOT_1:	dc.l	SHOOT_AMOUNT	; 00-99 Schuesse
	SHOOT_COUNT_FLAGS2:	dc.l	28,10
		SHOOT_2:	dc.l	SHOOT_AMOUNT	; 00-99 Schuesse


		;-------------------------------;
		SHOOT:
		;-------------------------------;

		tst.b	d0
		bne	SHOOT_NOW

		tst.b	d1
		bne	NO_ENERGIES_ZERO

		st	NEXT_GAME

NO_ENERGIES_ZERO:
		sf	FIRE_F(a3)
		sf	SHOT_F(a5)
		sf	BACK_F(a5)
		clr.w	BOB_NEW_X_F(a2)
		clr.w	BOB_NEW_Y_F(a2)

		clr.w	BOB_OLD_X_F(a2)
		clr.w	BOB_OLD_Y_F(a2)
		rts


SHOOT_NOW:	tst.b	FIRE_F(a3)
		beq	EXIT_SHOOT	; Feuerknopf gedrueckt ?
	
		tst.b	SHOT_F(a5)
		bne	LET_FLY_SHOOT	; Schonmal geschossen ?
		st	SHOT_F(a5)


		;***** Init Shoot 1x *****;

		move.w	BOB_NEW_X_F(a1),BOB_NEW_X_F(a2)	; Coords for Schuss
		move.w	BOB_NEW_Y_F(a1),BOB_NEW_Y_F(a2)
		move.w	BOB_OLD_X_F(a1),BOB_OLD_X_F(a2)
		move.w	BOB_OLD_Y_F(a1),BOB_OLD_Y_F(a2)

		move.l	(a4),a4
		move.w	(a4)+,OLD_RICHTUNG_X_F(a5)
		move.w	(a4),OLD_RICHTUNG_Y_F(a5)

		subq.l	#1,SHOOT_COUNT_F(a0)
		rts


LET_FLY_SHOOT:	move.w	OLD_RICHTUNG_X_F(a5),d0
		move.w	OLD_RICHTUNG_Y_F(a5),d1


		;*****  Move the Shoot  *****;

		move.w	SHOOT_SPEED_F(a5),d7
SHOOT_SPEED:	add.w	d0,BOB_NEW_X_F(a2)
		add.w	d1,BOB_NEW_Y_F(a2)
		add.w	d0,BOB_OLD_X_F(a2)
		add.w	d1,BOB_OLD_Y_F(a2)
		dbra	d7,SHOOT_SPEED


		;***** Move Panzer Back *****;

		tst.b	BACK_F(a5)
		bne	NO_PANZER_BACK

		tst.b	CLOSE_UP_F(a6)
		bne	MOVE_BACK_STOP

		tst.b	CLOSE_DOWN_F(a6)
		bne	MOVE_BACK_STOP

MOVE_BACK_OK:	sub.w	d0,BOB_NEW_X_F(a1)
		sub.w	d1,BOB_NEW_Y_F(a1)
		sub.w	d0,BOB_OLD_X_F(a1)
		sub.w	d1,BOB_OLD_Y_F(a1)

		cmp.b	#4-1,BACK_COUNT_F(a5)
		bne	MOVE_BACK_AGAIN

MOVE_BACK_STOP:	clr.b	BACK_COUNT_F(a5)
		st	BACK_F(a5)

		move.w	#4-1,d7
MOVE_FORWARD:	add.w	d0,BOB_NEW_X_F(a1)
		add.w	d1,BOB_NEW_Y_F(a1)
		add.w	d0,BOB_OLD_X_F(a1)
		add.w	d1,BOB_OLD_Y_F(a1)
		dbra	d7,MOVE_FORWARD

		bra	NO_PANZER_BACK

MOVE_BACK_AGAIN:
		addq.b	#1,BACK_COUNT_F(a5)

NO_PANZER_BACK:

		;***** Improve Shoot Border *****;

		cmp.w	#RAND_RECHTS,BOB_NEW_X_F(a2)
		bls	SHOOT_IS_OUTSIDE

		cmp.w	#RAND_LINKS,BOB_NEW_X_F(a2)
		bhs	SHOOT_IS_OUTSIDE

		cmp.w	#RAND_OBEN,BOB_NEW_Y_F(a2)
		bls	SHOOT_IS_OUTSIDE

		cmp.w	#RAND_UNTEN,BOB_NEW_Y_F(a2)
		bhs	SHOOT_IS_OUTSIDE

NO_ARRIVED_DOWN:
EXIT_SHOOT:	rts


SHOOT_IS_OUTSIDE:
		sf	FIRE_F(a3)
		sf	SHOT_F(a5)
		sf	BACK_F(a5)
		clr.w	BOB_NEW_X_F(a2)
		clr.w	BOB_NEW_Y_F(a2)
		clr.w	BOB_OLD_X_F(a2)
		clr.w	BOB_OLD_Y_F(a2)
		rts


		;-------------------------------;
		CONTROL_GAME_OVER:
		;-------------------------------;

		lea	ENERGY_1(pc),a0
		lea	ENERGY_2(pc),a6
		lea	ENERGY_FLAG1(pc),a1
		lea	ENERGY_FLAG2(pc),a2
		bsr	CTRL_GAME_OVER

		lea	ENERGY_1(pc),a0
		lea	ENERGY_2(pc),a6
		lea	ENERGY_FLAG2(pc),a1
		lea	ENERGY_FLAG1(pc),a2
		bsr	CTRL_GAME_OVER

		lea	CUSTOM,a0
		rts


		;-------------------------------;
		CTRL_GAME_OVER:
		;-------------------------------;

		tst.b	(a1)
		bne	NO_ENERGY_EMPTY1
		st	NEXT_GAME

NO_ENERGY_EMPTY1:
		tst.b	(a2)
		bne	NO_ENERGY_EMPTY2
		st	NEXT_GAME

NO_ENERGY_EMPTY2:
		tst.b	NEXT_GAME
		bne	ENERGY_EMPTY
		rts

NEXT_GAME:	dc.b	0
		even


ENERGY_EMPTY:	sf	NEXT_GAME

		lea	GAMED_POS(pc),a5
		addq.b	#1,(a5)		; Ein Game gespielt
		subq.b	#1,1(a5)	; TIME_POS2 - 1


		;*****************************;
		;*****    Spiel aus ?    *****;
		;*****************************;

		lea	GAME_OVER(pc),a3
		lea	TIME_POS(pc),a4

		move.b	(a4),d0
		cmp.b	(a5),d0
		bne	NO_GAME_OVER
		st	(a3)		; GAME OVER !

		bsr	NO_GAME_OVER	; Weiss der Geier warum !?!


		;*****************************;
		;*** Spiel entgueltueg aus ***;
		;*****************************;

		lea	PANZER_NAME(pc),a1

		move.b	TANK_POINT1(pc),d0
		move.b	TANK_POINT2(pc),d1


		;********************************;
		;** Hoechster Punktzahl erster **;
		;********************************;

		cmp.b	d0,d1
		bhi	FIRST_POINT2

		move.b	d0,d2
		add.b	#$30,d2
		move.b	d2,PANZER1_POINT

		move.b	d1,d2
		add.b	#$30,d2
		move.b	d2,PANZER2_POINT

		bra	PRINT_POINTS_CONT	


		;*****************************;

FIRST_POINT2:	move.b	d1,d2
		add.b	#$30,d2
		move.b	d2,PANZER1_POINT

		move.b	d0,d2
		add.b	#$30,d2
		move.b	d2,PANZER2_POINT


		;*****************************;

PRINT_POINTS_CONT:

		;***** Unentschieden *****;

		cmp.b	d0,d1
		bne	SPIEL_UNGLEICH
		lea	TANKS_EQU(pc),a1
		lea	PANZER_EQU(pC),a2
		bra	CONT_GAME_OVER


		;***** Panzer x1 won *****;

SPIEL_UNGLEICH:	cmp.b	d0,d1
		bhi	PANZER2_WON
		lea	PANZER_EINS(pc),a2
		bra	CONT_GAME_OVER


		;***** Panzer x2 won *****;

PANZER2_WON:	lea	PANZER_ZWEI(pc),a2

CONT_GAME_OVER:	move.l	(a2)+,d0
COPY_PANZER_NAME:
		move.b	(a2)+,(a1)+
		dbra	d0,COPY_PANZER_NAME


		;***** Print the text *****;

		bsr	CLR_BOARD

		lea	BOARD,a1
		lea	GAME_TEXT3(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	GAME_TEXT4(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	GAME_TEXT5(pc),a2
		bsr	PRINT_TEXT


		;***** Warte auf Returntaste *****;

		moveq	#1,d0
		jsr	INIT_SONG

		lea	CUSTOM,a0
		move.w	#$C000,INTENA(a0)

	WAIT_RETURN_KEY:
		cmp.b	#$40,VHPOSR(a0)
		bne	WAIT_RETURN_KEY

		jsr	PLAY_SONG

		move.b	CIAASDR,d0
		ror.b	#1,d0
		not.b	d0
		cmp.b	#$44,d0		; RETURN ?
		bne	WAIT_RETURN_KEY

		move.w	#$4000,INTENA(a0)
		rts


NO_GAME_OVER:
		;***** Punkteverteilung *****;

		tst.b	(a1)
		bne	NO_POINTS_1

		addq.b	#1,TANK_POINT2
		move.b	TANK_POINT2(pc),d0
		add.b	#$30,d0
		move.b	d0,POINT_PTR2

NO_POINTS_1:	tst.b	(a2)
		bne	NO_POINTS_2

		addq.b	#1,TANK_POINT1
		move.b	TANK_POINT1(pc),d0
		add.b	#$30,d0
		move.b	d0,POINT_PTR1

NO_POINTS_2:
		;***** Energies vollladen *****;

		move.b	#80,(a1)
		move.b	#80,(a2)

		move.l	#-1,(a0)+
		move.l	#-1,(a0)+
		move.l	#%11111111111111110000000000000000,(a0)

		move.l	#-1,(a6)+
		move.l	#-1,(a6)+
		move.l	#%11111111111111110000000000000000,(a6)


		;*****  Texte ausgeben  *****;

		movem.l	d0-d7/a0-a6,-(sp)

		bsr	CLR_BOARD

		lea	BOARD,a1
		lea	GAME_TEXT1(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	GAME_TEXT2(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	GAME_TEXT3(pc),a2
		bsr	PRINT_TEXT


		tst.b	MUSIC_ON_OFF
		beq	NO_SAMPLE4
		clr.w	AUD2VOL(a0)
		clr.w	AUD3VOL(a0)


NO_SAMPLE4:	move.w	#$C000,INTENA(a0)
WAIT_RETURN_KEY2:
		cmp.b	#$40,VHPOSR(a0)
		bne	WAIT_RETURN_KEY2

		tst.b	MUSIC_ON_OFF
		bne	RETURN_KEY

		jsr	PLAY_SONG

RETURN_KEY:	move.b	CIAASDR,d0
		ror.b	#1,d0
		not.b	d0
		cmp.b	#$44,d0		; RETURN ?
		bne	WAIT_RETURN_KEY2
		move.w	#$4000,INTENA(a0)


		tst.b	MUSIC_ON_OFF
		beq	NO_SAMPLE5
		move.w	#64,AUD2VOL(a0)
		move.w	#64,AUD3VOL(a0)

NO_SAMPLE5:	movem.l	(sp)+,d0-d7/a0-a6


		; Schuesse werden vom GAME_VIEW wieder neu gesetzt

		movem.l	d0-d7/a0-a6,-(sp)

		bsr	CLR_MEMORY
		bsr	COPY_LEVELS
		bsr	INIT_LEVELS
		bsr	CALC_MASKS
		bsr	CALC_PANZER_POSNS
		bsr	INIT_GAME_VIEW
		bsr	INIT_GAME_PLF
		bsr	INIT_BOARD
		bsr	INIT_SOUNDS

		movem.l	(sp)+,d0-d7/a0-a6
		rts


GAMED_POS:	dc.b	0
TIME_POS2:	dc.b	0

TANK_POINT1:	dc.b	0
TANK_POINT2:	dc.b	0

GAME_TEXT1:	dc.l	0,4
		dc.b	"                                       "
		dc.b	"           PANZER EINS :  "
POINT_PTR1:	dc.b	"0",-1
		EVEN

GAME_TEXT2:	dc.l	0,4+9
		dc.b	"                                       "
		dc.b	"           PANZER ZWEI :  "
POINT_PTR2:	dc.b	"0",-1
		EVEN

GAME_TEXT3:	dc.l	0,4+9+9
		dc.b	"                                       "
		dc.b	"  BITTE DRUECKEN SIE DIE RETURN-TASTE  ",-1
		EVEN

GAME_TEXT4:	dc.l	0,4
		dc.b	"                                       "
		dc.b	"           G A M E  O V E R  ! ! !     ",-1
		EVEN

GAME_TEXT5:	dc.l	3,4+9
		dc.b	"                                       "
TANKS_EQU:	dc.b	" ES GEWINNT "
PANZER_NAME:	dc.b	"PANZER EINS"	; oder PANZER ZWEI
		dc.b	" MIT   "
PANZER1_POINT:	dc.b	"4"
		dc.b	" : "
PANZER2_POINT:	dc.b	"2",-1
		EVEN


PANZER_EINS:	dc.l	11-1
		dc.b	"PANZER EINS"
		EVEN

PANZER_ZWEI:	dc.l	11-1
		dc.b	"PANZER ZWEI"
		EVEN

PANZER_EQU:	dc.l	29-1
		dc.b	" DAS SPIEL IST UNENTSCHIEDEN "
		EVEN


		;-------------------------------;
		CLR_BOARD:
		;-------------------------------;

		lea	CUSTOM,a0
		move.w	#[BOARD_HEIGHT*DEPTH*64]+[BOARD_WBYTES/2],d0
		move.l	#BOARD,d1
		bsr	CLR_CHIP
		rts


		;-------------------------------;
		CONTROL_POINTS:
		;-------------------------------;

		;***** Shoot-counter *****;

		lea	SHOOT_COUNT_FLAGS1(pc),a3
		bsr	SEE_SHOOT_NUM

		lea	SHOOT_COUNT_FLAGS2(pc),a3
		bsr	SEE_SHOOT_NUM


		;***** Energy-counter *****;

		lea	ENERGY_FLAG1(pc),a3
		lea	ENERGY_1(pc),a4
		moveq	#8,d7
		bsr	SEE_ENERGY_NUM

		lea	ENERGY_FLAG2(pc),a3
		lea	ENERGY_2(pc),a4
		moveq	#28,d7
		bsr	SEE_ENERGY_NUM
		rts

GAME_OVER:	dc.b	0
		EVEN


		;-------------------------------;
		SEE_ENERGY_NUM:
		;-------------------------------;

		;***** Calc BLTAFWM *****;

		move.l	a4,a5

		moveq	#0,d3
		move.b	(a3),d3

		divu	#32,d3
		move.l	d3,d4

		subq.w	#1,d3
		bmi	CALC_LAST_BLTAFWM
		
CALC_BLTAFWM_LOOP:
		move.l	#-1,(a5)+
		dbra	d3,CALC_BLTAFWM_LOOP

CALC_LAST_BLTAFWM:
		clr.w	d4
		swap	d4

		tst.w	d4
		bne	NOT_YET_BLT_ENERGIES
		clr.l	(a5)
		bra	BLT_ENERGIES

NOT_YET_BLT_ENERGIES:
		moveq	#32,d0
		moveq	#0,d2

CALC_LAST_BLTAFWM_LOOP:
		subq.b	#1,d0
		bset	d0,d2
		dbra	d4,CALC_LAST_BLTAFWM_LOOP

		move.l	d2,(a5)		; Letztes auch eintragen

BLT_ENERGIES:
		;*****  Blt Energy  *****;

		move.l	(a4)+,d2
		bsr	BLT_ENERGY
		addq.l	#4,d7

		move.l	(a4)+,d2
		bsr	BLT_ENERGY
		addq.l	#4,d7

		move.l	(a4),d2
		bsr	BLT_ENERGY

EXIT_ENERGY_NUM:rts


		;*************************;
		;***** Copy New Ener. ****;
		;*************************;

		;***** d2 -> BltAfwm *****;
		;***** d5 -> BltMods *****;
		;***** d6 -> BltSize *****;

BLT_ENERGY:	move.l	d2,BLTAFWM(a0)
		move.l	#$09F00000,BLTCON0(a0)

		move.w	#BOARD_WBYTES-4,BLTAMOD(a0)
		move.w	#BOARD_WBYTES-4,BLTDMOD(a0)

		lea	BOARD,a1
		lea	(a1,d7.l),a2
		move.l	a2,BLTAPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	#[[CHAR_HEIGHT+1]*DEPTH*64]+[4/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER

		move.l	#-1,BLTAFWM(a0)
		rts


	ENERGY_FLAG1:	dc.b	79
	ENERGY_FLAG2:	dc.b	79
	HOHL_FLAG:	dc.w	0

	ENERGY_1:	dc.l	-1,-1,%11111111111111110000000000000000
	ENERGY_2:	dc.l	-1,-1,%11111111111111110000000000000000


		;-------------------------------;
		SEE_SHOOT_NUM:
		;-------------------------------;

		lea	BOARD,a1
		lea	CHARSET,a2


		;***** Calc XYPos of BoardShootNumbers *****;

		move.l	(a3)+,d0
		add.l	d0,a1
		move.l	(a3)+,d0
		mulu	#BOARD_WBYTES*DEPTH,d0
		lea	(a1,d0.l),a1


		;***** Print the Numbers there *****;

		move.l	(a3),d0
		divu	#10,d0
		move.l	d0,d1

		and.l	#$0000000F,d0
		lea	16(a2,d0.l),a5
		bsr	PRINT_NUMBER

		clr.w	d1
		swap	d1
		lea	16(a2,d1.l),a5
		bsr	PRINT_NUMBER
		rts


		;***** Printing *****;

PRINT_NUMBER:	moveq	#CHAR_HEIGHT-1,d7
PRINT_CHAR_P2:	move.b	(a5),BOARD_WBYTES*0(a1)
		move.b	(a5),BOARD_WBYTES*1(a1)
		lea	CHAR_WBYTES(a5),a5
		lea	BOARD_WBYTES*DEPTH(a1),a1
		dbra	d7,PRINT_CHAR_P2

		lea	-[[CHAR_HEIGHT*BOARD_WBYTES*DEPTH]-1](a1),a1
		rts



;-----------------------------------------------------------------------;
;		;****** Calc the Mask of the BOB *****;			;
;-----------------------------------------------------------------------;

		;-------------------------------;
		CALC_MASKS:
		;-------------------------------;

		lea	PANZER,a1
		lea	PANZER_MASK,a2
		moveq	#PANZER_WBYTES,d4
		moveq	#PANZER_HEIGHT,d5
		moveq	#DEPTH,d6
		bsr	CALC_MASK

		lea	SCHUESSE,a1
		lea	SCHUESSE_MASK,a2
		moveq	#SCHUSS_WBYTES,d4
		moveq	#SCHUSS_HEIGHT,d5
		moveq	#DEPTH,d6
		bsr	CALC_MASK
		rts


		;-------------------------------;
		CALC_MASK:
		;-------------------------------;

		;***** USED by Routine *****;

		;***** d0 = PanzerWbytes - 1
		;***** d1 = Mask and Bob Offset
		;***** d2 = MaskByte
		;***** d3 = PanzerWbytes * Depth
		;***** d6 = PanzerWbytes * [ Depth - 1]
		;***** d7 = PanzerWbytes


		;***** USED  by User   *****;

		;***** d4 = PanzerWbytes
		;***** d5 = PanzerHeight
		;***** d6 = Depth


		movem.l	d0/d1/d2/d3/d7,-(sp)

		move.l	d6,d3
		mulu	d4,d3	; d3 = PanzerWbytes * Depth
		mulu	d4,d6
		sub.l	d4,d6	; d6 = PanzerWbytes * [ Depth -1 ]
		move.l	d4,d7
		subq.l	#1,d4
		move.l	d4,d0	; d0 = d4 = PanzerWbytes - 1
		subq.l	#1,d5	; PanzerHeight - 1
		moveq	#0,d2

MASK_LOOP:	or.b	(a1,d1.l),d2
		add.l	d7,a1
		or.b	(a1,d1.l),d2
		add.l	d7,a1
		or.b	(a1,d1.l),d2
		add.l	d7,a1
		or.b	(a1,d1.l),d2
		sub.l	d6,a1

		move.b	d2,(a2,d1.l)
		add.l	d7,a2
		move.b	d2,(a2,d1.l)
		add.l	d7,a2
		move.b	d2,(a2,d1.l)
		add.l	d7,a2
		move.b	d2,(a2,d1.l)
		sub.l	d6,a2

		addq.l	#1,d1
		moveq	#0,d2
		dbra	d4,MASK_LOOP

		move.l	d0,d4
		moveq	#0,d1
		add.l	d3,a1	; next line source
		add.l	d3,a2	; next line destination
		dbra	d5,MASK_LOOP

		movem.l	(sp)+,d0/d1/d2/d3/d7
		rts

;-----------------------------------------------------------------------;
;		;***** Calc Mask Routine ENDE *****;			;
;-----------------------------------------------------------------------;

		;-------------------------------;
		INIT_LEVELS:
		;-------------------------------;

		lea	SCREEN_POS(pc),a1
		lea	LEVEL_STRUCT_GAME1(pc),a2
		lea	LEVEL_STRUCT_GAME2(pc),a3
		lea	LEVEL_STRUCT_GAME3(pc),a4

		moveq	#0,d0
		move.b	(a1),d0
		mulu	#LEVEL_SIZE,d0
		add.l	#GAME_LEVELS,d0
		move.l	d0,12(a2)
		move.l	d0,12(a3)
		move.l	d0,12(a4)
		rts


		;-------------------------------;
		COPY_LEVELS:
		;-------------------------------;

		lea	LEVELS,a1
		lea	GAME_LEVELS,a2

		move.w	#[LEVEL_SIZE*10]-1,d7
COPY_LEVELS_LOOP:
		move.b	(a1)+,(a2)+
		dbra	d7,COPY_LEVELS_LOOP
		rts


		;-------------------------------;
		INIT_BOARD:
		;-------------------------------;

		lea	SCREEN_PTR(pc),a1
		move.b	SCREEN_POS(pc),d0
		bsr	PUT_TEXT_POS

		lea	TIME_PTR(pc),a1
		move.b	TIME_POS2(pc),d0
		bsr	PUT_TEXT_POS

		lea	BOARD,a1
		lea	ENERGY_TEXT(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	SHOOT_TEXT(pc),a2
		bsr	PRINT_TEXT

		lea	BOARD,a1
		lea	REST_TEXT(pc),a2
		bsr	PRINT_TEXT
		rts


PUT_TEXT_POS:	move.b	d0,d1
		and.b	#$0F,d0
		add.b	#$30,d0
		move.b	d0,1(a1)
		lsr.b	#4,d1
		add.b	#$30,d1
		move.b	d1,(a1)
		rts


ENERGY_TEXT:	dc.l	0,0
		dc.b	"                                        "
		dc.b	"ENERGY  ##########  ENERGY  ##########  ",-1
		even

SHOOT_TEXT:	dc.l	0,10
		dc.b	"                                        "
		dc.b	"SHOOT               SHOOT              ",-1
		even

REST_TEXT:	dc.l	0,20
		dc.b	"                                        "
		dc.b	"SCREEN  "
SCREEN_PTR:	dc.b	"            TIME    "
TIME_PTR:	dc.b	"          ",-1
		even


		;-------------------------------;
		PRINT_TEXT:
		;-------------------------------;

		move.l	(a2)+,d0
		add.l	d0,a1

		move.l	(a2)+,d1
		mulu	#BOARD_WBYTES*DEPTH,d1
		add.l	d1,a1

PRINT_TEXT_LOOP:moveq	#0,d0
		move.b	(a2)+,d0
		cmp.b	#-1,d0
		beq	PRINT_TEXT_EXIT
		sub.b	#32,d0
		lea	CHARSET,a3
		add.l	d0,a3

		moveq	#CHAR_HEIGHT-1,d0
PRINT_CHAR:	move.b	(a3),BOARD_WBYTES*0(a1)
		move.b	(a3),BOARD_WBYTES*3(a1)
		lea	CHAR_WBYTES(a3),a3
		lea	BOARD_WBYTES*DEPTH(a1),a1
		dbra	d0,PRINT_CHAR

		lea	-[[CHAR_HEIGHT*BOARD_WBYTES*DEPTH]-1](a1),a1
		bra	PRINT_TEXT_LOOP

PRINT_TEXT_EXIT:rts


		;-------------------------------;
		INIT_GAME_PLF:
		;-------------------------------;

		lea	LEVEL_STRUCT_GAME1(pc),a6
		bsr	BUILD_LAND

		lea	LEVEL_STRUCT_GAME2(pc),a6
		bsr	BUILD_LAND

		lea	LEVEL_STRUCT_GAME3(pc),a6
		bra	BUILD_LAND


		;-------------------------------;
		INIT_GAME_VIEW:
		;-------------------------------;

		;*************************;
		;*** Build Copperlist  ***;
		;*************************;

		lea	GAME_COPPER,a1
		lea	GAME_COPPERLIST(pc),a2

		moveq	#[[GAME_COPPERLIST_END-GAME_COPPERLIST]/2]-1,d0
COPLST_CHIP:	move.w	(a2)+,(a1)+
		dbra	d0,COPLST_CHIP


		;***************************;
		;*****  Screen Colors  *****;
		;***************************;

		lea	GAME_COLORS,a2
		move.w	#COLOR00,d0
		moveq	#COLORS-1,d1

COLORS_GAME:	move.w	d0,(a1)+
		addq.w	#2,d0
		move.w	(a2)+,(a1)+
		dbra	d1,COLORS_GAME


		;***************************;
		;***** Screen for Game *****;
		;***************************;

		move.w	#BPL1MOD,(a1)+
		move.w	#[DEPTH*GAME_WBYTES]-40,(a1)+
		move.w	#BPL2MOD,(a1)+
		move.w	#[DEPTH*GAME_WBYTES]-40,(a1)+
		move.l	a1,GAME_COPPER_PTR
		move.l	#BITPLANES1+PLANE_OFFS,d1
		moveq	#GAME_WBYTES,d2
		bsr	MAKE_VIEW_COPPER


		;***************************;
		;***** Screen for Board ****;
		;***************************;

		move.l	#$FFDFFFFE,(a1)+
		move.l	#$0C01FFFE,(a1)+

		move.w	#BPL1MOD,(a1)+
		move.w	#[DEPTH*BOARD_WBYTES]-40,(a1)+
		move.w	#BPL2MOD,(a1)+
		move.w	#[DEPTH*BOARD_WBYTES]-40,(a1)+
		move.l	#BOARD,d1
		moveq	#BOARD_WBYTES,d2		
		bsr	MAKE_VIEW_COPPER


		;***************************;

		move.l	#$FFFFFFFE,(a1)+


		;*************************;
		;*** Take Maschines ON ***;
		;*************************;

		lea	CUSTOM,a0
		move.w	#$100,DMACON(a0)
		move.l	#GAME_COPPER,COP1LCH(a0)
		clr.w	COPJMP1(a0)
		move.w	#$87E0,DMACON(a0)
		move.l	#$FFFFFFFF,BLTAFWM(a0)


		;** Die restlichen DC's **;

		moveq	#0,d0
		move.b	SHOOT_POS(pc),d0
		move.l	d0,SHOOT_1
		move.l	d0,SHOOT_2
		rts


GAME_COPPER_PTR:dc.l	0

		;*************************;
		;***  Copper for View  ***;
		;*************************;

GAME_COPPERLIST:dc.w	DIWSTRT,$2C81,DIWSTOP,$2CC1
		dc.w	DDFSTRT,$0038,DDFSTOP,$00D0
		dc.w	BPLCON0,[DEPTH*$1000]+$200
		dc.w	BPLCON1,$0000,BPLCON2,$0024

		dc.w	SPR0PTH   ,0 ,SPR0PTH+2 ,0
		dc.w	SPR0PTH+4 ,0 ,SPR0PTH+6 ,0
		dc.w	SPR0PTH+8 ,0 ,SPR0PTH+10,0
		dc.w	SPR0PTH+12,0 ,SPR0PTH+14,0
		dc.w	SPR0PTH+16,0 ,SPR0PTH+18,0
		dc.w	SPR0PTH+20,0 ,SPR0PTH+22,0
		dc.w	SPR0PTH+24,0 ,SPR0PTH+26,0
		dc.w	SPR0PTH+28,0 ,SPR0PTH+30,0

GAME_COPPERLIST_END:
		; Continue Copper in COPPER (chip-mem)

GAME_END:


;***********************************************************************;
;************************** E D I T O R ********************************;
;***********************************************************************;

		BACKWARD:	equ	18
		FORWARD:	equ	19
		LOAD:		equ	38
		SAVE:		equ	39


		;-------------------------------;
		EDITOR_START:	
		;-------------------------------;

		bsr	CLR_MEMORY
		bsr	WAIT_BLITTER
		bsr	COPY_MAUER
		bsr	INIT_EDITOR_VIEW
		bsr	INIT_EDITOR_PLF
		bsr	SAVE_TAKE_BUFFER
		bsr	SAVE_MAUER_BUFFER


		;-------------------------------;
		EDITOR_MAIN:	
		;-------------------------------;

		move.l	VPOSR(a0),d0
		and.l	#$001FF00,d0
		cmp.l	#$0000100,d0
		bne	EDITOR_MAIN

		jsr	PLAY_SONG

		bsr	MOVE_MOUSE
		bsr	JOYSTICK_MESSAGE
		bsr	MOVE_MOUSE_JOY

		bsr	CTRL_MOUSE
		bsr	CTRL_TAKE
		bsr	CTRL_PUT
		bsr	CTRL_LEVEL
		bsr	CTRL_LOAD
		bsr	CTRL_SAVE

		btst	#10,POTGOR(a0)
		bne	EDITOR_MAIN

		sf	MUSIC_ON_OFF

		move.w	#$4000,INTENA(a0)
		move.w	#$200,DMACON(a0)
		clr.w	COLOR00(a0)
		
		bra	INTRO_START


		;-------------------------------;
		CTRL_LOAD:
		;-------------------------------;

		lea	LEVEL_CODE(pc),a1

		cmp.b	#LOAD,(a1)
		beq	OK_LOAD_LEVEL
		rts

OK_LOAD_LEVEL:	clr.b	(a1)

		moveq	#1,d0
		jsr	INIT_SONG

		move.l	#[[LAND_HEIGHT+32]*DEPTH*64]+[LAND_WBYTES/2],d0
		move.l	#LAND,d1
		bsr	CLR_CHIP

		lea	LAND,a1
		lea	LOAD_MES_1(pc),a2
		bsr	PRINT_TEXT

		lea	LAND,a1
		lea	LOAD_MES_2(pc),a2
		bsr	PRINT_TEXT

		lea	LAND,a1
		lea	LOAD_MES_3(pc),a2
		bsr	PRINT_TEXT

		bsr	WAIT_RIGHT_BUTTON


		;**********************;
		;***** Load Level *****;
		;**********************;

		move.w	#$C000,INTENA(a0)

		;***** DosLib Oeffnen *****;

		bsr	OPEN_DOS

		;*****  File Oeffnen  *****;

		move.l	#NAME,d1
		move.l	#MODE_OLD,d2
		move.l	DOSBASE(pc),a6
		jsr	OPEN(a6)
		move.l	d0,FILE_HANDLE

		;***** File Speichern *****;

		move.l	FILE_HANDLE(pc),d1
		move.l	#LEVELS,d2
		move.l	#LEVEL_SIZE*10,d3
		move.l	DOSBASE(pc),a6
		jsr	READ(a6)

		;*****   File Close   *****;

		move.l	EXECBASE,a6
		move.l	DOSBASE(pc),a1
		jsr	CLOSELIBRARY(a6)

		;*****  DosLib Close  *****;

		bsr	CLOSE_DOS

		bsr	WAIT_SOME

		move.w	#$4000,INTENA(a0)
		bra	EDITOR_START


LOAD_MES_1:	dc.l	0,90
		dc.b	"                                        "
		dc.b	"  BITTE LEGEN SIE DIE SPIELDISKETTE IN  ",-1
		EVEN

LOAD_MES_2:	dc.l	0,100
		dc.b	"                                        "
		dc.b	"   DAS LAUFWERK UND DRUECKEN SIE DIE    ",-1
		EVEN

LOAD_MES_3:	dc.l	0,110
		dc.b	"                                        "
		dc.b	"           RECHTE MAUSTASTE !           ",-1
		EVEN


		;-------------------------------;
		CTRL_SAVE:
		;-------------------------------;

		lea	LEVEL_CODE(pc),a1

		cmp.b	#SAVE,(a1)
		beq	OK_SAVE_LEVEL
		rts

OK_SAVE_LEVEL:	clr.b	(a1)

		moveq	#1,d0
		jsr	INIT_SONG

		move.l	#[[LAND_HEIGHT+32]*DEPTH*64]+[LAND_WBYTES/2],d0
		move.l	#LAND,d1
		bsr	CLR_CHIP

		lea	LAND,a1
		lea	SAVE_MES_1(pc),a2
		bsr	PRINT_TEXT

		lea	LAND,a1
		lea	SAVE_MES_2(pc),a2
		bsr	PRINT_TEXT

		lea	LAND,a1
		lea	SAVE_MES_3(pc),a2
		bsr	PRINT_TEXT

		bsr	WAIT_RIGHT_BUTTON


		;*************(********;
		;***** Save Level *****;
		;**********************;

		move.w	#$C000,INTENA(a0)

		;***** DosLib Oeffnen *****;

		bsr	OPEN_DOS

		;*****  File Oeffnen  *****;

		move.l	#NAME,d1
		move.l	#MODE_NEW,d2
		move.l	DOSBASE(pc),a6
		jsr	OPEN(a6)
		move.l	d0,FILE_HANDLE

		;*****   File Save   *****;

		move.l	FILE_HANDLE(pc),d1
		move.l	#LEVELS,d2
		move.l	#LEVEL_SIZE*10,d3
		move.l	DOSBASE(pc),a6
		jsr	WRITE(a6)

		;*****   File Close  *****;

		move.l	EXECBASE,a6
		move.l	DOSBASE(pc),a1
		jsr	CLOSELIBRARY(a6)

		;*****  DosLib Close *****;

		bsr	CLOSE_DOS

		bsr	WAIT_SOME

		move.w	#$4000,INTENA(a0)
		bra	EDITOR_START


SAVE_MES_1:	dc.l	0,90
		dc.b	"                                        "
		dc.b	" BITTE LEGEN SIE DIE SPIELDISKETTE NICHT",-1
		EVEN

SAVE_MES_2:	dc.l	0,100
		dc.b	"                                        "
		dc.b	" SCHREIBGESCHUETZT IN DAS AMIGA-LAUFWERK",-1
		EVEN

SAVE_MES_3:	dc.l	0,110
		dc.b	"                                        "
		dc.b	" UND DRUECKEN SIE DIE RECHTE MAUSTASTE !",-1
		EVEN


		;-----------------------------;
		OPEN_DOS:
		;-----------------------------;

		lea	DOSNAME,a1
		move.l	EXECBASE,a6
		jsr	OPENLIBRARY(a6)
		move.l	d0,DOSBASE
		rts


		;-----------------------------;
		CLOSE_DOS:
		;-----------------------------;

		move.l	FILE_HANDLE(pc),d1
		move.l	DOSBASE(pc),a6
		jsr	CLOSE(a6)
		rts


FILE_HANDLE:	dc.l	0

DOSBASE:	dc.l	0
DOSNAME:	dc.b	"dos.library",0
		EVEN

NAME:		dc.b	"LEVELS",0
		EVEN


		;-------------------------------;
		WAIT_SOME:
		;-------------------------------;

		lea	CUSTOM,a0
		moveq	#0,d0

WAIT_SOME_SEC:	cmp.b	#$40,VHPOSR(a0)
		bne	WAIT_SOME_SEC
		addq.w	#1,d0
		cmp.w	#50*45,d0
		bne	WAIT_SOME_SEC
		rts


		;-------------------------------;
		WAIT_RIGHT_BUTTON:
		;-------------------------------;

		cmp.b	#$40,VHPOSR(a0)
		bne	WAIT_RIGHT_BUTTON

		bsr	MOVE_MOUSE

		btst	#10,POTGOR(a0)
		bne	WAIT_RIGHT_BUTTON
		rts


		;-------------------------------;
		CTRL_LEVEL:
		;-------------------------------;

		lea	LEVEL_CODE(pc),a1
		lea	LEVEL_POS(pc),a2

		cmp.b	#FORWARD,(a1)
		beq	LEVEL_FORWARD

		cmp.b	#BACKWARD,(a1)
		beq	LEVEL_BACKWARD

		bra	NO_NEXT_LEVEL


		;*****************************;
		;***** One Level forward *****;
		;*****************************;

LEVEL_FORWARD:	bsr	PUT_LAND_OLD

		clr.b	(a1)

		tst.b	1(a2)
		bne	EXIT_CTRL_LEVEL
		st	1(a2)

		cmp.b	#9,(a2)
		beq	EXIT_CTRL_LEVEL
		addq.b	#1,(a2)
		bra	EXIT_CTRL_LEVEL


		;*****************************;
		;***** One Level backward ****;
		;*****************************;

LEVEL_BACKWARD:	bsr	PUT_LAND_OLD

		clr.b	(a1)

		tst.b	1(a2)
		bne	EXIT_CTRL_LEVEL
		st	1(a2)

		tst.b	(a2)
		beq	EXIT_CTRL_LEVEL

		subq.b	#1,(a2)
		bra	EXIT_CTRL_LEVEL

NO_NEXT_LEVEL:	sf	1(a2)
		rts

EXIT_CTRL_LEVEL:bra	BUILD_LEVEL


		;***************************;
		;***** Build the Level *****;
		;***************************;

BUILD_LEVEL:	moveq	#0,d0
		move.b	(a2),d0
		mulu	#LEVEL_SIZE,d0
		add.l	#LEVELS,d0
		lea	LEVEL_STRUCT_EDITOR(pc),a6
		move.l	d0,12(a6)
		bsr	BUILD_LAND
		bsr	SAVE_TAKE_BUFFER
		bra	TAKE_LAND_NEW

LEVEL_POS:	dc.b	0
OLD_LEVEL_F:	dc.b	0


		;-------------------------------;
		CTRL_MOUSE:
		;-------------------------------;

		lea	MOUSE_FLAGS(pc),a1

		cmp.w	#LAND_HEIGHT,MOUSE_Y_F(a1)
		bhi	CTRL_MOUSE_EXIT

		bsr	PUT_LAND_OLD
		bsr	TAKE_LAND_NEW
		bsr	PUT_LAND_NEW

CTRL_MOUSE_EXIT:rts


		;-------------------------------;
		PUT_LAND_OLD:
		;-------------------------------;

		;******************************;
		;***** Hintergrund setzen *****;
		;******************************;

		move.l	#$09F00000,BLTCON0(a0)

		clr.w	BLTAMOD(a0)
		move.w	#LAND_WBYTES-MAUER_WBYTE,BLTDMOD(a0)

		move.l	#MAUER_BUFFER,BLTAPTH(a0)
		move.l	OLD_LAND_POS(pc),BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bra	WAIT_BLITTER


		;-------------------------------;
		TAKE_LAND_NEW:
		;-------------------------------;

		;******************************;
		;**** Neue Pos ausrechenen ****;
		;******************************;

		bsr	CALC_MOUSE_QUADRAT

		lea	OLD_LAND_POS(pc),a1
		lea	LAND,a2

		lsl.w	#1,d0		; X * 2
		add.l	d0,a2

		lsl.w	#4,d1		; Y * 16
		mulu	#LAND_WBYTES*LAND_DEPTH,d1
		add.l	d1,a2

		move.l	a2,(a1)		; New pos. -> Old pos.


		;******************************;
		;**** Hintergrund sichern *****;
		;******************************;

		move.w	#LAND_WBYTES-MAUER_WBYTE,BLTAMOD(a0)
		clr.w	BLTDMOD(a0)

		move.l	a2,BLTAPTH(a0)
		move.l	#MAUER_BUFFER,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bra	WAIT_BLITTER

OLD_LAND_POS:	dc.l	LAND


		;-------------------------------;
		PUT_LAND_NEW:
		;-------------------------------;

		;******************************;
		;** Auf Hintergrund kopieren **;
		;******************************;

		clr.w	BLTAMOD(a0)
		move.w	#LAND_WBYTES-MAUER_WBYTE,BLTDMOD(a0)

		move.l	#TAKE_BUFFER,BLTAPTH(a0)
		move.l	a2,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bra	WAIT_BLITTER


		;-------------------------------;
		CTRL_TAKE:
		;-------------------------------;

		lea	MOUSE_FLAGS(pc),a1

		cmp.w	#LAND_HEIGHT,MOUSE_Y_F(a1)
		blo	TAKE_EXIT

		bsr	PUT_LAND_OLD

		btst	#6,CIAAPRA
		beq	CTRL_NOW_TAKE

		btst	#7,CIAAPRA
		beq	CTRL_NOW_TAKE
		rts

CTRL_NOW_TAKE:

		;**************************;
		;**** Find XY of Mauer ****;
		;**************************;

		bsr	CALC_MOUSE_QUADRAT

		lea	MAUER_SAWN,a4
		lsl.w	#1,d0		; X * 2
		add.l	d0,a4

		lsl.w	#4,d1		; Y * 16
		sub.l	#LAND_HEIGHT,d1
		mulu	#MAUER_WBYTES*LAND_DEPTH,d1
		add.l	d1,a4


		;**************************;
		;***** Inverse Mauer  *****;
		;**************************;

		move.l	a4,a1
		bsr	INVERSE_MAUER

WAIT_INV_TAKE:	btst	#6,CIAAPRA
		beq	WAIT_INV_TAKE

		btst	#7,CIAAPRA
		beq	WAIT_INV_TAKE

		move.l	a4,a1
		bsr	INVERSE_MAUER


		;**************************;
		;***** COPY TO BUFFER *****;
		;**************************;

		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

		move.w	#MAUER_WBYTES-MAUER_WBYTE,BLTAMOD(a0)
		clr.w	BLTDMOD(a0)

		move.l	a4,BLTAPTH(a0)
		move.l	#TAKE_BUFFER,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER


		;**************************;
		;****  TAKE LEVELCODE  ****;
		;**************************;

		lea	LEVEL_CODE(pc),a1

		bsr	CALC_MOUSE_QUADRAT

		sub.l	#LAND_HEIGHT/MAUER_HEIGHT,d1
		mulu	#MAUER_WBYTES/MAUER_WBYTE,d1

		add.w	d0,d1
		move.b	d1,(a1)
TAKE_EXIT:	rts

LEVEL_CODE:	dc.b	0
		even


		;-------------------------------;
		INVERSE_MAUER:
		;-------------------------------;

		moveq	#MAUER_HEIGHT-1,d0
INV_MAUER_LOOP:	not.w	LAND_WBYTES*0(a1)
		not.w	LAND_WBYTES*1(a1)
		not.w	LAND_WBYTES*2(a1)
		not.w	LAND_WBYTES*3(a1)
		lea	MAUER_WBYTES*LAND_DEPTH(a1),a1
		dbra	d0,INV_MAUER_LOOP
		rts


		;-------------------------------;
		CTRL_PUT:
		;-------------------------------;

		lea	LEVEL_CODE(pc),a1

		cmp.b	#FORWARD,(a1)
		beq	PUT_EXIT

		cmp.b	#BACKWARD,(a1)
		beq	PUT_EXIT

		cmp.b	#LOAD,(a1)
		beq	PUT_EXIT

		cmp.b	#SAVE,(a1)
		beq	PUT_EXIT


		lea	MOUSE_FLAGS(pc),a1

		btst	#6,CIAAPRA
		beq	CTLR_NOW_PUT

		btst	#7,CIAAPRA
		beq	CTLR_NOW_PUT
		rts


CTLR_NOW_PUT:	cmp.w	#LAND_HEIGHT,MOUSE_Y_F(a1)
		bhi	PUT_EXIT


		;**************************;
		;**** Find XY of Mauer ****;
		;**************************;

		bsr	CALC_MOUSE_QUADRAT

		lea	LAND,a4
		lsl.w	#1,d0		; X * 2
		add.l	d0,a4

		lsl.w	#4,d1		; Y * 16
		mulu	#LAND_WBYTES*LAND_DEPTH,d1
		add.l	d1,a4


		;**************************;
		;*****  COPY TO LAND  *****;
		;**************************;

		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

		clr.w	BLTAMOD(a0)
		clr.w	BLTDMOD(a0)

		move.l	#TAKE_BUFFER,BLTAPTH(a0)
		move.l	#MAUER_BUFFER,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bsr	WAIT_BLITTER


		;**************************;
		;****  PUT LEVELCODE   ****;
		;**************************;

		bsr	CALC_MOUSE_QUADRAT

		mulu	#MAUER_WBYTES/MAUER_WBYTE,d1	; Reihe * Y
		add.w	d0,d1				; + X = ....

		move.l	LEVEL_STRUCT_EDITOR+LAND_LEVELS_F(pc),a1
		move.b	LEVEL_CODE(pc),(a1,d1.w)
PUT_EXIT:	rts


		;-------------------------------;
		CALC_MOUSE_QUADRAT:
		;-------------------------------;

		move.l	a1,-(sp)

		lea	MOUSE_FLAGS(pc),a1

		moveq	#0,d0
		move.w	MOUSE_X_F(a1),d0
		lsr.w	#4,d0	; X / 16

		moveq	#0,d1
		move.w	MOUSE_Y_F(a1),d1
		lsr.w	#4,d1	; Y / 16

		move.l	(sp)+,a1
		rts


		;-------------------------------;
		WAIT_BLITTER:
		;-------------------------------;

		btst	#14,DMACONR(a0)
		bne	WAIT_BLITTER
		rts


		;-------------------------------;
		INIT_EDITOR_PLF:
		;-------------------------------;

		lea	LEVEL_STRUCT_EDITOR(pc),a6
		bra	BUILD_LAND


;-----------------------------------------------------------------------;
;		;***** Die LevelCodes als Bild darstellen ***;
;-----------------------------------------------------------------------;

		;**************************;
		;*****   Land Prefs   *****;
		;**************************;

		LAND_BLTAMOD_F:		equ	0
		LAND_BLTDMOD_F:		equ	LAND_BLTAMOD_F+2
		LAND_BLTSIZE_F:		equ	LAND_BLTDMOD_F+2
		LAND_LINE_SOURCE_F:	equ	LAND_BLTSIZE_F+2
		LAND_LINE_DESTIN_F:	equ	LAND_LINE_SOURCE_F+2
		LAND_SIZE_F:		equ	LAND_LINE_DESTIN_F+2
		LAND_LEVELS_F:		equ	LAND_SIZE_F+2
		LAND_VIEW_F:		equ	LAND_LEVELS_F+4


		;**************************;
		;*****  Land Structs  *****;
		;**************************;

	;---------------------------------------;
	;Syntax:dc.w	BLTAMOD			;
	;	dc.w	BLTDMOD			;
	;	dc.w	BLTSIZE			;
	;	dc.w	LINE_SIZE_SOURCE	;
	;	dc.w	LINE_SIZE_DESTIN	;
	;	dc.w	LEVEL_SIZE		;
	;	dc.l	*LEVEL_CODES		;
	;	dc.l	*VIEW			;
	;---------------------------------------;

		;**** Fuer den Editor *****;

LEVEL_STRUCT_EDITOR:
		dc.w	MAUER_WBYTES-MAUER_WBYTE
		dc.w	LAND_WBYTES-MAUER_WBYTE
		dc.w	[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2]
		dc.w	MAUER_WBYTES*MAUER_HEIGHT*LAND_DEPTH
		dc.w	LAND_WBYTES*MAUER_HEIGHT*LAND_DEPTH
		dc.w	LEVEL_SIZE-1
		dc.l	LEVELS
		dc.l	LAND


		;****  Fuer Playf. 1 *****;

LEVEL_STRUCT_GAME1:
		dc.w	MAUER_WBYTES-MAUER_WBYTE
		dc.w	GAME_WBYTES-MAUER_WBYTE
		dc.w	[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2]
		dc.w	MAUER_WBYTES*MAUER_HEIGHT*LAND_DEPTH
		dc.w	GAME_WBYTES*MAUER_HEIGHT*DEPTH
		dc.w	LEVEL_SIZE-1
		dc.l	GAME_LEVELS
		dc.l	BITPLANES1+PLANE_OFFS


		;****  Fuer Playf. 2 *****;

LEVEL_STRUCT_GAME2:
		dc.w	MAUER_WBYTES-MAUER_WBYTE
		dc.w	GAME_WBYTES-MAUER_WBYTE
		dc.w	[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2]
		dc.w	MAUER_WBYTES*MAUER_HEIGHT*LAND_DEPTH
		dc.w	GAME_WBYTES*MAUER_HEIGHT*DEPTH
		dc.w	LEVEL_SIZE-1
		dc.l	GAME_LEVELS
		dc.l	BITPLANES2+PLANE_OFFS


		;****  Fuer Playf. 3 *****;

LEVEL_STRUCT_GAME3:
		dc.w	MAUER_WBYTES-MAUER_WBYTE
		dc.w	GAME_WBYTES-MAUER_WBYTE
		dc.w	[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2]
		dc.w	MAUER_WBYTES*MAUER_HEIGHT*LAND_DEPTH
		dc.w	GAME_WBYTES*MAUER_HEIGHT*DEPTH
		dc.w	LEVEL_SIZE-1
		dc.l	GAME_LEVELS
		dc.l	BITPLANES3+PLANE_OFFS


		;-------------------------------;
		BUILD_LAND:
		;-------------------------------;

		movem.l	d0-d7/a0-a6,-(sp)

		move.l	LAND_LEVELS_F(a6),a1
		lea	MAUER,a2
		move.l	a2,a3
		move.l	LAND_VIEW_F(a6),a4
		move.l	a4,a5

		move.l	#$09F00000,BLTCON0(a0)

		move.w	LAND_BLTAMOD_F(a6),BLTAMOD(a0)
		move.w	LAND_BLTDMOD_F(a6),BLTDMOD(a0)

		moveq	#0,d3
		move.w	LAND_SIZE_F(a6),d7

BUILD_LAND_LP:	moveq	#0,d0
		move.b	(a1)+,d0	; Next Mauer
		move.w	LAND_LINE_SOURCE_F(a6),d2
		bsr	CALC_LAND_XY
		move.l	a2,a3
		add.l	d0,a3		; Mauer + X
		add.l	d1,a3		; Mauer + Y

		move.l	d3,d0
		move.w	LAND_LINE_DESTIN_F(a6),d2
		bsr	CALC_LAND_XY
		move.l	a4,a5
		add.l	d0,a5		; Land + X
		add.l	d1,a5		; Land + Y
		addq.l	#1,d3		; Next Land

		move.l	a3,BLTAPTH(a0)
		move.l	a5,BLTDPTH(a0)
		move.w	LAND_BLTSIZE_F(a6),BLTSIZE(a0)
		bsr	WAIT_BLITTER

		dbra	d7,BUILD_LAND_LP

		movem.l	(sp)+,d0-d7/a0-a6
		rts


		;-------------------------------;
		CALC_LAND_XY:
		;-------------------------------;

		;***** d1 <- QuadratPlatz *****;
		;***** d0 -> X Coord	  *****;
		;***** d1 -> Y Coord	  *****;


		;***** Y Coord *****;

		divu	#MAUER_WBYTES/MAUER_WBYTE,d0
		moveq	#0,d1
		move.w	d0,d1
		mulu	d2,d1

		;***** X Coord *****;

		clr.w	d0
		swap	d0
		mulu	#MAUER_WBYTE,d0
		rts


;-----------------------------------------------------------------------;


		;-------------------------------;
		COPY_MAUER:
		;-------------------------------;

		move.l	#$09F00000,BLTCON0(a0)

		move.w	#0,BLTAMOD(a0)
		move.w	#0,BLTDMOD(a0)

		move.l	#MAUER,BLTAPTH(a0)
		move.l	#MAUER_SAWN,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHTS*LAND_DEPTH*64]+[MAUER_WBYTES/2],BLTSIZE(a0)
		bra	WAIT_BLITTER


		;-------------------------------;
		SAVE_MAUER_BUFFER:
		;-------------------------------;

		move.w	#$09F0,BLTCON0(a0)
		clr.w	BLTCON1(a0)

		move.w	#LAND_WBYTES-MAUER_WBYTE,BLTAMOD(a0)
		move.w	#0,BLTDMOD(a0)

		move.l	OLD_LAND_POS(pc),BLTAPTH(a0)
		move.l	#MAUER_BUFFER,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bra	WAIT_BLITTER


		;-------------------------------;
		SAVE_TAKE_BUFFER:
		;-------------------------------;

		move.l	#$09F00000,BLTCON0(a0)

		move.w	#MAUER_WBYTES-MAUER_WBYTE,BLTAMOD(a0)
		move.w	#0,BLTDMOD(a0)

		move.l	#MAUER,BLTAPTH(a0)
		move.l	#TAKE_BUFFER,BLTDPTH(a0)
		move.w	#[MAUER_HEIGHT*LAND_DEPTH*64]+[MAUER_WBYTE/2],BLTSIZE(a0)
		bra	WAIT_BLITTER


		;-------------------------------;
		INIT_EDITOR_VIEW:	
		;-------------------------------;

		lea	CUSTOM,a0
		move.w	#$200,DMACON(a0)

		lea	MOUSE_FLAGS(pc),a1
		clr.w	(a1)+
		clr.l	(a1)

		;*************************;
		;*** Build Copperlist  ***;
		;*************************;

		lea	LAND_COPPER,a1
		lea	LAND_COPPERLIST(pc),a2

		moveq	#[[LAND_COPPERLIST_END-LAND_COPPERLIST]/2]-1,d0
LAND_COPLST_CHIP:
		move.w	(a2)+,(a1)+
		dbra	d0,LAND_COPLST_CHIP


		;***************************;
		;*****  Screen Colors  *****;
		;***************************;

		lea	GAME_COLORS,a2
		move.w	#COLOR00,d0
		moveq	#COLORS-1,d1

COLORS_EDITOR:	move.w	d0,(a1)+
		addq.w	#2,d0
		move.w	(a2)+,(a1)+
		dbra	d1,COLORS_EDITOR


		;***************************;
		;*****  Sprite Colors  *****;
		;***************************;

		lea	MAUS_COLORS,a2
		move.w	#COLOR00+[16*2],d0
		moveq	#COLORS-1,d1

COLORS_MAUS:	move.w	d0,(a1)+
		addq.w	#2,d0
		move.w	(a2)+,(a1)+
		dbra	d1,COLORS_MAUS
		

		;*************************;
		;** Build SpriteCopList **;
		;*************************;

		lea	MAUS,a2
		move.l	#$2C403C00,(a2)

		move.l	a2,d0
		move.w	#SPR0PTH,d1
		bsr	MAKE_SPRITE_COPPER

		moveq	#0,d0		; SprPTR's -> $0000
		moveq	#8-1-1,d7
SPRITE_DUMMY_LOOP:
		bsr	MAKE_SPRITE_COPPER
		dbra	d7,SPRITE_DUMMY_LOOP


		;***************************;
		;**** Screen for EDITOR ****;
		;***************************;

		move.l	#LAND,d1
		moveq	#LAND_WBYTES,d2
		bsr	MAKE_VIEW_COPPER


		;*************************;
		;*** Take Maschines ON ***;
		;*************************;

		move.w	#$0000,JOYTEST(a0)
		move.w	#$100,DMACON(a0)
		move.l	#LAND_COPPER,COP1LCH(a0)
		clr.w	COPJMP1(a0)
		move.w	#$87E0,DMACON(a0)
		move.l	#$FFFFFFFF,BLTAFWM(a0)
		rts


		;*************************;
		;***  Copper for View  ***;
		;*************************;

LAND_COPPERLIST:dc.w	DIWSTRT,$2C81,DIWSTOP,$2CC1
		dc.w	DDFSTRT,$0038,DDFSTOP,$00D0
		dc.w	BPLCON0,[LAND_DEPTH*$1000]+$200
		dc.w	BPLCON1,$0000,BPLCON2,$0024
		dc.w	BPL1MOD,[LAND_DEPTH*LAND_WBYTES]-40
		dc.w	BPL2MOD,[LAND_DEPTH*LAND_WBYTES]-40
LAND_COPPERLIST_END:
		; Continue Copper in COPPER (chip-mem)


		;-------------------------------;
		MAKE_SPRITE_COPPER:
		;-------------------------------;

		move.w	d1,(a1)+
		addq.w	#2,d1
		swap	d0
		move.w	d0,(a1)+

		move.w	d1,(a1)+
		addq.w	#2,d1
		swap	d0
		move.w	d0,(a1)+
		rts


		;-------------------------------;
		MAKE_VIEW_COPPER:
		;-------------------------------;

		movem.l	d0/d3,-(sp)

		moveq	#LAND_DEPTH-1,d0
		move.w	#BPL1PTH,d3

MAKE_VIEW_COPPER_LOOP:
		move.w	d3,(a1)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a1)+
		move.w	d3,(a1)+
		addq.w	#2,d3
		swap    d1
		move.w	d1,(a1)+
		add.l	d2,d1
		dbra	d0,MAKE_VIEW_COPPER_LOOP

		movem.l	(sp)+,d0/d3
		rts

EDITOR_END:
		END

