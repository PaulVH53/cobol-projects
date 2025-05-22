       IDENTIFICATION DIVISION.
       PROGRAM-ID. AGE-CHECK.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 AGE      PIC 99 VALUE 59.
       PROCEDURE DIVISION.
           IF AGE >= 60
               DISPLAY "Senior"
           ELSE
               DISPLAY "Not yet senior".
           STOP RUN.
