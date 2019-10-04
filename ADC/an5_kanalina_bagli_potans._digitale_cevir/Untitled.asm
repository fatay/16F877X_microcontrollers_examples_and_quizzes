#INCLUDE <P16F877A.INC>

SAYAC1 EQU 0X20
SAYAC2 EQU 0X21
SAYAC3 EQU 0X22
	ORG 0X00
MAIN
	BANKSEL TRISE
	MOVLW B'111'
	MOVWF TRISE
	CLRF TRISB
	CLRF TRISC
	BANKSEL PORTB
	CLRF PORTB
	CLRF PORTC
	CLRF PORTE
	MOVLW B'10000000'
	MOVWF ADCON1
	BANKSEL ADCON0
	MOVLW B'11101001' ;RE0/AN5 KANALI SE��LD�
	MOVWF ADCON0
	CALL GECIKME

DONUSTUR
	BANKSEL ADCON0
	BSF ADCON0,GO ;DONUSUME BASLA
	CALL GECIKME
KONTROL
	BTFSC ADCON0,GO
	GOTO KONTROL
YAZ
	BANKSEL ADRESH
	MOVFW ADRESH
	BANKSEL PORTC
	MOVWF PORTC
	BANKSEL ADRESL
	MOVFW ADRESL
	BANKSEL PORTB
	MOVWF PORTB
	GOTO DONUSTUR
GECIKME
	MOVLW D'255'
	MOVWF SAYAC1
GECIKME1
	MOVLW D'255'
	MOVWF SAYAC2
GECIKTIR
	DECFSZ SAYAC2,F
	GOTO GECIKTIR
	DECFSZ SAYAC1,F
	GOTO GECIKME1
	RETURN
	END