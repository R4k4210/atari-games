;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    processor 6502
    seg code    ; Define a new assembler segment for our code
    org $F000   ; Define the origin of the ROM code at address $F000

Start:
    lda #$82    ; Load the A register with the literal hexadecimal value $82
    ldx #82     ; Load the X register with the literal decimal value 82
    ldy $82 	; Load the Y register with the value that is inside memory position $82
    
    org $FFFC   ; End the ROM always at position $FFFC
    .word Start ; Put 2 bytes with reset address at memory position $FFFC
    .word Start ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #$A             ; Load the A register with the hexadecimal value $A
    ldx #%11111111      ; Load the X register with the binary value %11111111

    sta $80             ; Store the value in the A register into memory address $80
    stx $81             ; Store the value in the X register into memory address $81

    jmp Start           ; Force looop on Start
    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000https://www.youtube.com/watch?v=8FJXZfH03Mk&ab_channel=colinfurze

Start:
    lda #15             ; Load the A register with the liteal decimal value 15
                        ; Register instructions!!!
    tax                 ; Transfer the value from A to X
    tay                 ; Transfer the value from A to Y
    txa                 ; Transfer the value from X to A
    tya                 ; Transfer the value from Y to A

                        ; Important: There is no TXY or TYX
                        ; Therefore we can't transfer directly X to Y or Y to X
                        ; If we widh to do so, we must go through the A

    ldx #6              ; Load X with the decimal value #6
    txa                 ; Transfer X to A
    tay                 ; Transfer A to Y
    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #100            ; Load the A register with the literal decimal value 100

    clc                 ; We always clear the carry flag before calling ADC
    adc #5              ; Add the decimal value 5 to the accumulator
                        ; Register A should now contain the decimal value #105

    sec                 ; We always set the carry flag before callig SBC                        
    sbc #10             ; Substract the decimal value 10 from the accumulator
                        ; Register A should now contain the decimal 95 (or $5F in hexadecimal)

    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #$0A            ; Load the A register with the hexadecimal value $A
    ldx #%1010          ; Load the X register with the binary value %1010
    
    sta $80             ; Store the value in the A register into (zero page) memory address $80
    stx $81             ; Store the value in the X register into (zero page) memory address $81
    
    lda #10             ; Store A with the decimal value 10 
                    
    clc                 ; Clear the carry flag before ADC
    adc $80             ; Add to A the value inside RAM address $80
    adc $81             ; Add to A the value inside RAM address $81
                        ; A should contain (#10 + $A + %1010) = #30 (or $1E in hexadecimal)

    sta $82             ; Store the value inside A into RAM position $82

    jmp Start           ; Jump to the Start label to force an infinite lopp
    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #1              ; Load the A register with the decimal value 1 
    ldx #2              ; Load the X register with the decimal value 2
    ldy #3              ; Load the Y register with the decimal value 3

    inx                 ; Increment X
    iny                 ; Increment Y

    clc
    adc #1              ; Increment A in 1. We dont have increment A.

    dex                 ; Decrement X
    dey                 ; Decrement Y

    sec
    sbc #1              ; Substract 1 from A (The 6502 has no "dec A" instruction)
                        ; In the 6502, we can directly increment and decrement both
                        ; X and Y, but not A. We can only ADC #1 and SBC #1 from A.
                        ; This make X and Y great choices to control loops.

    jmp Start           ; Jump to the Start label to force an infinite loop 
    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #10             ; Load the A register with the decimal value 10
    sta $80             ; Store the value from A into memory position $80

    inc $80             ; Increment the value inside a (zero page) memory position $80
    dec $80             ; Decrement the value inside a (zero page) memory position $80

    jmp Start           ; Jump to the Start label to force an infinite lopp
    
    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    ldy #10             ; Initialze the Y register with the decimal value 10

Loop:
    tya                 ; Transfer Y to A
    sta $80,Y           ; Store the value in A inside memory position $80+Y
    dey                 ; Decrement Y
    bpl Loop            ; Branch if plus (positive) (result of last instruction was positive)
                        ; When is negative, stop.

    jmp Start           ; Jump to Start label to force an infinite loop

    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Execsice 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502
    seg code            ; Define a new assembler segment for our code
    org $F000           ; Define the origin of the ROM code at address $F000

Start:
    lda #1              ; Initialize the A register with the decimal value 1

Loop:
    clc                 ; Clean Carry flag before ADC
    adc #1              ; Increment A (using ADC #1)
    cmp #10             ; Compare the value in A with the decimal value 10
                        ; CMP set Zero flag
    bne Loop            ; Branch back to loop if the comparison was not equals (to zero)

    jmp Start           ; Jump to the Start labelt to force an infinite loop

    org $FFFC           ; End the ROM always at position $FFFC
    .word Start         ; Put 2 bytes with reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with break address at memory position $FFFE

