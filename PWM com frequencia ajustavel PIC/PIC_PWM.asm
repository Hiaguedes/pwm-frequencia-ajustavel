
_interrupt:

;PIC_PWM.c,5 :: 		void interrupt(){
;PIC_PWM.c,7 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
	GOTO        L_interrupt0
;PIC_PWM.c,9 :: 		PORTC.RC2 = ~PORTC.RC2;
	BTG         PORTC+0, 2 
;PIC_PWM.c,10 :: 		CCPR1L=adc;
	MOVF        _adc+0, 0 
	MOVWF       CCPR1L+0 
;PIC_PWM.c,11 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
;PIC_PWM.c,12 :: 		}
L_interrupt0:
;PIC_PWM.c,13 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;PIC_PWM.c,15 :: 		void main() {
;PIC_PWM.c,17 :: 		GIE_bit = 0x01;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;PIC_PWM.c,18 :: 		PEIE_bit = 0x01;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;PIC_PWM.c,19 :: 		TMR2IE_bit = 0x01;
	BSF         TMR2IE_bit+0, BitPos(TMR2IE_bit+0) 
;PIC_PWM.c,23 :: 		T2CON = 0b00010110;  //postscale 1:3 prescale 1:16
	MOVLW       22
	MOVWF       T2CON+0 
;PIC_PWM.c,24 :: 		CMCON =0X07;
	MOVLW       7
	MOVWF       CMCON+0 
;PIC_PWM.c,25 :: 		CCPR1L = 0X00;
	CLRF        CCPR1L+0 
;PIC_PWM.c,26 :: 		CCP1CON = 0X0C;
	MOVLW       12
	MOVWF       CCP1CON+0 
;PIC_PWM.c,28 :: 		TRISC = 0b11111011;
	MOVLW       251
	MOVWF       TRISC+0 
;PIC_PWM.c,31 :: 		ADCON0=0X01;
	MOVLW       1
	MOVWF       ADCON0+0 
;PIC_PWM.c,32 :: 		ADCON1=0b00001101;
	MOVLW       13
	MOVWF       ADCON1+0 
;PIC_PWM.c,33 :: 		TRISA=0XFF;
	MOVLW       255
	MOVWF       TRISA+0 
;PIC_PWM.c,36 :: 		while(1)
L_main1:
;PIC_PWM.c,38 :: 		frequencia();
	CALL        _frequencia+0, 0
;PIC_PWM.c,39 :: 		adc = ADC_Read(1)/5;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;PIC_PWM.c,41 :: 		}
	GOTO        L_main1
;PIC_PWM.c,42 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_frequencia:

;PIC_PWM.c,44 :: 		void frequencia(){
;PIC_PWM.c,45 :: 		PR2=34 + ADC_Read(0)*0.78;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVLW       20
	MOVWF       R4 
	MOVLW       174
	MOVWF       R5 
	MOVLW       71
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       PR2+0 
;PIC_PWM.c,47 :: 		}
L_end_frequencia:
	RETURN      0
; end of _frequencia
