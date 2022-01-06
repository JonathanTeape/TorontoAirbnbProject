--Showing all Data from maindata set - "Listings$"
select *
from PortfolioProject..Listings$ 

--Showing how many distinct niehgbours are within the dataset
select COUNT(Distinct host_neighbourhood)
from PortfolioProject..Listings$ 

--Showing average price per neighbourhood
select neighbourhood_cleansed,AVG(price) as Average_Price
from PortfolioProject.dbo.Listings$
Group by neighbourhood_cleansed
Order by neighbourhood_cleansed asc

--Showing the chepeast AIRBNB per neighbourhood per night
select neighbourhood_cleansed,MIN(price) as Cheapest_Price
from PortfolioProject.dbo.Listings$
Group by neighbourhood_cleansed
Order by neighbourhood_cleansed asc

--Showing average price per Bedroom 
select bedrooms, AVG(price) as Average_Price
from PortfolioProject.dbo.Listings$
where bedrooms is not null 
Group by bedrooms
Order by bedrooms asc

--Showing average price per proprty type
select property_type,AVG(price) as Average_Price
from PortfolioProject.dbo.Listings$
Group by property_type
Order by property_type 

--Showing specified neighbourhood,listing_id,host_response_time within an hour and host_response_rate , host_acceptance_rate = 100%
--Unable to cast host_response_rate to int due to N/A values. Used above workaround
select listing_id,host_response_time, host_response_rate , host_acceptance_rate, neighbourhood_cleansed 
from PortfolioProject.dbo.Listings$
where host_response_rate not in ('N/A') and  host_acceptance_rate like ('100%') and host_response_rate like ('100%') and host_response_time like  ('within an hour') and neighbourhood_cleansed like ('Annex')
order by host_response_time desc

--Showing listing IDs that have a score rating of and a number of reviews are greater then 25 
select listing_id, review_scores_rating, number_of_reviews
from PortfolioProject.dbo.Listings$
Where review_scores_rating =5 and number_of_reviews >=25
Order by number_of_reviews desc

--Interchangeable keyword search in comments database 
Select listing_id,comments
from PortfolioProject.dbo.Reviews$
Where comments like '%quiet' -- interchangeable keyword 

--Interchangeable keyword search in comments database with JOIN on Listings$ DB to narrow price  
select neighbourhood_cleansed, comments, price 
from PortfolioProject..Listings$ list
JOIN PortfolioProject..Reviews$ rev
ON list.listing_id=rev.listing_id 
where price < 120 and comments like '%quiet' -- interchangeable keyword 
Group by comments, neighbourhood_cleansed,price
Order by neighbourhood_cleansed asc
