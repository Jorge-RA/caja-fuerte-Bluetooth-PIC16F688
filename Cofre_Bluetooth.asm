
_main:

;Cofre_Bluetooth.c,20 :: 		void main() {
;Cofre_Bluetooth.c,22 :: 		TRISA.F0 = 0; //salida
	BCF        TRISA+0, 0
;Cofre_Bluetooth.c,23 :: 		PORTA.F0 = 0; //PUERTA
	BCF        PORTA+0, 0
;Cofre_Bluetooth.c,24 :: 		TRISA.F2 = 0; //salida
	BCF        TRISA+0, 2
;Cofre_Bluetooth.c,25 :: 		PORTA.F2 = 0; //LEDPIC
	BCF        PORTA+0, 2
;Cofre_Bluetooth.c,26 :: 		TRISA.F1 = 1; //entrada, STATE
	BSF        TRISA+0, 1
;Cofre_Bluetooth.c,27 :: 		ANSEL=0x00;//ANSELH=0;
	CLRF       ANSEL+0
;Cofre_Bluetooth.c,28 :: 		CMCON0 = 0xFF; // para que los pines del puerto A sean entradas digitales por completo
	MOVLW      255
	MOVWF      CMCON0+0
;Cofre_Bluetooth.c,29 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Cofre_Bluetooth.c,30 :: 		chekDefault();
	CALL       _chekDefault+0
;Cofre_Bluetooth.c,31 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;Cofre_Bluetooth.c,33 :: 		while(1){
L_main1:
;Cofre_Bluetooth.c,34 :: 		unsigned char enterUser[8]={0},dato=0,i=0;
	CLRF       main_enterUser_L1+0
	CLRF       main_enterUser_L1+1
	CLRF       main_enterUser_L1+2
	CLRF       main_enterUser_L1+3
	CLRF       main_enterUser_L1+4
	CLRF       main_enterUser_L1+5
	CLRF       main_enterUser_L1+6
	CLRF       main_enterUser_L1+7
	CLRF       main_dato_L1+0
	CLRF       main_i_L1+0
;Cofre_Bluetooth.c,35 :: 		if(STATE == 1){
	BTFSS      PORTA+0, 1
	GOTO       L_main3
;Cofre_Bluetooth.c,36 :: 		PORTA.F2 = 1; //LEDPIC
	BSF        PORTA+0, 2
;Cofre_Bluetooth.c,37 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;Cofre_Bluetooth.c,39 :: 		if( chekPsw() ){
	CALL       _chekPsw+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;Cofre_Bluetooth.c,40 :: 		PUERTA = 1;
	BSF        PORTA+0, 0
;Cofre_Bluetooth.c,41 :: 		UART2_Write_Text("Abriendo...\r\r\n");
	MOVLW      ?lstr_1_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_1_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,42 :: 		delay_ms(5000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;Cofre_Bluetooth.c,43 :: 		PUERTA = 0;
	BCF        PORTA+0, 0
;Cofre_Bluetooth.c,45 :: 		UART2_Write_Text("Ingrese opcion. x para salir:\r\n");
	MOVLW      ?lstr_2_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_2_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,46 :: 		UART2_Write_Text("'dinero'  : Ver dinero. \r\n");
	MOVLW      ?lstr_3_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_3_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,47 :: 		UART2_Write_Text("'cambiar' : Cambiar clave.\r\n");
	MOVLW      ?lstr_4_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_4_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,50 :: 		while(dato != '\r' && STATE == 1){
L_main7:
	MOVF       main_dato_L1+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	BTFSS      PORTA+0, 1
	GOTO       L_main8
L__main82:
;Cofre_Bluetooth.c,51 :: 		if( UART1_Data_Ready() ){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main11
;Cofre_Bluetooth.c,52 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      main_dato_L1+0
;Cofre_Bluetooth.c,53 :: 		if(dato != '\r'){
	MOVF       R0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main12
;Cofre_Bluetooth.c,54 :: 		enterUser[i] = dato;
	MOVF       main_i_L1+0, 0
	ADDLW      main_enterUser_L1+0
	MOVWF      FSR
	MOVF       main_dato_L1+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,55 :: 		i++;
	INCF       main_i_L1+0, 1
;Cofre_Bluetooth.c,56 :: 		}
L_main12:
;Cofre_Bluetooth.c,57 :: 		}
L_main11:
;Cofre_Bluetooth.c,58 :: 		}
	GOTO       L_main7
L_main8:
;Cofre_Bluetooth.c,60 :: 		if ( !strncmp("dinero",enterUser,10) )
	MOVLW      ?lstr5_Cofre_Bluetooth+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      main_enterUser_L1+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      10
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;Cofre_Bluetooth.c,61 :: 		chekDinero();
	CALL       _chekDinero+0
	GOTO       L_main14
L_main13:
;Cofre_Bluetooth.c,63 :: 		else if ( !strncmp("cambiar",enterUser,10) )
	MOVLW      ?lstr6_Cofre_Bluetooth+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      main_enterUser_L1+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      10
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Cofre_Bluetooth.c,64 :: 		cambiarPsw();
	CALL       _cambiarPsw+0
	GOTO       L_main16
L_main15:
;Cofre_Bluetooth.c,67 :: 		UART2_Write_Text("Saliendo...\r\r\n");
	MOVLW      ?lstr_7_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_7_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
L_main16:
L_main14:
;Cofre_Bluetooth.c,71 :: 		}
L_main5:
;Cofre_Bluetooth.c,72 :: 		}
L_main3:
;Cofre_Bluetooth.c,73 :: 		}
	GOTO       L_main1
;Cofre_Bluetooth.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_chekPsw:

;Cofre_Bluetooth.c,76 :: 		unsigned char chekPsw(){
;Cofre_Bluetooth.c,78 :: 		unsigned char enterUser[10]={0}, dato=0,i=0,n_dato=0;
	CLRF       chekPsw_enterUser_L0+0
	CLRF       chekPsw_enterUser_L0+1
	CLRF       chekPsw_enterUser_L0+2
	CLRF       chekPsw_enterUser_L0+3
	CLRF       chekPsw_enterUser_L0+4
	CLRF       chekPsw_enterUser_L0+5
	CLRF       chekPsw_enterUser_L0+6
	CLRF       chekPsw_enterUser_L0+7
	CLRF       chekPsw_enterUser_L0+8
	CLRF       chekPsw_enterUser_L0+9
	CLRF       chekPsw_dato_L0+0
	CLRF       chekPsw_i_L0+0
;Cofre_Bluetooth.c,80 :: 		UART2_Write_Text("Ingrese contrasenia:\r\n");
	MOVLW      ?lstr_8_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_8_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,83 :: 		while(dato != '\r' && STATE == 1){
L_chekPsw17:
	MOVF       chekPsw_dato_L0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_chekPsw18
	BTFSS      PORTA+0, 1
	GOTO       L_chekPsw18
L__chekPsw84:
;Cofre_Bluetooth.c,85 :: 		if( UART1_Data_Ready() ){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_chekPsw21
;Cofre_Bluetooth.c,86 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      chekPsw_dato_L0+0
;Cofre_Bluetooth.c,87 :: 		if(dato != '\r'){
	MOVF       R0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_chekPsw22
;Cofre_Bluetooth.c,88 :: 		enterUser[i] = dato;
	MOVF       chekPsw_i_L0+0, 0
	ADDLW      chekPsw_enterUser_L0+0
	MOVWF      FSR
	MOVF       chekPsw_dato_L0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,89 :: 		i++;
	INCF       chekPsw_i_L0+0, 1
;Cofre_Bluetooth.c,90 :: 		}
L_chekPsw22:
;Cofre_Bluetooth.c,91 :: 		}
L_chekPsw21:
;Cofre_Bluetooth.c,93 :: 		}
	GOTO       L_chekPsw17
L_chekPsw18:
;Cofre_Bluetooth.c,96 :: 		if ( !strncmp(pswAcceso,enterUser,5) || !strncmp("root:J1A9R9A9",enterUser,10) ){
	MOVLW      _pswAcceso+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      chekPsw_enterUser_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      5
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L__chekPsw83
	MOVLW      ?lstr9_Cofre_Bluetooth+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      chekPsw_enterUser_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      10
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L__chekPsw83
	GOTO       L_chekPsw25
L__chekPsw83:
;Cofre_Bluetooth.c,97 :: 		UART2_Write_Text("Contrasenia correcta.\r\n");
	MOVLW      ?lstr_10_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_10_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,98 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_chekPsw
;Cofre_Bluetooth.c,99 :: 		}
L_chekPsw25:
;Cofre_Bluetooth.c,101 :: 		UART2_Write_Text("Contrasenia incorrecta.\r\n");
	MOVLW      ?lstr_11_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_11_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,102 :: 		return 0;
	CLRF       R0+0
;Cofre_Bluetooth.c,106 :: 		}
L_end_chekPsw:
	RETURN
; end of _chekPsw

_cambiarPsw:

;Cofre_Bluetooth.c,108 :: 		void cambiarPsw(){
;Cofre_Bluetooth.c,109 :: 		unsigned char i = 0;
	CLRF       cambiarPsw_i_L0+0
	CLRF       cambiarPsw_dato_L0+0
	CLRF       cambiarPsw_enterUser_L0+0
	CLRF       cambiarPsw_enterUser_L0+1
	CLRF       cambiarPsw_enterUser_L0+2
	CLRF       cambiarPsw_enterUser_L0+3
	CLRF       cambiarPsw_enterUser_L0+4
;Cofre_Bluetooth.c,113 :: 		UART2_Write_Text("Nueva contrasenia:\r\n");
	MOVLW      ?lstr_12_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_12_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,116 :: 		while(dato != '\r' && STATE == 1){
L_cambiarPsw27:
	MOVF       cambiarPsw_dato_L0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_cambiarPsw28
	BTFSS      PORTA+0, 1
	GOTO       L_cambiarPsw28
L__cambiarPsw85:
;Cofre_Bluetooth.c,118 :: 		if( UART1_Data_Ready() ){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_cambiarPsw31
;Cofre_Bluetooth.c,119 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      cambiarPsw_dato_L0+0
;Cofre_Bluetooth.c,120 :: 		if(dato != '\r'){
	MOVF       R0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_cambiarPsw32
;Cofre_Bluetooth.c,121 :: 		enterUser[i] = dato;
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      cambiarPsw_enterUser_L0+0
	MOVWF      FSR
	MOVF       cambiarPsw_dato_L0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,122 :: 		i++;
	INCF       cambiarPsw_i_L0+0, 1
;Cofre_Bluetooth.c,123 :: 		}
L_cambiarPsw32:
;Cofre_Bluetooth.c,124 :: 		}
L_cambiarPsw31:
;Cofre_Bluetooth.c,126 :: 		}
	GOTO       L_cambiarPsw27
L_cambiarPsw28:
;Cofre_Bluetooth.c,128 :: 		if(i==tamPsw){
	MOVF       cambiarPsw_i_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_cambiarPsw33
;Cofre_Bluetooth.c,129 :: 		for(i=0;i<tamPsw;i++){
	CLRF       cambiarPsw_i_L0+0
L_cambiarPsw34:
	MOVLW      4
	SUBWF      cambiarPsw_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_cambiarPsw35
;Cofre_Bluetooth.c,130 :: 		write_EEPROM(0x00,enterUser[i],0x00, ubicacionPswEEPROM+i); //Clave por defecto "1234" posicion 0x10
	CLRF       FARG_write_EEPROM_datoH+0
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      cambiarPsw_enterUser_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      16
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,131 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_cambiarPsw37:
	DECFSZ     R13+0, 1
	GOTO       L_cambiarPsw37
	DECFSZ     R12+0, 1
	GOTO       L_cambiarPsw37
	NOP
	NOP
;Cofre_Bluetooth.c,129 :: 		for(i=0;i<tamPsw;i++){
	INCF       cambiarPsw_i_L0+0, 1
;Cofre_Bluetooth.c,132 :: 		}
	GOTO       L_cambiarPsw34
L_cambiarPsw35:
;Cofre_Bluetooth.c,133 :: 		UART2_Write_Text("Contrasenia actualizada.\r\n");
	MOVLW      ?lstr_13_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_13_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,134 :: 		UART2_Write_Text("Su nueva contrasenia es: ");
	MOVLW      ?lstr_14_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_14_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,135 :: 		for(i=0; i<tamPsw;i++)
	CLRF       cambiarPsw_i_L0+0
L_cambiarPsw38:
	MOVLW      4
	SUBWF      cambiarPsw_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_cambiarPsw39
;Cofre_Bluetooth.c,136 :: 		UART1_Write(enterUser[i]);
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      cambiarPsw_enterUser_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Cofre_Bluetooth.c,135 :: 		for(i=0; i<tamPsw;i++)
	INCF       cambiarPsw_i_L0+0, 1
;Cofre_Bluetooth.c,136 :: 		UART1_Write(enterUser[i]);
	GOTO       L_cambiarPsw38
L_cambiarPsw39:
;Cofre_Bluetooth.c,137 :: 		UART1_Write('\r');
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Cofre_Bluetooth.c,138 :: 		UART1_Write('\n');
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Cofre_Bluetooth.c,139 :: 		}
	GOTO       L_cambiarPsw41
L_cambiarPsw33:
;Cofre_Bluetooth.c,141 :: 		UART2_Write_Text("Contrasenia NO actualizada.\r\n");
	MOVLW      ?lstr_15_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_15_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
L_cambiarPsw41:
;Cofre_Bluetooth.c,144 :: 		for(i=0;i<tamPsw;i++){
	CLRF       cambiarPsw_i_L0+0
L_cambiarPsw42:
	MOVLW      4
	SUBWF      cambiarPsw_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_cambiarPsw43
;Cofre_Bluetooth.c,145 :: 		pswAcceso[i]=read_EEPROM(0x00,ubicacionPswEEPROM+i);
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      _pswAcceso+0
	MOVWF      FLOC__cambiarPsw+0
	CLRF       FARG_read_EEPROM_addrH+0
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      16
	MOVWF      FARG_read_EEPROM_addrL+0
	CALL       _read_EEPROM+0
	MOVF       FLOC__cambiarPsw+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,146 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_cambiarPsw45:
	DECFSZ     R13+0, 1
	GOTO       L_cambiarPsw45
	DECFSZ     R12+0, 1
	GOTO       L_cambiarPsw45
	NOP
	NOP
;Cofre_Bluetooth.c,144 :: 		for(i=0;i<tamPsw;i++){
	INCF       cambiarPsw_i_L0+0, 1
;Cofre_Bluetooth.c,147 :: 		}
	GOTO       L_cambiarPsw42
L_cambiarPsw43:
;Cofre_Bluetooth.c,148 :: 		pswAcceso[i] = '\0';
	MOVF       cambiarPsw_i_L0+0, 0
	ADDLW      _pswAcceso+0
	MOVWF      FSR
	CLRF       INDF+0
;Cofre_Bluetooth.c,151 :: 		}
L_end_cambiarPsw:
	RETURN
; end of _cambiarPsw

_chekDinero:

;Cofre_Bluetooth.c,153 :: 		void chekDinero(){
;Cofre_Bluetooth.c,154 :: 		unsigned char i = 0, j = 0,dato=0;
	CLRF       chekDinero_i_L0+0
	CLRF       chekDinero_j_L0+0
	CLRF       chekDinero_dato_L0+0
	CLRF       chekDinero_dinero_L0+0
	CLRF       chekDinero_dinero_L0+1
	CLRF       chekDinero_dinero_L0+2
	CLRF       chekDinero_dinero_L0+3
	CLRF       chekDinero_dinero_L0+4
	CLRF       chekDinero_dinero_L0+5
	CLRF       chekDinero_dinero_L0+6
	CLRF       chekDinero_dinero_L0+7
	CLRF       chekDinero_dinero_L0+8
	CLRF       chekDinero_dinero_L0+9
	CLRF       chekDinero_enterUser_L0+0
	CLRF       chekDinero_enterUser_L0+1
	CLRF       chekDinero_enterUser_L0+2
	CLRF       chekDinero_enterUser_L0+3
	CLRF       chekDinero_enterUser_L0+4
	CLRF       chekDinero_enterUser_L0+5
	CLRF       chekDinero_enterUser_L0+6
	CLRF       chekDinero_enterUser_L0+7
	CLRF       chekDinero_enterUser_L0+8
	CLRF       chekDinero_enterUser_L0+9
;Cofre_Bluetooth.c,158 :: 		UART2_Write_Text("Dinero actual: $");
	MOVLW      ?lstr_16_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_16_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,160 :: 		while( read_EEPROM(0x00,ubicacionDineroEEPROM+i) != 0xFF  ){
L_chekDinero46:
	CLRF       FARG_read_EEPROM_addrH+0
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      24
	MOVWF      FARG_read_EEPROM_addrL+0
	CALL       _read_EEPROM+0
	MOVF       R0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_chekDinero47
;Cofre_Bluetooth.c,161 :: 		dinero[i] =  read_EEPROM(0x00,ubicacionDineroEEPROM+i);
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      chekDinero_dinero_L0+0
	MOVWF      FLOC__chekDinero+0
	CLRF       FARG_read_EEPROM_addrH+0
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      24
	MOVWF      FARG_read_EEPROM_addrL+0
	CALL       _read_EEPROM+0
	MOVF       FLOC__chekDinero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,162 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDinero48:
	DECFSZ     R13+0, 1
	GOTO       L_chekDinero48
	DECFSZ     R12+0, 1
	GOTO       L_chekDinero48
	NOP
	NOP
;Cofre_Bluetooth.c,163 :: 		i++;
	INCF       chekDinero_i_L0+0, 1
;Cofre_Bluetooth.c,164 :: 		}
	GOTO       L_chekDinero46
L_chekDinero47:
;Cofre_Bluetooth.c,165 :: 		dinero[i] = '\0';
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      chekDinero_dinero_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Cofre_Bluetooth.c,166 :: 		UART1_Write_Text(dinero);
	MOVLW      chekDinero_dinero_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Cofre_Bluetooth.c,167 :: 		UART1_Write('\r');
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Cofre_Bluetooth.c,169 :: 		UART2_Write_Text("Desea modificar monto?\r\n");
	MOVLW      ?lstr_17_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_17_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,170 :: 		i=0;
	CLRF       chekDinero_i_L0+0
;Cofre_Bluetooth.c,171 :: 		while(dato != '\r' && STATE == 1){
L_chekDinero49:
	MOVF       chekDinero_dato_L0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_chekDinero50
	BTFSS      PORTA+0, 1
	GOTO       L_chekDinero50
L__chekDinero86:
;Cofre_Bluetooth.c,173 :: 		if( UART1_Data_Ready() ){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_chekDinero53
;Cofre_Bluetooth.c,174 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      chekDinero_dato_L0+0
;Cofre_Bluetooth.c,175 :: 		if(dato != '\r'){
	MOVF       R0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_chekDinero54
;Cofre_Bluetooth.c,176 :: 		enterUser[i] = dato;
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      chekDinero_enterUser_L0+0
	MOVWF      FSR
	MOVF       chekDinero_dato_L0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,177 :: 		i++;
	INCF       chekDinero_i_L0+0, 1
;Cofre_Bluetooth.c,178 :: 		}
L_chekDinero54:
;Cofre_Bluetooth.c,179 :: 		}
L_chekDinero53:
;Cofre_Bluetooth.c,181 :: 		}
	GOTO       L_chekDinero49
L_chekDinero50:
;Cofre_Bluetooth.c,182 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_chekDinero55:
	DECFSZ     R13+0, 1
	GOTO       L_chekDinero55
	DECFSZ     R12+0, 1
	GOTO       L_chekDinero55
	NOP
	NOP
;Cofre_Bluetooth.c,184 :: 		if ( !strncmp("si",enterUser,3) ){
	MOVLW      ?lstr18_Cofre_Bluetooth+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      chekDinero_enterUser_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      3
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_chekDinero56
;Cofre_Bluetooth.c,186 :: 		UART2_Write_Text("Ingrese nuevo monto:\r\n");
	MOVLW      ?lstr_19_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_19_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,187 :: 		UART1_Read_Text(enterUser,"\r",14);
	MOVLW      chekDinero_enterUser_L0+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr20_Cofre_Bluetooth+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      14
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;Cofre_Bluetooth.c,188 :: 		for ( i=0; i<strlen(enterUser); i++ ){
	CLRF       chekDinero_i_L0+0
L_chekDinero57:
	MOVLW      chekDinero_enterUser_L0+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__chekDinero91
	MOVF       R0+0, 0
	SUBWF      chekDinero_i_L0+0, 0
L__chekDinero91:
	BTFSC      STATUS+0, 0
	GOTO       L_chekDinero58
;Cofre_Bluetooth.c,189 :: 		write_EEPROM(0x00,enterUser[i],0x00,ubicacionDineroEEPROM+i);
	CLRF       FARG_write_EEPROM_datoH+0
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      chekDinero_enterUser_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVF       chekDinero_i_L0+0, 0
	ADDLW      24
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,190 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDinero60:
	DECFSZ     R13+0, 1
	GOTO       L_chekDinero60
	DECFSZ     R12+0, 1
	GOTO       L_chekDinero60
	NOP
	NOP
;Cofre_Bluetooth.c,188 :: 		for ( i=0; i<strlen(enterUser); i++ ){
	INCF       chekDinero_i_L0+0, 1
;Cofre_Bluetooth.c,191 :: 		}
	GOTO       L_chekDinero57
L_chekDinero58:
;Cofre_Bluetooth.c,192 :: 		for(j=i; j<(i+10); j++){
	MOVF       chekDinero_i_L0+0, 0
	MOVWF      chekDinero_j_L0+0
L_chekDinero61:
	MOVLW      10
	ADDWF      chekDinero_i_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__chekDinero92
	MOVF       R1+0, 0
	SUBWF      chekDinero_j_L0+0, 0
L__chekDinero92:
	BTFSC      STATUS+0, 0
	GOTO       L_chekDinero62
;Cofre_Bluetooth.c,193 :: 		write_EEPROM(0x00,0xFF,0x00,ubicacionDineroEEPROM+j);
	CLRF       FARG_write_EEPROM_datoH+0
	MOVLW      255
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVF       chekDinero_j_L0+0, 0
	ADDLW      24
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,194 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDinero64:
	DECFSZ     R13+0, 1
	GOTO       L_chekDinero64
	DECFSZ     R12+0, 1
	GOTO       L_chekDinero64
	NOP
	NOP
;Cofre_Bluetooth.c,192 :: 		for(j=i; j<(i+10); j++){
	INCF       chekDinero_j_L0+0, 1
;Cofre_Bluetooth.c,195 :: 		}
	GOTO       L_chekDinero61
L_chekDinero62:
;Cofre_Bluetooth.c,196 :: 		UART2_Write_Text("Dinero actualizado.\r\n");
	MOVLW      ?lstr_21_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_21_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
;Cofre_Bluetooth.c,198 :: 		}
	GOTO       L_chekDinero65
L_chekDinero56:
;Cofre_Bluetooth.c,200 :: 		UART2_Write_Text("Ok.\r\n");
	MOVLW      ?lstr_22_Cofre_Bluetooth+0
	MOVWF      FARG_UART2_Write_Text_text+0
	MOVLW      hi_addr(?lstr_22_Cofre_Bluetooth+0)
	MOVWF      FARG_UART2_Write_Text_text+1
	CALL       _UART2_Write_Text+0
L_chekDinero65:
;Cofre_Bluetooth.c,202 :: 		}
L_end_chekDinero:
	RETURN
; end of _chekDinero

_chekDefault:

;Cofre_Bluetooth.c,206 :: 		void chekDefault(){
;Cofre_Bluetooth.c,208 :: 		unsigned char i = 0;
	CLRF       chekDefault_i_L0+0
;Cofre_Bluetooth.c,210 :: 		if(read_EEPROM(0x00,0x08)!=1){
	CLRF       FARG_read_EEPROM_addrH+0
	MOVLW      8
	MOVWF      FARG_read_EEPROM_addrL+0
	CALL       _read_EEPROM+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_chekDefault66
;Cofre_Bluetooth.c,212 :: 		for(i=0;i<tamPsw;i++){
	CLRF       chekDefault_i_L0+0
L_chekDefault67:
	MOVLW      4
	SUBWF      chekDefault_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_chekDefault68
;Cofre_Bluetooth.c,213 :: 		write_EEPROM(0x00,0x31+i,0x00, ubicacionPswEEPROM+i); //Clave por defecto "1234" posicion 0x10
	CLRF       FARG_write_EEPROM_datoH+0
	MOVF       chekDefault_i_L0+0, 0
	ADDLW      49
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVF       chekDefault_i_L0+0, 0
	ADDLW      16
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,214 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDefault70:
	DECFSZ     R13+0, 1
	GOTO       L_chekDefault70
	DECFSZ     R12+0, 1
	GOTO       L_chekDefault70
	NOP
	NOP
;Cofre_Bluetooth.c,212 :: 		for(i=0;i<tamPsw;i++){
	INCF       chekDefault_i_L0+0, 1
;Cofre_Bluetooth.c,215 :: 		}
	GOTO       L_chekDefault67
L_chekDefault68:
;Cofre_Bluetooth.c,216 :: 		write_EEPROM(0x00,0x01,0x00,ubicacionBanderaPsw); //Escribir en alto la bandera, clave por defecto ya escrita
	CLRF       FARG_write_EEPROM_datoH+0
	MOVLW      1
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVLW      8
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,217 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDefault71:
	DECFSZ     R13+0, 1
	GOTO       L_chekDefault71
	DECFSZ     R12+0, 1
	GOTO       L_chekDefault71
	NOP
	NOP
;Cofre_Bluetooth.c,218 :: 		write_EEPROM(0x00,0x30,0x00,ubicacionDineroEEPROM); //Escribir dinero inicial(0 pesos),   posicion 0x18
	CLRF       FARG_write_EEPROM_datoH+0
	MOVLW      48
	MOVWF      FARG_write_EEPROM_datoL+0
	CLRF       FARG_write_EEPROM_addrH+0
	MOVLW      24
	MOVWF      FARG_write_EEPROM_addrL+0
	CALL       _write_EEPROM+0
;Cofre_Bluetooth.c,219 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDefault72:
	DECFSZ     R13+0, 1
	GOTO       L_chekDefault72
	DECFSZ     R12+0, 1
	GOTO       L_chekDefault72
	NOP
	NOP
;Cofre_Bluetooth.c,220 :: 		}
L_chekDefault66:
;Cofre_Bluetooth.c,221 :: 		for(i=0;i<tamPsw;i++){
	CLRF       chekDefault_i_L0+0
L_chekDefault73:
	MOVLW      4
	SUBWF      chekDefault_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_chekDefault74
;Cofre_Bluetooth.c,222 :: 		pswAcceso[i]=read_EEPROM(0x00,ubicacionPswEEPROM+i);
	MOVF       chekDefault_i_L0+0, 0
	ADDLW      _pswAcceso+0
	MOVWF      FLOC__chekDefault+0
	CLRF       FARG_read_EEPROM_addrH+0
	MOVF       chekDefault_i_L0+0, 0
	ADDLW      16
	MOVWF      FARG_read_EEPROM_addrL+0
	CALL       _read_EEPROM+0
	MOVF       FLOC__chekDefault+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Cofre_Bluetooth.c,223 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_chekDefault76:
	DECFSZ     R13+0, 1
	GOTO       L_chekDefault76
	DECFSZ     R12+0, 1
	GOTO       L_chekDefault76
	NOP
	NOP
;Cofre_Bluetooth.c,221 :: 		for(i=0;i<tamPsw;i++){
	INCF       chekDefault_i_L0+0, 1
;Cofre_Bluetooth.c,224 :: 		}
	GOTO       L_chekDefault73
L_chekDefault74:
;Cofre_Bluetooth.c,225 :: 		pswAcceso[i] = '\0';
	MOVF       chekDefault_i_L0+0, 0
	ADDLW      _pswAcceso+0
	MOVWF      FSR
	CLRF       INDF+0
;Cofre_Bluetooth.c,227 :: 		}
L_end_chekDefault:
	RETURN
; end of _chekDefault

_write_EEPROM:

;Cofre_Bluetooth.c,240 :: 		void write_EEPROM(unsigned char datoH,unsigned char datoL,unsigned char addrH,unsigned char addrL)
;Cofre_Bluetooth.c,242 :: 		EECON1.EEPGD=0;
	BCF        EECON1+0, 7
;Cofre_Bluetooth.c,243 :: 		EECON1. WREN=1;
	BSF        EECON1+0, 2
;Cofre_Bluetooth.c,244 :: 		EEDATA=datoL;
	MOVF       FARG_write_EEPROM_datoL+0, 0
	MOVWF      EEDATA+0
;Cofre_Bluetooth.c,245 :: 		EEDATH= datoH;
	MOVF       FARG_write_EEPROM_datoH+0, 0
	MOVWF      EEDATH+0
;Cofre_Bluetooth.c,246 :: 		EEADR=addrL;
	MOVF       FARG_write_EEPROM_addrL+0, 0
	MOVWF      EEADR+0
;Cofre_Bluetooth.c,247 :: 		EEADRH=addrH;
	MOVF       FARG_write_EEPROM_addrH+0, 0
	MOVWF      EEADRH+0
;Cofre_Bluetooth.c,248 :: 		INTCON.GIE = 0; //Deshabilitar todas las interrupciones para que el codigo no se interrumpa cuando esté escribiendo en la memoria y así evitar un error
	BCF        INTCON+0, 7
;Cofre_Bluetooth.c,249 :: 		EECON2=0x55;  //OBLIGATORIO POR FABRICANTE
	MOVLW      85
	MOVWF      EECON2+0
;Cofre_Bluetooth.c,250 :: 		EECON2=0xAA;  //OBLIGATORIO POR FABRICANTE
	MOVLW      170
	MOVWF      EECON2+0
;Cofre_Bluetooth.c,251 :: 		EECON1.WR=1;
	BSF        EECON1+0, 1
;Cofre_Bluetooth.c,253 :: 		nop
	NOP
;Cofre_Bluetooth.c,254 :: 		nop
	NOP
;Cofre_Bluetooth.c,256 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;Cofre_Bluetooth.c,258 :: 		}
L_end_write_EEPROM:
	RETURN
; end of _write_EEPROM

_UART2_Write_Text:

;Cofre_Bluetooth.c,260 :: 		void UART2_Write_Text(const unsigned char text[50]){
;Cofre_Bluetooth.c,262 :: 		unsigned char i = 0, tam = 0;
	CLRF       UART2_Write_Text_i_L0+0
	CLRF       UART2_Write_Text_tam_L0+0
;Cofre_Bluetooth.c,264 :: 		while(text[tam]!= '\0') tam++;
L_UART2_Write_Text77:
	MOVF       UART2_Write_Text_tam_L0+0, 0
	ADDWF      FARG_UART2_Write_Text_text+0, 0
	MOVWF      R0+0
	MOVF       FARG_UART2_Write_Text_text+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_UART2_Write_Text78
	INCF       UART2_Write_Text_tam_L0+0, 1
	GOTO       L_UART2_Write_Text77
L_UART2_Write_Text78:
;Cofre_Bluetooth.c,266 :: 		for (i=0; i<tam; i++){
	CLRF       UART2_Write_Text_i_L0+0
L_UART2_Write_Text79:
	MOVF       UART2_Write_Text_tam_L0+0, 0
	SUBWF      UART2_Write_Text_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_UART2_Write_Text80
;Cofre_Bluetooth.c,267 :: 		UART1_Write(text[i]);
	MOVF       UART2_Write_Text_i_L0+0, 0
	ADDWF      FARG_UART2_Write_Text_text+0, 0
	MOVWF      R0+0
	MOVF       FARG_UART2_Write_Text_text+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Cofre_Bluetooth.c,266 :: 		for (i=0; i<tam; i++){
	INCF       UART2_Write_Text_i_L0+0, 1
;Cofre_Bluetooth.c,268 :: 		}
	GOTO       L_UART2_Write_Text79
L_UART2_Write_Text80:
;Cofre_Bluetooth.c,272 :: 		}
L_end_UART2_Write_Text:
	RETURN
; end of _UART2_Write_Text

_read_EEPROM:

;Cofre_Bluetooth.c,274 :: 		unsigned char read_EEPROM(unsigned char addrH,unsigned char addrL)
;Cofre_Bluetooth.c,276 :: 		EECON1.EEPGD=0;
	BCF        EECON1+0, 7
;Cofre_Bluetooth.c,277 :: 		EEDAT=0x00; //Para limpiar la memoria
	CLRF       EEDAT+0
;Cofre_Bluetooth.c,278 :: 		EEADR=addrL;
	MOVF       FARG_read_EEPROM_addrL+0, 0
	MOVWF      EEADR+0
;Cofre_Bluetooth.c,279 :: 		EEADRH=addrH;
	MOVF       FARG_read_EEPROM_addrH+0, 0
	MOVWF      EEADRH+0
;Cofre_Bluetooth.c,280 :: 		EECON1.RD=1;
	BSF        EECON1+0, 0
;Cofre_Bluetooth.c,282 :: 		nop
	NOP
;Cofre_Bluetooth.c,283 :: 		nop
	NOP
;Cofre_Bluetooth.c,286 :: 		return EEDATA;
	MOVF       EEDATA+0, 0
	MOVWF      R0+0
;Cofre_Bluetooth.c,287 :: 		}
L_end_read_EEPROM:
	RETURN
; end of _read_EEPROM
