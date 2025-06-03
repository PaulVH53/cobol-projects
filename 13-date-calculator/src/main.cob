      *-----------------------
       IDENTIFICATION DIVISION.
      *-----------------------
       PROGRAM-ID. DATE-CALCULATOR.
      *-----------------------
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
      * Date handling variables
       01 YYYYMMDD         PIC 9(8).
       01 INTEGER-FORM     PIC S9(9).
      * 
      * Current date functions return value
       01 WS-CURRENT-DATE  PIC X(21).
      * 
      * Display formatting variables
       01 WS-YYYY-DISPLAY  PIC 9999.
       01 WS-MM-DISPLAY    PIC 99.
       01 WS-DD-DISPLAY    PIC 99.
       01 WS-DUE-YYYY      PIC 9999.
       01 WS-DUE-MM        PIC 99.
       01 WS-DUE-DD        PIC 99.
      * 
      * Work variables for date processing
       01 WS-DAYS-TO-ADD   PIC 999 VALUE 90.
       01 WS-TEMP-DATE     PIC 9(8).
      * 
      *------------------
       PROCEDURE DIVISION.
      *------------------
       MAIN-PROCESSING.
           PERFORM DISPLAY-HEADER
           PERFORM GET-CURRENT-DATE
           PERFORM CALCULATE-DUE-DATE
           PERFORM DISPLAY-RESULTS
           STOP RUN.
      *     
       DISPLAY-HEADER.
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "      DATE CALCULATOR PROGRAM        "
           DISPLAY "======================================"
           DISPLAY SPACES.
      *     
       GET-CURRENT-DATE.
      * Get current date and extract YYYYMMDD portion
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE
           MOVE FUNCTION CURRENT-DATE(1:8) TO YYYYMMDD
      *     
      * Extract components for display
           MOVE YYYYMMDD(1:4) TO WS-YYYY-DISPLAY
           MOVE YYYYMMDD(5:2) TO WS-MM-DISPLAY
           MOVE YYYYMMDD(7:2) TO WS-DD-DISPLAY
      *     
           DISPLAY "CURRENT DATE INFORMATION:"
           DISPLAY "------------------------"
           DISPLAY "Today's Date (YYYYMMDD): " YYYYMMDD
           DISPLAY "Computer Formatted Date: " WS-CURRENT-DATE
           DISPLAY "Integer Form: " FUNCTION INTEGER-OF-DATE(YYYYMMDD)
           DISPLAY "Integer to Date again: "
                FUNCTION 
                    DATE-OF-INTEGER(FUNCTION INTEGER-OF-DATE(YYYYMMDD))
           DISPLAY "Formatted Date: " WS-YYYY-DISPLAY "/"
                   WS-MM-DISPLAY "/" WS-DD-DISPLAY
           DISPLAY "Days to Add: " WS-DAYS-TO-ADD
           DISPLAY SPACES.
      *     
       CALCULATE-DUE-DATE.
      * Convert current date to integer form
           COMPUTE INTEGER-FORM = FUNCTION INTEGER-OF-DATE(YYYYMMDD)
      *     
      * Add the specified number of days
           ADD WS-DAYS-TO-ADD TO INTEGER-FORM
      *     
      * Convert back to date format
           COMPUTE YYYYMMDD = FUNCTION DATE-OF-INTEGER(INTEGER-FORM)
      *     
      * Extract components for formatted display
           MOVE YYYYMMDD(1:4) TO WS-DUE-YYYY
           MOVE YYYYMMDD(5:2) TO WS-DUE-MM
           MOVE YYYYMMDD(7:2) TO WS-DUE-DD
       .   
      *
       DISPLAY-RESULTS.
           DISPLAY "DATE CALCULATION RESULTS:"
           DISPLAY "------------------------"
           DISPLAY "Due Date: " YYYYMMDD
           DISPLAY "Formatted Due Date: " WS-DUE-YYYY "/" 
                   WS-DUE-MM "/" WS-DUE-DD
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "     PROCESSING COMPLETED            "
           DISPLAY "======================================".
      *     
       END PROGRAM DATE-CALCULATOR.
      *
