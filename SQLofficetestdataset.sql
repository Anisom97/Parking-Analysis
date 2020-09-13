
use parkingdatamain;

CREATE Table officeITareatest
(
  
   OfficeITPlaceId nvarchar,
   DateTimeStamp datetime,
   
)

drop table officeITareatest;

Declare @RandomPlaceID int;
Declare @RandomDateTimeStamp datetime;

Declare @IdLowerLimitNumber int;
Declare @IdUpperLimitNumber int;

Set @IdLowerLimitNumber = 1
Set @IdUpperLimitNumber = 4

DECLARE @start DATETIME = '2015-01-01 00:00:00';
DECLARE @end DATETIME = '2015-03-05 00:00:00';
DECLARE @minuteInterval INT = 5;

DECLARE @countNum INT = DATEDIFF(MINUTE, @start, @end) / @minuteInterval + 1;

Declare @count int
Set @count = 1

While @count <= @countNum
Begin 

    Select @RandomPlaceID = Round(((@IdUpperLimitNumber - @IdLowerLimitNumber) * Rand()) + @IdLowerLimitNumber, 0)

    SELECT @RandomDateTimeStamp = DATEADD(MINUTE, @minuteInterval * @count, @start)

	Insert Into officeITareatest values (@RandomPlaceID, @RandomDateTimeStamp)

    Set @count = @count + 1

End

Select * from officeITareatest;
								

--drop table officeITarea;

Select y.OfficeITPlaceId,
		y.DateTimeStamp,
		y.OccupancyPercent 
		into officeITTbtest from 
		(select *, OccupancyPercent=case
									when DATEPART(hh,datetimestamp) >= 8 AND DATEPART(hh,datetimestamp) <= 13 
									then abs(Round((90 - 80) * Rand(checksum(newid())) + 80, 0))
									when DATEPART(hh,datetimestamp) >= 14 AND DATEPART(hh,datetimestamp) <= 19 
									then abs(Round((75 - 65) * Rand(checksum(newid())) + 65, 0))
									when DATEPART(hh,datetimestamp) >= 20 AND DATEPART(hh,datetimestamp) <= 23
									then abs(Round((40 - 30) * Rand(checksum(newid())) + 30, 0))
									when DATEPART(hh,datetimestamp) >= 0 AND DATEPART(hh,datetimestamp) <= 01
									then abs(Round((40 - 30) * Rand(checksum(newid())) + 30, 0))
									when DATEPART(hh,datetimestamp) >= 2 AND DATEPART(hh,datetimestamp) <= 7 
									then abs(Round((30 - 20) * Rand(checksum(newid())) + 20, 0))
									else cast(null as float)
									End 
		from officeITareatest) 
		as y ;

select * from officeITTbtest;

select count(*) from officeITTbtest;


drop table officeITTbtest;

drop table [dbo].[tblBooks];
drop table [dbo].[tblAuthors];

drop table marketplace;

