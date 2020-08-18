void interrupt(){

    if(TMR2IF_bit){
    
     PORTB = ~PORTB;
     TMR2IF_bit = 0x00;
    }
}

void main() {
    GIE_bit = 0x01;
    PEIE_bit = 0x01;
    TMR2IE_bit = 0x01;

    //Configuracoes  do Timer 2
    
    T2CON = 0b00010110;  //postscale 1:3 prescale 1:16
    PR2 = 26;
    //CCPR1L = 0X00;
    //CCP1CON = 0X0C;

    TRISB = 0x00;      // Saida RB3 definida como saída
    PORTB = 0x00;    // RB3 inicia em LOW

    while(1);
}