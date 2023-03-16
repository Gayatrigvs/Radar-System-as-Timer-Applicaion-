;******************************************************************************
;   This file is a basic template for creating relocatable assembly code for  *
;   a PIC18F452. Copy this file into your project directory and modify or     *
;   add to it as needed.                                                      *
;                                                                             *
;   The PIC18FXXX architecture allows two interrupt configurations. This      *
;   template code is written for priority interrupt levels and the IPEN bit   *
;   in the RCON register must be set to enable priority levels. If IPEN is    *
;   left in its default zero state, only the interrupt vector at 0x008 will   *
;   be used and the WREG_TEMP, BSR_TEMP and STATUS_TEMP variables will not    *
;   be needed.                                                                *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on the         *
;   features of the assembler and linker.                                     *
;                                                                             *
;   Refer to the PIC18FXX2 Data Sheet for additional information on the       *
;   architecture and instruction set.                                         *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:                                                                *
;    Date:                                                                    *
;    File Version:                                                            *
;                                                                             *
;    Author:                                                                  *
;    Company:                                                                 *
;                                                                             * 
;******************************************************************************
;                                                                             *
;    Files required: P18F452.INC                                              *
;                                                                             *
;******************************************************************************

	LIST P=18F452, F=INHX32,N=0, ST=OFF, R=HEX	;directive to define processor and file format
	#include <P18F452.INC>	;processor specific variable definitions

;******************************************************************************
;Configuration bits
;Microchip has changed the format for defining the configuration bits, please 
;see the .inc file for futher details on notation.  Below are a few examples.



;   Oscillator Selection:
    CONFIG	OSC = HS, OSCS=OFF, BORV=45, PWRT=ON, DEBUG=OFF, LVP=OFF, STVR=OFF 
    ORG 2AH
    
    bcf TRISC,0
    
    movlw 04H
    movwf T0CON
    
    AGAIN
    movlw 24H
    movwf TMR0H
    movlw 47H
    movwf TMR0L
    bcf INTCON, TMR0IF
    
    SENSORCHECK
    btfss PORTB,RB0
    bra SENSORCHECK
    
    bsf PORTC,RC0
    
    bsf T0CON,TMR0ON
    
    ROLLOVERCHECK
    btfss INTCON, TMR0IF
    bra ROLLOVERCHECK
    
    bcf T0CON,TMR0ON
    
    bcf PORTC,RC0
    
    bra AGAIN
    
    end           

