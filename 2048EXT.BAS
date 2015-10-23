DECLARE SUB DrawField ()
DECLARE SUB drawcell (x!, y!, n!)

WIDTH 80, 50
CLS
CALL DrawField

SUB drawcell (x, y, n)
        IF n MOD 10 = 0 THEN i = 8: s$ = "1  "
        IF n MOD 10 = 1 THEN i = 8: s$ = "2  "
        IF n MOD 10 = 2 THEN i = 8: s$ = "4  "
        IF n MOD 10 = 3 THEN i = 8: s$ = "8  "
        IF n MOD 10 = 4 THEN i = 7: s$ = "16 "
        IF n MOD 10 = 5 THEN i = 7: s$ = "32 "
        IF n MOD 10 = 6 THEN i = 7: s$ = "64 "
        IF n MOD 10 = 7 THEN i = 15: s$ = "128"
        IF n MOD 10 = 8 THEN i = 15: s$ = "256"
        IF n MOD 10 = 9 THEN i = 15: s$ = "512"
        r = INT(n / 10)
        IF r = 0 THEN l$ = "   ": p = 0
        IF r = 1 THEN l$ = "  K": p = 1
        IF r = 2 THEN l$ = "  M": p = 2
        IF r = 3 THEN l$ = "  G": p = 3
        IF r = 4 THEN l$ = "  T": p = 6
        IF r = 5 THEN l$ = "  P": p = 4
        IF r > 5 THEN l$ = "Big": p = 4: i = 14

        COLOR i, p

        IF n = 0 THEN COLOR 0, 0
        

        LOCATE x * 4 + 1, y * 5 + 1
        PRINT "ÚÄÄÄ¿"
        LOCATE x * 4 + 2, y * 5 + 1
        PRINT "³" + s$ + "³"
        LOCATE x * 4 + 3, y * 5 + 1
        PRINT "³" + l$ + "³"
        LOCATE x * 4 + 4, y * 5 + 1
        PRINT "ÀÄÄÄÙ"
END SUB

SUB DrawField
        FOR i = 0 TO 11
                FOR j = 0 TO 11
                        CALL drawcell(i, j, i + j * 6)
                NEXT
        NEXT
END SUB

