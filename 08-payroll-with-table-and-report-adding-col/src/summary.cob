       IDENTIFICATION DIVISION.
       PROGRAM-ID. summary.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REPORT-FILE ASSIGN TO "report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  REPORT-FILE.
       01  REPORT-LINE              PIC X(80).

       WORKING-STORAGE SECTION.
       01  IDX                    PIC 9(2) VALUE ZEROS.
       01  DISP-IDX               PIC Z9.
       01  DISP-NAME              PIC X(10).
       01  DISP-WEEKLY-PAY      PIC ZZ,ZZ9.

       LINKAGE SECTION.
       01 COUNT-IN PIC 9(2).
       01 EARNER-TABLE.
          05 EARNER-ENTRY OCCURS 10 TIMES.
             10 EARNER-NAME-FIELD      PIC X(10).
             10 EARNER-WEEKLY-PAY-FIELD PIC 9(5).

       PROCEDURE DIVISION USING COUNT-IN EARNER-TABLE.
           DISPLAY "============================="
           DISPLAY "   High-Earning Employees"
           DISPLAY "============================="
           DISPLAY " No. | Name       | Weekly Pay"
           DISPLAY "-----------------------------"


           OPEN OUTPUT REPORT-FILE
           MOVE SPACES TO REPORT-LINE
           MOVE " No. | Name       | Weekly Pay" TO REPORT-LINE
           WRITE REPORT-LINE
           MOVE SPACES TO REPORT-LINE
           MOVE "-----------------------------" TO REPORT-LINE
           WRITE REPORT-LINE

           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > COUNT-IN
               MOVE IDX TO DISP-IDX
               MOVE EARNER-NAME-FIELD(IDX) TO DISP-NAME
               MOVE EARNER-WEEKLY-PAY-FIELD(IDX) TO DISP-WEEKLY-PAY
           
               MOVE SPACES TO REPORT-LINE
               STRING
                   " " DISP-IDX DELIMITED BY SIZE
                   "   | " DELIMITED BY SIZE
                   DISP-NAME DELIMITED BY SIZE
                   " | " DELIMITED BY SIZE
                   DISP-WEEKLY-PAY DELIMITED BY SIZE
                   INTO REPORT-LINE
               DISPLAY REPORT-LINE
               WRITE REPORT-LINE
           END-PERFORM


           CLOSE REPORT-FILE
           DISPLAY "============================"
           DISPLAY "Done."
           GOBACK.
