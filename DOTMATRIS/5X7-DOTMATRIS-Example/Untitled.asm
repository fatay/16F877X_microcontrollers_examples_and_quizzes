#INCLUDE <P16F877A.INC>
SAYI EQU 0X20
SAYI1 EQU 0X21
SAYAC EQU 0X22
SAYAC1 EQU 0X23
	ORG 0X00
	GOTO MAIN
	ORG 0X05
MAIN
	BANKSEL ADCON1
	MOVLW D'6'
	MOVWF ADCON1
	BANKSEL TRISB
	MOVLW D'15'
	MOVWF TRISA
	CLRF TRISB
	CLRF TRISD
	CLRF TRISC
	BANKSEL PORTB
	CLRF PORTB
	CLRF PORTA
	CLRF PORTD
	CLRF PORTC
ISLE
	BSF PORTC,5
	MOVLW B'11110111'
	MOVWF PORTD
	GOTO ISLE
GECIKME
	MOVLW D'25'
	MOVWF SAYAC
GECIKME1
	MOVLW D'25'
	MOVWF SAYAC1
GECIKTIR
	DECFSZ SAYAC1,F
	GOTO GECIKTIR
	DECFSZ SAYAC,F
	GOTO GECIKME1
	RETURN
 END