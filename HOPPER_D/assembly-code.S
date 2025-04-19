CIAAPRA=$BFE001
CUSTOM =$DFF000
VHPOSR =$006
BLTCON0=$040
BLTCON1=$042
BLTAFWM=$044
BLTAPTH=$050
BLTDPTH=$054
BLTSIZE=$058
BLTAMOD=$064
BLTDMOD=$066
COP1LCH=$080
COPJMP1=$088
DIWSTRT=$08E
DIWSTOP=$090
DDFSTRT=$092
DDFSTOP=$094
DMACON =$096
INTENA =$09A
INTREQ =$09C
INTREQR=$01E
BPL1PTH=$0E0
BPLCON0=$100
BPLCON1=$102
BPLCON2=$104
BPL1MOD=$108
BPL2MOD=$10A
SPR0PTH=$120
SPR0PTL=$122
SPR0POS=$140
SPR0CTL=$142
SPR0DATA=$144
SPR0DATB=$146
COLOR00=$180
CLOSELIBRARY=-414
ALLOCABS=-204
OLDOPENLIBRARY=-408
OPEN=-30
READ=-42
CLOSE=-36
OPENLIBRARY=-408
;**************************;
EXECBASE=4
VECT_VERTB=$6C
COP_LEN=$2d44
COLOR_LEN=2048
;**************************;
DEPTH=3
HEIGHT=256
WIDTH=320
WBYTES=40
PLANE_SIZE=40*420
SIZE=[40*420]*3
;**************************;
FONT_HEIGHT=25
FONT_WBYTES=40
FONT_WBYTE=4
FONT_PLANESIZE=[40*25]*5
FONT_SIZE=FONT_PLANESIZE*3
BUFFER_SIZE=[WBYTES+8]*[25+8]
;**************************;
BITPLANES=$40000
BUFFER=BITPLANES+[PLANE_SIZE*3]+[40*56]
COPPER=$79000
COLORS1=COPPER+COP_LEN
COLORS2=COLORS1+COLOR_LEN
COLORS3=COLORS2+1024
COLORS4=COLORS3+1024
COLORS5=COLORS4+1024
;**************************;
SOUND_START=$60000
SOUND_LEN=66564
XY=SOUND_START+66164
FONT_START=SOUND_START+SOUND_LEN
FONT_LEN=15016
PIC_START=FONT_START+FONT_LEN
PIC_LEN=17176
;**************************;

	;------------------;
	      START:
	;------------------;

	bsr	LOAD_SOUND
	bsr	LOAD_FONT
	bsr	LOAD_PIC
	bsr	MULTI_AWAY
	jmp	GO_TO_START
START_MAIN:
	st	START_AGAIN
	jsr	NOW_GO_ON
	sf	START_AGAIN
	sf	GET_EXIT
	jmp	NOW_GO_ON

NOW_GO_ON:
	jsr	SOUND_START+$34
	jsr	SOUND_START+$F4
	bsr	CLS
	bsr	COLORTABLE
	bsr	MAKE_BPLS
	bsr	BUILD_COPPER1
	bsr	INIT_VIEW
	bsr	COPPER_ON
	bsr	SHOW_PIC
	bsr	GET_COLORS
	
	;---------------------;
	      WAIT_RASTER:
	;---------------------;

	move.b	VHPOSR(a0),d0
	cmp.b	#-20,d0
	bne	WAIT_RASTER

	bsr	COLOR_SCROLL
	jsr	SOUND_START+$160
	bsr	SPR_ANIM
	bsr	FONT_SCROLL
	bsr	ANIM_BOB
	bsr	COLOR_ANIM

	tst.b	START_AGAIN
	bne	AGAI_N
	and.b	#64,CIAAPRA
	bne	NO_GET_EXIT
	st	GET_EXIT
NO_GET_EXIT:
	tst.b	GET_EXIT
	bne	EXIT
	bra	WAIT_RASTER

AGAI_N:	rts

START_AGAIN:
	dc.b	0
GET_EXIT:
	dc.b	0

	;---------------------;
	       SPR_ANIM:
	;---------------------;

	lea	COPPER,a1
	add.w	#$2252,a1
	move.w	#9,d0
	move.w	#58,d1
SPR_ANIM_LOOP1:
	move.w	#$bbb,(a1)+
	addq.w	#2,a1
	subq.w	#2,(a1)+
	add.w	d1,a1
	move.w	#$999,(a1)+	
	addq.w	#2,a1
	subq.w	#1,(a1)+
	add.w	d1,a1
	move.w	#$ddd,(a1)+
	addq.w	#2,a1
	subq.w	#3,(a1)+	
	add.w	d1,a1
	move.w	#$fff,(a1)+
	addq.w	#2,a1
	subq.w	#4,(a1)+
	add.w	d1,a1
	dbra	d0,SPR_ANIM_LOOP1
		
	lea	COPPER,a1
	add.w	#34,a1
	move.w	#9,d0
	move.w	#22,d1
SPR_ANIM_LOOP2:
	move.w	#$bbb,(a1)+
	addq.w	#2,a1
	addq.w	#2,(a1)+
	add.w	d1,a1
	move.w	#$999,(a1)+	
	addq.w	#2,a1
	addq.w	#1,(a1)+
	add.w	d1,a1
	move.w	#$ddd,(a1)+
	addq.w	#2,a1
	addq.w	#3,(a1)+	
	add.w	d1,a1
	move.w	#$fff,(a1)+
	addq.w	#2,a1
	addq.w	#4,(a1)+
	add.w	d1,a1
	dbra	d0,SPR_ANIM_LOOP2
	rts	

	;---------------------;
	      GO_TO_START:
	;---------------------;

	move.l	$80,OLD_TRAP0
	move.l	#START_MAIN,$80
	trap	#0
	move.l	OLD_TRAP0,$80
	rts
	
	;---------------------;
	      FONT_SCROLL:
	;---------------------;

	lea	BUFFER-[48*4]+4,a4
	lea	BITPLANES+[40*277],a5	
	move.w	#8,BLTAMOD(a0)
	clr.w	BLTDMOD(a0)
	move.w	#%0000100111110000,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	move.l	#BUFFER_SIZE,NEXT_PLANE1
	move.l	#PLANE_SIZE,NEXT_PLANE2
	move.w	#FONT_HEIGHT+8*64+20,BLT_SIZE
	bsr	BLT_NOW
	lea	BUFFER-[48*4]+4,a4
	lea	BITPLANES+[40*98],a5	
	bsr	BLT_NOW

	addq.w	#1,CHAR_POS
	move.w	CHAR_POS,d4
	cmp.w	ACT_POS,d4
	bne	SCROLL_AGAIN
	clr.w	CHAR_POS
	bsr	FONT_BUFFER
SCROLL_AGAIN:
	lea	BUFFER+4,a4
	lea	BUFFER+2,a5
	move.w	#2,BLTAMOD(a0)
	move.w	#2,BLTDMOD(a0)
	move.w	BLT_CON0,BLTCON0(a0)
	move.l	#BUFFER_SIZE,NEXT_PLANE1
	move.l	#BUFFER_SIZE,NEXT_PLANE2
	move.w	#FONT_HEIGHT*64+23,BLT_SIZE
	bsr	BLT_NOW
	rts

FONT_BUFFER:
	lea	MESSAGE,a1
	lea	ASCII,a2
	lea	FONT_START,a4
	lea	BUFFER+44,a5
	add.w	NEXT_CHAR,a1
	move.b	(a1),d0
	clr.l	d1
SEARCH:	cmp.b	(a2)+,d0
	beq	FOUND
	addq.w	#1,d1
	bra	SEARCH
FOUND:	divu	#10,d1
	move.w	d1,d2
	mulu	#[40*25],d2
	add.l	d2,a4	
	swap	d1
	mulu	#4,d1
	add.l	d1,a4
	addq.w	#1,NEXT_CHAR
	cmp.b	#-1,(a1)
	bne	GET_CONT
	st	GET_EXIT
GET_CONT:
	bra	GET_COMMANDS
NO_START:
	move.w	#WBYTES-FONT_WBYTE,BLTAMOD(a0)
	move.w	#44,BLTDMOD(a0)
	move.w	#%0000100111110000,BLTCON0(a0)
	move.l	#FONT_PLANESIZE,NEXT_PLANE1
	move.l	#BUFFER_SIZE,NEXT_PLANE2
	move.w	#FONT_HEIGHT*64+2,BLT_SIZE
	bsr	BLT_NOW
NOT_JET_COPY:
	rts	

ACT_POS:	dc.w	0
BLT_CON0:	dc.w	0


	;----------------------;
	      GET_COMMANDS:
	;----------------------;

	cmp.b	#0,(a1)
	bne	NO_FAST
	move.w	#%1000100111110000,BLT_CON0
	move.w	#4,ACT_POS
	bra	NOT_JET_COPY
NO_FAST:cmp.b	#1,(a1)
	bne	NO_ONE2
	move.w	#%1110100111110000,BLT_CON0
	move.w	#16,ACT_POS
	bra	NOT_JET_COPY
NO_ONE2:cmp.b	#5,(a1)
	bne	NO_ONE
	move.w	#%0000100111110000,BLT_CON0
	move.w	#2,ACT_POS
	bra	NOT_JET_COPY
NO_ONE:	cmp.b	#2,(a1)
	bne	NO_TWO
	move.w	#%1100100111110000,BLT_CON0
	move.w	#8,ACT_POS
	bra	NOT_JET_COPY
NO_TWO:	cmp.b	#7,(a1)
	bne	DONT1
	move.w	#4,XY_ADJUST
	bra	NOT_JET_COPY
DONT1:	cmp.b	#8,(a1)
	bne	DONT2
	move.w	#6,XY_ADJUST
	bra	NOT_JET_COPY
DONT2:	cmp.b	#9,(a1)
	bne	NO_CMD
	move.w	#8,XY_ADJUST
	bra	NOT_JET_COPY
NO_CMD:	bra	NO_START

	;------------------------;
		SHOW_PIC:
	;------------------------;
	
	move.l	#$FFFFFFFF,BLTAFWM(a0)
	move.w	#%0000100111110000,BLTCON0(a0)
	clr.w	BLTAMOD(a0)
	clr.w	BLTDMOD(a0)
	lea	PIC_START,a4
	lea	BITPLANES+[40*130],a5
	move.l	#40*143,NEXT_PLANE1
	move.l	#PLANE_SIZE,NEXT_PLANE2
	move.w	#143*64+20,BLT_SIZE
	bsr	BLT_NOW
	rts

BLT_NOW:
	move.w	#DEPTH-1,d7
BLT_AGAIN:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	BLT_SIZE,BLTSIZE(a0)
	add.l	NEXT_PLANE1,a4
	add.l	NEXT_PLANE2,a5
	dbra	d7,BLT_AGAIN
	rts	

NEXT_PLANE1:
	dc.l	0
NEXT_PLANE2:
	dc.l	0
BLT_SIZE:
	dc.w	0
CHAR_POS:
	dc.w	0
NEXT_CHAR:
	dc.w	0

	;-------------------;
	      ANIM_BOB:
	;-------------------;

	move.l	ZEIGER,a6
	cmp.w	#$ff,(a6)
	bne	NOT_M
	move.l	#XY,ZEIGER
	clr.w	d1
	lea	XY,a6
	move.b	(a6),d1
	bra	SHIT
NOT_M:	clr.w	d1
	move.b	-(a6),d1
SHIT:	mulu	#40,d1
	add.l	#BITPLANES,d1
	bsr	MAKE_BPLS
	clr.l	d4
	lea	ZEIGER,a5
	move.w	XY_ADJUST,d4
	add.l	d4,(a5)
	rts

ZEIGER:	dc.l XY

	;--------------------;
	     COLOR_ANIM:
	;--------------------;

	move.l	COPPER2,a1
	cmp.w	#0,COUNT1
	bne	NOW2
	cmp.w	#600,LOOP1
	beq	NOW1
	addq.w	#1,LOOP1
	rts
NOW1:	bsr	IN
	cmp.w	#10,COUNT2
	bne	GO_ON
	move.w	#10,COUNT1
	clr.w	COUNT2
	clr.w	LOOP1
	clr.w	LOOP2
GO_ON:	rts
NOW2:	cmp.w	#300,LOOP2
	beq	OUT
	addq.w	#1,LOOP2
	rts
OUT:	subq.w	#1,COUNT1
	move.w	#59,d0
	bsr	ANIM_COL_NOW1
	move.w	#55,d0
	add.w	#8,a1
	bsr	ANIM_COL_NOW1
	add.w	#8,a1
	move.w	#53,d0
	bsr	ANIM_COL_NOW1
	rts
ANIM_COL_NOW1:
	add.w	#8,a1
	subq.w	#4,(a1)+
	add.w	#14,a1
	addq.w	#4,(a1)+
	add.w	#18,a1
	dbra	d0,ANIM_COL_NOW1
	rts
IN:	addq.w	#1,COUNT2
	move.w	#59,d0
	bsr	ANIM_COL_NOW2
	move.w	#55,d0
	add.w	#8,a1
	bsr	ANIM_COL_NOW2
	add.w	#8,a1
	move.w	#53,d0
	bsr	ANIM_COL_NOW2
	rts
ANIM_COL_NOW2:
	add.w	#8,a1
	addq.w	#4,(a1)+
	add.w	#14,a1
	subq.w	#4,(a1)+
	add.w	#18,a1
	dbra	d0,ANIM_COL_NOW2
	rts

COUNT1:
	dc.w	0 
COUNT2:
	dc.w	0
LOOP1:
	dc.w	0
LOOP2:
	dc.w	0

	;---------------------;
             COLOR_SCROLL:
	;---------------------;

	lea	COLORS1,a2
	lea	COLORS5,a3
	lea	COLORS2,a4
	addq.w	#4,NEWPOS_ONE
	addq.w	#4,NEWPOS_THREE
	add.w	NEWPOS_THREE,a3
	cmp.w	#300,NEWPOS_ONE
	beq	RESET_POS_UP
	bra	SCROLL_DOWN
RESET_POS_UP:	
	clr.w	NEWPOS_ONE
	clr.w	NEWPOS_THREE
SCROLL_DOWN:
	sub.w   #2,NEWPOS_TWO
	add.w 	NEWPOS_TWO,a2
	cmp.w	#0,NEWPOS_TWO
	beq 	RESET_POS_DOWN
	bra	SCROLL_CONT
RESET_POS_DOWN:	
	move.w	#384,NEWPOS_TWO
SCROLL_CONT:
	move.w	#8,d4
	move.l	COPPER2,a1
	addq.w	#6,a1
	move.w	#59,d0
	bsr	SCROLL_NOW
	add.w	d4,a1
	move.w	#55,d0
	bsr	SCROLL_NOW
	add.w	d4,a1
	move.w	#53,d0
	bsr	SCROLL_NOW
	rts	
SCROLL_NOW:
	move.w	(a3)+,(a1)+
	addq.w	#6,a1
	move.w	(a2)+,(a1)+
	addq.w	#6,a1
	move.w	(a4)+,(a1)+
	addq.w	#6,a1
	move.w	(a3),(a1)+	
	addq.w	#6,a1
	move.w	(a2),(a1)+
	add.w	#10,a1
	dbra	d0,SCROLL_NOW
	rts	

	;--------------------;
	    BUILD_COPPER1:
	;--------------------;

	lea	COLORS4,a2
	move.l	COPPER1,a1
	move.w	#42,d0
	move.w	#$2901,d1
	move.w	#$29df,d2
	move.w	#$2939,d3
	move.w	#$fff,d4
BUILD_COPPER2:
	move.w	d1,(a1)+
	move.w	#$fffe,(a1)+
	move.w	#COLOR00+14,(a1)+	
	move.w	(a2)+,(a1)+
	move.w	#COLOR00+38,(a1)+	
	clr.w	(a1)+
	move.w	#SPR0POS,(a1)+
	move.w	d3,(a1)+
	move.w	#SPR0DATA,(a1)+
	move.w	#1,(a1)+
	move.w	#SPR0DATB,(a1)+
	move.w	#1,(a1)+	
	move.w	d2,(a1)+
	move.w	#$fffe,(a1)+
	add.w	#$0100,d1
	add.w	#$0100,d2
	add.w	#$0100,d3
	add.w	#$0013,d3
	dbra	d0,BUILD_COPPER2
	bsr	SPR_END

	move.l	a1,COPPER2
	lea	COLORS4,a2
	move.w	#213,d0
	move.w	#$5401,d1
	move.w	#$5401+160-24,BW_POS
	move.w	#$5401+072,d2
	move.w	#$5401+160,d3
	move.w	#$5401+212,d4
	move.w	#$5401+124,d5
	move.w	#$54df,d6
	move.w	#$54d8,d7
COLOR_SCROLL_LOOP:
	move.w  d2,(a1)+
	move.w	#$fffe,(a1)+
	move.w	#COLOR00,(a1)+
	clr.w	(a1)+
	move.w  d5,(a1)+
	move.w  #$fffe,(a1)+
	move.w	#COLOR00,(a1)+
	clr.w	(a1)+
	move.w  BW_POS,(a1)+
	move.w	#$fffe,(a1)+
	move.w	#COLOR00+14,(a1)+
	move.w	(a2)+,(a1)+
	move.w  d3,(a1)+
	move.w  #$fffe,(a1)+
	move.w	#COLOR00,(a1)+
	clr.w   (a1)+
	move.w  d4,(a1)+
	move.w  #$fffe,(a1)+
	move.w	#COLOR00,(a1)+
	clr.w   (a1)+
	move.w	d6,(a1)+
	move.w	#$fffe,(a1)+
	add.w 	#$0100,d1
	add.w	#$0100,d2
	add.w	#$0100,d3
	add.w   #$0100,d4
	add.w   #$0100,d5
	add.w   #$0100,d6
	add.w	#$0100,d7
	add.w	#$0100,BW_POS
	tst.b	NOW_SPR
	bne	SPR_EVER
	cmp.w	#$ff01,d1
	bne	NOT_SPR
SPR_EVER:
	st	NOW_SPR
	move.w	d1,(a1)+
	move.w	#$fffe,(a1)+
	move.w	#COLOR00+38,(a1)+
	clr.w	(a1)+
	move.w	#SPR0POS,(a1)+
	move.w	d7,(a1)+
	move.w	#SPR0DATA,(a1)+
	move.w	#1,(a1)+
	move.w	#SPR0DATB,(a1)+
	move.w	#1,(a1)+
	sub.w	#$0013,d7
NOT_SPR:
	cmp.w	#$9001,d1
	bne	NOT_JET1
	move.w	#BPL1MOD,(a1)+
	move.w	#40,(a1)+
	move.w	#BPL2MOD,(a1)+
	move.w	#40,(a1)+
NOT_JET1:
	cmp.w	#$c801,d1
	bne	NOT_JET2
	move.w	#BPL1MOD,(a1)+
	move.w	#0,(a1)+
	move.w	#BPL2MOD,(a1)+
	move.w	#0,(a1)+
NOT_JET2:
	dbra 	d0,COLOR_SCROLL_LOOP
	bsr	SPR_END
	move.l	#$01800000,(a1)+
	move.l	#$fffffffe,(a1)+
	rts
SPR_END:
	clr.w	d3
	move.w	#SPR0POS,(a1)+
	move.w	d3,(a1)+
	move.w	#SPR0DATA,(a1)+
	move.w	#2,(a1)+
	move.w	#SPR0DATB,(a1)+
	move.w	#1,(a1)+	
	rts
MAKE_BPLS_1:
	move.l	#BITPLANES,d1
MAKE_BPLS:
	moveq	#2,d4
	lea	COPPER,a1
	move.w	#BPL1PTH,d3
MAKE_BPL_CL:
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	add.l	#PLANE_SIZE,d1
	dbra	d4,MAKE_BPL_CL
	move.l	a1,COPPER1
	rts	

NEWPOS_ONE:	dc.w	0
NEWPOS_TWO:	dc.w	0
NEWPOS_THREE:	dc.w	0
BW_POS:		dc.w	0
NOW_SPR:	dc.b	0
		even

	;-------------------;
	    MULTI_AWAY:
	;-------------------;

	lea	CUSTOM,a0
	move.w	#$4000,INTENA(a0)
	move.w	#$4000,INTREQ(a0)
	move.w	#$0020,INTREQ(a0)
	move.w	#$8020,INTENA(a0)
	rts
	
	;-------------------;
  	    INIT_VIEW:
	;-------------------;

	lea	CUSTOM,a0
	move.w	#$2a81,DIWSTRT(a0)
	move.w	#$2ac1,DIWSTOP(a0)
	move.w	#$0038,DDFSTRT(a0)
	move.w	#$00d0,DDFSTOP(a0)
	move.w	#%011001000000000,BPLCON0(a0)
	clr.w	BPLCON1(a0)
	move.w	#%000000000000100,BPLCON2(a0)

	move.w 	#384,NEWPOS_TWO
	clr.w	NEXT_CHAR
	move.w	#10,COUNT1
	move.w	#$FF,XY+360
	clr.b	NOW_SPR
	move.w	#%1100100111110000,BLT_CON0
	move.w	#8,ACT_POS
	move.w	#8,XY_ADJUST
	rts

XY_ADJUST:
	dc.w	0

	;-------------------;
	    COPPER_ON: 
	;-------------------;

	lea	CUSTOM,a0
	move.w	#%0000000000100000,DMACON(a0)
	move.l	#COPPER,COP1LCH(a0)
	clr.w	COPJMP1(a0)
	move.w	#%1001111100000000,DMACON(a0)
	rts
	
	;-------------------;
 	    COLORTABLE:
	;-------------------;

	lea	CUSTOM,a0
	move.w	#%000000100000000,DMACON(a0)
	lea	COLORS1,a0
	move.w	#$f,d4
	move.w	#2,d7
	move.l	#COLORDEFS,NEW_TABLE
	bsr	AGAIN

	lea	COLORS2,a0
	move.w	#10,d7
	move.l	#COLORREDS,NEW_TABLE
	bsr	AGAIN
	lea	COLORS3,a0
	move.w	#2,d7
	move.l	#COLORREDS,NEW_TABLE
	bsr	AGAIN

	lea	COLORS4,a0
	move.w	#20,d7
	move.l	#COLORBLUES,NEW_TABLE
	bsr	AGAIN
	bsr	GET_OTHER_COLORS
	rts

AGAIN:	move.l	NEW_TABLE,a1
TAKE_AGAIN:
	bsr	TAKE_COLOR
CALC_COLOR_ONE:
	move.w	d2,(a0)+
	add.w	d1,d2
	dbra	d0,CALC_COLOR_ONE
	bsr	TAKE_COLOR
CALC_COLOR_TWO:	
	move.w	d2,(a0)+
	sub.w	d1,d2
	dbra	d0,CALC_COLOR_TWO
	cmp.w	#-99,(a1)
	beq	TAKE_COLOR_EXIT
	bra	TAKE_AGAIN
TAKE_COLOR:
	move.w	(a1)+,d1
  	move.w	(a1)+,d2
	move.w	d4,d0
	rts
TAKE_COLOR_EXIT:	
	dbra	d7,AGAIN
	rts

GET_OTHER_COLORS:
	lea	COLORS5,a1
	move.w	#14,d7
AGA_IN:	move.w	#$e,d0
	move.w	#$00f,d1
	move.w	#$100,d2
	move.w	#$001,d3
GET_OC_LOOP1:
	move.w	d1,(a1)+	
	add.w	d2,d1
	sub.w	d3,d1
	dbra	d0,GET_OC_LOOP1
	move.w	#$e,d0
GET_OC_LOOP2:
	move.w	d1,(a1)+
	sub.w	d2,d1
	add.w	d3,d1
	dbra	d0,GET_OC_LOOP2
	dbra	d7,AGA_IN
	rts

COLORDEFS2:
	dc.w	$100,$300
	dc.w	$100,$f00
	dc.w	$010,$330
	dc.w	$010,$3f0
	dc.w	$001,$333
	dc.w	$001,$33f
	dc.w	-99

COLORDEFS:
	dc.w	$111,$000
	dc.w	$101,$fff
	dc.w	$001,$0f0
	dc.w	$010,$0ff
	dc.w	$100,$00f
	dc.w	$100,$f0f
	dc.w	$010,$00f
	dc.w	$001,$0ff 
	dc.w	$100,$0f0 
	dc.w	$010,$ff0 
	dc.w	$010,$f00
	dc.w	$110,$ff0
	dc.w	-99
COLORREDS:
	dc.w	$011,$f00
	dc.w	$011,$fff
	dc.w	-99
COLORBLUES:
	dc.w	$110,$00f
	dc.w	$110,$fff
	dc.w	-99
NEW_TABLE:
	dc.l	0	

	;-------------------;
		CLS:
	;-------------------;

	lea	BITPLANES,a1
	move.w	#SIZE,d6
	clr.w	d2
	bsr	FILL_LOOP
	lea	BUFFER-[48*4],a1
	move.w	#BUFFER_SIZE*3,d6
	bsr	FILL_LOOP
	rts
FILL_LOOP:
	move.b	d2,(a1)+
	dbra	d6,FILL_LOOP
	rts

	;-------------------;
	     GET_COLORS:
	;-------------------;

	lea	COLOR_MAP,a1
	lea	$DFF180,a2
	moveq	#7,d4
COLOR_LOOP:
	move.w	(a1)+,(a2)+
	dbra	d4,COLOR_LOOP
	rts		

COLOR_MAP:
	dc.w	$bef,$bef,$9cf,$7ad,$58b,$379,$369,$f00

	;-------------------;
	    LOAD_SOUND:
	;-------------------;

	lea	DOS_NAME,a1
	move.l	4,a6
	jsr	OLDOPENLIBRARY(a6)
	move.l	d0,DOSBASE

	move.l	#SOUND_NAME,d1
	move.l	#1005,d2
	move.l	DOSBASE,a6
	jsr	OPEN(a6)
	move.l	d0,d1
	move.l	d1,-(SP)
	move.l	#SOUND_START,d2
	move.l	#SOUND_LEN,d3
	jsr	READ(a6)
	move.l	(SP)+,d1
	jsr	CLOSE(a6)
	rts

	;-------------------;
	    LOAD_FONT:
	;-------------------;

	move.l	#FONT_NAME,d1
	move.l	#1005,d2
	move.l	DOSBASE,a6
	jsr	OPEN(a6)
	move.l	d0,d1
	move.l	d1,-(SP)
	move.l	#FONT_START,d2
	move.l	#FONT_LEN,d3
	jsr	READ(a6)
	move.l	(SP)+,d1
	jsr	CLOSE(a6)
	rts

	;-------------------;
	    LOAD_PIC:
	;-------------------;

	move.l	#PIC_NAME,d1
	move.l	#1005,d2
	move.l	DOSBASE,a6
	jsr	OPEN(a6)
	move.l	d0,d1
	move.l	d1,-(SP)
	move.l	#PIC_START,d2
	move.l	#PIC_LEN,d3
	jsr	READ(a6)
	move.l	(SP)+,d1
	jsr	CLOSE(a6)
	rts

	;-------------------;
		EXIT:
	;-------------------;

	move.l	EXECBASE,a6
	lea	GFXNAME,a1
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	lea	$dff000,a0
	move.l	38(a4),COP1LCH(a0)
	clr.w	COPJMP1(a0)		
	move.w	#$83E0,DMACON(a0)
	jsr	SOUND_START+$130
	moveq	#0,d0
	rte
	
COPPER1:	dc.l	0
COPPER2:	dc.l	0
OLD_TRAP0:	dc.l	0
GFXNAME:	dc.b	"graphics.library",0,0
DOSBASE:	dc.l	0
DOS_NAME:	dc.b	"dos.library",0,0
SOUND_NAME:	dc.b	"sound",0
FONT_NAME:	dc.b	"font",0
PIC_NAME:	dc.b	"amiga",0

MESSAGE:
 dc.b	9,"             BITTE SCROLL-TEXT DURCHLESEN ",7
 dc.b	"   ",1,"HERZLICHEN DANK !",0,8
 dc.b	"           ",2,"          HALLO   AMMIGOS !!!",0
 dc.b	"           ",2,"  THIS INTRO WAS DESIGNED AND CODED BY  ",1,9 
 dc.b	" ] MEMED ]",5,"            ",2,7
 dc.b	"   USING THE SEKA-ASSEMBLER ....   ",8
 dc.b	" THE MUZAK WAS COMPOSED BY",1," [[ KERMY [[ ",2,"(SOUNDTRACKER)   "
 dc.b	" FIRST AT ALL I=LL SEND SOME SERVUS TO MY CODING-TEACHER  "
 dc.b	1,"    [[ MINGI [[ ",5,"               "
 dc.b	2,"        OK BUT NOW CONTINUE WITH THE "
 dc.b	"GREATINGS  ....  GREAT DOUBLE GREETINGS TO SOME OF MY LOCAL "
 dc.b	"FRIENDS                      ",1,9
 dc.b	"  PILOT,HERMY,INGO",5,"              ",1
 dc.b	" MARC ",5,"                         ",1
 dc.b	"  STEFFAN ",5,"              ",1  
 dc.b	" HOT-AMIGA ",5,"              ",1  
 dc.b	" POWERFORCE ",5,"                     ",1  
 dc.b	"  BOND ",5,"                          "
 dc.b	" BLOODY",1,"CROWLER",5,"AND",1,"REFREGERATOR",2
 dc.b	" THE AMSTRAD-CPC KNALLERS "
 dc.b	5,"                     ",1,"  THE GUILD OF GURU ",5
 dc.b	"                  ",1
 dc.b	"  HERBY ",5,"              ",1
 dc.b	"  HASY,ROLI ",5,"              ",1
 dc.b	"  MICHI,BERND ",5,"        ",1
 dc.b	"  DIENI,NES ",5,"        ",1
 dc.b	"  TAFTY ",5
 dc.b	"                ",1
 dc.b	" AND OF COURSE  LUTZ AND KERMY ",5              
 dc.b	"                       ",2
 dc.b	7," SUPER-SONIC-HIGH-DOUBLE-MEGA-GIGA GREETINGS TO "
 dc.b	"THE BEST PROGRAMMERS :",9,"                  ",1
 dc.b	"MINGI ",5,"              ",1 
 dc.b	"MORDILLO ",5,"              ",1 
 dc.b	" BOND ",5,"               ",1
 dc.b	" ANDY ",5,"               ",1
 dc.b	" SODAN AND MAGICIAN 42",5,"             ",1 
 dc.b	"  ATOM (NORTHSTARS) ",2 
 dc.b	" ALSO THE OTHER CODERS FROM THE NORTHSTARS ",5
 dc.b	"             ",0,"]] KERMY AND"
 dc.b	"LUTZ",1,"THE C-64 PROFS ]]            ",1 
 dc.b	" AND THE HQC-CODERS",2                
 dc.b	"     GREETINGS AGAIN "
 dc.b	"TO ALL CRACKERS:     ",0 
 dc.b	"  THE KNIGHT-HAWKS, BITSTOPPERS ,"
 dc.b	" SUNRIDERS, D.O.C , O K S , ENFORCER , NORTHSTAR , DEXION ,"
 dc.b	" GUILD OF GURU , POWERSTATION , BAMIGA SECTOR ONE , TRACK-7"
 dc.b	" , THE PROPHETS , FASHIONATIONS , H Q C , POWER-TRACK , "
 dc.b	"POWER-CONECTION, GOLDEN-DELTA,"
 dc.b	" OUTSIDER , POWERFORCE  AND ALL THE OTHERS ....       ",2
 dc.b	" OK ZWISCHENDURCH MAL WAS ANDERES ...  ",8
 dc.b	"  WOLLT IHR MEINE TELEPHONNUMMER WISSEN??  DANN RUFT MICH "
 dc.b	"DOCH EINFACH MAL AN !!              ALSO GUT ICH SAG=S EUCH "
 dc.b	" ALSO SCHREIBZEUG BEREIT HALTEN,",0," WEIL DER TEXT LAEUFT"
 dc.b	" =N BISSCHEN SCHNELL,",2,"ALSO JETZT ",0,"          "
 dc.b	"QUARK",2," ICH SAG=S DOCH NICHT !!     GELL IHR WOLLT MICH "
 dc.b	" AN DIE BULLS VERPETZEN !!!     "
 dc.b	" ALSO GUT ICH SAG=S DOCH, ABER NUR WENN IHR NICHT DIE "
 dc.b	"BULLEN VERSTAENDIGT !! OK, ALSO,",0," ICH WOHNE IM MARS "
 dc.b	", MOND-STERN-HIMMEL-STRASSE 1313, HEISSE MEMED, ",2
 dc.b	"BIN 2.99 M  MICRO-WINZIG UND WENN ICH 9 GEWORDEN BIN DARF "
 dc.b	"ICH AUCH ENDLICH MIT MEINEM UFO RUMHEIZEN               "
   dc.b	"WAR WOHL KEIN SO GUTER WITZ ??  OK,OK  ",8
 dc.b	" DANN WAS ANDERES.....     "
 dc.b	" HEY FREACKS WENN IHR ORIGINALS HABT, ICH CRACKS FREI ....  "
 dc.b	" ACH NOCH ETWAS, ICH BIN LEIDER NOCH EIN ANFAENGER - "
 dc.b	"DIE GANZE SCHEISSE HAB ICH IN GANZE  6 MONATE "
 dc.b	"ZUSAMMEN-GEKOTET, VORHER HATTE "
 dc.b	"ICH IN  C  PROGRAMMIERT,  KANN ICH ABER LEIDER NICHT "
 dc.b	"EMPFAEHLEN, WEIL DAS WIRKLICH DER LETZTE REINFALL IST "
 dc.b	0,"ALSO FANGT GLEICH MIT ASSEMBLER AN, ",0,"HALT!!",1,"ODER AM",2,"  BESTEN "
 dc.b	"GAR NICHT, SONST VERBLOEDET IHR NOCH (GENAU SO WIE ICH) "
 dc.b	"OHNE SHIT FREI ICH ERZAEHL HIER KEIN BULL-SHIT ....   "
 dc.b	" MEINEN AMIGA HAB ICH JETZT SEIT GENAU EINEM JAHR ... "
 dc.b	" MEIN ERSTER COMPI WAR EIN SPECTRUM MIT SUPER 48K SPEICHER "
 dc.b	0,"(APRIL 1985)",2," DANACH FOLGTE EIN CPC-SCHNEIDER "
 dc.b	0,"(DEZEMBER " 
 dc.b	"1986)",2," SPAETER BEKAM ICH EIN ATARI-ST" 
 dc.b	0,"(JUNI 1987)",2," UND "
 dc.b	"SCHLIESSLICH NACH ALL DEM SCHRECK, HORROR UND "
 dc.b	"WAS WEIS ICH NOCH FUER KACKE "
 dc.b	" KAUFTE ICH MIR MEIN AMIGA ",0,"(DEZEMBER 1987)",2," UND BEREUE ES "
 dc.b	"HEUTE NOCH NICHT.  "
 dc.b	0,"    OK ICH NEHM AN DAS WARS MAL WIEDER ,",2," HALT AGAIN !!!"
 dc.b	" ZUM ABSHIED NOCH DAS ALPHABET:",0," ABCDEFGHIJKLMNOPQRSTUV"
 dc.b	"WXYZ ",2,"  UND AUCH DAS ZAHLENSYSTEM ",0
 dc.b	"0123456789ABCDEF                ",2
 dc.b	"  BUT NOW IS REALLY SENSE  =CAUSE I MUST NOW GO TO BED   " 
 dc.b	"MAN BIN ICH MUEDE  OOOOOAAAAAHHHHH !!  ( 23.58.39 UHR )"
 dc.b	"   ALSO DANN GRUESST AUCH DIE ANDEREN VON MIR "
 dc.b	" AND MEGA SERVUS TO ALL DIE ES "
 dc.b	"GEREADET HABEN !!!!  TILL TO MY NEXT INTRO !!!!  "  
 dc.b	"                                                       ",-1

ASCII:
 dc.b   "ABCDEFGHIJ"
 dc.b   "KLMNOPQRST"
 dc.b   "UVWXYZ!?:;"
 dc.b	"0123456789"
 dc.b   "+(),-.=[] "

END=$78238
