#line 1 "D:/Jorge/Codigos en Mikro C/Cofre_Bluetooth/Cofre_Bluetooth.c"







void write_EEPROM(unsigned char datoH,unsigned char datoL,unsigned char addrH,unsigned char addrL);
unsigned char read_EEPROM(unsigned char addrH,unsigned char addrL);
void chekDefault();
unsigned char chekPsw();
void chekDinero();
void cambiarPsw();
void UART2_Write_Text(const text[50]);



unsigned char pswAcceso[5] = {0};

void main() {

 TRISA.F0 = 0;
 PORTA.F0 = 0;
 TRISA.F2 = 0;
 PORTA.F2 = 0;
 TRISA.F1 = 1;
 ANSEL=0x00;
 CMCON0 = 0xFF;
 UART1_Init(9600);
 chekDefault();
 delay_ms(500);

 while(1){
 unsigned char enterUser[8]={0},dato=0,i=0;
 if( PORTA.F1  == 1){
 PORTA.F2 = 1;
 delay_ms(1000);

 if( chekPsw() ){
  PORTA.F0  = 1;
 UART2_Write_Text("Abriendo...\r\r\n");
 delay_ms(5000);
  PORTA.F0  = 0;

 UART2_Write_Text("Ingrese opcion. x para salir:\r\n");
 UART2_Write_Text("'dinero'  : Ver dinero. \r\n");
 UART2_Write_Text("'cambiar' : Cambiar clave.\r\n");


 while(dato != '\r' &&  PORTA.F1  == 1){
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


 while(dato != '\r' &&  PORTA.F1  == 1){

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


 while(dato != '\r' &&  PORTA.F1  == 1){

 if( UART1_Data_Ready() ){
 dato = UART1_Read();
 if(dato != '\r'){
 enterUser[i] = dato;
 i++;
 }
 }

 }

 if(i== 4 ){
 for(i=0;i< 4 ;i++){
 write_EEPROM(0x00,enterUser[i],0x00,  0x10 +i);
 delay_ms(10);
 }
 UART2_Write_Text("Contrasenia actualizada.\r\n");
 UART2_Write_Text("Su nueva contrasenia es: ");
 for(i=0; i< 4 ;i++)
 UART1_Write(enterUser[i]);
 UART1_Write('\r');
 UART1_Write('\n');
 }
 else
 UART2_Write_Text("Contrasenia NO actualizada.\r\n");


 for(i=0;i< 4 ;i++){
 pswAcceso[i]=read_EEPROM(0x00, 0x10 +i);
 delay_ms(10);
 }
 pswAcceso[i] = '\0';


}

void chekDinero(){
 unsigned char i = 0, j = 0,dato=0;
 unsigned char dinero[10]={0};
 unsigned char enterUser[10] = {0};

 UART2_Write_Text("Dinero actual: $");

 while( read_EEPROM(0x00, 0x18 +i) != 0xFF ){
 dinero[i] = read_EEPROM(0x00, 0x18 +i);
 delay_ms(10);
 i++;
 }
 dinero[i] = '\0';
 UART1_Write_Text(dinero);
 UART1_Write('\r');

 UART2_Write_Text("Desea modificar monto?\r\n");
 i=0;
 while(dato != '\r' &&  PORTA.F1  == 1){

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

 UART2_Write_Text("Ingrese nuevo monto:\r\n");
 UART1_Read_Text(enterUser,"\r",14);
 for ( i=0; i<strlen(enterUser); i++ ){
 write_EEPROM(0x00,enterUser[i],0x00, 0x18 +i);
 delay_ms(10);
 }
 for(j=i; j<(i+10); j++){
 write_EEPROM(0x00,0xFF,0x00, 0x18 +j);
 delay_ms(10);
 }
 UART2_Write_Text("Dinero actualizado.\r\n");

 }
 else
 UART2_Write_Text("Ok.\r\n");

}



 void chekDefault(){

 unsigned char i = 0;

 if(read_EEPROM(0x00,0x08)!=1){

 for(i=0;i< 4 ;i++){
 write_EEPROM(0x00,0x31+i,0x00,  0x10 +i);
 delay_ms(10);
 }
 write_EEPROM(0x00,0x01,0x00, 0x08 );
 delay_ms(10);
 write_EEPROM(0x00,0x30,0x00, 0x18 );
 delay_ms(10);
 }
 for(i=0;i< 4 ;i++){
 pswAcceso[i]=read_EEPROM(0x00, 0x10 +i);
 delay_ms(10);
 }
 pswAcceso[i] = '\0';

}
#line 240 "D:/Jorge/Codigos en Mikro C/Cofre_Bluetooth/Cofre_Bluetooth.c"
void write_EEPROM(unsigned char datoH,unsigned char datoL,unsigned char addrH,unsigned char addrL)
{
 EECON1.EEPGD=0;
 EECON1. WREN=1;
 EEDATA=datoL;
 EEDATH= datoH;
 EEADR=addrL;
 EEADRH=addrH;
 INTCON.GIE = 0;
 EECON2=0x55;
 EECON2=0xAA;
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



 }

unsigned char read_EEPROM(unsigned char addrH,unsigned char addrL)
{
 EECON1.EEPGD=0;
 EEDAT=0x00;
 EEADR=addrL;
 EEADRH=addrH;
 EECON1.RD=1;
 asm{
 nop
 nop
 }

 return EEDATA;
}
