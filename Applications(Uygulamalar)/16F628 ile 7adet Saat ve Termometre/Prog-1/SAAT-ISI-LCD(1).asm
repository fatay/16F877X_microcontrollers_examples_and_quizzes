
; PicBasic Pro Compiler 2.46, (c) 1998, 2005 microEngineering Labs, Inc. All Rights Reserved.  
PM_USED			EQU	1

	INCLUDE	"16F628.INC"


; Define statements.
#define		LCD_DREG				PORTB	
#define		LCD_DBIT				4		
#define		LCD_EREG				PORTB	
#define		LCD_EBIT				3		
#define		LCD		 RWREG    PORTB   
#define		LCD_RWBIT		    2       
#define		LCD_RSREG			PORTB	
#define		LCD_RSBIT			1		
#define		LCD_BITS				4		
#define		LCD_LINES			2		

RAM_START       		EQU	00020h
RAM_END         		EQU	0014Fh
RAM_BANKS       		EQU	00003h
BANK0_START     		EQU	00020h
BANK0_END       		EQU	0007Fh
BANK1_START     		EQU	000A0h
BANK1_END       		EQU	000EFh
BANK2_START     		EQU	00120h
BANK2_END       		EQU	0014Fh
EEPROM_START    		EQU	02100h
EEPROM_END      		EQU	0217Fh

R0              		EQU	RAM_START + 000h
R1              		EQU	RAM_START + 002h
R2              		EQU	RAM_START + 004h
R3              		EQU	RAM_START + 006h
R4              		EQU	RAM_START + 008h
R5              		EQU	RAM_START + 00Ah
R6              		EQU	RAM_START + 00Ch
R7              		EQU	RAM_START + 00Eh
R8              		EQU	RAM_START + 010h
T1              		EQU	RAM_START + 012h
FLAGS           		EQU	RAM_START + 014h
GOP             		EQU	RAM_START + 015h
RM1             		EQU	RAM_START + 016h
RM2             		EQU	RAM_START + 017h
RR1             		EQU	RAM_START + 018h
RR2             		EQU	RAM_START + 019h
_Float           		EQU	RAM_START + 01Ah
_HAM             		EQU	RAM_START + 01Ch
_ISI             		EQU	RAM_START + 01Eh
_X               		EQU	RAM_START + 020h
_DAK             		EQU	RAM_START + 022h
_GUN             		EQU	RAM_START + 023h
PB01            		EQU	RAM_START + 024h
_SAAT            		EQU	RAM_START + 025h
_SAYAC           		EQU	RAM_START + 026h
_SIGN            		EQU	RAM_START + 027h
_SN              		EQU	RAM_START + 028h
_TEMP            		EQU	RAM_START + 029h
_PORTL           		EQU	 PORTB
_PORTH           		EQU	 PORTA
_TRISL           		EQU	 TRISB
_TRISH           		EQU	 TRISA
_HAM_LOWBYTE     		EQU	_HAM
_HAM_HIGHBYTE    		EQU	_HAM + 001h
#define _Comm_Pin        	_PORTB_0
#define _Busy            	 PB01, 000h
#define _SIGN_BITI       	_HAM_BIT11
#define _SEC             	_PORTA_0
#define _YUKARI          	_PORTA_2
#define _ASAGI           	_PORTA_1
#define _PORTB_0         	 PORTB, 000h
#define _HAM_BIT11       	_HAM + 001h, 003h
#define _PORTA_0         	 PORTA, 000h
#define _PORTA_2         	 PORTA, 002h
#define _PORTA_1         	 PORTA, 001h
#define _INTCON_2        	 INTCON, 002h

; Constants.
_NEGAT_ISI       		EQU	00001h
_Deg             		EQU	000DFh
	INCLUDE	"SAAT-I~1.MAC"
	INCLUDE	"PBPPIC14.LIB"

	MOVE?CB	000h, PORTA
	MOVE?CB	000h, PORTB
	MOVE?CB	0F0h, TRISB
	MOVE?CB	007h, TRISA

	ASM?
 DEVICE pic16F628                      

	ENDASM?


	ASM?
 DEVICE pic16F628, WDT_ON              

	ENDASM?


	ASM?
 DEVICE pic16F628, PWRT_ON             

	ENDASM?


	ASM?
 DEVICE pic16F628, PROTECT_OFF         

	ENDASM?


	ASM?
 DEVICE pic16F628, MCLR_off            

	ENDASM?


	ASM?
 DEVICE pic16F628, XT_OSC

	ENDASM?

	ONINT?LL	_KESME, L00001
	ICALL?L	L00001
	MOVE?CB	085h, OPTION_REG
	ICALL?L	L00001
	MOVE?CB	0A0h, INTCON
	ICALL?L	L00001
	MOVE?CB	000h, TMR0
	ICALL?L	L00001
	MOVE?CB	007h, CMCON
	ICALL?L	L00001
	CLEAR?	
	ICALL?L	L00001
	PAUSE?C	0C8h
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	001h

	LABEL?L	_BASLA	
	ICALL?L	L00001
	GOSUB?L	_EKRAN0
	ICALL?L	L00001
	CMPEQ?TCL	_SEC, 000h, _AYAR
	ICALL?L	L00001
	GOSUB?L	_SENSOROKU
	ICALL?L	L00001
	GOTO?L	_BASLA

	LABEL?L	_EKRAN0	
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	084h
	LCDOUTCOUNT?C	002h
	LCDOUTNUM?B	_SAAT
	LCDOUTDEC?	
	LCDOUT?C	03Ah
	LCDOUTCOUNT?C	002h
	LCDOUTNUM?B	_DAK
	LCDOUTDEC?	
	ICALL?L	L00001
	RETURN?	

	LABEL?L	_AYAR	
	ICALL?L	L00001
	LABEL?L	L00002	
	CMPNE?TCL	_SEC, 000h, L00003
	ICALL?L	L00001
	GOTO?L	L00002
	LABEL?L	L00003	

	LABEL?L	_HOUR	
	ICALL?L	L00001
	GOSUB?L	_EKRAN0
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	084h
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	00Eh
	ICALL?L	L00001
	CMPEQ?TCL	_SEC, 000h, _MINBIR
	ICALL?L	L00001
	CMPNE?TCL	_YUKARI, 000h, L00004
	ICALL?L	L00001
	ADD?BCB	_SAAT, 001h, _SAAT
	ICALL?L	L00001
	CMPNE?BCL	_SAAT, 018h, L00006
	MOVE?CB	000h, _SAAT
	LABEL?L	L00006	
	ICALL?L	L00001
	LABEL?L	L00004	
	ICALL?L	L00001
	CMPNE?TCL	_ASAGI, 000h, L00008
	ICALL?L	L00001
	SUB?BCB	_SAAT, 001h, _SAAT
	ICALL?L	L00001
	CMPNE?BCL	_SAAT, 0FFh, L00010
	MOVE?CB	017h, _SAAT
	LABEL?L	L00010	
	ICALL?L	L00001
	LABEL?L	L00008	
	ICALL?L	L00001
	GOSUB?L	_GECIKME
	ICALL?L	L00001
	GOTO?L	_HOUR

	LABEL?L	_MINBIR	
	ICALL?L	L00001
	LABEL?L	L00012	
	CMPNE?TCL	_SEC, 000h, L00013
	ICALL?L	L00001
	GOTO?L	L00012
	LABEL?L	L00013	

	LABEL?L	_MINUTE	
	ICALL?L	L00001
	GOSUB?L	_EKRAN0
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	087h
	ICALL?L	L00001
	CMPEQ?TCL	_SEC, 000h, _SECBIR
	ICALL?L	L00001
	CMPNE?TCL	_YUKARI, 000h, L00014
	ICALL?L	L00001
	ADD?BCB	_DAK, 001h, _DAK
	ICALL?L	L00001
	CMPNE?BCL	_DAK, 03Ch, L00016
	MOVE?CB	000h, _DAK
	LABEL?L	L00016	
	ICALL?L	L00001
	LABEL?L	L00014	
	ICALL?L	L00001
	CMPNE?TCL	_ASAGI, 000h, L00018
	ICALL?L	L00001
	SUB?BCB	_DAK, 001h, _DAK
	ICALL?L	L00001
	CMPNE?BCL	_DAK, 0FFh, L00020
	MOVE?CB	03Bh, _DAK
	LABEL?L	L00020	
	ICALL?L	L00001
	LABEL?L	L00018	
	ICALL?L	L00001
	GOSUB?L	_GECIKME
	ICALL?L	L00001
	GOTO?L	_MINUTE

	LABEL?L	_SECBIR	
	ICALL?L	L00001
	LABEL?L	L00022	
	CMPNE?TCL	_SEC, 000h, L00023
	ICALL?L	L00001
	GOTO?L	L00022
	LABEL?L	L00023	

	LABEL?L	_SECOND	
	ICALL?L	L00001
	GOSUB?L	_EKRAN0
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	08Ah
	ICALL?L	L00001
	CMPEQ?TCL	_SEC, 000h, _ARA
	ICALL?L	L00001
	CMPNE?TCL	_YUKARI, 000h, L00024
	ICALL?L	L00001
	ADD?BCB	_SN, 001h, _SN
	ICALL?L	L00001
	CMPNE?BCL	_SN, 03Ch, L00026
	MOVE?CB	000h, _SN
	LABEL?L	L00026	
	ICALL?L	L00001
	LABEL?L	L00024	
	ICALL?L	L00001
	CMPNE?TCL	_ASAGI, 000h, L00028
	ICALL?L	L00001
	SUB?BCB	_SN, 001h, _SN
	ICALL?L	L00001
	CMPNE?BCL	_SN, 0FFh, L00030
	MOVE?CB	000h, _SN
	LABEL?L	L00030	
	ICALL?L	L00001
	LABEL?L	L00028	
	ICALL?L	L00001
	GOSUB?L	_GECIKME
	ICALL?L	L00001
	GOTO?L	_SECOND

	LABEL?L	_GECIKME	
	ICALL?L	L00001
	MOVE?CW	000h, _X
	LABEL?L	L00032	
	CMPGT?WCL	_X, 00708h, L00033
	ICALL?L	L00001
	PAUSEUS?C	064h
	ICALL?L	L00001
	NEXT?WCL	_X, 001h, L00032
	LABEL?L	L00033	
	ICALL?L	L00001
	RETURN?	

	LABEL?L	_ARA	
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	00Ch
	ICALL?L	L00001
	LABEL?L	L00034	
	CMPNE?TCL	_SEC, 000h, L00035
	ICALL?L	L00001
	GOTO?L	L00034
	LABEL?L	L00035	
	ICALL?L	L00001
	GOTO?L	_BASLA

	LABEL?L	_SENSOROKU	
	ICALL?L	L00001
	OWPIN?T	_Comm_Pin
	OWMODE?C	001h
	OWOUT?C	0CCh
	OWOUT?C	044h
	OWEND?	

	LABEL?L	_Bekle	
	ICALL?L	L00001
	OWPIN?T	_Comm_Pin
	OWMODE?C	004h
	OWIN?T	_Busy
	OWEND?	
	ICALL?L	L00001
	CMPEQ?TCL	_Busy, 000h, _Bekle
	ICALL?L	L00001
	OWPIN?T	_Comm_Pin
	OWMODE?C	001h
	OWOUT?C	0CCh
	OWOUT?C	0BEh
	OWEND?	
	ICALL?L	L00001
	OWPIN?T	_Comm_Pin
	OWMODE?C	002h
	OWIN?B	_HAM_LOWBYTE
	OWIN?B	_HAM_HIGHBYTE
	OWEND?	
	ICALL?L	L00001
	GOSUB?L	_Hesapla
	ICALL?L	L00001
	RETURN?	

	LABEL?L	_Hesapla	
	ICALL?L	L00001
	MOVE?CB	02Bh, _SIGN
	ICALL?L	L00001
	CMPNE?TCL	_SIGN_BITI, _NEGAT_ISI, L00036
	ICALL?L	L00001
	MOVE?CB	02Dh, _SIGN
	ICALL?L	L00001
	SUB?CWW	0FFFFh, _HAM, T1
	ADD?WCW	T1, 001h, T1
	MUL?WCB	T1, 00271h, _TEMP
	ICALL?L	L00001
	DIV32?CW	00Ah, _ISI
	ICALL?L	L00001
	GOTO?L	_GEC
	ICALL?L	L00001
	LABEL?L	L00036	
	ICALL?L	L00001
	ADD?WCW	_HAM, 001h, T1
	MUL?CWB	00271h, T1, _TEMP
	ICALL?L	L00001
	DIV32?CW	00Ah, _ISI

	LABEL?L	_GEC	
	ICALL?L	L00001
	MOD?WCW	_ISI, 003E8h, T1
	DIV?WCW	T1, 064h, _Float
	ICALL?L	L00001
	DIV?WCW	_ISI, 003E8h, _ISI
	ICALL?L	L00001
	LCDOUT?C	0FEh
	LCDOUT?C	0C4h
	LCDOUT?B	_SIGN
	LCDOUTCOUNT?C	000h
	LCDOUTNUM?W	_ISI
	LCDOUTDEC?	
	LCDOUT?C	02Eh
	LCDOUTCOUNT?C	001h
	LCDOUTNUM?W	_Float
	LCDOUTDEC?	
	LCDOUT?C	020h
	LCDOUT?C	_Deg
	LCDOUT?C	043h
	LCDOUT?C	020h
	ICALL?L	L00001
	RETURN?	
	DISABLE?	

	LABEL?L	_KESME	
	ADD?BCB	_SAYAC, 001h, _SAYAC
	CMPNE?BCL	_SAYAC, 03Dh, L00038
	MOVE?CB	000h, _SAYAC
	ADD?BCB	_SN, 001h, _SN
	TOGGLE?T	_PORTB_0
	CMPNE?BCL	_SN, 03Ch, L00040
	MOVE?CB	000h, _SN
	ADD?BCB	_DAK, 001h, _DAK
	CMPNE?BCL	_DAK, 03Ch, L00042
	MOVE?CB	000h, _DAK
	ADD?BCB	_SAAT, 001h, _SAAT
	CMPNE?BCL	_SAAT, 018h, L00044
	MOVE?CB	000h, _SAAT
	LABEL?L	L00044	
	LABEL?L	L00042	
	LABEL?L	L00040	
	LCDOUT?C	0FEh
	LCDOUT?C	089h
	LCDOUT?C	03Ah
	LCDOUTCOUNT?C	002h
	LCDOUTNUM?B	_SN
	LCDOUTDEC?	
	LABEL?L	L00038	

	LABEL?L	_CIK	
	MOVE?CT	000h, _INTCON_2
	RESUME?	
	ENABLE?	
	ICALL?L	L00001
	END?	

	END