       IDENTIFICATION DIVISION.
       PROGRAM-ID. summary.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REPORT-FILE ASSIGN TO "output/report.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  REPORT-FILE.
       01  REPORT-LINE              PIC X(80).

       WORKING-STORAGE SECTION.
       01  IDX                    PIC 9(2) VALUE ZEROS.
       01  DISP-IDX               PIC Z9.
       01  DISP-NAME              PIC X(10).

       LINKAGE SECTION.
       01  EARNER-NAMES.
           05  EARNER-NAME OCCURS 10 TIMES.
               10  NAME-FIELD      PIC X(10).
       01  COUNT-IN                 PIC 9(2).

       PROCEDURE DIVISION USING EARNER-NAMES COUNT-IN.
           DISPLAY "============================"
           DISPLAY "   High-Earning Employees"
           DISPLAY "============================"
           DISPLAY " No. | Name"
           DISPLAY "----------------------------"

           OPEN OUTPUT REPORT-FILE
           MOVE SPACES TO REPORT-LINE
           MOVE " No. | Name" TO REPORT-LINE
           WRITE REPORT-LINE
           MOVE SPACES TO REPORT-LINE
           MOVE "----------------------------" TO REPORT-LINE
           WRITE REPORT-LINE

           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > COUNT-IN
               MOVE IDX TO DISP-IDX
               MOVE NAME-FIELD(IDX) TO DISP-NAME

               DISPLAY " " DISP-IDX "   | " DISP-NAME

               MOVE SPACES TO REPORT-LINE
               STRING
                   " " DISP-IDX DELIMITED BY SIZE
                   "   | " DELIMITED BY SIZE
                   DISP-NAME DELIMITED BY SIZE
                   INTO REPORT-LINE
               WRITE REPORT-LINE
           END-PERFORM

           CLOSE REPORT-FILE
           DISPLAY "============================"
           DISPLAY "Done."
           GOBACK.
