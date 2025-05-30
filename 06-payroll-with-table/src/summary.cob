       IDENTIFICATION DIVISION.
       PROGRAM-ID. summary.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDX               PIC 99.

       LINKAGE SECTION.
       01 COUNT-IN          PIC 99.
       01 NAMES-IN.
          05 NAME-ENTRY OCCURS 10 TIMES.
             10 NAME-FIELD  PIC X(10).

       PROCEDURE DIVISION USING COUNT-IN NAMES-IN.
           DISPLAY "Employees earning over $1000: " COUNT-IN

           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > COUNT-IN
           DISPLAY "Employee " IDX " : " NAME-FIELD(IDX)
           END-PERFORM.

      