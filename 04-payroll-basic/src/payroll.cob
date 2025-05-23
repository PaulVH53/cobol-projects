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
       01 EMPLOYEE-RECORD.
           05 EMP-ID         PIC 9(3).
           05 EMP-NAME       PIC X(10).
           05 HOURS-WORKED   PIC 9(2).
           05 HOURLY-RATE    PIC 9(2).

       FD REPORT-FILE.
       01 REPORT-RECORD PIC X(80).


       WORKING-STORAGE SECTION.
       01 EOF-FLAG           PIC X VALUE "N".
           88 END-OF-FILE    VALUE "Y".
           88 NOT-END-OF-FILE VALUE "N".

       01 WEEKLY-PAY         PIC 9(5).
       01 OUT-LINE           PIC X(80).
       
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT EMPLOYEE-FILE
                OUTPUT REPORT-FILE

           PERFORM UNTIL END-OF-FILE
               READ EMPLOYEE-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       COMPUTE WEEKLY-PAY = HOURS-WORKED * HOURLY-RATE
                       MOVE SPACES TO OUT-LINE
                       STRING
                           EMP-ID DELIMITED BY SIZE
                           " " DELIMITED BY SIZE
                           EMP-NAME DELIMITED BY SIZE
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
