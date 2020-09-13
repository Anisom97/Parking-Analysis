

--Creating data base ; name of the database PARKINGDATA for better understanding

Create database parkingdata;

use parkingdata;

--Create table 

CREATE Table mallsandsupermarket
(
   --ID int identity,
   MallsPlaceId nvarchar,
   DateTimeStamp datetime,
   --Occupancy float(5)
)



SELECT * from mallsandsupermarket;


Declare @RandomMallsPlaceID int;
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

    Select @RandomMallsPlaceID = Round(((@IdUpperLimitNumber - @IdLowerLimitNumber) * Rand()) + @IdLowerLimitNumber, 0)

    SELECT @RandomDateTimeStamp = DATEADD(MINUTE, @minuteInterval * @count, @start);

	Insert Into mallsandsupermarket values (@RandomMallsPlaceID, @RandomDateTimeStamp)

    Set @count = @count + 1

End


------------querying from table------------------------------------------

Select * from mallsandsupermarket;

Select count(*) from mallsandsupermarket;


----------------------------FINAL TABLE NAME : mallsandsupermarkettb------------------------------------------
								
----------------------New final table will data and column---------------------------------------

Select z.MallsPlaceId,
		z.DateTimeStamp,
		z.OccupancyPercent into mallsandsupermarkettb from 
		(select *, 
		OccupancyPercent=case
						when DATEPART(hh,datetimestamp) >= 6 AND DATEPART(hh,datetimestamp) <= 8 
						then abs(Round((30 - 20) * Rand(checksum(newid())) + 20, 0))
						when DATEPART(hh,datetimestamp) >= 9 AND DATEPART(hh,datetimestamp) <= 11 
						then abs(Round((40 - 30) * Rand(checksum(newid())) + 30, 0))
						when DATEPART(hh,datetimestamp) >= 12 AND DATEPART(hh,datetimestamp) <= 14 
						then abs(Round((40 - 32) * Rand(checksum(newid())) + 32, 0))
						when DATEPART(hh,datetimestamp) >= 15 AND DATEPART(hh,datetimestamp) <= 17 								
						then abs(Round((55 - 45) * Rand(checksum(newid())) + 45, 0))
						when DATEPART(hh,datetimestamp) >= 18 AND DATEPART(hh,datetimestamp) <= 20 
						then abs(Round(((75 - 65) * Rand()) + 65, 0))
						when DATEPART(hh,datetimestamp) >= 21 AND DATEPART(hh,datetimestamp) <= 23 
						then abs(Round((40 - 30) * Rand(checksum(newid())) + 30, 0))
						when DATEPART(hh,datetimestamp) >= 0 AND DATEPART(hh,datetimestamp) <= 2 
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						when DATEPART(hh,datetimestamp) >= 3 AND DATEPART(hh,datetimestamp) <= 5 
						then abs(Round((15 - 5) * Rand(checksum(newid())) + 5, 0))
						else 'Null'
						End 
		from mallsandsupermarket) 
		as z ;

		drop table  mallsandsupermarkettb;
		
Select * from mallsandsupermarkettb;


------------------------------------------------------------------------------------------------------------









