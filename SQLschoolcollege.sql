
--Create database parkingdata;

use parkingdata;

--Create table 

CREATE Table schoolcollege
(
   --ID int identity,
   PlaceId nvarchar,
   DateTimeStamp datetime,
   --Occupancy float(5)
)



SELECT * from schoolcollege;


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

    SELECT @RandomDateTimeStamp = DATEADD(MINUTE, @minuteInterval * @count, @start);

	Insert Into schoolcollege values (@RandomPlaceID, @RandomDateTimeStamp)

    Set @count = @count + 1

End


------------querying from table------------------------------------------

Select * from schoolcollege;

Select count(*) from schoolcollege;


----------------------------FINAL TABLE NAME : schoolcollegetb------------------------------------------
								
----------------------New final table will data and column---------------------------------------

Select sc.PlaceId,
		sc.DateTimeStamp,
		sc.OccupancyPercent into schoolcollegetb from 
		(select *, 
		OccupancyPercent=case
						when DATEPART(hh,datetimestamp) >= 6 AND DATEPART(hh,datetimestamp) <= 7 
						then abs(Round((90 - 80) * Rand(checksum(newid())) + 80, 0))
						when DATEPART(hh,datetimestamp) >= 8 AND DATEPART(hh,datetimestamp) <= 12 
						then abs(Round((80 - 70) * Rand(checksum(newid())) + 70, 0))
						when DATEPART(hh,datetimestamp) >= 13 AND DATEPART(hh,datetimestamp) <= 15 
						then abs(Round((90 - 80) * Rand(checksum(newid())) + 80, 0))
						when DATEPART(hh,datetimestamp) >= 16 AND DATEPART(hh,datetimestamp) <= 22 								
						then abs(Round((30 - 20) * Rand(checksum(newid())) + 20, 0))
						when DATEPART(hh,datetimestamp) > 22 AND DATEPART(hh,datetimestamp) <= 23 
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						when DATEPART(hh,datetimestamp) > 23 AND DATEPART(hh,datetimestamp) <= 0
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						when DATEPART(hh,datetimestamp) = 0 
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						when DATEPART(hh,datetimestamp) >= 1 AND DATEPART(hh,datetimestamp) <= 6
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						else cast(Null as float)
						End 
		from schoolcollege) 
		as sc ;
		
Select * from schoolcollegetb;

drop table schoolcollegetb;