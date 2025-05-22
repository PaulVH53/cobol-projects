       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATOR.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 A        PIC 9(3) VALUE 15.
       01 B        PIC 9(3) VALUE 5.
       01 RESULT   PIC 9(4).
       PROCEDURE DIVISION.
           ADD A TO B GIVING RESULT.
           DISPLAY "A + B = " RESULT.
           SUBTRACT B FROM A GIVING RESULT.
           DISPLAY "A - B = " RESULT.
           MULTIPLY A BY B GIVING RESULT.
           DISPLAY "A * B = " RESULT.
           DIVIDE A BY B GIVING RESULT.
           DISPLAY "A / B = " RESULT.
           STOP RUN.
