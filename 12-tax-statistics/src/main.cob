      *-----------------------
       IDENTIFICATION DIVISION.
      *-----------------------
       PROGRAM-ID. TAX-STATISTICS.
      *--------------------
       ENVIRONMENT DIVISION.
      *--------------------
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
      *-------------
       DATA DIVISION.
      *-------------
       WORKING-STORAGE SECTION.
      * 
      * Tax rates for different categories
       01 TAX-S            PIC 99V999 VALUE .045.
       01 TAX-T            PIC 99V999 VALUE .020.
       01 TAX-W            PIC 99V999 VALUE .035.
       01 TAX-B            PIC 99V999 VALUE .030.
      * 
      * Statistical calculations
       01 AVE-TAX          PIC 99V999.
       01 MEDIAN-TAX       PIC 99V999.
       01 TAX-RANGE        PIC 99V999.
      * 
      * Display formatting variables
       01 WS-AVE-DISPLAY   PIC ZZ.999.
       01 WS-MED-DISPLAY   PIC ZZ.999.
       01 WS-RNG-DISPLAY   PIC ZZ.999.
       01 WS-TAX-S-DISPLAY PIC ZZ.999.
       01 WS-TAX-T-DISPLAY PIC ZZ.999.
       01 WS-TAX-W-DISPLAY PIC ZZ.999.
       01 WS-TAX-B-DISPLAY PIC ZZ.999.
      * 
      * Work variables for manual calculations
      * (if functions not available)
       01 WS-TOTAL         PIC 99V999.
       01 WS-COUNT         PIC 99 VALUE 4.
       01 WS-MAX-TAX       PIC 99V999.
       01 WS-MIN-TAX       PIC 99V999.
       01 WS-TEMP1         PIC 99V999.
       01 WS-TEMP2         PIC 99V999.
      * 
      *------------------
       PROCEDURE DIVISION.
      *------------------
       MAIN-PROCESSING.
           PERFORM DISPLAY-HEADER
           PERFORM DISPLAY-TAX-RATES
           PERFORM CALCULATE-STATISTICS
           PERFORM DISPLAY-RESULTS
           STOP RUN.
      *     
       DISPLAY-HEADER.
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "     TAX STATISTICS CALCULATOR       "
           DISPLAY "======================================"
           DISPLAY SPACES.
      *     
       DISPLAY-TAX-RATES.
           MOVE TAX-S TO WS-TAX-S-DISPLAY
           MOVE TAX-T TO WS-TAX-T-DISPLAY
           MOVE TAX-W TO WS-TAX-W-DISPLAY
           MOVE TAX-B TO WS-TAX-B-DISPLAY
      *     
           DISPLAY "TAX RATES:"
           DISPLAY "----------"
           DISPLAY "Tax-S (Sales):     " WS-TAX-S-DISPLAY
           DISPLAY "Tax-T (Transport): " WS-TAX-T-DISPLAY
           DISPLAY "Tax-W (Wage):      " WS-TAX-W-DISPLAY
           DISPLAY "Tax-B (Business):  " WS-TAX-B-DISPLAY
           DISPLAY SPACES.
      *     
       CALCULATE-STATISTICS.
      * Using COBOL intrinsic functions (modern COBOL)
      * If your COBOL compiler supports these functions:
           COMPUTE AVE-TAX = FUNCTION MEAN(TAX-S TAX-T TAX-W TAX-B)
           COMPUTE MEDIAN-TAX = FUNCTION MEDIAN(TAX-S TAX-T TAX-W TAX-B)
           COMPUTE TAX-RANGE = FUNCTION RANGE(TAX-S TAX-T TAX-W TAX-B)
       .   
      *
       DISPLAY-RESULTS.
           MOVE AVE-TAX TO WS-AVE-DISPLAY
           MOVE MEDIAN-TAX TO WS-MED-DISPLAY
           MOVE TAX-RANGE TO WS-RNG-DISPLAY
      *     
           DISPLAY "STATISTICAL RESULTS:"
           DISPLAY "-------------------"
           DISPLAY "Average Tax Rate:  " WS-AVE-DISPLAY
           DISPLAY "Median Tax Rate:   " WS-MED-DISPLAY
           DISPLAY "Tax Range:         " WS-RNG-DISPLAY
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "     PROCESSING COMPLETED            "
           DISPLAY "======================================".
      *     
       END PROGRAM TAX-STATISTICS.
      *
