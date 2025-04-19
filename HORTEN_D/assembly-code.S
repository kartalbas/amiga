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
COLDCAPTURE=42
;**************************;
EXECBASE=4
VECT_VERTB=$6C
COP_LEN=$2d44
COLOR_LEN=2048
;**************************;
DEPTH=3
HEIGHT=100
WIDTH=320
WBYTES=40
PLANE_SIZE=40*100
SIZE=[40*100]*3
;**************************;
FONT_HEIGHT=45
FONT_WBYTES=40
FONT_WBYTE=4
FONT_PLANESIZE=[40*45]*5
FONT_SIZE=FONT_PLANESIZE*3
BUFFER_SIZE=[WBYTES+8]*45
;**************************;
BITPLANES=$40000
BUFFER=$49000
COPPER=$7d900
COLORS=$7e400
CAPTURE=$79000
;**************************;
SOUND_START=$4b000
SOUND_LEN=67870
FONT_START=$5d000
FONT_LEN=27016
PIC_START=FONT_START
PIC_LEN=105030
AMIGAW=$63c38
SELFP=$6d8b8
XY=$63aa8
;**************************;

	;------------------;
	      START:
	;------------------;

	bsr	LOAD_IT

	jsr	$4b034
	jsr	$4b0f4
	bsr	MULTI_AWAY
	jmp	GO_TO_START
SECOND_START:
	bsr	CLS
	bsr	BUILD_COPPER
	bsr	INIT_VIEW
	bsr	COPPER_ON
	
	;---------------------;
	      WAIT_RASTER:
	;---------------------;

	move.b	VHPOSR(a0),d0
	cmp.b	#-20,d0
	bne	WAIT_RASTER

	bsr	FONT_SCROLL
	bsr	ANIM_PICS
	bsr	ANIM_FONT
	jsr	$4b160

	and.b	#64,CIAAPRA
	beq	EXIT
	bra	WAIT_RASTER

	;-------------------;
	    ANIM_FONT:
	;-------------------;

	move.l	ZEIGER2,a6
	cmp.w	#$ff,(a6)
	bgt	NOT_M
	move.l	#XY2,ZEIGER2
	clr.w	d1
	lea	XY2,a6
	move.b	(a6),d1
	bra	SHIT
NOT_M:	clr.w	d1
	move.b	-(a6),d1
SHIT:	mulu	#40,d1
	add.l	#BITPLANES,d1
	bsr	MAKE_BPLS3
	addq.l	#2,ZEIGER2
	rts

ZEIGER2: dc.l	XY2
XY2:	 dc.b	1,2,3,4,5,6,6,7,8,8,9,10,11,12,13,14,15,16,17,18,19
	 dc.b	20,21,22,23,24,25,25,26,27,27,28,29,29,30,31,31,31
	 dc.b	31,31,31,30,29,29,28,27,27,26,25,25,24,23,22,21,20
	 dc.b	19,18,17,16,15,14,13,12,11,10,9,8,8,7,6,6,5,4,3,2,1
	 dc.b	$ff,$ff

	;-------------------;
	    ANIM_PICS:
	;-------------------;

	move.l	ZEIGER,a6
	cmp.w	#$ff,(a6)
	bne	NOT_M2
	move.l	#XY,ZEIGER
	clr.w	d1
	lea	XY,a6
	move.b	(a6),d1
	bra	SHIT2
NOT_M2:	clr.w	d1
	move.b	-(a6),d1
SHIT2:	mulu	#40,d1
	move.l	d1,ADJUST_XY
	add.l	#SELFP,d1
	bsr	MAKE_BPLS1
	move.l	ADJUST_XY,d1
	add.l	#AMIGAW,d1
	bsr	MAKE_BPLS2
	clr.l	d4
	lea	ZEIGER,a5
	move.w	XY_ADJUST,d4
	add.l	d4,(a5)
	rts

ADJUST_XY:
	dc.l	0
ZEIGER:	dc.l	XY


MAKE_BPLS1:
	lea	$7d904,a1
	moveq	#4,d4
	move.w	#BPL1PTH,d3
MAKE_BPL_CL1:
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	add.l	#40*186,d1
	dbra	d4,MAKE_BPL_CL1
	rts	

MAKE_BPLS2:
	lea	$7de40,a1
	moveq	#4,d4
	move.w	#BPL1PTH,d3
MAKE_BPL_CL2:
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	add.l	#40*200,d1
	dbra	d4,MAKE_BPL_CL2
	rts	

MAKE_BPLS3:
	lea	$7d9b0,a1
	moveq	#4,d4
	move.w	#BPL1PTH,d3
MAKE_BPL_CL3:
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	move.w	d3,(a1)+
	addq.w	#2,d3
	swap	d1
	move.w	d1,(a1)+
	add.l	#40*100,d1
	dbra	d4,MAKE_BPL_CL3
	rts	

	;---------------------;
	      GO_TO_START:
	;---------------------;

	move.l	$80,OLD_TRAP0
	move.l	#SECOND_START,$80
	trap	#0
	move.l	OLD_TRAP0,$80
	rts
	
	;---------------------;
	      FONT_SCROLL:
	;---------------------;

	move.l	#$ffffffff,BLTAFWM(a0)
	move.w	#8,BLTAMOD(a0)
	clr.w	BLTDMOD(a0)
	move.w	#%0000100111110000,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	move.l	#BUFFER_SIZE,NEXT_PLANE1
	move.l	#PLANE_SIZE,NEXT_PLANE2
	move.w	#FONT_HEIGHT*64+20,BLT_SIZE
	lea	BUFFER+4,a4
	lea	BITPLANES+[40*36],a5	
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
	mulu	#[40*45],d2
	add.l	d2,a4	
	swap	d1
	mulu	#4,d1
	add.l	d1,a4
	addq.w	#1,NEXT_CHAR
	cmp.b	#-1,(a1)
	bne	GET_CONT
	clr.w	NEXT_CHAR
	rts
GET_CONT:
	bsr	GET_COMMANDS
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
	lea	FONT_START,a4
	lea	BUFFER+44,a5
	add.l	#[40*45]*4,a4
	add.l	#9*4,a4
	rts
NO_FAST:cmp.b	#1,(a1)
	bne	NO_ONE2
	move.w	#%1110100111110000,BLT_CON0
	move.w	#16,ACT_POS
	lea	FONT_START,a4
	lea	BUFFER+44,a5
	add.l	#[40*45]*4,a4
	add.l	#9*4,a4
	rts
NO_ONE2:cmp.b	#5,(a1)
	bne	NO_ONE
	move.w	#%0000100111110000,BLT_CON0
	move.w	#2,ACT_POS
	lea	FONT_START,a4
	lea	BUFFER+44,a5
	add.l	#[40*45]*4,a4
	add.l	#9*4,a4
	rts
NO_ONE:	cmp.b	#2,(a1)
	bne	NO_CMD
	move.w	#%1100100111110000,BLT_CON0
	move.w	#8,ACT_POS
	lea	FONT_START,a4
	lea	BUFFER+44,a5
	add.l	#[40*45]*4,a4
	add.l	#9*4,a4
NO_CMD:	rts

	;------------------------;
	       BLT_NOW:
	;------------------------;
	
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


	;------------------;
	   BUILD_COPPER:
	;------------------;

	bsr	GETCOLORS
	lea	COPPER_COM,a1
	lea	COPPER,a2
	move.w	#123,d6
GET_COPPER_COM:
	move.w	(a1)+,(a2)+
	dbra	d6,GET_COPPER_COM		
	bsr	GET_COLORS
	move.w	96,d6
GET3:	move.w	(a1)+,(a2)+
	dbra	d6,GET3
	rts

GET_COLORS:
	lea	COLORS,a3
	move.l	#$800ffffe,d1
	move.l	#$801ffffe,d2
	move.w	#90,d0
GETCOLORSLOOP:
	move.l	d1,(a2)+
	move.w	#$180,(a2)+
	move.w	(a3)+,(a2)+
	move.l	d2,(a2)+
	add.l	#$01000000,d1
	add.l	#$01000000,d2
	dbra	d0,GETCOLORSLOOP
	rts		

GETCOLORS:
	lea	COLORS,a3
	move.w	#5,d0
GET_ALL_LOOP:
	move.w	#$00f,d1
	move.w	#$100,d2
	move.w	#$001,d3
	move.w	#14,d7
GET1_LOOP:
	move.w	d1,(a3)+
	add.w	d2,d1
	sub.w	d3,d1
	dbra	d7,GET1_LOOP
	move.w	#14,d7
GET2_LOOP:
	move.w	d1,(a3)+
	sub.w	d2,d1
	add.w	d3,d1
	dbra	d7,GET2_LOOP
	dbra	d0,GET_ALL_LOOP
	rts

COPPER_COM:
	dc.w	$290f,$fffe	; SELF_PORTRAIT_COLORS
	dc.w	$00e0,$0006,$00e2,$D8B8
	dc.w	$00e4,$0006,$00e6,$f5c8
	dc.w	$00e8,$0007,$00ea,$12d8
	dc.w	$00ec,$0007,$00ee,$2Fe8
	dc.w	$00f0,$0007,$00f2,$4Cf8
	dc.w	$180,$000,$182,$dcc,$184,$a99,$186,$877
	dc.w	$188,$766,$18a,$fb9,$18c,$fb9,$18e,$e98
	dc.w	$190,$fa8,$192,$e97,$194,$d86,$196,$c75
	dc.w	$198,$b64,$19a,$953,$19c,$c76,$19e,$b76
	dc.w	$1a0,$a65,$1a2,$a64,$1a4,$965,$1a6,$865
	dc.w	$1a8,$854,$1aa,$754,$1ac,$743,$1ae,$643
	dc.w	$1b0,$543,$1b2,$432,$1b4,$110,$1b6,$ca8
	dc.w	$1b8,$000,$1ba,$000,$1bc,$022,$1be,$087		

	dc.w	$7f0f,$fffe	; FONT_COLORS
	dc.w	$00e0,$0004,$00e2,$0000
	dc.w	$00e4,$0004,$00e6,$0fa0
	dc.w	$00e8,$0004,$00ea,$1f40
	dc.w	$00ec,$0004,$00ee,$2ee0
	dc.w	$00f0,$0004,$00f2,$3e80
	dc.w	$180,$000,$182,$ed0,$184,$cb0,$186,$b90
	dc.w	$188,$970,$18a,$850,$18c,$640,$18e,$fff

	dc.w	$dc0f,$fffe	; AMIGA_WORLD_COLORS
	dc.w	$00e0,$0006,$00e2,$3c38
	dc.w	$00e4,$0006,$00e6,$5b78
	dc.w	$00e8,$0006,$00ea,$7ab8
	dc.w	$00ec,$0006,$00ee,$99f8
	dc.w	$00f0,$0006,$00f2,$b938
	dc.w	$180,$000,$182,$044,$184,$154,$186,$365
	dc.w	$188,$476,$18a,$da3,$18c,$e70,$18e,$e40
	dc.w	$190,$c00,$192,$a00,$194,$0ad,$196,$08f
	dc.w	$198,$05c,$19a,$229,$19c,$8a7,$19e,$854
	dc.w	$1a0,$965,$1a2,$b86,$1a4,$c97,$1a6,$da8
	dc.w	$1a8,$eb9,$1aa,$fca,$1ac,$222,$1ae,$333
	dc.w	$1b0,$444,$1b2,$666,$1b4,$777,$1b6,$999
	dc.w	$1b8,$aaa,$1ba,$ccc,$1bc,$ddd,$1be,$fff
	dc.w	$ffff,$fffe,-4		

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
	move.w	#$2af0,DIWSTOP(a0)
	move.w	#$0038,DDFSTRT(a0)
	move.w	#$00d0,DDFSTOP(a0)
	move.w	#%0101001000000000,BPLCON0(a0)
	clr.w	BPLCON1(a0)
	move.w	#%000000000000100,BPLCON2(a0)
	clr.w	BPL1MOD(a0)
	clr.w	BPL2MOD(a0)

	clr.w	NEXT_CHAR
	move.w	#$FF,XY+360
	move.w	#%1100100111110000,BLT_CON0
	move.w	#8,ACT_POS
	move.w	#6,XY_ADJUST
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
		CLS:
	;-------------------;

	lea	BITPLANES,a1
	move.w	#SIZE*2,d6
	clr.w	d2
	bsr	FILL_LOOP
	lea	BUFFER,a1
	move.w	#BUFFER_SIZE*3,d6
	bsr	FILL_LOOP
	rts
FILL_LOOP:
	move.b	d2,(a1)+
	dbra	d6,FILL_LOOP
	rts

	;------------------;
	     LOAD_IT:
	;------------------;

	lea	DOS_NAME,a1
	move.l	EXECBASE,a6
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

DOSBASE:
 dc.l	0
DOS_NAME:
 dc.b	"dos.library",0,0
SOUND_NAME:
 dc.b	"sound",0
FONT_NAME:
 dc.b	"horten.font",0
PIC_NAME:
 dc.b	"graphics",0

	;-------------------;
		EXIT:
	;-------------------;

	jsr	$4b130
	move.l	EXECBASE,a6
	lea	GFXNAME,a1
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	lea	$dff000,a0
	move.l	38(a4),COP1LCH(a0)
	clr.w	COPJMP1(a0)		
	move.w	#$83E0,DMACON(a0)
	moveq	#0,d0
	rte
	
COPPER1:	dc.l	0
COPPER2:	dc.l	0
OLD_TRAP0:	dc.l	0
GFXNAME:	dc.b	"graphics.library",0,0

MESSAGE:
 dc.b	0,"                   ",2
 dc.b	"DIES",0,"IST",2,"EIN",0,"DEMO",2,"FUER",0,"HORTEN",2
 dc.b	"        ",0,"            ",-1

ASCII:
 dc.b   "ABCDEFGHIJ"
 dc.b   "KLMNOPQRST"
 dc.b   "UVWXYZ!?:;"
 dc.b	"0123456789"
 dc.b   "+(),-.=[] "

END:
