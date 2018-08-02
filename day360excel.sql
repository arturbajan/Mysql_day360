CREATE DEFINER=`root`@`localhost` FUNCTION `dni360excel`(`data_przeter` DATETIME, `data_st` DATETIME) RETURNS int(11)
    DETERMINISTIC
BEGIN
declare wynik integer;
set wynik=(CASE
WHEN
            LAST_DAY(data_przeter) = data_st
        THEN
            0

        WHEN
            LAST_DAY(data_przeter) = data_przeter
        THEN
            (PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
                    DATE_FORMAT(data_st, '%Y%m')) * 30) + (30 - (TO_DAYS(LAST_DAY(data_przeter)) - TO_DAYS(data_przeter))) - 1
                    
           WHEN
            LAST_DAY(data_przeter) = data_przeter or day(LAST_DAY(data_przeter))=28
        THEN
            (PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
                    DATE_FORMAT(data_st, '%Y%m')) * 30) + (30 - (TO_DAYS(LAST_DAY(data_przeter)) - TO_DAYS(data_przeter))) - 3
        
                  
        WHEN
            LAST_DAY(data_przeter) = data_przeter or day(LAST_DAY(data_przeter))=29
        THEN
            (PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
                    DATE_FORMAT(data_st, '%Y%m')) * 30) + (30 - (TO_DAYS(LAST_DAY(data_przeter)) - TO_DAYS(data_przeter))) - 2 
                    
         when    PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
            DATE_FORMAT(data_st, '%Y%m')) in (3,5,8,10)   then    (PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
                    DATE_FORMAT(data_st, '%Y%m')) * 30) + (30 - (TO_DAYS(LAST_DAY(data_przeter)) - TO_DAYS(data_przeter))) - 1  
                    
        ELSE (PERIOD_DIFF(DATE_FORMAT(data_przeter, '%Y%m'),
                DATE_FORMAT(data_st, '%Y%m')) * 30) + (30 - DAY(data_przeter))
    END);
RETURN if(wynik>40000,0,wynik);

END
