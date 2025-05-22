       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE-FILE ASSIGN TO "data/employees.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORT-FILE ASSIGN TO "output/report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD EMPLOYEE-FILE.
       01 EMPLOYEE-RECORD         PIC X(50).  *> Read whole line

       FD REPORT-FILE.
       01 REPORT-RECORD           PIC X(80).  *> Output line

       WORKING-STORAGE SECTION.
       01 EOF-FLAG                PIC X VALUE "N".
           88 END-OF-FILE         VALUE "Y".
           88 NOT-END-OF-FILE     VALUE "N".

       01 EMP-ID-FIELD            PIC 9(3).
       01 EMP-NAME-FIELD          PIC X(10).
       01 HOURS-FIELD             PIC 99.
       01 RATE-FIELD              PIC 99.
       01 WEEKLY-PAY              PIC 9(5).
       01 OUT-LINE                PIC X(80).

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT EMPLOYEE-FILE
                OUTPUT REPORT-FILE

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

                       MOVE SPACES TO OUT-LINE
                       STRING
                           EMP-ID-FIELD DELIMITED BY SIZE
                           " " DELIMITED BY SIZE
                           EMP-NAME-FIELD DELIMITED BY SIZE
                           " $" DELIMITED BY SIZE
                           WEEKLY-PAY DELIMITED BY SIZE
                           INTO OUT-LINE

                       MOVE OUT-LINE TO REPORT-RECORD
                       WRITE REPORT-RECORD
               END-READ
           END-PERFORM

           CLOSE EMPLOYEE-FILE
                 REPORT-FILE

           DISPLAY "Payroll processing complete.".

           STOP RUN.
