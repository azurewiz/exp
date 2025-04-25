;compare
ORG 0000H

MAIN:
        ;— initialize outputs to 0 ——
        MOV P3, #00H ; clear “greater” port
        MOV P2, #00H ; clear “difference” port

LOOP:
        MOV A, P1 ; read the 8-bit switch input
        MOV R0, A ; save it

        ;— value1 = lower nibble (bits 0–3) ——
        ANL A, #0FH ; mask off bits 4–7
        MOV R1, A ; R1 ← value1

        ;— value2 = upper nibble (bits 4–7) ——
        MOV A, R0
        ANL A, #0F0H ; mask off bits 0–3
        SWAP A ; high nibble → low nibble
        MOV R2, A ; R2 ← value2

        ;— compare R1 vs R2 ——
        MOV A, R1
        CLR C
        SUBB A, R2 ; A = R1–R2
        JC VALUE2_GT ; if borrow, value2>value1

  ;—— R1 ≥ R2 path ——
        MOV A, R1
        MOV P3, A ; P3 = greater
        MOV A, R1
        CLR C
        SUBB A, R2
        MOV P2, A ; P2 = difference
        SJMP BACK

VALUE2_GT:
        MOV A, R2
        MOV P3, A ; P3 = greater
        MOV A, R2
        CLR C
        SUBB A, R1
        MOV P2, A ; P2 = difference

BACK:
        SJMP LOOP ; repeat forever

        END
