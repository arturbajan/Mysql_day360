CREATE DEFINER=`root`@`%` FUNCTION `days360gl`(
	`data_st` DATETIME,
	`data_ko` DATETIME
)
RETURNS int(11)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
declare wynik int;
set wynik=
(case when data_st is null or  data_st<'1990-01-01' then 0 else 
cast(((year(data_ko)-year(data_st))*360)+ 
((month(data_ko)-month(data_st)-1)*30)+
((30- (case when day(data_st)=31 then 30.0 else day(data_st) end))+
DAY(data_ko)) as decimal(18)) end);
RETURN wynik;
END