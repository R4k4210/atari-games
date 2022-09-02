    processor 6502      ; Esto le dice a assembler el micro al que apuntamos

    seg code            ; Con esto le decimos que vamos a empezar un segmento de código
    org $F000           ; Con esto le decimos el origen de la memoria donde vamos a empezar
    
Start:                  ; Esto es un label - acá vamos a meter las config iniciales siempre
    sei                 ; Disable interrupts - Por mas que no tiene se debe hacer!
    cld                 ; Disable the BCD (binary code decimal) math mode
    ldx #$FF            ; Loads the X register with #$FF
    txs                 ; Transfer the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Clear the Page Zero / Zero Page region ($00 to $FF)
;  Meaning the entire RAM and also the entire TIA registers
;  We are going to do this from the end to start
;
;  # => Literal decimal / $ => Hexadecimal / #$ => El literal del Hexa / % => Binario 
;
;  The difference between # and $ is that, for example, LDA #80 loads the register A with
;  the literal decimal value 80, but LDA $80 loads the A register with the value inside
;  memory address $80. These are two different addressing mode types.
;
;  So, LDA #80 is the Immediate Mode and LDA $80 is the Absolute (Zero Page) Mode.
;  If you want to use Immediate Mode with hex, use LDA #$80 that loads the A register with
;  the literal hexadecimal number $80.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    lda #0              ; A = 0
    ldx #$FF            ; X = #$FF Literal!
    sta $FF             ; Make sure $FF is zeroed before the loop starts

MemLoop:                ; Un loop para ir limpiando la memoria del cartucho
    dex                 ; X-- => Vamos decrementando en X
    sta $0,X            ; Store the value of A inside memory address $0 + X (lo que tenga X)
    bne MemLoop         ; Branch if not equal to zero. 
                        ; Loop until X is equal to zero (z-flag is set) 
                        ; Esto hace un decremento pero no en la posicón $FF por eso la limpio
                        ; primero antes del loop.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Fill the ROM size to exacly 4KB. Seteamos el origen en $FFFC porque atari espera 
;  siempre encontrar en esa posición 2 bytes
;  La palabra .word mete 2 bytes en esos dos registros.
;  Esto es configuración propia de atari.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    org $FFFC           ; Saltamos a la posición $FFFC
    .word Start         ; Reset vector at $FFFC (where the program starts)
    .word Start         ; Interrupt vector at $FFFE (unused in the VSC) Requerido por Atari!

