      *-----------------------
       IDENTIFICATION DIVISION.
      *-----------------------
       PROGRAM-ID. LOAN-ANNUITY-CALCULATOR.
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
      * Financial calculation variables
       01 LOAN             PIC 9(9)V99.
       01 PAYMENT          PIC 9(9)V99.
       01 INTEREST         PIC 9(9)V99.
       01 NUMBER-PERIODS   PIC 99.
      * 
      * Work variables for calculations
       01 WS-ANNUAL-INT-PERC  PIC 9(9)V999.
       01 WS-MONTH-RATE-PERC  PIC 9(9)V999.
       01 WS-TOTAL-PAID    PIC 9(9)V99.
       01 WS-TOTAL-INTEREST PIC 9(9)V99.
      * 
      * Display formatting variables
       01 WS-LOAN-DISPLAY  PIC $$$,$$$,$$9.99.
       01 WS-ANNUAL-INT-PERC-DISPLAY PIC ZZ9.99.
       01 WS-MONTH-RATE-PERC-DISPLAY PIC ZZ9.99.
       01 WS-PAYMENT-DISPLAY PIC $$$,$$$,$$9.99.
       01 WS-TOTAL-DISPLAY PIC $$$,$$$,$$9.99.
       01 WS-INT-DISPLAY   PIC $$$,$$$,$$9.99.
      * 
      * Additional loan scenarios for demonstration
       01 WS-SCENARIO      PIC 99 VALUE 1.
       01 WS-MAX-SCENARIOS PIC 99 VALUE 3.
      * 
      *------------------
       PROCEDURE DIVISION.
      *------------------
       MAIN-PROCESSING.
           PERFORM DISPLAY-HEADER
           PERFORM CALCULATE-LOAN-SCENARIOS
           PERFORM DISPLAY-SUMMARY
           STOP RUN.
      *     
       DISPLAY-HEADER.
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "    LOAN ANNUITY CALCULATOR          "
           DISPLAY "======================================"
           DISPLAY SPACES.
      *     
       CALCULATE-LOAN-SCENARIOS.
           PERFORM VARYING WS-SCENARIO FROM 1 BY 1 
                   UNTIL WS-SCENARIO > WS-MAX-SCENARIOS
               PERFORM SETUP-SCENARIO-DATA
               PERFORM CALCULATE-PAYMENT
               PERFORM DISPLAY-SCENARIO-RESULTS
           END-PERFORM.
      *     
       SETUP-SCENARIO-DATA.
           EVALUATE WS-SCENARIO
               WHEN 1
                   COMPUTE LOAN = 15000
                   COMPUTE INTEREST = .12
                   COMPUTE NUMBER-PERIODS = 36
                   DISPLAY "SCENARIO 1: Original Example"
                   DISPLAY "----------------------------"
               WHEN 2
                   COMPUTE LOAN = 25000
                   COMPUTE INTEREST = .08
                   COMPUTE NUMBER-PERIODS = 48
                   DISPLAY "SCENARIO 2: Lower Rate, Longer Term"
                   DISPLAY "-----------------------------------"
               WHEN 3
                   COMPUTE LOAN = 10000
                   COMPUTE INTEREST = .15
                   COMPUTE NUMBER-PERIODS = 24
                   DISPLAY "SCENARIO 3: Higher Rate, Shorter Term"
                   DISPLAY "------------------------------------"
           END-EVALUATE.
      *     
       CALCULATE-PAYMENT.
      * Using COBOL ANNUITY function for payment calculation
           COMPUTE PAYMENT = LOAN * FUNCTION ANNUITY(
               (INTEREST / 12) NUMBER-PERIODS)
      *     
      * Calculate total payment and interest
           COMPUTE WS-TOTAL-PAID = PAYMENT * NUMBER-PERIODS
           COMPUTE WS-TOTAL-INTEREST = WS-TOTAL-PAID - LOAN
       .   
      *
       DISPLAY-SCENARIO-RESULTS.
      * Format values for display
           MOVE LOAN TO WS-LOAN-DISPLAY
           MOVE PAYMENT TO WS-PAYMENT-DISPLAY
           COMPUTE WS-ANNUAL-INT-PERC = INTEREST * 100
           MOVE WS-ANNUAL-INT-PERC TO WS-ANNUAL-INT-PERC-DISPLAY
           COMPUTE WS-MONTH-RATE-PERC = (INTEREST / 12) * 100
           MOVE WS-MONTH-RATE-PERC TO WS-MONTH-RATE-PERC-DISPLAY
           MOVE WS-TOTAL-PAID TO WS-TOTAL-DISPLAY
           MOVE WS-TOTAL-INTEREST TO WS-INT-DISPLAY
      *     
           DISPLAY "Loan Amount:        " WS-LOAN-DISPLAY
           DISPLAY "Annual Interest:    " WS-ANNUAL-INT-PERC-DISPLAY "%"
           DISPLAY "Monthly Rate:       " WS-MONTH-RATE-PERC-DISPLAY "%"
           DISPLAY "Number of Periods:  " NUMBER-PERIODS " months"
           DISPLAY "Monthly Payment:    " WS-PAYMENT-DISPLAY
           DISPLAY "Total Amount Paid:  " WS-TOTAL-DISPLAY
           DISPLAY "Total Interest:     " WS-INT-DISPLAY
           DISPLAY SPACES.
      *     
       DISPLAY-SUMMARY.
           DISPLAY "======================================"
           DISPLAY "ANNUITY FUNCTION DEMONSTRATION:"
           DISPLAY "Payment = Loan * FUNCTION ANNUITY("
           DISPLAY "          (Interest/12) Periods)"
           DISPLAY SPACES
           DISPLAY "This function calculates the periodic"
           DISPLAY "payment required to amortize a loan"
           DISPLAY "over a specified number of periods."
           DISPLAY SPACES
           DISPLAY "======================================"
           DISPLAY "     PROCESSING COMPLETED            "
           DISPLAY "======================================".
      *     
       END PROGRAM LOAN-ANNUITY-CALCULATOR.
      *
