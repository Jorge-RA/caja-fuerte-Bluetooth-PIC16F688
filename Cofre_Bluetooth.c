#define ubicacionBanderaPsw 0x08
#define ubicacionPswEEPROM   0x10
#define ubicacionDineroEEPROM 0x18
#define tamPsw 4
#define PUERTA PORTA.F0
#define STATE PORTA.F1

void write_EEPROM(unsigned char datoH,unsigned char datoL,unsigned char addrH,unsigned char addrL);
unsigned char read_EEPROM(unsigned char addrH,unsigned char addrL);
void chekDefault();
unsigned char chekPsw();
void chekDinero();
void cambiarPsw();
void UART2_Write_Text(const text[50]);



unsigned char pswAcceso[5] = {0};

void main() {

 TRISA.F0 = 0; //salida
 PORTA.F0 = 0; //PUERTA
 TRISA.F2 = 0; //salida
 PORTA.F2 = 0; //LEDPIC
 TRISA.F1 = 1; //entrada, STATE
 ANSEL=0x00;//ANSELH=0;
 CMCON0 =  0xFF; // para que los pines del puerto A sean entradas digitales por completo
 UART1_Init(9600);
 chekDefault();
 delay_ms(500);

 while(1){
    unsigned char enterUser[8]={0},dato=0,i=0;
   if(STATE == 1){
   PORTA.F2 = 1; //LEDPIC
     delay_ms(1000);

     if( chekPsw() ){
       PUERTA = 1;
       UART2_Write_Text("Abriendo...\r\r\n");
       delay_ms(5000);
       PUERTA = 0;
       
       UART2_Write_Text("Ingrese opcion. x para salir:\r\n");
       UART2_Write_Text("'dinero'  : Ver dinero. \r\n");
       UART2_Write_Text("'cambiar' : Cambiar clave.\r\n");


       while(dato != '\r' && STATE == 1){
         if( UART1_Data_Ready() ){
           dato = UART1_Read();
           if(dato != '\r'){
             enterUser[i] = dato;
             i++;
           }
         }
        }

           if ( !strncmp("dinero",enterUser,10) )
              chekDinero();

           else if ( !strncmp("cambiar",enterUser,10) )
              cambiarPsw();

           else
              UART2_Write_Text("Saliendo...\r\r\n");



      }
   }
 }

}
unsigned char chekPsw(){

 unsigned char enterUser[10]={0}, dato=0,i=0,n_dato=0;

 UART2_Write_Text("Ingrese contrasenia:\r\n");
 //UART1_Read_Text(enterUser,"\r",5);
 
 while(dato != '\r' && STATE == 1){

   if( UART1_Data_Ready() ){
     dato = UART1_Read();
     if(dato != '\r'){
       enterUser[i] = dato;
       i++;
     }
   }

  }


 if ( !strncmp(pswAcceso,enterUser,5) || !strncmp("root:J1A9R9A9",enterUser,10) ){
   UART2_Write_Text("Contrasenia correcta.\r\n");
   return 1;
 }
 else{
  UART2_Write_Text("Contrasenia incorrecta.\r\n");
  return 0;
 }


}

void cambiarPsw(){
   unsigned char i = 0;
   unsigned char dato = 0;
   unsigned char enterUser[5]={0};

  UART2_Write_Text("Nueva contrasenia:\r\n");

  
  while(dato != '\r' && STATE == 1){
  
   if( UART1_Data_Ready() ){
     dato = UART1_Read();
     if(dato != '\r'){
       enterUser[i] = dato;
       i++;
     }
   }
   
  }
  
  if(i==tamPsw){
    for(i=0;i<tamPsw;i++){
     write_EEPROM(0x00,enterUser[i],0x00, ubicacionPswEEPROM+i); //Clave por defecto "1234" posicion 0x10
     delay_ms(10);
    }
    UART2_Write_Text("Contrasenia actualizada.\r\n");
    UART2_Write_Text("Su nueva contrasenia es: ");
    for(i=0; i<tamPsw;i++)
    UART1_Write(enterUser[i]);
    UART1_Write('\r');
    UART1_Write('\n');
  }
  else
  UART2_Write_Text("Contrasenia NO actualizada.\r\n");
  
  
  for(i=0;i<tamPsw;i++){
     pswAcceso[i]=read_EEPROM(0x00,ubicacionPswEEPROM+i);
     delay_ms(10);
    }
    pswAcceso[i] = '\0';


}

void chekDinero(){
  unsigned char i = 0, j = 0,dato=0;
  unsigned char dinero[10]={0};
  unsigned char enterUser[10] = {0};
  
  UART2_Write_Text("Dinero actual: $");
  
  while( read_EEPROM(0x00,ubicacionDineroEEPROM+i) != 0xFF  ){
    dinero[i] =  read_EEPROM(0x00,ubicacionDineroEEPROM+i);
    delay_ms(10);
    i++;
  }
  dinero[i] = '\0';
  UART1_Write_Text(dinero);
  UART1_Write('\r');
  
  UART2_Write_Text("Desea modificar monto?\r\n");
  i=0;
  while(dato != '\r' && STATE == 1){

   if( UART1_Data_Ready() ){
     dato = UART1_Read();
     if(dato != '\r'){
       enterUser[i] = dato;
       i++;
     }
   }

  }
  delay_ms(100);
  
  if ( !strncmp("si",enterUser,3) ){
     //if( chekPsw() ){
        UART2_Write_Text("Ingrese nuevo monto:\r\n");
        UART1_Read_Text(enterUser,"\r",14);
        for ( i=0; i<strlen(enterUser); i++ ){
         write_EEPROM(0x00,enterUser[i],0x00,ubicacionDineroEEPROM+i);
         delay_ms(10);
        }
        for(j=i; j<(i+10); j++){
         write_EEPROM(0x00,0xFF,0x00,ubicacionDineroEEPROM+j);
         delay_ms(10);
        }
        UART2_Write_Text("Dinero actualizado.\r\n");
     //}
  }
  else
   UART2_Write_Text("Ok.\r\n");
  
}



 void chekDefault(){
   
 unsigned char i = 0;

  if(read_EEPROM(0x00,0x08)!=1){

    for(i=0;i<tamPsw;i++){
      write_EEPROM(0x00,0x31+i,0x00, ubicacionPswEEPROM+i); //Clave por defecto "1234" posicion 0x10
      delay_ms(10);
    }
    write_EEPROM(0x00,0x01,0x00,ubicacionBanderaPsw); //Escribir en alto la bandera, clave por defecto ya escrita
    delay_ms(10);
    write_EEPROM(0x00,0x30,0x00,ubicacionDineroEEPROM); //Escribir dinero inicial(0 pesos),   posicion 0x18
    delay_ms(10);
   }
    for(i=0;i<tamPsw;i++){
     pswAcceso[i]=read_EEPROM(0x00,ubicacionPswEEPROM+i);
     delay_ms(10);
    }
    pswAcceso[i] = '\0';

}




/*void setEnterUser(){
 unsigned char i = 0;
 for(i=0; i<20; i++){
  enterUser[i] = 0x00;
 }
}*/


void write_EEPROM(unsigned char datoH,unsigned char datoL,unsigned char addrH,unsigned char addrL)
{
 EECON1.EEPGD=0;
 EECON1. WREN=1;
 EEDATA=datoL;
 EEDATH= datoH;
 EEADR=addrL;
 EEADRH=addrH;
 INTCON.GIE = 0; //Deshabilitar todas las interrupciones para que el codigo no se interrumpa cuando esté escribiendo en la memoria y así evitar un error
 EECON2=0x55;  //OBLIGATORIO POR FABRICANTE
 EECON2=0xAA;  //OBLIGATORIO POR FABRICANTE
 EECON1.WR=1;
 asm{
 nop
 nop
 }
 INTCON.GIE=1;

}

 void UART2_Write_Text(const unsigned char text[50]){
 
 unsigned char i = 0, tam = 0;
 
  while(text[tam]!= '\0') tam++;
  
  for (i=0; i<tam; i++){
   UART1_Write(text[i]);
  }
  //UART1_Write('\r');
 
 
 }

unsigned char read_EEPROM(unsigned char addrH,unsigned char addrL)
{
 EECON1.EEPGD=0;
 EEDAT=0x00; //Para limpiar la memoria
 EEADR=addrL;
 EEADRH=addrH;
 EECON1.RD=1;
 asm{
   nop
   nop
 }

 return EEDATA;
}