DECLARE SUB KeyFree ()
DECLARE SUB DrawCell (x!, y!, n!)
DECLARE SUB DrawField (M!())
DECLARE SUB DrawStat (s!, M!)
DECLARE SUB Game (size!)
DECLARE SUB Randomizer (M!(), size!, num!, max!)
DECLARE FUNCTION OneMove! (M!(), nap$)

WIDTH 80, 50
CLS
CALL Game(12)

SUB DrawCell (x, y, n)
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
        PRINT "┌───┐"
        LOCATE x * 4 + 2, y * 5 + 1
        PRINT "│" + s$ + "│"
        LOCATE x * 4 + 3, y * 5 + 1
        PRINT "│" + l$ + "│"
        LOCATE x * 4 + 4, y * 5 + 1
        PRINT "└───┘"
END SUB

SUB DrawField (M())
        FOR i = 0 TO 11
                FOR j = 0 TO 11
                        CALL DrawCell(i, j, M(i, j))
                NEXT
        NEXT
END SUB

SUB DrawStat (s, M)
        LOCATE 1, 65
        COLOR 7, 0
        PRINT "Score:"
        LOCATE 3, 65
        COLOR 15, 0
        PRINT s
        LOCATE 7, 65
        COLOR 7, 0
        PRINT "Moves:"
        LOCATE 9, 65
        COLOR 15, 0
        PRINT M
END SUB

SUB Game (size)
    DIM M(size, size)
    score = 0
    moves = 0
    ext = 0
    DO
        CALL DrawStat(score, moves)
        CALL Randomizer(M(), size, 3, 2)
        CALL DrawField(M())
        DO
            k$ = INKEY$
        LOOP UNTIL k$ <> ""
        IF k$ = CHR$(0) + CHR$(72) THEN score = score + OneMove(M(), "up"): moves = moves + 1
        IF k$ = CHR$(0) + CHR$(75) THEN score = score + OneMove(M(), "left"): moves = moves + 1
        IF k$ = CHR$(0) + CHR$(77) THEN score = score + OneMove(M(), "right"): moves = moves + 1
        IF k$ = CHR$(0) + CHR$(80) THEN score = score + OneMove(M(), "down"): moves = moves + 1
        IF k$ = CHR$(27) THEN END
        'CALL DrawStat(score, moves)
    LOOP UNTIL ext <> 0
END SUB

SUB KeyFree ()
    'Освободим клавиатурный буфер, чтоб не пищало
    DO
    LOOP UNTIL INKEY$ = ""
END SUB

FUNCTION OneMove (M(), nap$)
    'Некрасиво, конечно, что на каждое направление написан практически
    'одинаковый код, но так было быстрей
    score = 0
    DIM B(12, 12)
    IF nap$ = "up" THEN
        DO
            mov = 0
            FOR i = 1 TO 11
                FOR j = 0 TO 11
                    IF M(i, j) <> 0 AND M(i - 1, j) = 0 THEN
                        M(i - 1, j) = M(i, j)
                        M(i, j) = 0
                        mov = 1
                    END IF
                    IF M(i, j) <> 0 AND M(i - 1, j) = M(i, j) AND B(i, j) = 0 AND B(i - 1, j) = 0 THEN
                        M(i - 1, j) = M(i, j) + 1
                        M(i, j) = 0
                        B(i - 1, j) = 1
                        mov = 1
                        score = score + M(i - 1, j)
                    END IF
                NEXT
            NEXT
            CALL DrawField(M())
            KeyFree
        LOOP UNTIL mov = 0
    END IF
    IF nap$ = "left" THEN
        DO
            mov = 0
            FOR i = 0 TO 11
                FOR j = 1 TO 11
                    IF M(i, j) <> 0 AND M(i, j - 1) = 0 THEN
                        M(i, j - 1) = M(i, j)
                        M(i, j) = 0
                        mov = 1
                    END IF
                    IF M(i, j) <> 0 AND M(i, j - 1) = M(i, j) AND B(i, j) = 0 AND B(i, j - 1) = 0 THEN
                        M(i, j - 1) = M(i, j) + 1
                        M(i, j) = 0
                        B(i, j - 1) = 1
                        mov = 1
                        score = score + M(i, j - 1)
                    END IF
                NEXT
            NEXT
            CALL DrawField(M())
            KeyFree
        LOOP UNTIL mov = 0
    END IF
    IF nap$ = "down" THEN
        DO
            mov = 0
            FOR i = 10 TO 0 STEP -1
                FOR j = 0 TO 11
                    IF M(i, j) <> 0 AND M(i + 1, j) = 0 THEN
                        M(i + 1, j) = M(i, j)
                        M(i, j) = 0
                        mov = 1
                    END IF
                    IF M(i, j) <> 0 AND M(i + 1, j) = M(i, j) AND B(i, j) = 0 AND B(i + 1, j) = 0 THEN
                        M(i + 1, j) = M(i, j) + 1
                        M(i, j) = 0
                        B(i + 1, j) = 1
                        mov = 1
                        score = score + M(i + 1, j)
                    END IF
                NEXT
            NEXT
            CALL DrawField(M())
            KeyFree
        LOOP UNTIL mov = 0
    END IF
    IF nap$ = "right" THEN
        DO
            mov = 0
            FOR i = 0 TO 11
                FOR j = 10 TO 0 STEP -1
                    IF M(i, j) <> 0 AND M(i, j + 1) = 0 THEN
                        M(i, j + 1) = M(i, j)
                        M(i, j) = 0
                        mov = 1
                    END IF
                    IF M(i, j) <> 0 AND M(i, j + 1) = M(i, j) AND B(i, j) = 0 AND B(i, j + 1) = 0 THEN
                        M(i, j + 1) = M(i, j) + 1
                        M(i, j) = 0
                        B(i, j + 1) = 1
                        mov = 1
                        score = score + M(i, j + 1)
                    END IF
                NEXT
            NEXT
            CALL DrawField(M())
            KeyFree
        LOOP UNTIL mov = 0
    END IF
    OneMove = score
END FUNCTION

SUB Randomizer (M(), size, num, max)

'Сначала узнать, есть ли место, если нет - game over

        FOR i = 1 TO num
                DO
                        x = INT(RND * size)
                        y = INT(RND * size)
                LOOP UNTIL M(x, y) = 0
                M(x, y) = INT(RND * max) + 1
        NEXT
END SUB

