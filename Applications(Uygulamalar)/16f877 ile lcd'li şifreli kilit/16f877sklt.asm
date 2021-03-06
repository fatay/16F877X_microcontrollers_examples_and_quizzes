	LIST P=16F877
	INCLUDE "P16F877.INC"
	__CONFIG _CP_OFF &_WDT_OFF &_PWRTE_ON &_HS_OSC &_BODEN_OFF &_LVP_OFF &_CPD_OFF &_WRT_ENABLE_OFF 
KOD1	EQU	H'0020'
KOD2	EQU	H'0021'
KOD3	EQU	H'0022'
KOD4	EQU	H'0023'
KOD5	EQU	H'0024'
KOD6	EQU	H'0025'
KOD7	EQU	H'0026'
KOD8	EQU	H'0027'
KOD9	EQU	H'0028'	
KOD10	EQU	H'0029'	
MSB	EQU	H'002A'
KONT	EQU	H'002B'
SAYAC	EQU	H'002C'
BINKOD	EQU	H'002D'
YAZKOD	EQU	H'002E'
SAYI	EQU	H'002F'
LSB	EQU	H'0030'
SAYAC2	EQU	H'0031'
SAYAC3	EQU	H'0032'
SONUC	EQU	H'0033'
SAYAC4	EQU	H'0034'
SAYAC1	EQU	H'0035'
EADRES	EQU	H'0036'
SAYAC5	EQU	H'0037'
	ORG 	H'0000'
	GOTO 	BASLA
BASLA
	BCF	STATUS,6
	BSF	STATUS,5
	CLRF	TRISB
	CLRF	TRISC
	CLRF	TRISD
	MOVLW	H'FF'
	MOVWF	TRISA
	MOVLW	H'06'
	MOVWF	ADCON1
	BCF	STATUS,5
	CLRF	PORTB
	CLRF	PORTC
	CLRF	PORTD
	CLRF	SAYI
	MOVLW	.150
	MOVWF	KOD1
	MOVWF	KOD2
	MOVWF	KOD3
	MOVWF	KOD4
	MOVWF	KOD5
	MOVWF	KOD6
	MOVWF	KOD7
	MOVWF	KOD8
	MOVWF	KOD9
	MOVWF	KOD10
	CLRF	KONT
	CLRF	BINKOD
	CLRF	YAZKOD
	CLRF	SAYAC
	CLRF	SAYAC1
	CLRF	SAYAC2
	CLRF	SAYAC3
	CLRF	SAYAC4
	CLRF	SONUC
	CLRF	MSB
	CLRF	LSB
	CALL	TEMIZLE
	GOTO	KONTROL
;*************************
COKBEKLE
	MOVLW	.15
	MOVWF	SAYAC5
CBDL
	MOVLW	.255
	MOVWF	LSB
DL_111
	MOVLW .255
	MOVWF MSB
DL_222	
	DECFSZ  MSB,F
	GOTO DL_222
	DECFSZ  LSB,F
	GOTO DL_111
DL_333
	DECFSZ  SAYAC5,F
	GOTO CBDL
	RETURN
;-------------------------
BEKLE
	MOVLW 	.255
	MOVWF LSB
	MOVLW	.255
	MOVWF	SAYAC5
DL1
	MOVLW .255
	MOVWF MSB
DL2	
	DECFSZ  MSB,F
	GOTO DL2
	DECFSZ  LSB,F
	GOTO DL1
DL3
	DECFSZ  SAYAC5,F
	GOTO DL3
	RETURN	
;************************* 
KONTROL
	MOVLW	.0
	MOVWF	EADRES
	CALL	EEOKU
	MOVWF	MSB
	MOVLW	.255    ;H'FF'
	SUBWF	MSB,W       
	BTFSS	STATUS,Z
	GOTO	KONTROL2   
	GOTO	YENI	  ;yaz�lmam��sa yeni yaz
;---------------------------
KONTROL2
	MOVLW	.0    
	SUBWF	MSB,W       
	BTFSS	STATUS,Z
	GOTO	ANA	;�ifre yaz�lm��sa ana programa git 
	GOTO	YENI	;yaz�lmam��sa yeni yaz
;**************************
YENI
	CLRF	PORTB
	CLRF	MSB
	CLRF	KONT
	BSF	PORTB,7
	CALL	TEMIZLE
	CALL	GIRYAZI
	CALL	SATIR2
	MOVLW 	H'F'
	CALL 	KOMUTYAZ
;----------------------------------
TARA1
	CALL	BUTARA		;butonlar� tara
	MOVLW	.1
	SUBWF	SAYI,W 		
	BTFSS	STATUS,C	;butondan de�er girilmemi�se 
	GOTO	TARA1		;tekrar tara
	CALL	IMLEC		;Say�y� lcd g�ster
	MOVLW	.0		;de�er girilmi�se eeprom "0"a yaz
	MOVWF EADRES
	CALL EEYAZ
	MOVLW	.1
	MOVWF	KONT	;kontura 1basamak y�kle
	GOTO	TARA2
;---------------------
TARA2
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA2
	CALL	IMLEC
	MOVLW	.1
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.2
	MOVWF	KONT
	GOTO	TARA3
;-------------------------
TARA3
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA3
	CALL	IMLEC
	MOVLW	.2
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.3
	MOVWF	KONT
	GOTO	TARA4
;------------------------
TARA4
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA4
	CALL	IMLEC
	MOVLW	.3
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.4
	MOVWF	KONT
	GOTO	TARA5
;--------------------------
TARA5
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA5
	CALL	IMLEC
	MOVLW	.4
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.5
	MOVWF	KONT
	GOTO	TARA6
;---------------------
TARA6
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA6
	CALL	IMLEC
	MOVLW	.5
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.6
	MOVWF	KONT
	GOTO	TARA7
;-------------------------
TARA7
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA7
	CALL	IMLEC
	MOVLW	.6
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.7
	MOVWF	KONT
	GOTO	TARA8
;------------------------
TARA8
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA8
	CALL	IMLEC
	MOVLW	.7
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.8
	MOVWF	KONT
	GOTO	TARA9
;--------------------------
TARA9
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA9
	CALL	IMLEC
	MOVLW	.8
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.9
	MOVWF	KONT
	GOTO	TARA10
;--------------------------
TARA10
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA10
	CALL	IMLEC
	MOVLW	.9
	MOVWF EADRES
	CALL EEYAZ
	CLRF	KONT
	MOVLW	.10
	MOVWF	KONT
TEKRAR
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	ANA1
	GOTO	TEKRAR
;---------------------------
ANA1
	CALL	TEMIZLE
	MOVF	KONT,W	  ;konturu eeprom11e yaz
	MOVWF	SAYI
	MOVLW	.11
	MOVWF EADRES
	CALL EEYAZ
	CALL	SDEGISTI
	CALL	COKBEKLE
	CALL	TEMIZLE
	GOTO	ANA
;*****************************
ANA
	CALL	TEMIZLE
ANA_LCD
	CALL	AEKRANI
ANA_DNG	
	MOVLW	B'00001100'
	MOVWF	PORTB	
	BTFSS	PORTA,3	  ;"*" � test et
	GOTO	GIRIS
	BTFSS	PORTA,4
	GOTO	FORMATLA
	GOTO	ANA_DNG
;*****************************
FORMATLA
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	BSF	PORTB,1
	BCF	PORTB,2
	BTFSC	PORTA,1 ;5 Rakam�
	GOTO	ANA
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	BSF	PORTB,2
	BCF	PORTB,1
	BTFSS	PORTA,4
	GOTO	KODGIR
	GOTO	ANA
;*********************************************
KODGIR
	MOVLW	B'01101110'
	MOVWF	PORTB
	CALL	ZAMAN_0
KILIT
	CLRF	YAZKOD
;---------------------------
BYD
	MOVLW	.3
	SUBWF	SAYAC4,W
	BTFSS	STATUS,Z
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,2
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,0	;"1"rakam�
	GOTO	ARTTIR
	BSF	PORTB,1
DEVAM
	BSF	PORTB,1	
	BCF	PORTB,2
	BTFSS	PORTA,3	;"0"rakam�
	GOTO	AZALT
	BSF	PORTB,2
DEVAM2
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	TESTET
	BSF	PORTB,3
	GOTO	BYD
;---------------------------
TESTET
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,3	
	GOTO	TESTET
	MOVLW	.45
	SUBWF	YAZKOD,W
	BTFSS	STATUS,Z
	GOTO	KILIT
	GOTO	BYDZ_0
;---------------------------
BYDZ_0
	CALL	ZAMAN_0
BYD2
	MOVLW	.3
	SUBWF	SAYAC4,W
	BTFSS	STATUS,Z
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,2
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,0	;"1"rakam�
	GOTO	ARTTIR2
	BSF	PORTB,1
DEVAM3
	BSF	PORTB,1
	BCF	PORTB,2
	BTFSS	PORTA,3	;"0"rakam�
	GOTO	AZALT2
	BSF	PORTB,2
DEVAM4
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3	;"#"onayla
	GOTO	TEST2
	BSF	PORTB,3
	GOTO	BYD2
;---------------------------
TEST2
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,3
	GOTO	TEST2
	MOVLW	.35
	SUBWF	YAZKOD,W
	BTFSS	STATUS,Z
	GOTO	KILIT	
	BSF	PORTB,3
	GOTO	YENI
;---------------------------
ANADON
	CALL	BEKLE
	BTFSS	PORTA,3
	GOTO	ANADON
	GOTO	ANA
;****************************************************
ARTTIR
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,0
	GOTO	ARTTIR
	INCF	YAZKOD,F
	GOTO	DEVAM
;---------------------------
AZALT
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,3
	GOTO	AZALT
	DECF	YAZKOD,F
	GOTO	DEVAM2
;***************************
ARTTIR2
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,0
	GOTO	ARTTIR2
	INCF	YAZKOD,F
	GOTO	DEVAM3
;---------------------------
AZALT2
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BTFSS	PORTA,3
	GOTO	AZALT2
	DECF	YAZKOD,F
	GOTO	DEVAM4	  
;*****************************
GIRIS
	BSF	PORTB,6
	CALL	TEMIZLE
	BTFSS	PORTA,3
	GOTO	GIRIS
;----------------------
	CALL	EKRANAYAZ
	CALL	SATIR2
	MOVLW 	H'F'
	CALL 	KOMUTYAZ
;----------------------
	CLRF	KONT
	MOVLW	.11
	MOVWF	EADRES
	CALL	EEOKU    
	MOVWF	KONT
	CALL	ZAMAN_0
	GOTO	TARA11
;----------------------
TARA11
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C	;butondan de�er girilmemi�se 
	GOTO	TARA11		;tekrar tara
	CALL	IMLEC
	MOVF	SAYI,W		;girilmi�se
	MOVWF	KOD1		;kod1'e yaz
	MOVLW	.1
	SUBWF	KONT,W
	BTFSS	STATUS,C	;basamak say�s�n� test et
	CALL	SIFIRSAYI	;fazla yaz�ld�ysa s�f�rla
	CALL	ZAMAN_0		;eksikse di�erinin yaz�lmas�na izin ver
TARA22
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA22
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD2
	MOVLW	.2
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA33
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA33
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD3
	MOVLW	.3
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA44
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA44
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD4
	MOVLW	.4
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA55
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA55
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD5
	MOVLW	.5
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA66
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA66
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD6
	MOVLW	.6
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA77
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA77
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD7
	MOVLW	.7
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA88
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA88
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD8
	MOVLW	.8
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA99
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA99
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD9
	MOVLW	.9
	SUBWF	KONT,W
	BTFSS	STATUS,C
	CALL	SIFIRSAYI
	CALL	ZAMAN_0
TARA00
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	BSF	PORTB,1
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	TARA00
	CALL	IMLEC
	MOVF	SAYI,W
	MOVWF	KOD10
	MOVLW	.10
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	CALL	SIFIRSAYI	
	GOTO	ONAY1
;*************************
ONAY1
	CALL	ZAMAN_0
ONAY
	CALL	ZAMANSAY
	MOVLW	.255
	SUBWF	SONUC,W
	BTFSC	STATUS,Z
	GOTO	ANA
	BSF	PORTB,6
	BSF	PORTB,1
	BSF	PORTB,2
	BCF	PORTB,3
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BSF	PORTB,3
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	CALL	BUTARA
	MOVLW	.1
	SUBWF	SAYI,W 
	BTFSS	STATUS,C
	GOTO	ONAY
	CALL	IMLEC
	CALL	SIFIRSAYI
	GOTO	ONAY
;**************************
SIFIRLA
	MOVLW	.150
	MOVWF	KOD1
	MOVWF	KOD2
	MOVWF	KOD3
	MOVWF	KOD4
	MOVWF	KOD5
	MOVWF	KOD6
	MOVWF	KOD7
	MOVWF	KOD8
	MOVWF	KOD9
	MOVWF	KOD10
	GOTO	ONAY1
;**************************
SIFIRSAYI
	MOVLW	.150
	MOVWF	KOD1
	MOVWF	KOD2
	MOVWF	KOD3
	MOVWF	KOD4
	MOVWF	KOD5
	MOVWF	KOD6
	MOVWF	KOD7
	MOVWF	KOD8
	MOVWF	KOD9
	MOVWF	KOD10
	RETURN
;*************************
VAZGEC
	BCF	PORTB,6
	BSF	PORTB,1
	BSF	PORTB,2
	BSF	PORTB,3
	BCF	PORTB,0 
	CALL	TEMIZLE
VAZGEC_1
	CALL	REKLAM
	CALL	COKBEKLE
VAZGEC_2
	BCF	PORTB,6
	BSF	PORTB,1
	BSF	PORTB,2
	BSF	PORTB,3
	BCF	PORTB,0  
	BTFSS	PORTA,3
	GOTO	VAZGEC_2
KLT0
	MOVLW	.150
	MOVWF	KOD1
	MOVWF	KOD2
	MOVWF	KOD3
	MOVWF	KOD4
	MOVWF	KOD5
	MOVWF	KOD6
	MOVWF	KOD7
	MOVWF	KOD8
	MOVWF	KOD9
	MOVWF	KOD10
	BCF	PORTB,0   ;kontrol ��k���n� 0 yap   
	BSF	PORTB,4	  ;kilit uyar�s� verme
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	BEKLE
	CALL	TEMIZLE
	BCF	PORTB,4	  ;kilit uyar�s� verme
	GOTO	ANA
;***************************
INCELE
	BTFSS	PORTA,3   ; "#"i test et
	GOTO	INCELE
	BCF	PORTB,6
;-------------------------1
INC1
	MOVLW	.0
	MOVWF	EADRES
	CALL	EEOKU	   
	SUBWF	KOD1,W     ;kod1'le girilen say�y� kar��la�t�r  
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.1
	SUBWF	KONT,W	    ;Girilen basamak say�s� kadar incele
	BTFSS	STATUS,Z
	GOTO	INC2
	GOTO	SDOGRU			   
;------------------------2
INC2  
	MOVLW	.1
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD2,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.2
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC3
	GOTO	SDOGRU	
;-------------------------3
INC3
	MOVLW	.2
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD3,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.3
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC4
	GOTO	SDOGRU	
;-------------------------4
INC4
	MOVLW	.3
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD4,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.4
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC5
	GOTO	SDOGRU	
;-------------------------5
INC5
	MOVLW	.4
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD5,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.5
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC6
	GOTO	SDOGRU	
;;-------------------------6
INC6
	MOVLW	.5
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD6,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.6
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC7
	GOTO	SDOGRU	
;-------------------------7
INC7
	MOVLW	.6
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD7,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.7
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC8
	GOTO	SDOGRU	
;-------------------------8
INC8
	MOVLW	.7
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD8,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.8
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC9
	GOTO	SDOGRU	
;-------------------------9
INC9
	MOVLW	.8
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD9,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	MOVLW	.9
	SUBWF	KONT,W
	BTFSS	STATUS,Z
	GOTO	INC10
	GOTO	SDOGRU	
;-------------------------10
INC10
	MOVLW	.9
	MOVWF	EADRES
	CALL	EEOKU
	SUBWF	KOD10,W       
	BTFSS	STATUS,Z
	GOTO	HATALI
	GOTO	SDOGRU	;hepsi do�ruysa
;**************************
SDOGRU
	CALL	TEMIZLE
SDOGRU_1
	CALL	DOGRUUU
SDOGRU_2	
	CLRF	SAYAC4
	BCF	PORTB,6	 ;�ifreyi yaz uyar�s� ledi s�nd�r
	BSF	PORTB,0  ; ��k�� [1]
	BTFSS	PORTA,4	  ;�ifre de�i� butonu test et
	GOTO	YENI	  ;bas�lm��sa yeni yaz
	BSF	PORTB,3
	BSF	PORTB,2
	BCF	PORTB,1
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	CALL	BEKLE
	CALL	BEKLE
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	CALL	BEKLE
	CALL	BEKLE
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	CALL	BEKLE
	CALL	BEKLE
	BTFSS	PORTA,3   ; "*"� test et
	GOTO	VAZGEC
	CALL	BEKLE
	CALL	BEKLE
	BTFSS	PORTA,5
	GOTO	VAZGEC
	GOTO	SDOGRU_2	
;***************************
HATALI
	CALL	TEMIZLE
	CALL	HATAAA
	BCF	PORTB,6
	BSF	PORTB,5  ;hata ikaz�
	CALL	COKBEKLE
	INCF	SAYAC4,F
	MOVLW	.3
	SUBWF	SAYAC4,W
	BTFSC	STATUS,Z
	GOTO	KLTLCD
	BSF	PORTB,5
	GOTO	VAZGEC
;****************************
KLTLCD
	CALL	TEMIZLE
KLTLCD_1
	CALL	KLTLENDI
	CALL	SATIR2
	CALL	PUKKODU
	CALL	SATIR1
	GOTO	KILIT
ZAMAN_0
	CLRF	SAYAC
	CLRF	SAYAC2
	MOVLW	.200
	MOVWF	SAYAC3
	CLRF	SONUC
	RETURN
ZAMANSAY
	MOVLW	.1
	ADDWF	SAYAC,F
	BTFSS	STATUS,C
	RETURN
	CLRF	SAYAC
	MOVLW	.1
	ADDWF	SAYAC2,F
	BTFSS	STATUS,C
	RETURN	
	CLRF	SAYAC2
	MOVLW	.1
	ADDWF	SAYAC3,F
	BTFSS	STATUS,C
	RETURN
	MOVLW	.255
	MOVWF	SONUC
	RETURN
;******************************************************
EEOKU
	MOVF	EADRES,W 		;
	BSF	STATUS,RP1 		;
	BCF	STATUS,RP0 		;Bank 2
	MOVWF	EEADR 			;
	BSF	STATUS,RP0 		;Bank 3
	BCF	EECON1,EEPGD 		;
	BSF	EECON1,RD 		;
	BCF	STATUS,RP0 		;Bank 2
	MOVF	EEDATA,W 		;
	BCF	STATUS,RP1		;
	BCF	STATUS,RP0		;Bank 0
	RETURN
;******************************************************
EEYAZ
	MOVF	EADRES,W 		;
	BSF	STATUS,RP1 		;
	BCF	STATUS,RP0 		;Bank 2
	MOVWF	EEADR 			;
	BCF	STATUS,RP1		;
	BCF	STATUS,RP0		;Bank 0
	MOVF	SAYI,W			;
	BSF	STATUS,RP1 		;
	BCF	STATUS,RP0 		;Bank 2
	MOVWF	EEDATA 			;
	BSF	STATUS,RP0 		;Bank 3
	BCF	EECON1,EEPGD 		;
	BSF	EECON1,WREN 		;
	BCF	INTCON,GIE 		;
	MOVLW	0x55 			;
	MOVWF	EECON2 			;
	MOVLW	0xAA 			;
	MOVWF	EECON2 			;
	BSF	EECON1,WR 		;
	BSF	INTCON,GIE 		;
	BCF	EECON1,WREN 		;
	BTFSC	EECON1,WR 		;
	GOTO	EEYAZSON 		;
	GOTO	EEYAZ
EEYAZSON
	BCF	STATUS,RP1 		;
	BCF	STATUS,RP0		;Bank 0
	RETURN
;*******************************************************
BUTARA	
	BSF	PORTB,1
	BSF	PORTB,2
	BSF	PORTB,3
	CLRF	SAYI
;-----------------------
	BCF	PORTB,1	   ; 1.s�ton aktif
;-----------------------
	BTFSC	PORTA,0	   ; "1"rakam�n� test et
	GOTO	T1
DO1
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,0
	GOTO	DO1
	BCF	PORTB,4
	MOVLW	.1
	MOVWF	SAYI
	BSF	PORTB,1	 
	RETURN
T1	
	BTFSC	PORTA,1	   ; "4"rakam�n� test et
	GOTO	T2
DO2
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,1
	GOTO	DO2
	BCF	PORTB,4
	MOVLW	.4
	MOVWF	SAYI
	BSF	PORTB,1
	RETURN
T2	
	BTFSC	PORTA,2	   ; "7"rakam�n� test et
	GOTO	BUTARA2
DO3
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,2
	GOTO	DO3
	BCF	PORTB,4
	MOVLW	.7
	MOVWF	SAYI
	BSF	PORTB,1 
	RETURN
BUTARA2
	BSF	PORTB,1    ; 1.s�ton pasif
;------------------------
	BCF	PORTB,2    ; 2.s�ton aktif
;------------------------
	BTFSC	PORTA,0	   ; "2"rakam�n� test et
	GOTO	T11
DO4
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,0
	GOTO	DO4
	BCF	PORTB,4
	MOVLW	.2
	MOVWF	SAYI
	BSF	PORTB,2
	RETURN
T11	
	BTFSC	PORTA,1	   ; "5"rakam�n� test et
	GOTO	T22
DO5
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,1
	GOTO	DO5
	BCF	PORTB,4
	MOVLW	.5
	MOVWF	SAYI
	BSF	PORTB,2
	RETURN
T22	
	BTFSC	PORTA,2	   ; "8"rakam�n� test et
	GOTO	T33
DO6
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,2
	GOTO	DO6
	BCF	PORTB,4
	MOVLW	.8
	MOVWF	SAYI
	BSF	PORTB,2
	RETURN
T33	
	BTFSC	PORTA,3	   ; "0"rakam�n� test et
	GOTO	BUTARA3
DO7
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4	
	BTFSS	PORTA,3
	GOTO	DO7
	BCF	PORTB,4
	MOVLW	.10
	MOVWF	SAYI
	BSF	PORTB,2
	RETURN
BUTARA3
	BSF	PORTB,2
;-------------------------
	BCF	PORTB,3    ;3.s�ton aktif
;-------------------------
	BTFSC	PORTA,0
	GOTO	T111
DO8
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,0	   ; "3"rakam�n� test et
	GOTO	DO8
	BCF	PORTB,4
	MOVLW	.3
	MOVWF	SAYI
	BSF	PORTB,3
	RETURN
T111	
	BTFSC	PORTA,1	   ; "6"rakam�n� test et
	GOTO	T222
DO9
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,1
	GOTO	DO9
	BCF	PORTB,4
	MOVLW	.6
	MOVWF	SAYI
	BSF	PORTB,3
	RETURN
T222	
	BTFSC	PORTA,2	   ; "9"rakam�n� test et
	GOTO	TSON
DO10
	CALL	BEKLE	;kontak s��ramas�n� �nle
	BSF	PORTB,4
	BTFSS	PORTA,2
	GOTO	DO10
	BCF	PORTB,4
	MOVLW	.9
	MOVWF	SAYI
	BSF	PORTB,3
	RETURN
TSON
	BSF	PORTB,3
	BSF	PORTB,2
	BSF	PORTB,1
	CLRF	SAYI
	RETURN
;**********************************************************************************************************************
SATIR2
	MOVLW	H'C0'
	CALL	KOMUTYAZ
	RETURN
SATIR1
	MOVLW	H'80'
	CALL	KOMUTYAZ
	RETURN
IMLEC
	MOVLW	A'*'
	CALL	VERIYAZ
	RETURN
VERIYAZ
	BSF	PORTC,1
	MOVWF	PORTD
	BCF	PORTC,0
	CALL	GECIKME
	BSF	PORTC,0
	RETURN
TEMIZLE
	MOVLW	H'0C'
	CALL	KOMUTYAZ
	MOVLW	H'01'
	CALL	KOMUTYAZ
	MOVLW	H'38'
	CALL	KOMUTYAZ
	MOVLW	H'0C'
	CALL	KOMUTYAZ
	RETURN
KOMUTYAZ
	BCF	PORTC,1
	MOVWF	PORTD
	BCF	PORTC,0
	CALL	GECIKME
	BSF	PORTC,0
	RETURN
EKRANAYAZ
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A'Y'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'G'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'Z'
	CALL	VERIYAZ
	RETURN
DOGRUUU
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'O'
	CALL	VERIYAZ
	MOVLW	A'G'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'U'
	CALL	VERIYAZ
	RETURN
HATAAA
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'Y'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A'L'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'!'
	CALL	VERIYAZ
	RETURN
GIRYAZI
	MOVLW	A'Y'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'Y'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'G'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	RETURN
REKLAM
	MOVLW	A'W'
	CALL	VERIYAZ
	MOVLW	A'W'
	CALL	VERIYAZ
	MOVLW	A'W'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'P'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'O'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'H'
	CALL	VERIYAZ
	MOVLW	A'M'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A'T'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'C'
	CALL	VERIYAZ
	MOVLW	A'O'
	CALL	VERIYAZ
	MOVLW	A'M'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'T'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'.'
	CALL	VERIYAZ
	MOVLW	A'T'
	CALL	VERIYAZ
	MOVLW	A'C'
	CALL	VERIYAZ
	RETURN
AEKRANI
	MOVLW	A'G'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'C'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'*'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'B'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'S'
	CALL	VERIYAZ
	RETURN
SDEGISTI
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'K'
	CALL	VERIYAZ
	MOVLW	A'A'
	CALL	VERIYAZ
	MOVLW	A'Y'
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'L'
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	RETURN
PUKKODU
	MOVLW	A'P'
	CALL	VERIYAZ
	MOVLW	A'U'
	CALL	VERIYAZ
	MOVLW	A'K'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'K'
	CALL	VERIYAZ
	MOVLW	A'O'
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'U'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A'U'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'G'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	RETURN
KLTLENDI
	MOVLW	A'S'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'F'
	CALL	VERIYAZ
	MOVLW	A'R'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A' '
	CALL	VERIYAZ
	MOVLW	A'K'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'L'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	MOVLW	A'T'
	CALL	VERIYAZ
	MOVLW	A'L'
	CALL	VERIYAZ
	MOVLW	A'E'
	CALL	VERIYAZ
	MOVLW	A'N'
	CALL	VERIYAZ
	MOVLW	A'D'
	CALL	VERIYAZ
	MOVLW	A'I'
	CALL	VERIYAZ
	RETURN
GECIKME
	MOVLW	H'F'
	MOVWF	SAYAC1
DON1
	MOVLW	H'FF'
	MOVWF	SAYAC2
DON2
	DECFSZ	SAYAC2,F
	GOTO	DON2
	DECFSZ	SAYAC1,F
	GOTO	DON1
	RETURN

	END
	 
