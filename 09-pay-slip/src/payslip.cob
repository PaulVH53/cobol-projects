       IDENTIFICATION DIVISION.
       PROGRAM-ID. payslip.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SLIP-FILE
               ASSIGN TO LNK-FILENAME
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD SLIP-FILE.
       01 SLIP-RECORD         PIC X(150).

       WORKING-STORAGE SECTION.
       01 WS-LINE             PIC X(150).
       01 WS-ID               PIC X(3).
       01 WS-NAME             PIC X(10).
       01 WS-BASE-PAY         PIC Z(5).99.
       01 WS-OT-PAY           PIC Z(5).99.
       01 WS-GROSS-PAY        PIC Z(5).99.
       01 WS-AFP              PIC Z(5).99.
       01 WS-NET              PIC Z(5).99.

       LINKAGE SECTION.
       01 LNK-ID              PIC X(3).
       01 LNK-NAME            PIC X(10).
       01 LNK-BASE-PAY        PIC 9(5)V99.
       01 LNK-OT-PAY          PIC 9(5)V99.
       01 LNK-GROSS-PAY       PIC 9(5)V99.
       01 LNK-AFP             PIC 9(5)V99.
       01 LNK-NET             PIC 9(5)V99.
       01 LNK-FILENAME        PIC X(100).

       PROCEDURE DIVISION USING
           LNK-ID LNK-NAME LNK-BASE-PAY LNK-OT-PAY
           LNK-GROSS-PAY LNK-AFP LNK-NET LNK-FILENAME.

           OPEN OUTPUT SLIP-FILE

           MOVE LNK-ID         TO WS-ID
           MOVE LNK-NAME       TO WS-NAME
           MOVE LNK-BASE-PAY   TO WS-BASE-PAY
           MOVE LNK-OT-PAY     TO WS-OT-PAY
           MOVE LNK-GROSS-PAY  TO WS-GROSS-PAY
           MOVE LNK-AFP        TO WS-AFP
           MOVE LNK-NET        TO WS-NET

           STRING "ID: "        WS-ID        DELIMITED BY SIZE
                  ", Nombre: "  WS-NAME      DELIMITED BY SIZE
                  ", Base: "    WS-BASE-PAY  DELIMITED BY SIZE
                  ", Extra: "   WS-OT-PAY    DELIMITED BY SIZE
                  ", Bruto: "   WS-GROSS-PAY DELIMITED BY SIZE
                  ", AFP: "     WS-AFP       DELIMITED BY SIZE
                  ", Neto: "    WS-NET       DELIMITED BY SIZE
                  INTO WS-LINE

           MOVE WS-LINE TO SLIP-RECORD
           WRITE SLIP-RECORD

           CLOSE SLIP-FILE
           GOBACK.
