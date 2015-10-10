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
WBYTES=48
PLANE_SIZE=48*270
SIZE=[48*270]*3
FONT_PLANESIZE=[40*25]*5
;**************************;
BITPLANES=$40000
BIT1=BITPLANES
BIT2=BIT1+[48*30]
BIT3=BIT2+[48*31]
BIT4=BIT3+[48*30]
BIT5=BIT4+[48*30]
BIT6=BIT5+[48*31]
BIT7=BIT6+[48*30]
BIT8=BIT7+[48*30]
BIT9=BIT8+[48*28]
COPPER=$7b000
COLOR_RED=COPPER-2000
NEXT_COLOR=$7AB50
;**************************;
SOUND_START=$60000
SOUND_LEN=54760
FONT_START=SOUND_START+SOUND_LEN
FONT_LEN=15016
;**************************;

	;------------------;
	      START:
	;------------------;

;	bsr	LOAD_SOUND
;	bsr	LOAD_FONT
	jsr	START_AGAIN
	jsr	START_AGAIN
	jmp	WAIT_RASTER	

START_AGAIN:
	jsr	SOUND_START+$30
	jsr	SOUND_START+$F0
	bsr	MULTI_AWAY
	bsr	CLS
	bsr	GET_RED
	bsr	GET_COLORS
	bsr	INIT_VIEW
	bsr	BUILD_COPPER
	bsr	COPPER_ON
;	bsr	CIRCLE
	rts
	
	;---------------------;
	      WAIT_RASTER:
	;---------------------;

	move.b	VHPOSR(a0),d0
	cmp.b	#-20,d0
	bne	WAIT_RASTER

;	move.w	#$0f0,COLOR00(a0)
	bsr	FONT_SCROLL
	jsr	SOUND_START+$15C
;	clr.w	COLOR00(a0)

	and.b	#64,CIAAPRA
	beq	EXIT
	bra	WAIT_RASTER

	;------------------;
	     CIRCLE:
	;------------------;
	
	lea	COPPER,a1
	move.w	#32,d4
	add.w	#$26,a1
	add.w	#60,a1
	move.w	d4,d0
	lea	CIRC_NUMS,a2
	bsr	NOW_CIRC
	move.w	#1,d6
CIRC_LOOP_A:
	lea	CIRC_NUMS,a2
	sub.l	#40,a1
	move.w	d4,d0
	bsr	NOW_CIRC
	dbra	d6,CIRC_LOOP_A
	move.w	#1,d6
CIRC_LOOP_B:
	lea	CIRC_NUMS,a2
	sub.l	#20,a1
	move.w	d4,d0
	bsr	NOW_CIRC
	dbra	d6,CIRC_LOOP_B	
	move.w	#2,d6
CIRC_LOOP_C:
	lea	CIRC_NUMS,a2
	move.w	d4,d0
	sub.l	#40,a1
	bsr	NOW_CIRC
	dbra	d6,CIRC_LOOP_C
	lea	CIRC_NUMS,a2
	move.w	d4,d0
	sub.l	#60,a1
	bsr	NOW_CIRC
	rts
NOW_CIRC:
	cmp.w	#$1000,(a2)
	blo	NOT_CN
	lea	CIRC_NUMS,a2
	bra	NOT_Y
NOT_CN:	move.w	(a2)+,d7
	move.w	d7,(a1)
	add.l	#20,a1	
NOT_Y:	dbra	d0,NOW_CIRC
	rts

CIRC_NUMS:
	dc.w	$00,$11,$11,$22,$22,$22,$33
	dc.w	$33,$33,$44,$44,$44,$44,$55,$55,$55

	dc.w	$55,$55,$55,$44,$44,$44,$44,$33,$33
	dc.w	$33,$22,$22,$22,$11,$11,$00

	dc.w	$1000

	;------------------;
	    FONT_SCROLL:
	;------------------;

	move.l	#$FFFFFFFF,BLTAFWM(a0)
	clr.w	BLTCON1(a0)
	clr.w	BLTAMOD(a0)
	clr.w	BLTDMOD(a0)
SCROLL_AGAIN:
	addq.w	#1,CHAR_POS1
	cmp.w	#4,CHAR_POS1
	blt	NOPOS1
	clr.w	CHAR_POS1
	lea	MESSAGE1,a1
	lea	BIT1+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR1,a6
	cmp.b	#-1,(a6)
	blo	NO_START1
	clr.w	NEXT_CHAR1
NO_START1:
	add.w	NEXT_CHAR1,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR1
NOPOS1:	lea	BIT1,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1000100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS2
	cmp.w	#5,CHAR_POS2
	blt	NOPOS2
	clr.w	CHAR_POS2
	lea	MESSAGE2,a1
	lea	BIT2+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR2,a6
	cmp.b	#-1,(a6)
	blo	NO_START2
	clr.w	NEXT_CHAR2
NO_START2:
	add.w	NEXT_CHAR2,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR2
NOPOS2:	lea	BIT2,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1001100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS3
	cmp.w	#6,CHAR_POS3
	blt	NOPOS3
	clr.w	CHAR_POS3
	lea	MESSAGE3,a1
	lea	BIT3+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR3,a6
	cmp.b	#-1,(a6)
	blo	NO_START3
	clr.w	NEXT_CHAR3
NO_START3:
	add.w	NEXT_CHAR3,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR3
NOPOS3:	lea	BIT3,a4
	move.l	a4,a5
	subq.l	#2,a5	
	move.w	#%1010100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS4
	cmp.w	#8,CHAR_POS4
	blt	NOPOS4
	clr.w	CHAR_POS4
	lea	MESSAGE4,a1
	lea	BIT4+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR4,a6
	cmp.b	#-1,(a6)
	blo	NO_START4
	clr.w	NEXT_CHAR4
NO_START4:
	add.w	NEXT_CHAR4,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR4
NOPOS4:	lea	BIT4,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1100100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT	

	addq.w	#1,CHAR_POS5
	cmp.w	#11,CHAR_POS5
	blt	NOPOS5
	clr.w	CHAR_POS5
	lea	MESSAGE5,a1
	lea	BIT5+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR5,a6
	cmp.b	#-1,(a6)
	blo	NO_START5
	clr.w	NEXT_CHAR5
NO_START5:
	add.w	NEXT_CHAR5,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR5
NOPOS5:	lea	BIT5,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1101100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS6
	cmp.w	#7,CHAR_POS6
	blt	NOPOS6
	clr.w	CHAR_POS6
	lea	MESSAGE6,a1
	lea	BIT6+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR6,a6
	cmp.b	#-1,(a6)
	blo	NO_START6
	clr.w	NEXT_CHAR6
NO_START6:
	add.w	NEXT_CHAR6,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR6
NOPOS6:	lea	BIT6,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1011100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS7
	cmp.w	#6,CHAR_POS7
	blt	NOPOS7
	clr.w	CHAR_POS7
	lea	MESSAGE7,a1
	lea	BIT7+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR7,a6
	cmp.b	#-1,(a6)
	blo	NO_START7
	clr.w	NEXT_CHAR7
NO_START7:
	add.w	NEXT_CHAR7,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR7
NOPOS7:	lea	BIT7,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1010100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS8
	cmp.w	#5,CHAR_POS8
	blt	NOPOS8
	clr.w	CHAR_POS8
	lea	MESSAGE8,a1
	lea	BIT8+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR8,a6
	cmp.b	#-1,(a6)
	blo	NO_START8
	clr.w	NEXT_CHAR8
NO_START8:
	add.w	NEXT_CHAR8,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR8
NOPOS8:	lea	BIT8,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1001100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT

	addq.w	#1,CHAR_POS9
	cmp.w	#4,CHAR_POS9
	blt	NOPOS9
	clr.w	CHAR_POS9
	lea	MESSAGE9,a1
	lea	BIT9+40,a5
	move.l	a1,a6
	add.w	NEXT_CHAR9,a6
	cmp.b	#-1,(a6)
	blo	NO_START9
	clr.w	NEXT_CHAR9
NO_START9:
	add.w	NEXT_CHAR9,a1
	bsr	NOW_BUFFER
	addq.w	#1,NEXT_CHAR9
NOPOS9:	lea	BIT9,a4
	move.l	a4,a5
	subq.l	#2,a5
	move.w	#%1000100111110000,BLTCON0(a0)
	bsr	NOW_SCROLL_FONT
	rts

NOW_SCROLL_FONT:
	move.w	#2,BLTAMOD(a0)
	move.w	#2,BLTDMOD(a0)
	moveq	#3-1,d7
BLT_SCROLL:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	#25*64+23,BLTSIZE(a0)
	lea	PLANE_SIZE(a4),a4
	lea	PLANE_SIZE(a5),a5
	dbra	d7,BLT_SCROLL
	rts

NOW_BUFFER:
	lea	ASCII,a2
	lea	FONT_START,a4
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
BLITTER:
	move.w	#40-4,BLTAMOD(a0)
	move.w	#44,BLTDMOD(a0)
	move.w	#%0000100111110000,BLTCON0(a0)
	move.w	#2,d7
BLT_AGAIN1:
	move.l	a4,BLTAPTH(a0)
	move.l	a5,BLTDPTH(a0)
	move.w	#25*64+2,BLTSIZE(a0)
	lea	FONT_PLANESIZE(a4),a4
	lea	PLANE_SIZE(a5),a5
	dbra	d7,BLT_AGAIN1
	rts	

CHAR_POS1:	dc.w	0
CHAR_POS2:	dc.w	0
CHAR_POS3:	dc.w	0
CHAR_POS4:	dc.w	0
CHAR_POS5:	dc.w	0
CHAR_POS6:	dc.w	0
CHAR_POS7:	dc.w	0
CHAR_POS8:	dc.w	0
CHAR_POS9:	dc.w	0
NEXT_CHAR1:	dc.w	0
NEXT_CHAR2:	dc.w	0
NEXT_CHAR3:	dc.w	0
NEXT_CHAR4:	dc.w	0
NEXT_CHAR5:	dc.w	0
NEXT_CHAR6:	dc.w	0
NEXT_CHAR7:	dc.w	0
NEXT_CHAR8:	dc.w	0
NEXT_CHAR9:	dc.w	0

	;-------------------;
	    BUILD_COPPER:	
	;-------------------;

	move.l	#BITPLANES,d1
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
	
	lea	COLOR_RED+22,a2
	lea	NEXT_COLOR+52,a3
	move.w	#275,d0
	move.l	#$200ffffe,d1
	move.l	#$20dffffe,d2
BUILDCOPPER:
	move.l	d1,(a1)+
	move.w	#COLOR00,(a1)+
	move.w	(a2)+,(a1)+
	move.w	#COLOR00+14,(a1)+
	move.w	(a3)+,(a1)+
	move.w	#BPLCON1,(a1)+
	clr.w	(a1)+
	move.l	d2,(a1)+
	add.l	#$01000000,d1
	add.l	#$01000000,d2	
	dbra	d0,BUILDCOPPER
	move.l	#$fffffffe,(a1)
	rts	

	;--------------;
	   GET_RED:
	;--------------;

	lea	COLOR_RED,a1
	move.w	#10,d4
	move.w	#$f00,a3
	move.w	#$001,a4
	move.w	#$100,a5
	move.w	#$e,a2
	bsr	GET_AGAIN
	lea	NEXT_COLOR,a1
	move.w	#10,d4
	move.w	#$fff,a3
	move.w	#$000,a4
	move.w	#$111,a5
	move.w	#$e,a2
	bsr	GET_AGAIN
	rts
GET_AGAIN:
	move.w	a3,d0
	move.w	a4,d2
	move.w	a5,d3
	move.w	a2,d5
	move.w	d5,d6
GET1RL:	move.w	d0,(a1)+
	move.w	d0,(a1)+
	add.w	d2,d0
	sub.w	d3,d0
	dbra	d5,GET1RL
GET2RL:	move.w	d0,(a1)+
	move.w	d0,(a1)+
	sub.w	d2,d0
	add.w	d3,d0
	dbra	d6,GET2RL
	dbra	d4,GET_AGAIN
	rts

COLOR_PLUS:
	dc.b	0
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
	move.w	#$2661,DIWSTRT(a0)
	move.w	#$2fff,DIWSTOP(a0)
	move.w	#$0038,DDFSTRT(a0)
	move.w	#$00d0,DDFSTOP(a0)
	move.w	#%011001000000000,BPLCON0(a0)
	move.w	#%000000000000100,BPLCON2(a0)
	move.w	#8,BPL1MOD(a0)
	move.w	#8,BPL2MOD(a0)

	clr.w	NEXT_CHAR1
	clr.w	NEXT_CHAR2
	clr.w	NEXT_CHAR3
	clr.w	NEXT_CHAR4
	clr.w	NEXT_CHAR5
	clr.w	NEXT_CHAR6
	clr.w	NEXT_CHAR7
	clr.w	NEXT_CHAR8
	clr.w	NEXT_CHAR9
	clr.w	CHAR_POS1
	clr.w	CHAR_POS2
	clr.w	CHAR_POS3
	clr.w	CHAR_POS4
	clr.w	CHAR_POS5
	clr.w	CHAR_POS6
	clr.w	CHAR_POS7
	clr.w	CHAR_POS8
	clr.w	CHAR_POS9
	rts

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
	move.w	#SIZE,d6
	clr.w	d2
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
	dc.w	$bef-$222,$bef-$222,$9cf-$222,$7ad-$222
	dc.w	$58b-$222,$379-$222,$269-$222,$800
;	dc.w	$000,$ddd,$aaa,$888,$666,$444,$111,$07f

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
		EXIT:
	;-------------------;

	move.l	EXECBASE,a6
	lea	GFXNAME,a1
	jsr	OPENLIBRARY(a6)
	move.l	d0,a4
	lea	CUSTOM,a0
	move.l	38(a4),COP1LCH(a0)
	clr.w	COPJMP1(a0)		
	move.w	#$83E0,DMACON(a0)
	jsr	SOUND_START+$12C
	moveq	#0,d0
	rts
	
COPPER1:	dc.l	0
COPPER2:	dc.l	0
OLD_TRAP0:	dc.l	0
GFXNAME:	dc.b	"graphics.library",0,0
DOSBASE:
 dc.l	0
DOS_NAME:
 dc.b	"dos.library",0,0
SOUND_NAME:
 dc.b	"sound",0
FONT_NAME:
 dc.b	"font",0

MESSAGE1:
 dc.b	" SUPER-SONIC-GREETINGS TO MY LOCAL FRIENDS :  "
 dc.b	"PILOT,INGO,HERMY,MARC,"
 dc.b	"HERBY,LUTZ,KERMY,HOT-AMIGA,"
 dc.b	"TAFTY,UDO,POWERFORCE,STEFFAN,GUILD-OF-GURU,BLOODY-"
 dc.b	"CRAWLER AND REFREGERATOR,NES  ",-1
MESSAGE2:
 dc.b	" SOME GIGA-SERVUS ARE GOING TO MY CODING-FRIENDS: "
 dc.b	" MING,ANDY AND BOND ",-1
MESSAGE3:
 dc.b	" DOUBLE-MEGA-GIGA-GREAT-SERVUSES TO THE BEST "
 dc.b	"PROGRAMMERS :    "
 dc.b	" MINGI,MORDILLO,ANDY,BOND,LUTZ-AND-KERMY(C64-PROFS),"
 dc.b	"ATOM,BOERNY,GUILD-OF-GURU   ",-1 
MESSAGE4:
 dc.b	" THIS SPECIAL TEXT-LINE IS ONLY FOR MY CODING-TEACHER "
 dc.b	"  ]]] MING THE MERCILESS ]]]   ",-1
MESSAGE6:
 dc.b	" HALLO !!! THIS INTRO "
 dc.b	"USES THE AMIGA APROXIMATELY 90 PERCENT !!! "
 dc.b	" DESWEGEN KONNTE ICH LEIDER KEIN DREHEN,SCHWABBELN" 
 dc.b	" UND SOLCHE "
 dc.b	"SCHWACHSINNE NICHT EINBAUEN - ES IST JA SCHLIESSLICH EIN "
 dc.b 	"  [[ NINE-FONT-SCROLL-DEMO BY MEMED [[  " 
 dc.b	" UND KEIN SCHWABBEL UND WAS WEISS ICH NOCH FUER EIN "
 dc.b	"KACK-DEMO    ",-1 	
MESSAGE5:
 dc.b	" THIS INTRO WAS HACKED AND DESIGNED BY MEMED  "
 dc.b	" THE MUZAK, AS ALWAYS, WAS COMPOSED BY KERMY  ",-1 
MESSAGE7:
 dc.b	" SPECIAL HIGHS TO ALL CRACKER AS OUTBOUND AND"
 dc.b	" QUARTEX !!  ",-1
MESSAGE8:
 dc.b	" MENSCH WAS SOLL ICH DENN NOCH FUER QUARK-SHIT EINTIPPEN "
 dc.b	"!!!???   ",-1
MESSAGE9:
 dc.b	" PUUHHH !!  ENDLICH DAS IST DIE LETZTE,  "
 dc.b	" HYPRA-SERVUS TO ALL DIE ES GEREADET HABEN - THUESS !!!! " 
 dc.b	"    ",-1

ASCII:
 dc.b   "ABCDEFGHIJ"
 dc.b   "KLMNOPQRST"
 dc.b   "UVWXYZ!?:;"
 dc.b	"0123456789"
 dc.b   "+(),-.=[] "

