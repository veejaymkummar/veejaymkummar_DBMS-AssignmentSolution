/*Delete the database if it exists */
DROP Database IF EXISTS TravelOnTheGo;

/*Create the database also check for duplication*/
Create Database if not exists TravelOnTheGo;
/* After Creating Use the Database*/
Use TravelOnTheGo;

/* Create the table as per the specification in the assignment the lenght of the varchar i have assumed*/
/*Create Passenger table*/
Create Table PASSENGER (
Passenger_name varchar(255),
Category varchar(255),
Gender varchar(1),
Boarding_City varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(50)
);
/*Create Price Table*/
Create Table Price
( Bus_Type varchar(50),
Distance int,
Price int 
);
/*Showind empty tables post creating them*/
Select * from PASSENGER;
Select * from Price;

/* inserting multiple values in the Passenger table as per the assignment*/
Insert into PASSENGER (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type)
values ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
('Khushboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),
('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
('Hemant', 'Non-AC', 'M', 'panji', 'Mumbai', 700, 'Sleeper'),
('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

/* Showing the data post inserting the data */
Select * from Passenger;

/* inserting multiple values in the Price table as per the assignment*/
Insert into price
(Bus_Type,Distance,Price)
values
('Sleeper',350,770),
('Sleeper',500,1100),
('Sleeper',600,1320),
('Sleeper',700,1540),
('Sleeper',1000,2200),
('Sleeper',1200,2640),
('Sleeper',1500,2700),
('Sitting',500,620),
('Sitting',600,744),
('Sitting',700,868),
('Sitting',1000,1240),
('Sitting',1200,1488),
('Sitting',1500,1860);
/* Showing the data from price table post inserting the data*/
Select * from price;

/* Query section against the tables as per the questions in the assignment*/

/* Q3  Count of Female and Males who travelled minimum of 600 KM*/
Select Gender, count(Gender) as CountofPassengers from Passenger where Distance <= 600 Group by Gender;

/*Q4 Minimum price for Sleeper type using min function */
Select Min(price) from price where Bus_Type ='Sleeper';

/* Q5 All Passengers whose name starts with S  */
Select Passenger_name from Passenger Where substring(Passenger_name,1,1) ='S';

/* Q6 price for each passenger basis the distance and Bus type  */
Select
PASSENGER.Passenger_name,
PASSENGER.Boarding_City,
PASSENGER.Destination_City,
PASSENGER.Bus_Type, Price.Price
/* left join the passenger with price table on both distance and bus type*/
from PASSENGER left join
		Price ON PASSENGER.Distance = Price.Distance AND PASSENGER.Bus_Type = Price.Bus_Type;

/*Q7 Name of the passenger/s travelling in Sitting bus and a distance of 1000 KM */
Select PASSENGER.Passenger_name
from PASSENGER
left Join Price ON PASSENGER.Distance = Price.Distance AND PASSENGER.Bus_Type = Price.Bus_Type
Where (PASSENGER.Distance = 1000) AND (PASSENGER.Bus_Type = 'Sitting');

/* Q8  Displaying the Sitting and sleeper options for pallavi for bengaluru to panaji */
Select   PASSENGER.Passenger_name , 
'Bengaluru' as Boarding_City,
'Panaji' as Destination_City, 
Passenger.Distance, 
Price.Bus_Type, Price.Price
from PASSENGER inner join Price ON PASSENGER.Distance = Price.Distance
Where (PASSENGER.Passenger_name = 'Pallavi');     

/* Q9 Distinct distances in the decending order from passenger table */
Select Distinct Distance from Passenger Order by Distance DESC;

/* Q10 Displaying name of the passenger along with the distance each passenger travelled with a coulmn of 
sum of total disctance travelled by all passengers and also the %age of the distance travelled by the passenger
against the total */
SELECT Passenger_name, Distance as Distance_Travelled_by_Passenger, 
(Select Sum(Distance) as Total from Passenger) as Total_Distance,
Concat(distance/((SELECT SUM(Distance) AS Total1 FROM PASSENGER) /100),' %') AS Percentage_of_Total_Distance
FROM PASSENGER;

/* Q11 Categorising each price tag into Expensive, Average cost and Cheap basis the conditions in the assignement */
SELECT Distance, Price,
case
When price >1000 then "Expensiveprice"
When  price <1000 And Price > 500 then "Average Cost"
else "Cheap"
end
as Category
From Price