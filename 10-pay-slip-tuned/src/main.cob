       IDENTIFICATION DIVISION.
       PROGRAM-ID. main-payroll.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMP-FILE ASSIGN TO "data/employees.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD EMP-FILE.
       01 EMP-RECORD              PIC X(100).  *> Read whole line

       WORKING-STORAGE SECTION.
       01 END-FILE-FLAG           PIC X VALUE "N".
       01 EMP-ID                  PIC X(3).
       01 EMP-NAME                PIC X(10).
       01 EMP-HOURS               PIC 9(3).
       01 EMP-RATE                PIC 9(3)V99.
       01 OT-HOURS                PIC 9(3).
       01 BASE-PAY                PIC 9(5)V99.
       01 OT-PAY                  PIC 9(5)V99.
       01 GROSS-PAY               PIC 9(5)V99.
       01 AFP-AMOUNT              PIC 9(5)V99.
       01 NET-PAY                 PIC 9(5)V99.
       01 FILE-NAME               PIC X(100).
       01 TMP-NAME                PIC X(10).
       
       PROCEDURE DIVISION.

       BEGIN.
           OPEN INPUT EMP-FILE

           PERFORM UNTIL END-FILE-FLAG = "Y"
               READ EMP-FILE
                   AT END
                       MOVE "Y" TO END-FILE-FLAG
                   NOT AT END
                       UNSTRING EMP-RECORD 
                           DELIMITED BY SPACE
                           INTO EMP-ID 
                                EMP-NAME 
                                EMP-HOURS 
                                EMP-RATE

                       IF EMP-HOURS > 40
                           COMPUTE OT-HOURS = EMP-HOURS - 40
                       ELSE
                           MOVE 0 TO OT-HOURS
                       END-IF

                       COMPUTE BASE-PAY  = 
                           (EMP-HOURS - OT-HOURS) * EMP-RATE
                       COMPUTE OT-PAY    = OT-HOURS * EMP-RATE * 1.5
                       COMPUTE GROSS-PAY = BASE-PAY + OT-PAY
                       COMPUTE AFP-AMOUNT = GROSS-PAY * 0.08
                       COMPUTE NET-PAY    = GROSS-PAY - AFP-AMOUNT

                       MOVE EMP-NAME TO TMP-NAME
                       MOVE SPACES TO FILE-NAME *> clean file name
                       STRING "report/payslips/"
                               FUNCTION TRIM(TMP-NAME TRAILING)
                               ".txt"
                           DELIMITED BY SIZE
                           INTO FILE-NAME

                       DISPLAY "DEBUG CLEAN FILE: " FILE-NAME

                       CALL "payslip" USING
                           EMP-ID
                           EMP-NAME
                           BASE-PAY
                           OT-PAY
                           GROSS-PAY
                           AFP-AMOUNT
                           NET-PAY
                           FILE-NAME
               END-READ
           END-PERFORM

           CLOSE EMP-FILE
           STOP RUN.
                 
  
           
           