
========== PERFORMANCE COMPARISON ==========
PI vs Fuzzy+PI Hybrid Controller
===========================================

Reference voltage: 10.000 V

Metric                                      PI        Fuzzy+PI       Winner
---------------------------------------------------------------------------
Rise Time (s):                          0.0742          0.0065     Fuzzy+PI
Settling Time (s):                      0.1488          0.0223     Fuzzy+PI
Peak Overshoot (%):                     118.29          198.95           PI
Steady-State Error (V):               0.014697        0.025435           PI
IAE:                                    2.5875          1.3070     Fuzzy+PI
ITAE:                                   0.5458          0.6773           PI
MSE:                                 14.176468        2.365374     Fuzzy+PI

========== CONCLUSION ==========
Based on the analysis:

? Fuzzy+PI wins on Rise Time
? Fuzzy+PI wins on Settling Time
? PI wins on Overshoot
? PI wins on SS Error
? Fuzzy+PI wins on IAE
? PI wins on ITAE
? Fuzzy+PI wins on MSE

--- Final Score ---
PI: 3 wins
Fuzzy+PI: 4 wins

? CONCLUSION: Fuzzy+PI Hybrid performs BETTER than PI
   The hybrid approach shows improvement for this application.
See piture in figures folder
