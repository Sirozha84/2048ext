DECLARE SUB DrawField ()
DECLARE SUB drawcell (x!, y!, n!)

CLS
CALL DrawField

SUB drawcell (x, y, n)
        LOCATE x * 2 + 1, y * 3 + 1
        PRINT n
        LOCATE x * 2 + 2, y * 3 + 1
        PRINT "--"
END SUB

SUB DrawField
        FOR i = 0 TO 11
                FOR j = 0 TO 11
                        CALL drawcell(i, j, i + j * 2)
                NEXT
        NEXT
END SUB

