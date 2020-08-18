 int adc;
void frequencia();
void duty();

void interrupt(){

    if(TMR2IF_bit){

     PORTC.RC2 = ~PORTC.RC2;
     CCPR1L=adc;
      TMR2IF_bit = 0x00;
    }
}

void main() {

    GIE_bit = 0x01;
    PEIE_bit = 0x01;
    TMR2IE_bit = 0x01;

    //Configuracoes  do Timer 2

    T2CON = 0b00010110;  //postscale 1:3 prescale 1:16
    CMCON =0X07;
    CCPR1L = 0X00;
    CCP1CON = 0X0C;

    TRISC = 0b11111011;
    //PORTC = 0x00;

    ADCON0=0X01;
    ADCON1=0b00001101;
    TRISA=0XFF;


    while(1)
    {
    frequencia();
     adc = ADC_Read(1)/5;
    //duty();
    }
}

void frequencia(){
PR2=34 + ADC_Read(0)*0.78;

}

