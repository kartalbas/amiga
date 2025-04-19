CIAAPRA=$bfe001
CUSTOM =$dff000
VPOSR  =$004
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
BLTCDAT=$070
BLTBDAT=$072
BLTADAT=$074
BLTDDAT=$074
COP1LCH=$080
COPJMP1=$088
DMACON =$096
INTREQ =$09c
INTENA =$09a
DIWSTRT=$08e
DIWSTOP=$090
DDFSTRT=$092
DDFSTOP=$094
BPL1PTH=$0e0
BPLCON0=$100
BPLCON1=$102
BPLCON2=$104
BPL1MOD=$108
BPL2MOD=$10a
SPR1PTH=$120
COLOR00=$180
;*************************;
EXECBASE=4
OPENLIBRARY=-552
;*************************;
COLORS=16
DEPTH=4
WBYTES=46
HEIGHT=257
MIDDLE=1
;*************************;
PLANE_SIZE=WBYTES*HEIGHT
SIZE=PLANE_SIZE*DEPTH
;*************************;
BITPLANES=$40000
CHAR_SET=BITPLANES-[120*8]
COPPER=CHAR_SET-[1*1024]
SCREEN_BPLS=COPPER+36
CHAR_COLORS=COPPER+68
STAR_XYZ=BITPLANES+SIZE+[WBYTES*100]
OLD_STAR_XYZ=STAR_XYZ+[2*200*3]
HOP_NUMBERS=OLD_STAR_XYZ+[200*2]
CHAR_COUNT=HOP_NUMBERS+[400*4]
CHAR_OFFS=CHAR_COUNT+2
RAINBOW_COLORS=CHAR_OFFS+2
;*************************;
SND=$60000+1600
;*************************;
ORG	SND-1600
LOAD	*
;*************************;
>EXTERN "BloodMoneySnd",SND,28674
;*************************;

	;----------------;
	     START:
	;----------------;

	jsr	SND+42
	bsr.l	CLS
	bsr.l	GET_CHAR_SET
	bsr.l	CALC_HOP_NUMBERS
	bsr.l	INIT_VIEW

	;----------------;
	      MAIN:
	;----------------;

	cmp.b	#$60,VHPOSR(a0)
	bne.s	MAIN
	and.b	#64,CIAAPRA
	beq.l	EXIT

;	move.w	#$FFF,COLOR00(a0)
	bsr.l	MOVE_STARS
	bsr.s	SCROLL_CHAR
	bsr.s	HOP_CHAR
	jsr	SND+218
;	move.w	#$000,COLOR00(a0)

	bra.s	MAIN

	;----------------;
	    HOP_CHAR:
	;----------------;

	lea.l	COPPER+[COPPEREND-COPPERLIST]+16,a1
	lea.l	HOP_PTR(pc),a2
	move.l	(a2),a3
	addq.l	#4,(a2)
	move.l	(a3),d0
	cmp.w	#$FF,d0
	bne.s	CONT_HOP1
	move.l	#HOP_NUMBERS,(a2)
	rts
CONT_HOP1:
	move.w	#BPL1PTH+8,d1
	move.w	#DEPTH-3-1,d2
	bsr.l	BPLS_LOOP
	rts

HOP_PTR:dc.l	HOP_NUMBERS

	;----------------;
	   SCROLL_CHAR:
	;----------------;

	lea.l	MESSAGE(pc),a1
	lea.l	CHAR_SET,a3
	lea.l	BITPLANES+[PLANE_SIZE*3]+[WBYTES*3]+3,a5
	lea.l	WBYTES-2(a5),a2
	lea.l	CHAR_COUNT,a4
	lea.l	2(a4),a6

	clr.l	BLTAMOD(a0)
	move.w	#$E9F0,BLTCON0(a0)
	move.l	a5,BLTAPTH(a0)
	subq.l	#2,a5
	move.l	a5,BLTDPTH(a0)
	move.w	#[32*64]+[WBYTES/2],BLTSIZE(a0)

	move.w	#$09F0,BLTCON0(a0)
	lea.l	BITPLANES+[PLANE_SIZE*3]+[WBYTES*3]+3,a5
	move.l	a5,BLTAPTH(a0)
	lea.l	BITPLANES+[PLANE_SIZE*3]+[WBYTES*131]+3,a5
	move.l	a5,BLTDPTH(a0)
	move.w	#[32*64]+[WBYTES/2],BLTSIZE(a0)

	cmp.b	#3,(a4)
	beq.s	CONT_MESSAGE1
	addq.b	#1,(a4)
	rts

CONT_MESSAGE1:
	moveq	#0,d0
	clr.b	(a4)
	add.w	(a6),a1
	addq.w	#1,(a6)
	move.b	(a1),d0
	sub.b	#" ",d0
	cmp.b	#$DF,d0
	bne.s	CONT_MESSAGE2
	clr.w	(a6)
	moveq	#0,d0
CONT_MESSAGE2:
	add.w	d0,a3
	moveq	#8-1,d2
COPY_LOOP:
	move.b	(a3),(a2)
	add.w	#WBYTES,a2
	move.b	(a3),(a2)
	add.w	#WBYTES,a2
	move.b	(a3),(a2)
	add.w	#WBYTES,a2
	add.w	#120,a3
	dbra	d2,COPY_LOOP
	rts

MESSAGE:dc.b	"Servus Freax"
	dc.b	"  -STOP-  " 
	dc.b	"BLACK MONKS presents their new crack    xxxxx "
	dc.b	"  -STOP-  "
	dc.b	"  Cracked by IVENHOE "
	dc.b	"  -STOP-  "
	dc.b	"Small Intro by MEHMET "
	dc.b	"  -STOP-  "
	dc.b	"Sound was ripped from Blood-Money"
	dc.b	"  -END-  "
	dc.b	"         "
	dc.b	"         "
	dc.b	"         "
	dc.b	"         "
	dc.b	"         "
	dc.b	"         ",-1
	even

	;----------------;
	 CALC_HOP_NUMBERS:
	;----------------;

	lea.l	HOP_NUMBERS,a1
	move.w	#43-1,d0
	moveq	#0,d2
	moveq	#0,d3
	move.l	#BITPLANES+[PLANE_SIZE*3]+1,d4
	move.l	d4,d5
	bsr.s	HOP_STAND
	bsr.s	CALC_HOP
	move.w	#$5382,SUBQ
	move.w	#43-1,d0
	bsr.s	CALC_HOP
	bsr.s	HOP_STAND
	move.l	#$FF,(a1)+
	rts

HOP_STAND:
	move.w	#40,d7
HS_LOOP:move.l	d4,(a1)+
	dbra	d7,HS_LOOP
	rts

CALC_HOP:
	move.l	d5,d4
	sub.l	d3,d4
	move.l	d4,d3
	move.l	d3,(a1)+
	move.l	d2,d3
	mulu	d2,d3
	divu	#20,d3
	mulu	#WBYTES,d3
SUBQ:	addq.l	#1,d2
	dbra	d0,CALC_HOP
	rts

	;----------------;
	   MOVE_STARS:
	;----------------;

	lea.l	STAR_XYZ,a4
	lea.l	BITPLANES,a5
	lea.l	OLD_STAR_XYZ,a6

	move.w	#255,a2
	move.w	#370,a3
	move.w	#WBYTES,d6
	move.l	#PLANE_SIZE,d7

	move.w	#100-1,d3
STAR_LOOP:
	move.w	(a4)+,d4
	move.w	(a4)+,d5
	move.w	(a4),d2
	subq.w	#4,(a4)+
	bmi.l	GET_COORDS

	ext.l	d4
	ext.l	d5
	divs	d2,d4
	divs	d2,d5
	add.w	#200,d4
	add.w	#128,d5

	cmp.w	#10,d4
	bls.s	GET_COORDS
	tst.w	d5
	bls.s	GET_COORDS
	cmp.w	a3,d4
	bhs.s	GET_COORDS
	cmp.w	a2,d5
	bhs.s	GET_COORDS

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
	lea.w	(a5,d1.l),a1
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
	ble.s	NOT_COLOR_1 
	lea.w	(a5,d1.l),a1
	bset	d0,(a1)
	bra.s	NEXT_STAR
NOT_COLOR_1:
	cmp.w	#200,d2
	ble.s	NOT_COLOR_2 
	lea.w	(a5,d7.l),a1
	add.w	d1,a1
	bset	d0,(a1)
	bra.s	NEXT_STAR
NOT_COLOR_2:
	lea.w	(a5,d1.l),a1
	bset	d0,(a1)
	add.w	d7,a1
	bset	d0,(a1)
NEXT_STAR:
	dbra	d3,STAR_LOOP
	rts

GET_COORDS:
	subq.l	#6,a4
	bsr.s	GET_RND
	move.w	d0,(a4)+
	bsr.s	GET_RND
	move.w	d0,(a4)+
	move.w	#600,(a4)+
	bra.s	NEXT_STAR

GET_RND:move.w	VHPOSR(a0),d0
	move.b	$BFD800,d1
	move.b	$BFD801,d2
	asl.w	d2,d1
	mulu	200(sp),d0
	eor.w	d1,d0
	eor.w	#$feef,d0
	move.w	d0,200(sp)
	rts

	;----------------;
	    INIT_VIEW:
	;----------------;

	lea.l	CUSTOM,a0
	lea.l	COPPERLIST(pc),a1
	lea.l	COPPER,a2

	move.w	#COPPEREND-COPPERLIST,d7
COPY_COPPER:
	move.b	(a1)+,(a2)+
	dbra	d7,COPY_COPPER
	lea.l	SCREEN_BPLS,a1
	bsr.L	PUT_BPLS

	lea.l	CHAR_COLORS,a1
	move.l	#$01800000,d6
	move.l	d6,(a1)+
	move.w	#COLOR00,d0
	move.l	#$250ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$F00,(a1)+
	move.l	#$260ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$D00,(a1)+
	move.l	#$270ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$A00,(a1)+
	move.l	#$280ffffe,d1
	move.w	#$800,d5
	bsr.l	GET_C0
	move.l	#$4B0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$A00,(a1)+
	move.l	#$4C0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$E00,(a1)+
	move.l	#$4D0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$F00,(a1)+
	move.l	#$4E0ffffe,(a1)+
	move.l	d6,(a1)+
	move.l	#$01800000,d6
	move.l	d6,(a1)+

	move.l	#$A70ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$F,(a1)+
	move.l	#$A80ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$D,(a1)+
	move.l	#$A90ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$A,(a1)+
	move.l	#$AA0ffffe,d1
	move.w	#$8,d5
	bsr.s	GET_C0
	move.l	#$CD0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$A,(a1)+
	move.l	#$CE0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$E,(a1)+
	move.l	#$CF0ffffe,(a1)+
	move.w	d0,(a1)+
	move.w	#$F,(a1)+
	move.l	#$D00ffffe,(a1)+
	move.l	d6,(a1)+
	move.l	#$FFFFFFFE,(a1)+

	move.w	#$550,COLOR00+2(a0)
	move.w	#$880,COLOR00+4(a0)
	move.w	#$DD0,COLOR00+6(a0)
	move.w	#$F0A,COLOR00+8(a0)
	move.w	#$0FF,COLOR00+16(a0)
	move.w	#$4F8,COLOR00+24(a0)

	move.l	#COPPER,COP1LCH(a0)
	move.w	#$87E0,DMACON(a0)
	clr.w	COPJMP1(a0)
	move.w	#32,DMACON(a0)
	move.w	#$FFFF,BLTAFWM+2(a0)
	rts

GET_C0:	move.w	#35-1,d7
GET_COLORS0:
	move.l	d1,(a1)+
	move.w	d0,(a1)+
	move.w	d5,(a1)+
	add.l	#$01000000,d1
	dbra	d7,GET_COLORS0
	rts

PUT_BPLS:
	move.l	#BITPLANES+MIDDLE,d0
	move.w	#BPL1PTH,d1
	move.w	#DEPTH-1,d2
BPLS_LOOP:
	move.w	d1,(a1)+
	swap	d0
	move.w	d0,(a1)+
	addq.w	#2,d1
	move.w	d1,(a1)+
	swap 	d0
	move.w	d0,(a1)+
	addq.w	#2,d1
	add.w	#PLANE_SIZE,d0
	dbra	d2,BPLS_LOOP		
	rts

COPPERLIST:
	dc.w	DIWSTRT,$2C61,DIWSTOP,$2CD1
	dc.w	DDFSTRT,$002A,DDFSTOP,$00d6
	dc.w	BPL1MOD,WBYTES-46,BPL2MOD,WBYTES-46
	dc.w	BPLCON0,[DEPTH*$1000]+$200
	dc.w	BPLCON1,$0000,INTENA,$4000
COPPEREND:

	;----------------;
	  GET_CHAR_SET:
	;----------------;

	lea.l	$FC90F4,a1
	lea.l	CHAR_SET,a2

	move.w	#120-1,d1
	moveq	#8-1,d2
LOOP:	move.b	(a1)+,(a2)+
	dbra	d1,LOOP
	add.w	#152-80,a1
	move.w	#120-1,d1
	dbra	d2,LOOP
	rts

	;----------------;
	      CLS:
	;----------------;

	lea.l	COPPER,a1
	move.l	#[[$50000-COPPER]/4]-1,d0
CLS_LOOP:
	clr.l	(a1)+
	subq.l	#1,d0
	bpl.s	CLS_LOOP
	rts

	;----------------;
	      EXIT:
	;----------------;

	lea.l	GFXNAME(pc),a1
	move.l	EXECBASE,a6
	clr.l	d0
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	move.l	38(a4),COP1LCH+CUSTOM
	move.w	#$000F,DMACON+CUSTOM
	moveq	#0,d0
	rts

GFXNAME:dc.b	"graphics.library",0
END:
ENDE=SND+4850
