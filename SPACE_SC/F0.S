CIAAPRA=$BFE001
CUSTOM =$DFF000
DMACONR=$002
VHPOSR =$006
BLTCON0=$040
BLTCON1=$042
BLTAFWM=$044
BLTCPTH=$048
BLTBPTH=$04C
BLTAPTH=$050
BLTDPTH=$054
BLTSIZE=$058
BLTCMOD=$060
BLTBMOD=$062
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
OPENLIBRARY=-408
EXECBASE=4
;**************************;
DEPTH=5
WBYTES=40
HEIGHT=256
PLANE_SIZE=WBYTES*HEIGHT
SIZE=WBYTES*HEIGHT*DEPTH
;**************************;
MASKE=$40000
FONT=MASKE+$fa50
FONT_COLORS=FONT+[40*160*4]
GO=FONT_COLORS+32
COORDS=GO+880
COPPER=COORDS+200+900
;**************************;

ORG	GO
LOAD	*

	;------------------;
	      START:
	;------------------;

	bsr.l	CALC_COORDS
	bsr.l	BUILD_COPPER
	bsr.l	COPPER_ON

	;---------------------;
	      WAIT_RASTER:
	;---------------------;

	cmp.b	#$25,VHPOSR(a0)
	bne.s	WAIT_RASTER
	and.b	#64,CIAAPRA
	beq	EXIT

;	move.w	#$FFF,COLOR00(a0)
;	and.b	#128,CIAAPRA
;	bne.s	WAIT_RASTER
	bsr.s	SEARCH_CHAR
	bsr.s	GIVE_COLORS
	bsr.l	SCROLL_COLORS
;	move.w	#$000,COLOR00(a0)

	bra	WAIT_RASTER

	;-----------------;
	   SEARCH_CHAR:
	;-----------------;

	lea.l	MESSAGE,a1
	lea.l	ASCII,a2
	lea.l	FONT,a4
	lea.l	FONT_PTR,a5

	cmp.b	#31,5(a5)
	bne.s	CHAR_EXIT
	sf	5(a5)
NOT_FONT_END:
	add.w	6(a5),a1
	move.b	(a1),d0
	moveq	#0,d1
SEARCH:	cmp.b	(a2)+,d0
	beq.s	FOUND
	addq.w	#1,d1
	bra.s	SEARCH
FOUND:	divu	#10,d1
	move.w	d1,d2
	mulu	#[40*32*4],d2
	add.l	d2,a4
	clr.w	d1
	swap	d1
	rol.w	#2,d1
	add.l	d1,a4
	move.l	a4,(a5)
	addq.w	#1,6(a5)
	cmp.b	#-1,(a1)
	bne.s	CHAR_EXIT
	clr.w	6(a5)
	rts
CHAR_EXIT:
	addq.b	#1,5(a5)
	rts

FONT_PTR:
	dc.l	0
CHAR_COUNT:
	dc.w	31
NEXT_CHAR:
	dc.w	0

	;-----------------;
	    GIVE_COLORS:
	;-----------------;

	lea.l	COPPER+102+[136*80],a1
	lea.l	FONT_PTR,a2
	lea.l	FONT_COLORS,a3

	move.l	a3,a6
	move.l	(a2),a4

	moveq	#1,d6
	asl.l	#8,d6
	asl.l	#8,d6
	asl.l	#8,d6
	asl.l	#7,d6

	move.w	#31-1,d7
SEARCH_LOOP:
	moveq	#0,d0
	move.l	40*0(a4),d1
	move.l	40*1(a4),d2
	move.l	40*2(a4),d3
	move.l	40*3(a4),d4
	and.l	d6,d1
	bne.s	BPL2
	eor.b	#1,d0
BPL2:	and.l	d6,d2
	bne.s	BPL3
	eor.b	#2,d0
BPL3:	and.l	d6,d3
	bne.s	BPL5
	eor.b	#4,d0
BPL5:	and.l	d6,d4
	bne.s	BPLS_READY
	eor.b	#8,d0
BPLS_READY:
	move.l	a6,a3
	asl.b	#1,d0
	sub.w	d0,a3
	move.w	30(a3),(a1)
	lsr.l	#1,d6
	addq.l	#4,a1
	dbra	d7,SEARCH_LOOP
	add.l	#40*4,(a2)
	rts

	;-----------------;
	   SCROLL_COLORS:
	;-----------------;

	lea.l	COPPER+102,a1
	lea.l	136(a1),a2
	lea.l	BLTCON0(a0),a3

	move.w	#$09F0,(a3)
	move.w	#136-2,36(a3)
	move.w	#136-2,38(a3)

	move.w	#80*64+1,d6
	move.w	#31-1,d7
COLOR_SCRL_LOOP:
	move.l	a2,16(a3)
	move.l	a1,20(a3)
	move.w	d6,24(a3)
	addq.l	#4,a1
	addq.l	#4,a2
	dbra	d7,COLOR_SCRL_LOOP
	rts

	;-----------------;
	   CALC_COORDS:
	;-----------------;

	lea.l	COORDS,a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	#87,d2
CALC_PAR_LOOP:
	move.l	d0,d1
	mulu	d1,d1
	divu	#20,d1
	move.b	d1,(a1)+
	addq.l	#1,d0
	dbra	d2,CALC_PAR_LOOP

	lea.l	COORDS,a1
	lea.l	COORDS+13,a2
	move.l	#$00010203,(a1)+
	move.b	#$04,(a1)+
	move.w	#76,d7
COORDS_LOOP:
	move.b	(a2)+,(a1)+
	dbra	d7,COORDS_LOOP
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	rts

	;-----------------;
	   BUILD_COPPER:
	;-----------------;

	lea.l	COPPER,a1
	lea.l	COORDS,a2
	lea.l	COPPER_LST(pc),a3

	move.w	#52-1,d7
COPY_CLST:
	move.b	(a3)+,(a1)+
	dbra	d7,COPY_CLST

	move.l	#MASKE+[25*40*5],d1
	move.w	#BPL1PTH,d2
	moveq	#DEPTH-1,d0
VIEW_LOOP:
	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	add.l	#WBYTES,d1
	dbra	d0,VIEW_LOOP

	move.w	#80-1,d0
	move.w	#COLOR00+2,d1
	move.w	d1,d2
	move.w	#31-1,d5
	move.w	d5,d6
	moveq	#0,d3
BUILD_COPPER_LOOP:
	move.b	(a2)+,d3
	lsl.l	#8,d3
	lsl.l	#8,d3
	lsl.l	#8,d3
	move.l	d3,d4
	add.l	#$100ffffe,d3
	add.l	#$10dffffe,d4
	move.l	d3,(a1)+
	move.l	d4,(a1)+
COP_COL_LOOP:
	move.w	d1,(a1)+
	clr.w	(a1)+
	addq.w	#2,d1
	dbra	d5,COP_COL_LOOP
	move.w	d2,d1
	move.l	#$01020444,(a1)+
	move.w	d6,d5
	dbra	d0,BUILD_COPPER_LOOP
	move.l	#$01800000,(a1)+
	move.l	#$FFFFFFFE,(a1)
	rts

COPPER_LST:
	dc.w	INTENA,$4000,INTREQ,$4000,INTREQ,$0020,INTENA,$8020
	dc.w	DIWSTRT,$1081,DIWSTOP,$3AC1,DDFSTRT,$38,DDFSTOP,$D0
	dc.w	BPLCON0,DEPTH*$1000,BPLCON1,$4444,BPLCON2,$0004
	dc.w	BPL1MOD,[DEPTH*WBYTES]-WBYTES
	dc.w	BPL2MOD,[DEPTH*WBYTES]-WBYTES

	;-------------------;
  	     COPPER_ON:
	;-------------------;

	lea.l	CUSTOM,a0
	move.w	#%100000000,DMACON(a0)
	move.l	#COPPER,COP1LCH(a0)
	clr.w	COPJMP1(a0)
	move.w	#%1001111100000000,DMACON(a0)
	move.w	#%100000,DMACON(a0)
	move.l	#$FFFFFFFF,BLTAFWM(a0)
	clr.w	COLOR00(a0)
	rts

	;-------------------;
		EXIT:
	;-------------------;

	move.l	EXECBASE,a6
	lea.l	GFXNAME,a1
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	lea.l	CUSTOM,a0
	move.w	#256,DMACON(a0)
	move.l	38(a4),COP1LCH(a0)
	clr.w	COPJMP1(a0)		
	move.w	#$83E0,DMACON(a0)
	moveq	#0,d0
	rts

MESSAGE:dc.b	"HALLO LEUTE !!! "
	dc.b	"A B C D E F G H I J K L "
	dc.b	"M N O P Q R S T U V W X "
	dc.b	"Y Z 0 1 2 3 4 5 6 7 8 9 "
	dc.b	-1

ASCII:	dc.b	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	dc.b	"0123456789!?:;'[],-./"

GFXNAME:	dc.b	"graphics.library",0,0
END:
