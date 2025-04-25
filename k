//toggle
ORG 00h
SJMP MAIN
ORG 30H
MAIN:
BACK: MOV A,#55H
MOV P0,A
MOV P1,A
MOV P2,A
ACALL QSDELAY ;Quarter of a second
MOV A,#0AAH
MOV P0,A
MOV P1,A
MOV P2,A
ACALL QSDELAY
SJMP BACK
QSDELAY:
MOV R5,#11
H3: MOV R4,#248
H2: MOV R3,#255
H1: DJNZ R3,H1 ;4 MC for DS89C4x0
DJNZ R4,H2
DJNZ R5,H3
RET
END

//serial data
ORG 00h
SJMP MAIN
ORG 30H
MAIN:
MOV TMOD,#20H ;timer 1,mode 2(auto reload)
MOV TH1,#-3 ;9600 baud rate
MOV SCON,#50H ;8-bit, 1 stop, REN enabled
SETB TR1 ;start timer 1
AGAIN: MOV A,#'E' ;transfer “E”
ACALL TRANS
MOV A,#'C' ;transfer “C”
ACALL TRANS
MOV A,#'E' ;transfer “E”
ACALL TRANS
SJMP AGAIN ;keep doing it
;serial data transfer subroutine
TRANS: MOV SBUF,A ;load SBUF
HERE: JNB TI,HERE ;wait for the last bit
CLR TI ;get ready for next byte
RET
END

