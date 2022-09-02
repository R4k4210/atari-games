    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000           ; Define the origin of the ROM at $F000

START:
    ;CLEAN_START         ; Macro to safely clear the memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set background luminosity color to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #$1E            ; Load color into A ($1E is NTSC yellow)
    sta COLUBK          ; Store A to backgroundColor Address $09 (alias)

    jmp START           ; Repeat from START

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fill ROM size to exacly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC           ; Define origin to $FFFC
    .word START         ; Reset vector at $FFFC (where the program starts)
    .word START         ; Interrupt vector at $FFFE (unused in the VCS)

