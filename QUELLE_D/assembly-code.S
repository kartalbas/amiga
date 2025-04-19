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
OPEN=-30
READ=-42
CLOSE=-36
CLOSELIBRARY=-414
OPENLIBRARY=-408
EXECBASE=4
COLDCAPTURE=42
;**************************;
DEPTH=3
PLANE_SIZE=40*512
SIZE=[40*512]*3
;**************************;
SB=[[6*25]*3]
BOBEL=[36*25]
BUFFER_SIZE=[48*25]
;**************************;
BITPLANES=$2f000
BITPLANES2=BITPLANES+[[40*512]*3]
COPPER=$4e000
COLORS1=$7c560
COLORS2=$7d000
MASK=$7da00
BUFFER=$26500
BUFFER1=$7b900
BUFFER2=BUFFER1+SB
BUFFER3=BUFFER2+SB
BUFFER4=BUFFER3+SB
BUFFER5=BUFFER4+SB
BUFFER6=BUFFER5+SB
;**************************;
SOUND=$60000
X=SOUND-[640*4]
Y=X-[640*4]
Q=Y-16220
FONT=Q-[[40*125]*3]
HOP=FONT-636
LOGON=HOP-13220
MEHMET=LOGON-2416
KOPF_NUMS=HOP-256
PC_START=$28500

	;------------------;
	      START:
	;------------------;

	bsr	LOAD_MURKS
	jsr	SOUND+$30
	jsr	SOUND+$F0
	bsr	CLS
	bsr	COLOR_TABLE
	bsr	BUILD_COPPER
	bsr	GET_MASK
	bsr	GET_BM_NUMS
	bsr	GET_COLORS
	bsr	INIT_VIEW
	bsr	GET_NEW_STRUCT
	bsr	COPY_QUELLE
	bsr	COPY_MEHMET
	bsr	COPY_LOGON
	bsr	GET_KOPF_NUMS

	;-----------------;
	    NEW_VERTB:
	;-----------------;

	move.b	VHPOSR(a0),d0
	cmp.b	#10,d0
	bne.s	NEW_VERTB

;	move.w	#$f0f,COLOR00(a0)
	bsr	GET_KOPF
	bsr	ANIM_BOB_MAIN
	bsr	FONT_SCROLL
	bsr	COLOR_SCROLL
	jsr	SOUND+$15C
;	clr.w	COLOR00(a0)

	and.b	#64,CIAAPRA
	beq	EXIT
	bra	NEW_VERTB

	;--------------;
	   BLEND_OUT:
	;--------------;

	lea	COLOR00+16(a0),a1
	lea	BL_COLORS(pc),a5
	lea	BLEND_COUNT(pc),a6
	cmp.w	#[8*2]*6,(a6)
	beq	OK_OUT
	add.w	(a6),a5
	add.w	#8*2,(a6)
	moveq	#7,d0
OUT_LOOP:
	move.w	(a5)+,(a1)+
	dbra	d0,OUT_LOOP
OK_OUT:	rts

	;--------------;
	   BLEND_IN:
	;--------------;
	
	lea	COLOR00+16(a0),a1
	lea	BL_COLORS(pc),a5
	lea	BLEND_COUNT(pc),a6
	cmp.w	#0,(a6)
	beq	OK_IN
	sub.w	#8*2,(a6)
	add.w	(a6),a5
	moveq	#7,d0
IN_LOOP:
	move.w	(a5)+,(a1)+
	dbra	d0,IN_LOOP
OK_IN:	rts

BLEND_COUNT:
	dc.w	0

	;--------------;
	   GET_KOPF:
	;--------------;

	lea	KOPF(pc),a3
	move.b	(a3),d4
	tst.b	d4
	beq	NOT_KOPF_YET
	lea	KOPF_HOCH(pc),a3
	move.b	(a3),d4
	tst.b	d4
	bne.s	KOPF_UPER
	lea	KOPF_ZEIG(pc),a3
	move.l	(a3),a1
	addq.l	#4,(a3)
	cmp.l	#KOPF_NUMS+252,(a3)
	bne	NOT_SET_UP
	lea	KOPF_HOCH(pc),a2
	st	(a2)
	bra	GET_KOPF	
KOPF_UPER:
	lea	KOPF_ZEIG(pc),a3
	move.l	(a3),a1
	subq.l	#4,(a3)
	cmp.l	#KOPF_NUMS,(a3)
	bne.s	NOT_SET_DOWN
	lea	KOPF_HOCH(pc),a2
	sf	(a2)
	lea	KOPF_AGAIN(pc),a4
	addq.b	#1,(a4)
	cmp.b	#2,(a4)
	bne.s	NOT_AGAIN_END
	lea	KOPF(pc),a2
	lea	KOPF_AGAIN(pc),a3
	sf	(a2)
	sf	(a3)
NOT_AGAIN_END:
	lea	BPL2(pc),a2
	lea	BPL1(pc),a3
	move.w	#-80,(a2)
	clr.w	(a3)
	lea	UP2(pc),a2
	lea	UP1(pc),a3
	move.l	#40*256,(a2)
	clr.l	(a3)	
	bra	GET_KOPF
NOT_SET_DOWN:
	clr.l	d1
	move.b	(a1),d1
	mulu	#40,d1
	move.l	d1,d7
	lea	UP1(pc),a4
	add.l	(a4),d1
	add.l	(a4),d7
	add.l	#BITPLANES,d1
	add.l	#BITPLANES2,d7
	lea	BPL1(pc),a2
	move.w	(a2),BPL1MOD(a0)
	move.w	(a2),BPL2MOD(a0)
	bsr	BUILD_VIEW_COPPER
	move.l	d7,d2
	bsr	BUILD_VIEW_2
	rts
NOT_SET_UP:
	clr.l	d1
	move.b	(a1),d1
	mulu	#40,d1
	move.l	d1,d7
	lea	UP2(pc),a4
	add.l	(a4),d1
	add.l	(a4),d7
	add.l	#BITPLANES,d1
	add.l	#BITPLANES2,d7
	lea	BPL2(pc),a2
	move.w	(a2),BPL1MOD(a0)
	move.w	(a2),BPL2MOD(a0)
	bsr	BUILD_VIEW_COPPER
	move.l	d7,d1
	bsr	BUILD_VIEW_2
	rts
NOT_KOPF_YET:	
	lea	UP1(pc),a2
	move.l	#40*256,(a2)
	clr.l	4(a2)
	lea	BPL1(pc),a3
	move.w	#-80,(a3)
	clr.w	2(a3)
	bsr	HOPPER
	rts	

UP1:	dc.l	40*256
UP2:	dc.l	0
BPL1:	dc.w	-80
BPL2:	dc.w	0
KOPF_ZEIG:
	dc.l	KOPF_NUMS
KOPF_HOCH:
	dc.b	0
KOPF_RUNTER:
	dc.b	0
KOPF_AGAIN:
	dc.b	0
	even

	;----------------;
	  GET_KOPF_NUMS:
	;----------------;
	
	lea	KOPF_NUMS,a1
	clr.l	d0
	move.w	#$ff,d1
KOPF_LOOP:
	move.b	d0,(a1)+
	addq.b	#1,d0
	dbra	d1,KOPF_LOOP
	rts

	;--------------;
	     HOPPER:
	;--------------;

	clr.l	d1
	lea	HOP_ZEIG(pc),a2
	move.l	(a2),a1
	move.b	(a1),d1
	sub.b	#150,d1
	lea	HOP_ZEIG(pc),a2
	move.l	(a2),d5
	cmp.l	#HOP+320,d5
	bne.s	HOP_IT
	move.l	#HOP,(a2)
	bra	HOPPER
HOP_IT:mulu	#40,d1
	add.l	#BITPLANES,d1
	lea	HOP_ZEIG(pc),a2
	add.l	#16,(a2)
	bsr	BUILD_VIEW_COPPER
	rts

HOP_ZEIG:
	dc.l	HOP

	;-------------------;
	    FONT_SCROLL:
	;-------------------;

	lea	KOPF(pc),a2
	tst.b	(a2)
	bne	NOT_JET_COPY
	move.l	#$ffffffff,BLTAFWM(a0)
	move.w	#8,BLTAMOD(a0)
	clr.w	BLTDMOD(a0)
	move.w	#$09F0,BLTCON0(a0)
	clr.w	BLTCON1(a0)

	lea	BUFFER+4,a4
	lea	BITPLANES+[180*40],a5	
	moveq	#2,d6
BLT_LOOP1:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	#25*64+20,BLTSIZE(a0)
	lea	BUFFER_SIZE(a4),a4
	lea	PLANE_SIZE(a5),a5
	dbra	d6,BLT_LOOP1

	lea	CHAR_POS(pc),a2
	move.l	a2,a4
	addq.w	#1,(a2)
	move.w	(a2),d4
	lea	ACT_POS(pc),a3
	cmp.w	(a3),d4
	bne.s	SCROLL_AGAIN
	clr.w	(a4)
	bsr	FONT_BUFFER
SCROLL_AGAIN:
	move.w	#2,BLTAMOD(a0)
	move.w	#2,BLTDMOD(a0)
	lea	BLT_CON0(pc),a2
	move.w	(a2),BLTCON0(a0)
	lea	BUFFER+4,a4
	lea	BUFFER+2,a5
	moveq	#2,d6
BLT2_LOOP:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	#25*64+23,BLTSIZE(a0)
	lea	BUFFER_SIZE(a4),a4
	lea	BUFFER_SIZE(a5),a5
	dbra	d6,BLT2_LOOP
	rts

FONT_BUFFER:
	lea	MESSAGE(pc),a1
	lea	ASCII(pc),a2
	lea	NEXT_CHAR(pc),a3
	lea	FONT,a4
	lea	BUFFER+44,a5
	add.w	(a3),a1
	move.b	(a1),d0
	clr.l	d1
SEARCH:	cmp.b	(a2)+,d0
	beq.s	FOUND
	addq.w	#1,d1
	bra	SEARCH
FOUND:	divu	#10,d1
	move.w	d1,d2
	mulu	#[40*25],d2
	add.l	d2,a4	
	swap	d1
	mulu	#4,d1
	add.l	d1,a4
	lea	NEXT_CHAR(pc),a3
	addq.w	#1,(a3)
	cmp.b	#-1,(a1)
	bne.s	GET_CONT
	clr.w	(a3)
	rts
GET_CONT:
	bsr	GET_COMMANDS
NO_START:
	move.w	#40-4,BLTAMOD(a0)
	move.w	#44,BLTDMOD(a0)
	move.w	#$09F0,BLTCON0(a0)
	moveq	#2,d6
BLT3_LOOP:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	#25*64+2,BLTSIZE(a0)
	lea	40*125(a4),a4
	lea	BUFFER_SIZE(a5),a5
	dbra	d6,BLT3_LOOP
NOT_JET_COPY:
	rts	

ACT_POS:	dc.w	32
BLT_CON0:	dc.w	$09F0

ASCII:	dc.b	"ABCDEFGHIJ"
	dc.b	"KLMNOPQRST"
	dc.b	"UVWXYZ!?:;"
	dc.b	"0123456789"
	dc.b	"/(),-.'{} "

	;----------------------;
	      GET_COMMANDS:
	;----------------------;

	cmp.b	#9,(a1)
	bne.s	NOT_KOPF
	lea	KOPF(pc),a2
	st	(a2)
	lea	FONT,a4
	lea	BUFFER+44,a5
	add.l	#[40*25]*4,a4
	add.l	#9*4,a4
	rts
NOT_KOPF:
	cmp.b	#1,(a1)
	bne.s	NO_ONE2
	lea	BLT_CON0(pc),a2
	move.w	#$E9F0,(a2)
	lea	ACT_POS(pc),a2
	move.w	#16,(a2)
	lea	FONT,a4
	lea	BUFFER+44,a5
	add.l	#[40*25]*4,a4
	add.l	#9*4,a4
	rts
NO_ONE2:cmp.b	#0,(a1)
	bne.s	NO_ONE
	lea	BLT_CON0(pc),a2
	move.w	#$89F0,(a2)
	lea	ACT_POS(pc),a2
	move.w	#4,(a2)
	lea	FONT,a4
	lea	BUFFER+44,a5
	add.l	#[40*25]*4,a4
	add.l	#9*4,a4
	rts
NO_ONE:	cmp.b	#2,(a1)
	bne.s	NO_CMD
	lea	BLT_CON0(pc),a2
	move.w	#$C9F0,(a2)
	lea	ACT_POS(pc),a2
	move.w	#8,(a2)
	lea	FONT,a4
	lea	BUFFER+44,a5
	add.l	#[40*25]*4,a4
	add.l	#9*4,a4
NO_CMD:	rts

KOPF:	dc.b	0
	even

CHAR_POS:
	dc.w	0
NEXT_CHAR:
	dc.w	0

	;-------------------;
	    COPY_MEHMET:
	;-------------------;

	move.l	#$FFFFFFFF,BLTAFWM(a0)
	move.w	#$09F0,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	clr.w	BLTAMOD(a0)
	move.w	#20,BLTDMOD(a0)

	lea	MEHMET,a1
	lea	BITPLANES+[40*214]+10,a2
	moveq	#3-1,d6
MEHMET_BLT:
	move.l	a1,BLTAPTH(a0)
	move.l	a2,BLTDPTH(a0)
	move.w	#40*64+10,BLTSIZE(a0)
	lea	40*20(a1),a1
	lea	40*512(a2),a2
	dbra	d6,MEHMET_BLT
	rts	

	;-------------------;
	    COPY_LOGON:
	;-------------------;

	move.w	#$09F0,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	clr.w	BLTAMOD(a0)
	move.w	#4,BLTDMOD(a0)

	lea	LOGON,a1
	lea	BITPLANES2+[40*55]+2,a2
	moveq	#3-1,d6
LOGON_BLT:
	move.l	a1,BLTAPTH(a0)
	move.l	a2,BLTDPTH(a0)
	move.w	#113*64+18,BLTSIZE(a0)
	lea	113*36(a1),a1
	lea	40*512(a2),a2
	dbra	d6,LOGON_BLT
	rts	

	;-------------------;
	    COPY_QUELLE:
	;-------------------;

	move.w	#$09F0,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	move.w	#36,BLTAMOD(a0)
	move.w	#36,BLTDMOD(a0)
	lea	FONT+Q1,a1
	lea	BITPLANES+[40*21]+8,a2
	bsr	COPY
	lea	FONT+U1,a1
	lea	BITPLANES+[40*21]+12,a2
	bsr	COPY
	lea	FONT+E1,a1
	lea	BITPLANES+[40*21]+16,a2
	bsr	COPY
	lea	FONT+L1,a1
	lea	BITPLANES+[40*21]+20,a2
	bsr	COPY
	lea	FONT+L1,a1
	lea	BITPLANES+[40*21]+24,a2
	bsr	COPY
	lea	FONT+E1,a1
	lea	BITPLANES+[40*21]+28,a2
	bsr	COPY
	rts
COPY:	moveq	#3-1,d6
QUELLE:	move.l	a1,BLTAPTH(a0)
	move.l	a2,BLTDPTH(a0)
	move.w	#25*64+2,BLTSIZE(a0)
	lea	40*125(a1),a1
	lea	40*512(a2),a2	
	dbra	d6,QUELLE
	rts

Q1=[40*25]+24
U1=[40*25]*2
L1=[40*25]+4
E1=16

	;-------------------;
            COLOR_SCROLL:
	;-------------------;

	lea	COLORS1,a2
	move.l	a2,a3
	lea	NEWPOS_ONE(pc),a4
	addq.w	#4,(a4)
	add.w	(a4),a3
	cmp.w	#384*2,(a4)
	bne.s	SCROLL_DOWN
	clr.w	(a4)
SCROLL_DOWN:
	lea	NEWPOS_TWO(pc),a4
	sub.w   #2,(a4)
	add.w 	(a4),a2
	tst.w	(a4)
	bne.s	SCROLL_CONT
	move.w	#384*2,(a4)
SCROLL_CONT:
	lea	COPPER,a1
	add.w	#70,a1
	move.w	#252,d0
	move.l	#20,d7
SCROLL_NOW:
	move.w	(a3)+,(a1)
	addq.l	#8,a1
	move.w	(a2)+,(a1)
	addq.l	#8,a1
	move.w	(a3),(a1)
	addq.l	#8,a1
	move.w	(a2),(a1)
	add.l	d7,a1
	dbra	d0,SCROLL_NOW
	rts	

NEWPOS_ONE:	dc.w	0
NEWPOS_TWO:	dc.w	384*2

	;-----------------;
	   ANIM_BOB_MAIN:
	;-----------------;

	bsr	ANIM_BOB
	bsr	GET_BOB_POS
	bsr	NOW_ANIM_BOB
	bsr	NEW_POSITION
	rts

	;-----------------;
	     ANIM_BOB:
	;-----------------;

	lea	BR_PTR(pc),a2
	lea	BRLER(pc),a3
	lea	BRSLER(pc),a4
	cmp.l	#1,(a2)
	bne.s 	NOT_BR1
	addq.b	#1,(a3)
	cmp.b	#6,(a3)
	bne.s	NOT_BR1
	bsr	BLEND_OUT
	sf	(a3)
	cmp.b	#5,(a4)
	beq.s	NOT_BR1
	bsr	BROESEL_SUB
	addq.b	#1,(a4)
NOT_BR1:cmp.l	#2,(a2)
	bne.s 	NOT_BR2
	addq.b	#1,(a3)
	cmp.b	#6,(a3)
	bne.s	NOT_BR2
	bsr	BLEND_IN
	sf	(a3)
	tst.b	(a4)
	beq.s	NOT_BR2
	bsr	BROESEL_ADD
	subq.b	#1,(a4)
NOT_BR2:lea	XY(pc),a2
	lea	STR(pc),a3
	lea	COMP1(pc),a5
	move.l	(a5),d6
 	add.l	(a2),d6
	move.l	(a3),a1
	move.l	(a1),d4
	cmp.l	d6,d4
	blo.s	NOT_NEW_STRUCT
	bsr	GET_NEW_STRUCT
NOT_NEW_STRUCT:
	rts

X_PLUS:	dc.l	0
Y_PLUS:	dc.l	0
COMP1:	dc.l	0
COMP2:	dc.l	0
CMP1:	dc.l	0
CMP2:	dc.l	0
BR_PTR:	dc.l	0
STR:	dc.l	0
XY:	dc.l	0
BRSLER:	dc.b	0
BRLER:	dc.b	0

	;-----------------;
	  GET_NEW_STRUCT:
	;-----------------;

	lea	STRUCT_ZEIG(pc),a4
	move.l	(a4),a1
	cmp.l	#-1,(a1)
	bne.s	NOT_ZEIG_END
	lea	NEW_STRUCT(pc),a5
	move.l	a5,(a4)
	bra	GET_NEW_STRUCT
NOT_ZEIG_END:
	lea	STRUCT1(pc),a2
	lea	COMP1(pc),a3
	lea	X_PLUS(pc),a4
	lea	Y_PLUS(pc),a5
	move.l	(a1)+,d0
	move.l	(a1)+,d1
	move.l	(a1)+,d2		
	move.l	(a1)+,(a3)
	move.l	(a1)+,(a4)
	move.l	(a1)+,(a5)
	lea	BR_PTR(pc),a3
	lea	XY(pc),a4
	lea	STR(pc),a5
	move.l	(a1)+,(a3)
	move.l	(a1)+,(a4)
	move.l	(a1)+,(a5)

	moveq	#5,d3
STR_L1:	move.l	d0,(a2)+
	move.l	d1,(a2)+
	dbra	d3,STR_L1

	lea	STRUCT1(pc),a2
	addq.l	#8,a2
	move.l	d2,d4
	moveq	#4,d3
STR_L2:	add.l	d4,(a2)+
	add.l	d4,(a2)+
	add.l	d2,d4
	dbra	d3,STR_L2
	lea	STRUCT_ZEIG(pc),a4
	add.l	#9*4,(a4)
	rts
	
	;-----------------;
	     SEE_BOB:
	;-----------------;

	move.w	#36-6,BLTAMOD(a0)
	move.w	#36-6,BLTBMOD(a0)
	move.w	#40-6,BLTCMOD(a0)
	move.w	#40-6,BLTDMOD(a0)
	move.w	d0,BLTCON1(a0)
	eori.w	#$0FCA,d0
	move.w	d0,BLTCON0(a0)
	moveq	#3-1,d6
BLTGAIN:
	move.l	a3,BLTAPTH(a0)
	move.l	a1,BLTBPTH(a0)
	move.l	a2,BLTCPTH(a0)
	move.l	a2,BLTDPTH(a0)
	move.w	#25*64+3,BLTSIZE(a0)
	bsr	WAIT_BLITTER
	lea	36*150(a1),a1
	lea	40*512(a2),a2
	dbra	d6,BLTGAIN
	rts	

	;-----------------;
	    GET_BACK:
	;-----------------;
	
	move.w	#$09F0,BLTCON0(a0)
	clr.w	BLTCON1(a0)
	clr.w	BLTAMOD(a0)
	sub.l	#13*40,a2
	move.w	#34,BLTDMOD(a0)
	moveq	#3-1,d6
GETBACK:
	move.l	a4,BLTAPTH(a0)
	move.l	a2,BLTDPTH(a0)
	move.w	#43*64+3,BLTSIZE(a0)
	lea	6*25(a4),a4
	lea	40*512(a2),a2
	dbra	d6,GETBACK
	rts	

	;-----------------;
	     GET_X_Y:
	;-----------------;

	lea	BITPLANES,a2
	mulu	#40,d1
	add.l	d1,a2
	moveq	#0,d1
	divu	#16,d0
	move.w	d0,d1
	lsl.w	#1,d1
	add.l	d1,a2
	clr.w	d0
	moveq	#0,d6
	swap	d0
	ror.w	#4,d0
	rts

	;-----------------;
	   WAIT_BLITTER:
	;-----------------;

WAIT:	btst	#14,DMACONR(a0)
	bne.s	WAIT	
	rts
	
	;---------------;
	    GET_OLDS:
	;---------------;

	move.l	(a4),d0
	move.l	(a5),d1
	bsr	GET_X_Y
	rts

	;---------------;
	    GET_NEWS:
	;---------------;

	lea	X_PLUS(pc),a2
	move.l	(a2),d7
	add.l	d7,a4
	lea	Y_PLUS(pc),a2
	move.l	(a2),d7
	add.l	d7,a5
	move.l	(a4),d0
	move.l	(a5),d1
	bsr	GET_X_Y
	rts

	;-----------------;
	   NOW_ANIM_BOB:
	;-----------------;

	lea	BUFFER1,a4
	lea	OLDXY1(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	
	lea	BUFFER2,a4
	lea	OLDXY2(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	
	lea	BUFFER3,a4
	lea	OLDXY3(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	
	lea	BUFFER4,a4
	lea	OLDXY4(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	
	lea	BUFFER5,a4
	lea	OLDXY5(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	
	lea	BUFFER6,a4
	lea	OLDXY6(pc),a1
	move.l	(a1),a2
	bsr	GET_BACK	

	lea	BOB6(pc),a1
	lea	MASK6(pc),a3
	lea	X_ACC1(pc),a2
	lea	XY_ACC1(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB

	lea	BOB5(pc),a1
	lea	MASK5(pc),a3
	lea	X_ACC2(pc),a2
	lea	XY_ACC2(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB

	lea	BOB4(pc),a1
	lea	MASK4(pc),a3
	lea	X_ACC3(pc),a2
	lea	XY_ACC3(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB

	lea	BOB3(pc),a1
	lea	MASK3(pc),a3
	lea	X_ACC4(pc),a2
	lea	XY_ACC4(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB

	lea	BOB2(pc),a1
	lea	MASK2(pc),a3
	lea	X_ACC5(pc),a2
	lea	XY_ACC5(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB

	lea	BOB1(pc),a1
	lea	MASK1(pc),a3
	lea	X_ACC6(pc),a2
	lea	XY_ACC6(pc),a4
	move.l	(a1),a1
	move.l	(a3),a3
	move.w	(a2),d0
	move.l	(a4),a2
	bsr	SEE_BOB
	rts

	;-----------------;
	   NEW_POSITION:	
	;-----------------;

	lea	X_PLUS(pc),a2
	lea	Y_PLUS(pc),a3
	lea	STRUCT1(pc),a4
	move.l	(a2),d6
	move.l	(a3),d7
	move.w	#5,d0
STRUCT_LOOP:
	add.l	d6,(a4)+
	add.l	d7,(a4)+
	dbra	d0,STRUCT_LOOP
	rts

	;---------------;
	   BROESEL_ADD:
	;---------------;

	lea	BOB1(pc),a1
	lea	MASK1(pc),a2
	move.w	#5,d0
ADD_LOOP:
	addq.l	#6,(a1)+
	addq.l	#6,(a1)+
	dbra	d0,ADD_LOOP
	rts

	;---------------;
	   BROESEL_SUB:
	;---------------;

	lea	BOB1(pc),a1
	lea	MASK1(pc),a2
	move.w	#5,d0
SUB_LOOP:
	subq.l	#6,(a1)+
	subq.l	#6,(a1)+
	dbra	d0,SUB_LOOP
	rts

	;-----------------;
	   GET_BOB_POS:
	;-----------------;

	lea	OLDXY1(pc),a3
	lea	STRUCT1(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC1(pc),a3
	lea	XY_ACC1(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)

	lea	OLDXY2(pc),a3
	lea	STRUCT3(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC2(pc),a3
	lea	XY_ACC2(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)

	lea	OLDXY3(pc),a3
	lea	STRUCT5(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC3(pc),a3
	lea	XY_ACC3(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)

	lea	OLDXY4(pc),a3
	lea	STRUCT7(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC4(pc),a3
	lea	XY_ACC4(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)

	lea	OLDXY5(pc),a3
	lea	STRUCT9(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC5(pc),a3
	lea	XY_ACC5(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)

	lea	OLDXY6(pc),a3
	lea	STRUCT11(pc),a4
	lea	4(a4),a5
	move.l	(a4),a4
	move.l	(a5),a5
	bsr	GET_OLDS
	move.l	a2,(a3)
	bsr	GET_NEWS
	lea	X_ACC6(pc),a3
	lea	XY_ACC6(pc),a4
	move.w	d0,(a3)
	move.l	a2,(a4)
	rts

	;-----------------;
	    GET_MASK:
	;-----------------;

	move.l	#36*150,d7
	lea	Q,a1
	lea	(a1,d7.l),a2
	lea	(a2,d7.l),a3
	lea	MASK,a4
	move.l	#36*150,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
G_MASK_LOOP:
	move.b	(a1)+,d1
	move.b	(a2)+,d2
	move.b	(a3)+,d3
	ori.b	d1,d2
	ori.b	d2,d3
	move.b	d3,(a4)+
	dbra	d0,G_MASK_LOOP
	rts

	;--------------------;
	    BUILD_COPPER:
	;--------------------;

	move.l	#BITPLANES,d1
	bsr	BUILD_VIEW_COPPER
	move.l	#BITPLANES2,d1
	bsr	BUILD_VIEW_2
	move.w	#255,d0
	move.w	#$2c01,d1
	move.w	#$2c01+072-4,d2
	move.w	#$2c01+168-4,d3
	move.w	#$2c01+212-4,d4
	move.w	#$2c01+116-4,d5
	move.w	#$2c1f,d6
	lea	COLORS2+64,a3
COLOR_SCROLL_LOOP:
	move.w  d1,(a1)+
	move.w  #$fffe,(a1)+
	move.w	#COLOR00+14,(a1)+
	move.w  (a3)+,(a1)+
	move.w	d6,(a1)+
	move.w	#$fffe,(a1)+
	move.w  d2,(a1)+
	bsr	CUPPER
	move.w  d5,(a1)+
	bsr	CUPPER
	move.w  d3,(a1)+
	bsr	CUPPER
	move.w  d4,(a1)+
	bsr	CUPPER
	add.w 	#$0100,d1
	add.w	#$0100,d2
	add.w	#$0100,d3
	add.w   #$0100,d4
	add.w   #$0100,d5
	add.w   #$0100,d6
NOT_JET2:
	dbra 	d0,COLOR_SCROLL_LOOP
	move.l	#$fffffffe,(a1)+
	rts

CUPPER:	move.w	#$fffe,(a1)+
	move.w	#COLOR00,(a1)+
	clr.w	(a1)+
	rts

	;--------------------;
	  BUILD_VIEW_COPPER:
	;--------------------;

	lea	COPPER,a1
	move.l	#$100ffffe,(a1)+
	move.w	#$00e0,d2
	moveq	#3-1,d0
BWC_L1:	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	add.l	#PLANE_SIZE,d1
	addq.l	#4,d2
	dbra	d0,BWC_L1
	rts

	;--------------------;
	    BUILD_VIEW_2:
	;--------------------;

	move.w	#$00e4,d2
	moveq	#3-1,d0
BWC_L2:	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	move.w	d2,(a1)+
	addq.w	#2,d2
	swap	d1
	move.w	d1,(a1)+
	add.l	#PLANE_SIZE,d1
	addq.l	#4,d2
	dbra	d0,BWC_L2
	rts

	;----------------;
  	    INIT_VIEW:
	;----------------;

	lea	CUSTOM,a0
	move.w	#$4000,INTENA(a0)
	move.w	#$4000,INTREQ(a0)
	move.w	#$0020,INTREQ(a0)
	move.w	#$8020,INTENA(a0)

	move.w	#$2a81,DIWSTRT(a0)
	move.w	#$2ac1,DIWSTOP(a0)
	move.w	#$0038,DDFSTRT(a0)
	move.w	#$00d0,DDFSTOP(a0)
	move.w	#%0110011000000000,BPLCON0(a0)
	clr.w	BPLCON1(a0)
	move.w	#4,BPLCON2(a0)
	clr.w	BPL1MOD(a0)
	clr.w	BPL2MOD(a0)

	move.w	#%0000000100000000,DMACON(a0)
	move.l	#COPPER,COP1LCH(a0)
	clr.w	COPJMP1(a0)
	move.w	#%1001111100000000,DMACON(a0)
	move.w	#%0000000000100000,DMACON(a0)
	move.l	#$FFFFFFFF,BLTAFWM(a0)
	rts

	;-------------------;
 	    COLOR_TABLE:
	;-------------------;

	lea	COLORS1,a3
	move.w	#$f,d4
	move.w	#2,d7
	lea	COLORDEFS1(pc),a1
	lea	ADJUST_DEFS(pc),a5
	move.l	a1,(a5)
	bsr	AGAIN
	lea	COLORS2,a3
	move.w	#$f,d4
	move.w	#10,d7
	lea	COLORDEFS2(pc),a1
	lea	ADJUST_DEFS(pc),a5
	move.l	a1,(a5)
	bsr	AGAIN
	rts

ADJUST_DEFS:
	dc.l	0

AGAIN:	move.l	(a5),a1
TAKE_AGAIN:
	bsr	TAKE_COLOR
CALC_COLOR_ONE:
	move.w	d2,(a3)+
	move.w	d2,(a3)+
	add.w	d1,d2
	dbra	d0,CALC_COLOR_ONE
	bsr	TAKE_COLOR
CALC_COLOR_TWO:	
	move.w	d2,(a3)+
	move.w	d2,(a3)+
	add.w	d1,d2
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

COLORDEFS2:
	dc.w	$111,$000
	dc.w	-$111,$fff
	dc.w	-99
COLORDEFS1:
	dc.w	$100,$000
	dc.w	$001,$f00
	dc.w	-$100,$f0f
	dc.w	-$001,$00f
	dc.w	$010,$000
	dc.w	$100,$0f0
	dc.w	-$010,$ff0
	dc.w	-$100,$f00 
	dc.w	$001,$000 
	dc.w	$010,$00f 
	dc.w	-$001,$0ff
	dc.w	-$010,$0f0
	dc.w	-99

B=[40*512]*2

	;-------------------;
		CLS:
	;-------------------;

	lea	BITPLANES,a1
	move.w	#B,d6
	bsr	FILL_LOOP
	lea	BITPLANES+B,a1
	move.w	#B,d6
	bsr	FILL_LOOP
	lea	BITPLANES+B+B,a1
	move.w	#B,d6
	bsr	FILL_LOOP
	lea	BUFFER,a1
	move.w	#[BUFFER_SIZE]*3,d6
	bsr	FILL_LOOP
	lea	BUFFER1,a1
	move.w	#[[[6*25]*3]*8],d6
	bsr	FILL_LOOP
	rts
FILL_LOOP:
	clr.b	(a1)+
	dbra	d6,FILL_LOOP
	rts

	;----------------;
	   GET_BM_NUMS:
	;----------------;

	lea	BOB1(pc),a1
	move.l	#Q+30,(a1)+
	move.l	#MASK+30,(a1)+	
	move.l	#Q+30+BOBEL,(a1)+
	move.l	#MASK+30+BOBEL,(a1)+	
	move.l	#Q+30+[BOBEL*2],(a1)+
	move.l	#MASK+30+[BOBEL*2],(a1)+	
	move.l	#Q+30+[BOBEL*3],(a1)+
	move.l	#MASK+30+[BOBEL*3],(a1)+	
	move.l	#Q+30+[BOBEL*4],(a1)+
	move.l	#MASK+30+[BOBEL*4],(a1)+	
	move.l	#Q+30+[BOBEL*5],(a1)+
	move.l	#MASK+30+[BOBEL*5],(a1)+	
	rts

	;----------------;
	   GET_COLORS:
	;----------------;

	lea	COLOR_MAP,a1
	lea	$dff180,a2
	move.w	#7,d4
COLOR_LOOP:
	move.w	(a1)+,(a2)+
	dbra	d4,COLOR_LOOP
	rts		
COLOR_MAP:
	dc.w	$000,$bef-$111,$9cf-$111,$7ad-$111
	dc.w	$58b-$111,$379-$111,$147-$011,$00f
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0
BL_COLORS:
	dc.w	$000,$5ae,$69f,$48d
	dc.w	$26c,$35a,$459,$027
	dc.w	$000,$5ae-$110,$69f-$110,$48d-$110
	dc.w	$26c-$110,$35a-$110,$459-$110,$027-$010
	dc.w	$000,$5ae-$220,$69f-$220,$48d-$220
	dc.w	$26c-$220,$35a-$220,$459-$220,$027-$010
	dc.w	$000,$5ae-$330,$69f-$330,$48d-$330
	dc.w	$26c-$230,$35a-$330,$459-$330,$027-$020
	dc.w	$000,$5ae-$440,$69f-$440,$48d-$440
	dc.w	$26c-$240,$35a-$340,$459-$440,$027-$020
	dc.w	$000,$5ae-$563,$69f-$563,$48d-$463
	dc.w	$26c-$263,$35a-$353,$459-$453,$027-$023
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0

	;------------------;
	   LOAD_MURKS:
	;------------------;

	lea	DOS_NAME,a1
	move.l	EXECBASE,a6
	jsr	OPENLIBRARY(a6)
	move.l	d0,DOSBASE

	move.l	#NAME,d1
	move.l	#1005,d2
	move.l	DOSBASE,a6
	jsr	OPEN(a6)
	move.l	d0,d1
	move.l	d1,-(SP)
	move.l	#MEHMET,d2
	move.l	#164536,d3
	jsr	READ(a6)
	move.l	(SP)+,d1
	jsr	CLOSE(a6)
	rts

	;----------------;
	      EXIT:
	;----------------;

	jsr	SOUND+$12C
	move.l	EXECBASE,a6
	lea	GFXNAME,a1
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	lea	$dff000,a0
	move.l	38(a4),COP1LCH(a0)
	clr.w	COPJMP1(a0)		
	move.w	#$83E0,DMACON(a0)
	moveq	#0,d0
	rts

DOSBASE:
 dc.l	0
DOS_NAME:
 dc.b	"dos.library",0,0
NAME:
 dc.b	"data.murks",0
GFXNAME:dc.b	"graphics.library",0,0

MESSAGE:
 dc.b	0,"        AMIGA 500 ",9,1," ",2," ",0,"    "
 dc.b	1,"WOLLEN SIE  ",2
 dc.b	" ARBEITEN ? ",0,"          ",2
 dc.b	" SPIELEN ? ",0,"          ",2
 dc.b	" MALEN ? ",0,"          ",2
 dc.b	" MUSIZIEREN ? ",0,"          ",2
 dc.b	" ANIMIEREN ? ",0,"          ",2
 dc.b	" DANN KAUFEN SIE AM BESTEN EINEN"
 dc.b	0,"        AMIGA 500 ",9,1," ",2," ",0,"    ",2
 dc.b	" HIER BEI",1,"QUELLE",2," "
 dc.b	"NUR 898 DM",9,1," ",2," ",0,"    ",2
 dc.b	2," COMPUTER FUER ALLES   AMIGA 500 ",9,2," NUR  898 DM  "
 dc.b	" AMIGA ",2,"FUER ANFAENGER UND FORTGESCHRITTENE ",0,"     ",2
 dc.b	" DER BESTE IN SEINER KLASSE "
 dc.b	0,"        "
 dc.b	2," TECHNISCHE DATEN:   ",0,"        ",2
 dc.b	"4096 FARBEN  ,  "
 dc.b	"7.14 MHZ  ,  "  
 dc.b	"SUPER SCHNELLER GRAFIK-CHIP  ,  "
 dc.b	"SUPER SOUND-CHIP  ,  " 
 dc.b	"CO-PROZESSOR  ,  "
 dc.b	"512 KB AUFRUESTBAR AUF 10 MBYTE  ,  "
 dc.b	"BEHERRSCHT SPRACHAUSGABE !!   "
 dc.b	"UND NOCH VIELES MEHR !!!   ",0,"       ",2
 dc.b	"NUR  898 DM  ",2,"  HIER BEI QUELLE",1
 dc.b	"ERHAELTLICH",2,"(OHNE POWERPACK) AMIGA 500"
 dc.b	" COMPLETT MIT MAUS , "
 dc.b	"DISKETTENLAUFWERK , SYSTEM-SOFTWARE , UND BUECHER "
 dc.b	"FUER NUR 898 DM",9,2," ",0
 dc.b	"      ",2,"MIT POWERPACK FUER  NUR 1098 DM     ",0,"    " 
 dc.b	2,"POWERPACK ENTHAELT ZUSAETZLICH NOCH EIN ENGLISCH-KURS , "
 dc.b	"EIN GEOGRAPHIE-KURS , ZWEI SPIELE ,"
 dc.b	"  EIN TEXTPROGRAMM SOWIE AUCH EIN DATENPROGRAMM             "
 dc.b	-1,-1
 even

STRUCT_ZEIG:	
	dc.l	NEW_STRUCT
NEW_STRUCT:
	dc.l	Y,Y,44,632*2,8,4,1,Y,STRUCT1
	dc.l	Y,Y,44,632*2,16,8,0,Y,STRUCT1
	dc.l	Y,Y,44,632*2,8,4,2,Y,STRUCT1
	dc.l	Y,Y,44,632*2,16,8,1,Y,STRUCT1
	dc.l	Y,Y,44,632*2,16,8,0,Y,STRUCT1
	dc.l	Y,Y,44,632*2,8,4,2,Y,STRUCT1

	dc.l	Y,Y,92,632*2,8,4,1,Y,STRUCT1
	dc.l	Y,Y,92,632*2,16,8,0,Y,STRUCT1
	dc.l	Y,Y,92,632*2,8,4,2,Y,STRUCT1
	dc.l	Y,Y,92,632*2,16,8,1,Y,STRUCT1
	dc.l	Y,Y,92,632*2,16,8,0,Y,STRUCT1
	dc.l	Y,Y,92,632*2,8,4,2,Y,STRUCT1
	dc.l	Y,Y,92,632*2,4,8,1,Y,STRUCT2
	dc.l	Y,Y,92,632*2,8,16,0,Y,STRUCT2
	dc.l	Y,Y,92,632*2,4,8,0,Y,STRUCT2
	dc.l	Y,Y,92,632*2,4,8,2,Y,STRUCT2

	dc.l	X,Y,104,632,4,4,1,X,STRUCT1
	dc.l	X,Y,104,632,4,4,0,X,STRUCT1
	dc.l	X,Y,104,632,4,4,0,X,STRUCT1
	dc.l	X,Y,104,632,8,8,0,X,STRUCT1
	dc.l	X,Y,104,632,8,8,0,X,STRUCT1
	dc.l	X,Y,104,632,8,8,0,X,STRUCT1
	dc.l	X,Y,104,632,8,8,0,X,STRUCT1
	dc.l	X,Y,104,632,4,4,0,X,STRUCT1
	dc.l	X,Y,104,632,4,4,0,X,STRUCT1
	dc.l	X,Y,104,632,4,4,2,X,STRUCT1

	dc.l	X,Y,44,634*2,8,4,1,X,STRUCT1
	dc.l	X,Y,44,634*2,8,4,0,X,STRUCT1
	dc.l	X,Y,44,634*2,8,4,0,X,STRUCT1

	dc.l	X,Y,44,634,8,4,2,X,STRUCT1
	dc.l	X,Y,108,632,4,8,1,X,STRUCT1
	dc.l	X,Y,108,632,4,8,0,X,STRUCT1
	dc.l	X,Y,108,632,8,16,0,X,STRUCT1
	dc.l	X,Y,108,632,8,16,0,X,STRUCT1
	dc.l	X,Y,108,632,4,8,0,X,STRUCT1
	dc.l	X,Y,108,632,4,8,2,X,STRUCT1

	dc.l	X,Y,036,632,4,4,1,X,STRUCT1
	dc.l	X,Y,036,632,4,4,2,X,STRUCT1
	dc.l	X,Y,036,632,8,8,1,X,STRUCT1
	dc.l	X,Y,036,632,8,8,0,X,STRUCT1
	dc.l	X,Y,036,632,4,4,0,X,STRUCT1
	dc.l	X,Y,036,632,4,4,2,X,STRUCT1

	dc.l	X,Y,024,634*2,8,4,1,X,STRUCT1
	dc.l	X,Y,024,634*2,8,4,0,X,STRUCT1
	dc.l	X,Y,024,634*2,16,8,0,X,STRUCT1
	dc.l	X,Y,024,634*2,8,4,0,X,STRUCT1
	dc.l	X,Y,024,634,8,4,2,X,STRUCT1

	dc.l	X,Y,044,632,4,8,1,X,STRUCT1
	dc.l	X,Y,044,632,4,8,0,X,STRUCT1
	dc.l	X,Y,044,632,8,16,0,X,STRUCT1
	dc.l	X,Y,044,632,8,16,0,X,STRUCT1
	dc.l	X,Y,044,632,4,8,0,X,STRUCT1
	dc.l	X,Y,044,632,4,8,2,X,STRUCT1

	dc.l	X,Y,104,634*2,8,4,1,X,STRUCT1
	dc.l	X,Y,104,634*2,8,4,0,X,STRUCT1
	dc.l	X,Y,104,634*2,16,8,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,32,16,0,X,STRUCT1
	dc.l	X,Y,104,634*2,16,8,0,X,STRUCT1
	dc.l	X,Y,104,634*2,8,4,0,X,STRUCT1
	dc.l	X,Y,104,634,8,4,2,X,STRUCT1
	dc.l	-1,-1,-1

BOB1:	dc.l	0
MASK1:	dc.l	0
BOB2:	dc.l	0
MASK2:	dc.l	0
BOB3:	dc.l	0
MASK3:	dc.l	0
BOB4:	dc.l	0
MASK4:	dc.l	0
BOB5:	dc.l	0
MASK5:	dc.l	0
BOB6:	dc.l	0
MASK6:	dc.l	0

OLDXY1:	dc.l	0
OLDXY2:	dc.l	0
OLDXY3:	dc.l	0
OLDXY4:	dc.l	0
OLDXY5:	dc.l	0
OLDXY6:	dc.l	0

XY_ACC1:dc.l	0
XY_ACC2:dc.l	0
XY_ACC3:dc.l	0
XY_ACC4:dc.l	0
XY_ACC5:dc.l	0
XY_ACC6:dc.l	0

X_ACC1:	dc.w	0
X_ACC2:	dc.w	0
X_ACC3:	dc.w	0
X_ACC4:	dc.w	0
X_ACC5:	dc.w	0
X_ACC6:	dc.w	0

STRUCT1:dc.l	0
STRUCT2:dc.l	0
STRUCT3:dc.l	0
STRUCT4:dc.l	0
STRUCT5:dc.l	0
STRUCT6:dc.l	0
STRUCT7:dc.l	0
STRUCT8:dc.l	0
STRUCT9:dc.l	0
STRUCT10:dc.l	0
STRUCT11:dc.l	0
STRUCT12:dc.l	0
ENDE:
END=$7B534

