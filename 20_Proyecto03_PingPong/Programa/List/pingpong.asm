
;CodeVisionAVR C Compiler V2.60 Evaluation
;(C) Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8535
;Program type           : Application
;Clock frequency        : 1.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#pragma AVRPART ADMIN PART_NAME ATmega8535
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x025F
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rand=R4
	.DEF _cont1=R6
	.DEF _cont2=R8
	.DEF _puntos1=R10
	.DEF _puntos2=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP _ext_int0_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _ext_int2_isr
	RJMP 0x00
	RJMP 0x00

_0x3:
	.DB  0x40,0x79,0x24,0x30,0x19,0x12,0x2,0x78
	.DB  0x0,0x10,0xC0,0xCF,0xA4,0x86,0x8B,0x92
	.DB  0x90,0xC7,0x80,0x82

__GLOBAL_INI_TBL:
	.DW  0x14
	.DW  _tabla7segmentos
	.DW  _0x3*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 24/10/2019
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega8535
;Program type            : Application
;AVR Core Clock frequency: 1.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*****************************************************/
;
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;eeprom short random;
;eeprom short barra1;
;eeprom short barra2;
;int rand;
;//
;int cont1,cont2;
;int puntos1,puntos2;
;int i,j;
;int x,y;
;int direccion;
;int dsplz;
;int stay;
;int cols;
;int inst;
;//
;int win;
;int rapidez;
;int rapidez1;
;float rapidez2;
;int gan1;
;int gan2;
;int gan3;
;int gan4;
;const char tabla7segmentos[2][10]={
;{0x40,0x79,0x24,0x30,0x19,0x12,0x02,0x78,0x00,0x10},
;{0xc0,0xcf,0xa4,0x86,0x8b,0x92,0x90,0xc7,0x80,0x82}
;};

	.DSEG
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0039 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	RCALL SUBOPT_0x0
; 0000 003A     // Place your code here
; 0000 003B     if(cont1>20){
	CP   R30,R6
	CPC  R31,R7
	BRGE _0x4
; 0000 003C     cont1=0;
	CLR  R6
	CLR  R7
; 0000 003D     if(inst){
	RCALL SUBOPT_0x1
	BREQ _0x5
; 0000 003E         //Derecha
; 0000 003F         barra1++;
	RCALL SUBOPT_0x2
	ADIW R30,1
	RCALL __EEPROMWRW
; 0000 0040         if(barra1>3){
	RCALL SUBOPT_0x2
	SBIW R30,4
	BRLT _0x6
; 0000 0041             barra1=3;
	LDI  R26,LOW(_barra1)
	LDI  R27,HIGH(_barra1)
	RCALL SUBOPT_0x3
; 0000 0042         }
; 0000 0043     }else{
_0x6:
	RJMP _0x7
_0x5:
; 0000 0044         //Izquierda
; 0000 0045         barra1--;
	RCALL SUBOPT_0x2
	SBIW R30,1
	RCALL __EEPROMWRW
; 0000 0046         if(barra1<0){
	RCALL SUBOPT_0x4
	BRPL _0x8
; 0000 0047             barra1=0;
	RCALL SUBOPT_0x5
; 0000 0048         }
; 0000 0049     }
_0x8:
_0x7:
; 0000 004A     }else{
	RJMP _0x9
_0x4:
; 0000 004B     cont1++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	SBIW R30,1
; 0000 004C     }
_0x9:
; 0000 004D }
	RJMP _0xDA
; .FEND
;
;// External Interrupt 2 service routine
;interrupt [EXT_INT2] void ext_int2_isr(void)
; 0000 0051 {
_ext_int2_isr:
; .FSTART _ext_int2_isr
	RCALL SUBOPT_0x0
; 0000 0052 // Place your code here
; 0000 0053     if(cont2>20){
	CP   R30,R8
	CPC  R31,R9
	BRGE _0xA
; 0000 0054     cont2=0;
	CLR  R8
	CLR  R9
; 0000 0055     if(inst){
	RCALL SUBOPT_0x1
	BREQ _0xB
; 0000 0056         //Izquierda
; 0000 0057         barra2--;
	RCALL SUBOPT_0x6
	RCALL __EEPROMRDW
	SBIW R30,1
	RCALL __EEPROMWRW
; 0000 0058         if(barra2<0){
	RCALL SUBOPT_0x7
	BRPL _0xC
; 0000 0059             barra2=0;
	RCALL SUBOPT_0x6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RCALL __EEPROMWRW
; 0000 005A         }
; 0000 005B     }else{
_0xC:
	RJMP _0xD
_0xB:
; 0000 005C         //Derecha
; 0000 005D         barra2++;
	RCALL SUBOPT_0x8
	ADIW R30,1
	RCALL __EEPROMWRW
; 0000 005E         if(barra2>3){
	RCALL SUBOPT_0x8
	SBIW R30,4
	BRLT _0xE
; 0000 005F             barra2=3;
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x3
; 0000 0060         }
; 0000 0061 
; 0000 0062     }
_0xE:
_0xD:
; 0000 0063     }else{
	RJMP _0xF
_0xA:
; 0000 0064     cont2++;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,1
; 0000 0065     }
_0xF:
; 0000 0066 
; 0000 0067 }
_0xDA:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	RETI
; .FEND
;
;// Declare your global variables here
;
;void main(void)
; 0000 006C {
_main:
; .FSTART _main
; 0000 006D // Declare your local variables here
; 0000 006E 
; 0000 006F // Input/Output Ports initialization
; 0000 0070 // Port A initialization
; 0000 0071 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0072 // State7=0 State6=1 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0073 PORTA=0x40;
	LDI  R30,LOW(64)
	OUT  0x1B,R30
; 0000 0074 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0075 
; 0000 0076 // Port B initialization
; 0000 0077 // Func7=Out Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=Out
; 0000 0078 // State7=1 State6=P State5=P State4=P State3=P State2=P State1=P State0=1
; 0000 0079 PORTB=0xFF;
	OUT  0x18,R30
; 0000 007A DDRB=0x81;
	LDI  R30,LOW(129)
	OUT  0x17,R30
; 0000 007B 
; 0000 007C // Port C initialization
; 0000 007D // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 007E // State7=0 State6=1 State5=1 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 007F PORTC=0x60;
	LDI  R30,LOW(96)
	OUT  0x15,R30
; 0000 0080 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 0081 
; 0000 0082 // Port D initialization
; 0000 0083 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=Out Func0=Out
; 0000 0084 // State7=1 State6=1 State5=1 State4=1 State3=1 State2=P State1=1 State0=1
; 0000 0085 PORTD=0xFF;
	OUT  0x12,R30
; 0000 0086 DDRD=0xFB;
	LDI  R30,LOW(251)
	OUT  0x11,R30
; 0000 0087 
; 0000 0088 // Timer/Counter 0 initialization
; 0000 0089 // Clock source: System Clock
; 0000 008A // Clock value: Timer 0 Stopped
; 0000 008B // Mode: Normal top=0xFF
; 0000 008C // OC0 output: Disconnected
; 0000 008D TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 008E TCNT0=0x00;
	OUT  0x32,R30
; 0000 008F OCR0=0x00;
	OUT  0x3C,R30
; 0000 0090 
; 0000 0091 // Timer/Counter 1 initialization
; 0000 0092 // Clock source: System Clock
; 0000 0093 // Clock value: Timer1 Stopped
; 0000 0094 // Mode: Normal top=0xFFFF
; 0000 0095 // OC1A output: Discon.
; 0000 0096 // OC1B output: Discon.
; 0000 0097 // Noise Canceler: Off
; 0000 0098 // Input Capture on Falling Edge
; 0000 0099 // Timer1 Overflow Interrupt: Off
; 0000 009A // Input Capture Interrupt: Off
; 0000 009B // Compare A Match Interrupt: Off
; 0000 009C // Compare B Match Interrupt: Off
; 0000 009D TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 009E TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 009F TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 00A0 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00A1 ICR1H=0x00;
	OUT  0x27,R30
; 0000 00A2 ICR1L=0x00;
	OUT  0x26,R30
; 0000 00A3 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00A4 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00A5 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00A6 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00A7 
; 0000 00A8 // Timer/Counter 2 initialization
; 0000 00A9 // Clock source: System Clock
; 0000 00AA // Clock value: Timer2 Stopped
; 0000 00AB // Mode: Normal top=0xFF
; 0000 00AC // OC2 output: Disconnected
; 0000 00AD ASSR=0x00;
	OUT  0x22,R30
; 0000 00AE TCCR2=0x00;
	OUT  0x25,R30
; 0000 00AF TCNT2=0x00;
	OUT  0x24,R30
; 0000 00B0 OCR2=0x00;
	OUT  0x23,R30
; 0000 00B1 
; 0000 00B2 // External Interrupt(s) initialization
; 0000 00B3 // INT0: On
; 0000 00B4 // INT0 Mode: Falling Edge
; 0000 00B5 // INT1: Off
; 0000 00B6 // INT2: On
; 0000 00B7 // INT2 Mode: Falling Edge
; 0000 00B8 GICR|=0x60;
	IN   R30,0x3B
	ORI  R30,LOW(0x60)
	OUT  0x3B,R30
; 0000 00B9 MCUCR=0x02;
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 00BA MCUCSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 00BB GIFR=0x60;
	LDI  R30,LOW(96)
	OUT  0x3A,R30
; 0000 00BC 
; 0000 00BD // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00BE TIMSK=0x00;
	LDI  R30,LOW(0)
	OUT  0x39,R30
; 0000 00BF 
; 0000 00C0 // USART initialization
; 0000 00C1 // USART disabled
; 0000 00C2 UCSRB=0x00;
	OUT  0xA,R30
; 0000 00C3 
; 0000 00C4 // Analog Comparator initialization
; 0000 00C5 // Analog Comparator: Off
; 0000 00C6 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00C7 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00C8 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00C9 
; 0000 00CA // ADC initialization
; 0000 00CB // ADC disabled
; 0000 00CC ADCSRA=0x00;
	OUT  0x6,R30
; 0000 00CD 
; 0000 00CE // SPI initialization
; 0000 00CF // SPI disabled
; 0000 00D0 SPCR=0x00;
	OUT  0xD,R30
; 0000 00D1 
; 0000 00D2 // TWI initialization
; 0000 00D3 // TWI disabled
; 0000 00D4 TWCR=0x00;
	OUT  0x36,R30
; 0000 00D5 
; 0000 00D6 // Global enable interrupts
; 0000 00D7 #asm("sei")
	sei
; 0000 00D8 if(random<1){
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	SBIW R30,1
	BRGE _0x10
; 0000 00D9     random=1;
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0xA
	RCALL __EEPROMWRW
; 0000 00DA }
; 0000 00DB //multiplicar por numero primo
; 0000 00DC random=(random*7)+2;
_0x10:
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	RCALL SUBOPT_0xB
	ADIW R30,2
	RCALL SUBOPT_0xC
; 0000 00DD random=random%17;
	MOVW R26,R30
	LDI  R30,LOW(17)
	LDI  R31,HIGH(17)
	RCALL __MODW21
	RCALL SUBOPT_0xC
; 0000 00DE //definir direccion
; 0000 00DF rand=(int)random;
	RCALL SUBOPT_0xD
; 0000 00E0 rand*=7;
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xD
; 0000 00E1 direccion=rand%4;
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	RCALL SUBOPT_0xE
; 0000 00E2 //definir x
; 0000 00E3 x=2;
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x10
; 0000 00E4 //definir y
; 0000 00E5 y=3;
; 0000 00E6 //
; 0000 00E7 if(!(barra1>=0 && barra1<=3)){
	RCALL SUBOPT_0x4
	BRMI _0x12
	RCALL SUBOPT_0x2
	SBIW R30,4
	BRLT _0x11
_0x12:
; 0000 00E8     barra1=0;
	RCALL SUBOPT_0x5
; 0000 00E9 }
; 0000 00EA if(!(barra2>=0 && barra2<=3)){
_0x11:
	RCALL SUBOPT_0x7
	BRMI _0x15
	RCALL SUBOPT_0x8
	SBIW R30,4
	BRLT _0x14
_0x15:
; 0000 00EB     barra2=3;
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x3
; 0000 00EC }
; 0000 00ED //------------
; 0000 00EE cont1=0;
_0x14:
	CLR  R6
	CLR  R7
; 0000 00EF cont2=0;
	CLR  R8
	CLR  R9
; 0000 00F0 i=j=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _j,R30
	STS  _j+1,R31
	STS  _i,R30
	STS  _i+1,R31
; 0000 00F1 rapidez1=99;
	LDI  R30,LOW(99)
	LDI  R31,HIGH(99)
	STS  _rapidez1,R30
	STS  _rapidez1+1,R31
; 0000 00F2 rapidez=rapidez1;
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
; 0000 00F3 rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 00F4 dsplz=0;
	RCALL SUBOPT_0x14
; 0000 00F5 stay=0;
	RCALL SUBOPT_0x15
; 0000 00F6 cols=0;
	RCALL SUBOPT_0x16
; 0000 00F7 puntos1=0;
	CLR  R10
	CLR  R11
; 0000 00F8 puntos2=0;
	CLR  R12
	CLR  R13
; 0000 00F9 inst=0;
	RCALL SUBOPT_0x17
; 0000 00FA gan1=0;
	LDI  R30,LOW(0)
	STS  _gan1,R30
	STS  _gan1+1,R30
; 0000 00FB gan2=0;
	STS  _gan2,R30
	STS  _gan2+1,R30
; 0000 00FC gan3=0;
	STS  _gan3,R30
	STS  _gan3+1,R30
; 0000 00FD gan4=0;
	STS  _gan4,R30
	STS  _gan4+1,R30
; 0000 00FE win=0;
	STS  _win,R30
	STS  _win+1,R30
; 0000 00FF 
; 0000 0100 while (1)
_0x17:
; 0000 0101       {
; 0000 0102       // Place your code here
; 0000 0103       if(!win){
	LDS  R30,_win
	LDS  R31,_win+1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x1A
; 0000 0104         delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0105         //
; 0000 0106         //
; 0000 0107         cols++;
	LDI  R26,LOW(_cols)
	LDI  R27,HIGH(_cols)
	RCALL SUBOPT_0x18
; 0000 0108         if(cols>4){
	RCALL SUBOPT_0x19
	SBIW R26,5
	BRLT _0x1B
; 0000 0109             cols=0;
	RCALL SUBOPT_0x16
; 0000 010A         }
; 0000 010B         //
; 0000 010C         //
; 0000 010D         PORTA &=0x7f;
_0x1B:
	CBI  0x1B,7
; 0000 010E         PORTC &=0x7f;
	CBI  0x15,7
; 0000 010F         PORTB |=0x81;
	IN   R30,0x18
	ORI  R30,LOW(0x81)
	OUT  0x18,R30
; 0000 0110         PORTC |=0x60;
	IN   R30,0x15
	ORI  R30,LOW(0x60)
	OUT  0x15,R30
; 0000 0111         //
; 0000 0112         inst++;
	LDI  R26,LOW(_inst)
	LDI  R27,HIGH(_inst)
	RCALL SUBOPT_0x18
; 0000 0113         if(inst>1){
	RCALL SUBOPT_0x1A
	SBIW R26,2
	BRLT _0x1C
; 0000 0114             inst=0;
	RCALL SUBOPT_0x17
; 0000 0115         }
; 0000 0116         //
; 0000 0117         if(inst){
_0x1C:
	RCALL SUBOPT_0x1
	BREQ _0x1D
; 0000 0118             PORTA =tabla7segmentos[inst][puntos2];
	RCALL SUBOPT_0x1B
	ADD  R30,R12
	ADC  R31,R13
	LD   R30,Z
	OUT  0x1B,R30
; 0000 0119             //PORTA |=0x80;
; 0000 011A             PORTC &=0xbf;
	CBI  0x15,6
; 0000 011B             PORTB &=0x7f;
	CBI  0x18,7
; 0000 011C         }else{
	RJMP _0x1E
_0x1D:
; 0000 011D             PORTA =tabla7segmentos[inst][puntos1];
	RCALL SUBOPT_0x1B
	ADD  R30,R10
	ADC  R31,R11
	LD   R30,Z
	OUT  0x1B,R30
; 0000 011E             PORTC |=0x80;
	SBI  0x15,7
; 0000 011F             PORTC &=0xdf;
	CBI  0x15,5
; 0000 0120             PORTB &=0xfe;
	CBI  0x18,0
; 0000 0121         }
_0x1E:
; 0000 0122       //Matriz de LEDs
; 0000 0123       if(dsplz>rapidez){
	LDS  R30,_rapidez
	LDS  R31,_rapidez+1
	LDS  R26,_dsplz
	LDS  R27,_dsplz+1
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+2
	RJMP _0x1F
; 0000 0124         dsplz=0;
	RCALL SUBOPT_0x14
; 0000 0125       if(!stay){
	LDS  R30,_stay
	LDS  R31,_stay+1
	SBIW R30,0
	BRNE _0x20
; 0000 0126         stay=1;
	RCALL SUBOPT_0xA
	STS  _stay,R30
	STS  _stay+1,R31
; 0000 0127       }else{
	RJMP _0x21
_0x20:
; 0000 0128         stay=0;
	RCALL SUBOPT_0x15
; 0000 0129         //Validaciones
; 0000 012A 		switch(direccion){
	RCALL SUBOPT_0x1C
; 0000 012B 			case 0: //noroeste
	BRNE _0x25
; 0000 012C 				if((x-1)<0){
	RCALL SUBOPT_0x1D
	TST  R27
	BRPL _0x26
; 0000 012D                     if(y==1){
	RCALL SUBOPT_0x1E
	SBIW R26,1
	BRNE _0x27
; 0000 012E                         if(barra2==0 || barra2==1){
	RCALL SUBOPT_0x8
	SBIW R30,0
	BREQ _0x29
	RCALL SUBOPT_0x1F
	BRNE _0x28
_0x29:
; 0000 012F                             direccion=2;
	RCALL SUBOPT_0xF
	RJMP _0xD7
; 0000 0130 
; 0000 0131                         }else{
_0x28:
; 0000 0132                             direccion=1;
	RCALL SUBOPT_0xA
_0xD7:
	STS  _direccion,R30
	STS  _direccion+1,R31
; 0000 0133                         }
; 0000 0134                     }else if(y>=2){
	RJMP _0x2C
_0x27:
	RCALL SUBOPT_0x1E
	SBIW R26,2
	BRLT _0x2D
; 0000 0135                         direccion=1;
	RCALL SUBOPT_0x20
; 0000 0136                     }
; 0000 0137                 }else{
_0x2D:
_0x2C:
	RJMP _0x2E
_0x26:
; 0000 0138                     if(y==1){
	RCALL SUBOPT_0x1E
	SBIW R26,1
	BRNE _0x2F
; 0000 0139                         if(barra2==0){
	RCALL SUBOPT_0x8
	SBIW R30,0
	BRNE _0x30
; 0000 013A                                 if(x==1){
	RCALL SUBOPT_0x1D
	BRNE _0x31
; 0000 013B                                     direccion=3;
	RCALL SUBOPT_0x21
; 0000 013C                                 }
; 0000 013D                                 if(x==2){
_0x31:
	RCALL SUBOPT_0x22
	BRNE _0x32
; 0000 013E                                     direccion=2;
	RCALL SUBOPT_0x23
; 0000 013F                                 }
; 0000 0140                         }else if(barra2==1){
_0x32:
	RJMP _0x33
_0x30:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1F
	BRNE _0x34
; 0000 0141                                 if(x==2){
	RCALL SUBOPT_0x22
	BRNE _0x35
; 0000 0142                                     direccion=3;
	RCALL SUBOPT_0x21
; 0000 0143                                 }
; 0000 0144                                 if(x==3){
_0x35:
	RCALL SUBOPT_0x24
	BRNE _0x36
; 0000 0145                                     direccion=2;
	RCALL SUBOPT_0x23
; 0000 0146                                 }
; 0000 0147                         }else if(barra2==2){
_0x36:
	RJMP _0x37
_0x34:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x25
	BRNE _0x38
; 0000 0148                                 if(x==3){
	RCALL SUBOPT_0x24
	BRNE _0x39
; 0000 0149                                     direccion=3;
	RCALL SUBOPT_0x21
; 0000 014A                                 }
; 0000 014B                         }
_0x39:
; 0000 014C                     }else if(y<=2){
_0x38:
_0x37:
_0x33:
	RJMP _0x3A
_0x2F:
	RCALL SUBOPT_0x1E
	SBIW R26,3
; 0000 014D                         //direccion=0;
; 0000 014E                     }
; 0000 014F                 }
_0x3A:
_0x2E:
; 0000 0150 				break;
	RJMP _0x24
; 0000 0151 			case 1: //noreste
_0x25:
	RCALL SUBOPT_0x1F
	BRNE _0x3C
; 0000 0152 				if((x+1)>4){
	RCALL SUBOPT_0x26
	BRLT _0x3D
; 0000 0153                     if(y==1){
	RCALL SUBOPT_0x1E
	SBIW R26,1
	BRNE _0x3E
; 0000 0154                         if(barra2==2 || barra2==3){
	RCALL SUBOPT_0x8
	MOVW R26,R30
	SBIW R30,2
	BREQ _0x40
	RCALL SUBOPT_0x27
	BRNE _0x3F
_0x40:
; 0000 0155                             direccion=3;
	RCALL SUBOPT_0x21
; 0000 0156 
; 0000 0157                         }else{
	RJMP _0x42
_0x3F:
; 0000 0158                             direccion=0;
	RCALL SUBOPT_0x28
; 0000 0159                         }
_0x42:
; 0000 015A                     }else if(y>=2){
	RJMP _0x43
_0x3E:
	RCALL SUBOPT_0x1E
	SBIW R26,2
	BRLT _0x44
; 0000 015B                         direccion=0;
	RCALL SUBOPT_0x28
; 0000 015C                     }
; 0000 015D                 }else{
_0x44:
_0x43:
	RJMP _0x45
_0x3D:
; 0000 015E                     if(y==1){
	RCALL SUBOPT_0x1E
	SBIW R26,1
	BRNE _0x46
; 0000 015F                         if(barra2==1){
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1F
	BRNE _0x47
; 0000 0160                                 if(x==1){
	RCALL SUBOPT_0x1D
	BRNE _0x48
; 0000 0161                                     direccion=2;
	RCALL SUBOPT_0x23
; 0000 0162                                 }
; 0000 0163                         }else if(barra2==2){
_0x48:
	RJMP _0x49
_0x47:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x25
	BRNE _0x4A
; 0000 0164                                 if(x==2){
	RCALL SUBOPT_0x22
	BRNE _0x4B
; 0000 0165                                     direccion=2;
	RCALL SUBOPT_0x23
; 0000 0166                                 }
; 0000 0167                                 if(x==1){
_0x4B:
	RCALL SUBOPT_0x1D
	BRNE _0x4C
; 0000 0168                                     direccion=3;
	RCALL SUBOPT_0x21
; 0000 0169                                 }
; 0000 016A                         }else if (barra2==3){
_0x4C:
	RJMP _0x4D
_0x4A:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x29
	BRNE _0x4E
; 0000 016B                                 if(x==3){
	RCALL SUBOPT_0x24
	BRNE _0x4F
; 0000 016C                                     direccion=2;
	RCALL SUBOPT_0x23
; 0000 016D                                 }
; 0000 016E                                 if(x==2){
_0x4F:
	RCALL SUBOPT_0x22
	BRNE _0x50
; 0000 016F                                     direccion=3;
	RCALL SUBOPT_0x21
; 0000 0170                                 }
; 0000 0171                         }
_0x50:
; 0000 0172                     }else if(y>=2){
_0x4E:
_0x4D:
_0x49:
	RJMP _0x51
_0x46:
	RCALL SUBOPT_0x1E
	SBIW R26,2
; 0000 0173                         //direccion=1;
; 0000 0174                     }
; 0000 0175                 }
_0x51:
_0x45:
; 0000 0176 				break;
	RJMP _0x24
; 0000 0177 			case 2: //sureste
_0x3C:
	RCALL SUBOPT_0x25
	BRNE _0x53
; 0000 0178 				if((x+1)>4){
	RCALL SUBOPT_0x26
	BRLT _0x54
; 0000 0179                     if(y==5){
	RCALL SUBOPT_0x2A
	BRNE _0x55
; 0000 017A                         if(barra1==2 || barra1==3){
	RCALL SUBOPT_0x2
	MOVW R26,R30
	SBIW R30,2
	BREQ _0x57
	RCALL SUBOPT_0x27
	BRNE _0x56
_0x57:
; 0000 017B                             direccion=0;
	RCALL SUBOPT_0x28
; 0000 017C 
; 0000 017D                         }else{
	RJMP _0x59
_0x56:
; 0000 017E                             direccion=3;
	RCALL SUBOPT_0x21
; 0000 017F                         }
_0x59:
; 0000 0180                     }else if(y<=4){
	RJMP _0x5A
_0x55:
	RCALL SUBOPT_0x2A
	BRGE _0x5B
; 0000 0181                         direccion=3;
	RCALL SUBOPT_0x21
; 0000 0182                     }
; 0000 0183                 }else{
_0x5B:
_0x5A:
	RJMP _0x5C
_0x54:
; 0000 0184                     if(y==5){
	RCALL SUBOPT_0x2A
	BRNE _0x5D
; 0000 0185                         if(barra1==1){
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x1F
	BRNE _0x5E
; 0000 0186                                 if(x==1){
	RCALL SUBOPT_0x1D
	BRNE _0x5F
; 0000 0187                                     direccion=1;
	RCALL SUBOPT_0x20
; 0000 0188                                 }
; 0000 0189                         }else if(barra1==2){
_0x5F:
	RJMP _0x60
_0x5E:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x25
	BRNE _0x61
; 0000 018A                                 if(x==2){
	RCALL SUBOPT_0x22
	BRNE _0x62
; 0000 018B                                     direccion=1;
	RCALL SUBOPT_0x20
; 0000 018C                                 }
; 0000 018D                                 if(x==1){
_0x62:
	RCALL SUBOPT_0x1D
	BRNE _0x63
; 0000 018E                                     direccion=0;
	RCALL SUBOPT_0x28
; 0000 018F                                 }
; 0000 0190                         }else if (barra1==3){
_0x63:
	RJMP _0x64
_0x61:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x29
	BRNE _0x65
; 0000 0191                                 if(x==3){
	RCALL SUBOPT_0x24
	BRNE _0x66
; 0000 0192                                     direccion=1;
	RCALL SUBOPT_0x20
; 0000 0193                                 }
; 0000 0194                                 if(x==2){
_0x66:
	RCALL SUBOPT_0x22
	BRNE _0x67
; 0000 0195                                     direccion=0;
	RCALL SUBOPT_0x28
; 0000 0196                                 }
; 0000 0197                         }
_0x67:
; 0000 0198                     }else if(y<=4){
_0x65:
_0x64:
_0x60:
	RJMP _0x68
_0x5D:
	RCALL SUBOPT_0x2A
; 0000 0199                         //direccion=2;
; 0000 019A                     }
; 0000 019B                 }
_0x68:
_0x5C:
; 0000 019C 				break;
	RJMP _0x24
; 0000 019D 			case 3: //suroeste
_0x53:
	RCALL SUBOPT_0x29
	BRNE _0x81
; 0000 019E 				if((x-1)<0){
	RCALL SUBOPT_0x1D
	TST  R27
	BRPL _0x6B
; 0000 019F                     if(y==5){
	RCALL SUBOPT_0x2A
	BRNE _0x6C
; 0000 01A0                         if(barra1==0 || barra1==1){
	RCALL SUBOPT_0x2
	SBIW R30,0
	BREQ _0x6E
	RCALL SUBOPT_0x1F
	BRNE _0x6D
_0x6E:
; 0000 01A1                             direccion=1;
	RCALL SUBOPT_0xA
	RJMP _0xD8
; 0000 01A2 
; 0000 01A3                         }else{
_0x6D:
; 0000 01A4                             direccion=2;
	RCALL SUBOPT_0xF
_0xD8:
	STS  _direccion,R30
	STS  _direccion+1,R31
; 0000 01A5                         }
; 0000 01A6                     }else if(y<=4){
	RJMP _0x71
_0x6C:
	RCALL SUBOPT_0x2A
	BRGE _0x72
; 0000 01A7                         direccion=2;
	RCALL SUBOPT_0x23
; 0000 01A8                     }
; 0000 01A9                 }else{
_0x72:
_0x71:
	RJMP _0x73
_0x6B:
; 0000 01AA                     if(y==5){
	RCALL SUBOPT_0x2A
	BRNE _0x74
; 0000 01AB                         if(barra1==0){
	RCALL SUBOPT_0x2
	SBIW R30,0
	BRNE _0x75
; 0000 01AC                                 if(x==1){
	RCALL SUBOPT_0x1D
	BRNE _0x76
; 0000 01AD                                     direccion=0;
	RCALL SUBOPT_0x28
; 0000 01AE                                 }
; 0000 01AF                                 if(x==2){
_0x76:
	RCALL SUBOPT_0x22
	BRNE _0x77
; 0000 01B0                                     direccion=1;
	RCALL SUBOPT_0x20
; 0000 01B1                                 }
; 0000 01B2                         }else if(barra1==1){
_0x77:
	RJMP _0x78
_0x75:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x1F
	BRNE _0x79
; 0000 01B3                                 if(x==2){
	RCALL SUBOPT_0x22
	BRNE _0x7A
; 0000 01B4                                     direccion=0;
	RCALL SUBOPT_0x28
; 0000 01B5                                 }
; 0000 01B6                                 if(x==3){
_0x7A:
	RCALL SUBOPT_0x24
	BRNE _0x7B
; 0000 01B7                                     direccion=1;
	RCALL SUBOPT_0x20
; 0000 01B8                                 }
; 0000 01B9                         }else if(barra1==2){
_0x7B:
	RJMP _0x7C
_0x79:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x25
	BRNE _0x7D
; 0000 01BA                                 if(x==3){
	RCALL SUBOPT_0x24
	BRNE _0x7E
; 0000 01BB                                     direccion=0;
	RCALL SUBOPT_0x28
; 0000 01BC                                 }
; 0000 01BD                         }
_0x7E:
; 0000 01BE                     }else if(y<=4){
_0x7D:
_0x7C:
_0x78:
	RJMP _0x7F
_0x74:
	RCALL SUBOPT_0x2A
; 0000 01BF                         //direccion=3;
; 0000 01C0                     }
; 0000 01C1                 }
_0x7F:
_0x73:
; 0000 01C2 				break;
; 0000 01C3 			default:
_0x81:
; 0000 01C4 				break;
; 0000 01C5 		}
_0x24:
; 0000 01C6 		//
; 0000 01C7         switch(direccion){
	RCALL SUBOPT_0x1C
; 0000 01C8 			case 0: //noroeste
	BRNE _0x85
; 0000 01C9 				x--;
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x2C
; 0000 01CA 				y--;
	LDI  R26,LOW(_y)
	LDI  R27,HIGH(_y)
	RCALL SUBOPT_0x2C
; 0000 01CB 				break;
	RJMP _0x84
; 0000 01CC 			case 1: //noreste
_0x85:
	RCALL SUBOPT_0x1F
	BRNE _0x86
; 0000 01CD 				x++;
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x18
; 0000 01CE 				y--;
	LDI  R26,LOW(_y)
	LDI  R27,HIGH(_y)
	RCALL SUBOPT_0x2C
; 0000 01CF 				break;
	RJMP _0x84
; 0000 01D0 			case 2: //sureste
_0x86:
	RCALL SUBOPT_0x25
	BRNE _0x87
; 0000 01D1 				x++;
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x18
; 0000 01D2 				y++;
	LDI  R26,LOW(_y)
	LDI  R27,HIGH(_y)
	RCALL SUBOPT_0x18
; 0000 01D3 				break;
	RJMP _0x84
; 0000 01D4 			case 3: //suroeste
_0x87:
	RCALL SUBOPT_0x29
	BRNE _0x89
; 0000 01D5 				x--;
	RCALL SUBOPT_0x2B
	RCALL SUBOPT_0x2C
; 0000 01D6 				y++;
	LDI  R26,LOW(_y)
	LDI  R27,HIGH(_y)
	RCALL SUBOPT_0x18
; 0000 01D7 				break;
; 0000 01D8 			default:
_0x89:
; 0000 01D9 				break;
; 0000 01DA 		}
_0x84:
; 0000 01DB       }
_0x21:
; 0000 01DC       }else{
	RJMP _0x8A
_0x1F:
; 0000 01DD         dsplz++;
	LDI  R26,LOW(_dsplz)
	LDI  R27,HIGH(_dsplz)
	RCALL SUBOPT_0x18
; 0000 01DE       }
_0x8A:
; 0000 01DF       //
; 0000 01E0         PORTD |=0xfb;
	RCALL SUBOPT_0x2D
; 0000 01E1         PORTC &=0xe0;
; 0000 01E2         if((cols%5)==x){
	RCALL SUBOPT_0x2E
	MOVW R26,R30
	LDS  R30,_x
	LDS  R31,_x+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x8B
; 0000 01E3         switch(y){
	LDS  R30,_y
	LDS  R31,_y+1
; 0000 01E4             case 0:
	SBIW R30,0
	BRNE _0x8F
; 0000 01E5                 PORTD &=0x7f;
	CBI  0x12,7
; 0000 01E6                 break;
	RJMP _0x8E
; 0000 01E7             case 1:
_0x8F:
	RCALL SUBOPT_0x1F
	BRNE _0x90
; 0000 01E8                 PORTD &=0xbf;
	CBI  0x12,6
; 0000 01E9                 break;
	RJMP _0x8E
; 0000 01EA             case 2:
_0x90:
	RCALL SUBOPT_0x25
	BRNE _0x91
; 0000 01EB                 PORTD &=0xdf;
	CBI  0x12,5
; 0000 01EC                 break;
	RJMP _0x8E
; 0000 01ED             case 3:
_0x91:
	RCALL SUBOPT_0x29
	BRNE _0x92
; 0000 01EE                 PORTD &=0xef;
	CBI  0x12,4
; 0000 01EF                 break;
	RJMP _0x8E
; 0000 01F0             case 4:
_0x92:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x93
; 0000 01F1                 PORTD &=0xf7;
	CBI  0x12,3
; 0000 01F2                 break;
	RJMP _0x8E
; 0000 01F3             case 5:
_0x93:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x94
; 0000 01F4                 PORTD &=0xfd;
	CBI  0x12,1
; 0000 01F5                 break;
	RJMP _0x8E
; 0000 01F6             case 6:
_0x94:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x96
; 0000 01F7                 PORTD &=0xfe;
	CBI  0x12,0
; 0000 01F8                 break;
; 0000 01F9             default:
_0x96:
; 0000 01FA                 break;
; 0000 01FB         }
_0x8E:
; 0000 01FC         }
; 0000 01FD         //
; 0000 01FE         switch((cols%5)){
_0x8B:
	RCALL SUBOPT_0x2E
; 0000 01FF             case 0:
	SBIW R30,0
	BRNE _0x9A
; 0000 0200                 if(barra1==0){
	RCALL SUBOPT_0x2
	SBIW R30,0
	BRNE _0x9B
; 0000 0201                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 0202                 }
; 0000 0203                 if(barra2==0){
_0x9B:
	RCALL SUBOPT_0x8
	SBIW R30,0
	BRNE _0x9C
; 0000 0204                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 0205                 }
; 0000 0206                 PORTC |=0x01;
_0x9C:
	SBI  0x15,0
; 0000 0207                 break;
	RJMP _0x99
; 0000 0208             case 1:
_0x9A:
	RCALL SUBOPT_0x1F
	BRNE _0x9D
; 0000 0209                 if(barra1==0){
	RCALL SUBOPT_0x2
	SBIW R30,0
	BRNE _0x9E
; 0000 020A                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 020B                 }
; 0000 020C                 if(barra2==0){
_0x9E:
	RCALL SUBOPT_0x8
	SBIW R30,0
	BRNE _0x9F
; 0000 020D                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 020E                 }
; 0000 020F                 if(barra1==1){
_0x9F:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x1F
	BRNE _0xA0
; 0000 0210                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 0211                 }
; 0000 0212                 if(barra2==1){
_0xA0:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1F
	BRNE _0xA1
; 0000 0213                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 0214                 }
; 0000 0215                 PORTC |=0x02;
_0xA1:
	SBI  0x15,1
; 0000 0216                 break;
	RJMP _0x99
; 0000 0217             case 2:
_0x9D:
	RCALL SUBOPT_0x25
	BRNE _0xA2
; 0000 0218                 if(barra1==1){
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x1F
	BRNE _0xA3
; 0000 0219                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 021A                 }
; 0000 021B                 if(barra2==1){
_0xA3:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1F
	BRNE _0xA4
; 0000 021C                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 021D                 }
; 0000 021E                 if(barra1==2){
_0xA4:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x25
	BRNE _0xA5
; 0000 021F                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 0220                 }
; 0000 0221                 if(barra2==2){
_0xA5:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x25
	BRNE _0xA6
; 0000 0222                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 0223                 }
; 0000 0224                 PORTC |=0x04;
_0xA6:
	SBI  0x15,2
; 0000 0225                 break;
	RJMP _0x99
; 0000 0226             case 3:
_0xA2:
	RCALL SUBOPT_0x29
	BRNE _0xA7
; 0000 0227                 if(barra1==2){
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x25
	BRNE _0xA8
; 0000 0228                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 0229                 }
; 0000 022A                 if(barra2==2){
_0xA8:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x25
	BRNE _0xA9
; 0000 022B                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 022C                 }
; 0000 022D                 if(barra1==3){
_0xA9:
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x29
	BRNE _0xAA
; 0000 022E                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 022F                 }
; 0000 0230                 if(barra2==3){
_0xAA:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x29
	BRNE _0xAB
; 0000 0231                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 0232                 }
; 0000 0233                 PORTC |=0x08;
_0xAB:
	SBI  0x15,3
; 0000 0234                 break;
	RJMP _0x99
; 0000 0235             case 4:
_0xA7:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xAF
; 0000 0236                 if(barra1==3){
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x29
	BRNE _0xAD
; 0000 0237                     PORTD &=0xfe;
	CBI  0x12,0
; 0000 0238                 }
; 0000 0239                 if(barra2==3){
_0xAD:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x29
	BRNE _0xAE
; 0000 023A                     PORTD &=0x7f;
	CBI  0x12,7
; 0000 023B                 }
; 0000 023C                 PORTC |=0x10;
_0xAE:
	SBI  0x15,4
; 0000 023D                 break;
; 0000 023E             default:
_0xAF:
; 0000 023F                 break;
; 0000 0240         }
_0x99:
; 0000 0241       //
; 0000 0242         if(y<0 || y>6){
	LDS  R26,_y+1
	TST  R26
	BRMI _0xB1
	RCALL SUBOPT_0x1E
	SBIW R26,7
	BRGE _0xB1
	RJMP _0xB0
_0xB1:
; 0000 0243         PORTD |=0xfb;
	RCALL SUBOPT_0x2D
; 0000 0244         PORTC &=0xe0;
; 0000 0245         if(y>6){
	RCALL SUBOPT_0x1E
	SBIW R26,7
	BRLT _0xB3
; 0000 0246             puntos2++;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0000 0247             if(puntos2>9){
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	RCALL SUBOPT_0x2F
	BRGE _0xB4
; 0000 0248                 win=1;
	RCALL SUBOPT_0x30
; 0000 0249             }
; 0000 024A             //redefinir direccion
; 0000 024B             rand*=7;
_0xB4:
	MOVW R30,R4
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x31
; 0000 024C             rand=rand%11;
	RCALL SUBOPT_0xD
; 0000 024D             direccion=rand%2;
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	RCALL SUBOPT_0xE
; 0000 024E 
; 0000 024F         }
; 0000 0250         if(y<0){
_0xB3:
	LDS  R26,_y+1
	TST  R26
	BRPL _0xB5
; 0000 0251             puntos1++;
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
; 0000 0252             if(puntos1>9){
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	RCALL SUBOPT_0x32
	BRGE _0xB6
; 0000 0253                 win=1;
	RCALL SUBOPT_0x30
; 0000 0254             }
; 0000 0255             //redefinir direccion
; 0000 0256             rand*=7;
_0xB6:
	MOVW R30,R4
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x31
; 0000 0257             rand=rand%11;
	MOVW R4,R30
; 0000 0258             direccion=(rand%2)+2;
	MOVW R26,R4
	RCALL SUBOPT_0xF
	RCALL __MODW21
	ADIW R30,2
	STS  _direccion,R30
	STS  _direccion+1,R31
; 0000 0259 
; 0000 025A         }
; 0000 025B         //redefinir x
; 0000 025C         rand*=19;
_0xB5:
	MOVW R30,R4
	LDI  R26,LOW(19)
	LDI  R27,HIGH(19)
	RCALL __MULW12
	RCALL SUBOPT_0xD
; 0000 025D         rand+=7;
	ADIW R30,7
	MOVW R4,R30
; 0000 025E         x=1+(rand%3);
	MOVW R26,R4
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __MODW21
	ADIW R30,1
	RCALL SUBOPT_0x10
; 0000 025F         //redefinir y
; 0000 0260         y=3;
; 0000 0261         //
; 0000 0262         if(puntos1>8 && puntos2>8){
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x32
	BRGE _0xB8
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x2F
	BRLT _0xB9
_0xB8:
	RJMP _0xB7
_0xB9:
; 0000 0263             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0264             rapidez2=rapidez2*33/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42040000
	RJMP _0xD9
; 0000 0265             rapidez=(int)(rapidez2);
; 0000 0266         }else if(puntos1>7 && puntos2>7){
_0xB7:
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	RCALL SUBOPT_0x32
	BRGE _0xBC
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	RCALL SUBOPT_0x2F
	BRLT _0xBD
_0xBC:
	RJMP _0xBB
_0xBD:
; 0000 0267             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0268             rapidez2=rapidez2*39/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x421C0000
	RJMP _0xD9
; 0000 0269             rapidez=(int)(rapidez2);
; 0000 026A         }else if(puntos1>6 && puntos2>6){
_0xBB:
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RCALL SUBOPT_0x32
	BRGE _0xC0
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RCALL SUBOPT_0x2F
	BRLT _0xC1
_0xC0:
	RJMP _0xBF
_0xC1:
; 0000 026B             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 026C             rapidez2=rapidez2*41/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42240000
	RJMP _0xD9
; 0000 026D             rapidez=(int)(rapidez2);
; 0000 026E         }else if(puntos1>5 && puntos2>5){
_0xBF:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x32
	BRGE _0xC4
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x2F
	BRLT _0xC5
_0xC4:
	RJMP _0xC3
_0xC5:
; 0000 026F             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0270             rapidez2=rapidez2*53/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42540000
	RJMP _0xD9
; 0000 0271             rapidez=(int)(rapidez2);
; 0000 0272         }else if(puntos1>4 && puntos2>4){
_0xC3:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x32
	BRGE _0xC8
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x2F
	BRLT _0xC9
_0xC8:
	RJMP _0xC7
_0xC9:
; 0000 0273             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0274             rapidez2=rapidez2*63/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x427C0000
	RJMP _0xD9
; 0000 0275             rapidez=(int)(rapidez2);
; 0000 0276         }else if(puntos1>3 && puntos2>3){
_0xC7:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x32
	BRGE _0xCC
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x2F
	BRLT _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
; 0000 0277             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0278             rapidez2=rapidez2*73/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42920000
	RJMP _0xD9
; 0000 0279             rapidez=(int)(rapidez2);
; 0000 027A         }else if(puntos1>2 && puntos2>2){
_0xCB:
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x32
	BRGE _0xD0
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x2F
	BRLT _0xD1
_0xD0:
	RJMP _0xCF
_0xD1:
; 0000 027B             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 027C             rapidez2=rapidez2*83/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42A60000
	RJMP _0xD9
; 0000 027D             rapidez=(int)(rapidez2);
; 0000 027E         }else if(puntos1>1 && puntos2>1){
_0xCF:
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x32
	BRGE _0xD4
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x2F
	BRLT _0xD5
_0xD4:
	RJMP _0xD3
_0xD5:
; 0000 027F             rapidez2=(float)(rapidez1);
	RCALL SUBOPT_0x13
; 0000 0280             rapidez2=rapidez2*93/100;
	RCALL SUBOPT_0x33
	__GETD1N 0x42BA0000
_0xD9:
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x42C80000
	RCALL __DIVF21
	STS  _rapidez2,R30
	STS  _rapidez2+1,R31
	STS  _rapidez2+2,R22
	STS  _rapidez2+3,R23
; 0000 0281             rapidez=(int)(rapidez2);
	RCALL __CFD1
	RCALL SUBOPT_0x12
; 0000 0282         }
; 0000 0283         delay_ms(200);
_0xD3:
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0284         }
; 0000 0285         //
; 0000 0286       //
; 0000 0287       }
_0xB0:
; 0000 0288       }
_0x1A:
	RJMP _0x17
; 0000 0289 }
_0xD6:
	RJMP _0xD6
; .FEND

	.ESEG
_random:
	.BYTE 0x2
_barra1:
	.BYTE 0x2
_barra2:
	.BYTE 0x2

	.DSEG
_i:
	.BYTE 0x2
_j:
	.BYTE 0x2
_x:
	.BYTE 0x2
_y:
	.BYTE 0x2
_direccion:
	.BYTE 0x2
_dsplz:
	.BYTE 0x2
_stay:
	.BYTE 0x2
_cols:
	.BYTE 0x2
_inst:
	.BYTE 0x2
_win:
	.BYTE 0x2
_rapidez:
	.BYTE 0x2
_rapidez1:
	.BYTE 0x2
_rapidez2:
	.BYTE 0x4
_gan1:
	.BYTE 0x2
_gan2:
	.BYTE 0x2
_gan3:
	.BYTE 0x2
_gan4:
	.BYTE 0x2
_tabla7segmentos:
	.BYTE 0x14

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	LDS  R30,_inst
	LDS  R31,_inst+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 20 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(_barra1)
	LDI  R27,HIGH(_barra1)
	RCALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(_barra1+1)
	LDI  R27,HIGH(_barra1+1)
	RCALL __EEPROMRDB
	TST  R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(_barra1)
	LDI  R27,HIGH(_barra1)
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RCALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(_barra2)
	LDI  R27,HIGH(_barra2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(_barra2+1)
	LDI  R27,HIGH(_barra2+1)
	RCALL __EEPROMRDB
	TST  R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x8:
	RCALL SUBOPT_0x6
	RCALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(_random)
	LDI  R27,HIGH(_random)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xB:
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	RCALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	RCALL SUBOPT_0x9
	RCALL __EEPROMWRW
	RCALL SUBOPT_0x9
	RCALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	MOVW R4,R30
	MOVW R30,R4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	RCALL __MANDW12
	STS  _direccion,R30
	STS  _direccion+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xF:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10:
	STS  _x,R30
	STS  _x+1,R31
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	STS  _y,R30
	STS  _y+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x11:
	LDS  R30,_rapidez1
	LDS  R31,_rapidez1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	STS  _rapidez,R30
	STS  _rapidez+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:86 WORDS
SUBOPT_0x13:
	RCALL SUBOPT_0x11
	RCALL __CWD1
	RCALL __CDF1
	STS  _rapidez2,R30
	STS  _rapidez2+1,R31
	STS  _rapidez2+2,R22
	STS  _rapidez2+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	LDI  R30,LOW(0)
	STS  _dsplz,R30
	STS  _dsplz+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	LDI  R30,LOW(0)
	STS  _stay,R30
	STS  _stay+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(0)
	STS  _cols,R30
	STS  _cols+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	LDI  R30,LOW(0)
	STS  _inst,R30
	STS  _inst+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x18:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x19:
	LDS  R26,_cols
	LDS  R27,_cols+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1A:
	LDS  R26,_inst
	LDS  R27,_inst+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1B:
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(10)
	RCALL __MULB1W2U
	SUBI R30,LOW(-_tabla7segmentos)
	SBCI R31,HIGH(-_tabla7segmentos)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	LDS  R30,_direccion
	LDS  R31,_direccion+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x1D:
	LDS  R26,_x
	LDS  R27,_x+1
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0x1E:
	LDS  R26,_y
	LDS  R27,_y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x1F:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x20:
	RCALL SUBOPT_0xA
	STS  _direccion,R30
	STS  _direccion+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x21:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	STS  _direccion,R30
	STS  _direccion+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x22:
	LDS  R26,_x
	LDS  R27,_x+1
	SBIW R26,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x23:
	RCALL SUBOPT_0xF
	STS  _direccion,R30
	STS  _direccion+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x24:
	LDS  R26,_x
	LDS  R27,_x+1
	SBIW R26,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x25:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	LDS  R26,_x
	LDS  R27,_x+1
	ADIW R26,1
	SBIW R26,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x27:
	MOVW R30,R26
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x28:
	LDI  R30,LOW(0)
	STS  _direccion,R30
	STS  _direccion+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x29:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2A:
	RCALL SUBOPT_0x1E
	SBIW R26,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDI  R26,LOW(_x)
	LDI  R27,HIGH(_x)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x2C:
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2D:
	IN   R30,0x12
	ORI  R30,LOW(0xFB)
	OUT  0x12,R30
	IN   R30,0x15
	ANDI R30,LOW(0xE0)
	OUT  0x15,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2E:
	RCALL SUBOPT_0x19
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL __MODW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2F:
	CP   R30,R12
	CPC  R31,R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x30:
	RCALL SUBOPT_0xA
	STS  _win,R30
	STS  _win+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x31:
	MOVW R4,R30
	MOVW R26,R4
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	RCALL __MODW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x32:
	CP   R30,R10
	CPC  R31,R11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x33:
	LDS  R26,_rapidez2
	LDS  R27,_rapidez2+1
	LDS  R24,_rapidez2+2
	LDS  R25,_rapidez2+3
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

;END OF CODE MARKER
__END_OF_CODE:
