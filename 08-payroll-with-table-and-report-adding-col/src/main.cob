       IDENTIFICATION DIVISION.
       PROGRAM-ID. payroll.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE-FILE ASSIGN TO "data/employees.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD EMPLOYEE-FILE.
       01 EMPLOYEE-RECORD         PIC X(50).

       WORKING-STORAGE SECTION.
       01 EOF-FLAG                PIC X VALUE "N".
           88 END-OF-FILE         VALUE "Y".
           88 NOT-END-OF-FILE     VALUE "N".

       01 EMP-ID-FIELD            PIC 9(3).
       01 EMP-NAME-FIELD          PIC X(10).
       01 HOURS-FIELD             PIC 99.
       01 RATE-FIELD              PIC 99.
       01 WEEKLY-PAY              PIC 9(5).

       01 EARNER-COUNT            PIC 99 VALUE 0.
       
       01 EARNER-TABLE.
           05 EARNER-ENTRY OCCURS 10 TIMES.
               10 EARNER-NAME-FIELD      PIC X(10).
               10 EARNER-WEEKLY-PAY-FIELD PIC 9(5).

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT EMPLOYEE-FILE

           PERFORM UNTIL END-OF-FILE
               READ EMPLOYEE-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       UNSTRING EMPLOYEE-RECORD
                           DELIMITED BY SPACE
                           INTO EMP-ID-FIELD
                                EMP-NAME-FIELD
                                HOURS-FIELD
                                RATE-FIELD

                       COMPUTE WEEKLY-PAY = HOURS-FIELD * RATE-FIELD

                       IF WEEKLY-PAY > 1000
                           ADD 1 TO EARNER-COUNT
                           MOVE EMP-NAME-FIELD
                               TO EARNER-NAME-FIELD(EARNER-COUNT)
                           MOVE WEEKLY-PAY
                               TO EARNER-WEEKLY-PAY-FIELD(EARNER-COUNT)
                       END-IF
               END-READ
           END-PERFORM

           CLOSE EMPLOYEE-FILE

           CALL 'summary' USING EARNER-COUNT EARNER-TABLE

           DISPLAY "Done.".
           STOP RUN.
