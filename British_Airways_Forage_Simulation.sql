CREATE DATABASE lounge_analysis;
USE lounge_analysis;
SHOW DATABASES;
SHOW TABLES;

SELECT * FROM `flights data`;
SELECT FLIGHT_NO, ARRIVAL_REGION FROM `flights data`;

SELECT DISTINCT ARRIVAL_REGION FROM `flights data`; #determine number of categories - there are 4

SET SQL_SAFE_UPDATES = 0; #turn off safe updates so I can alter columns

#adding the total passengers column
ALTER TABLE `flights data`
ADD COLUMN Total_Pax INT;

UPDATE `flights data`
SET Total_Pax = FIRST_CLASS_SEATS+ BUSINESS_CLASS_SEATS+ECONOMY_SEATS
WHERE FLIGHT_NO>=0;

#adding tier 1 percent eligibility
ALTER TABLE `flights data`
ADD COLUMN tier_1_percent DECIMAL(5,4);

UPDATE `flights data`
SET tier_1_percent = (TIER1_ELIGIBLE_PAX/Total_Pax)
WHERE TIER1_ELIGIBLE_PAX>=0;

#adding tier 2 percent eligibility
ALTER TABLE `flights data`
ADD COLUMN tier_2_percent DECIMAL(5,4);

UPDATE `flights data`
SET tier_2_percent = TIER2_ELIGIBLE_PAX/Total_Pax;

#adding tier 3 percent eligiblity
ALTER TABLE `flights data`
ADD COLUMN tier_3_percent DECIMAL(5,4);

UPDATE `flights data`
SET tier_3_percent = TIER3_ELIGIBLE_PAX/Total_Pax;

#find the summary data required
SELECT ARRIVAL_REGION, AVG(tier_1_percent)*100 AS avg_tier_1_percent, AVG(tier_2_percent)*100 AS avg_tier_2_percent, AVG(tier_3_percent)*100 AS avg_tier_3_percent
FROM `flights data`
GROUP BY ARRIVAL_REGION;

#reset the safe updates
SET SQL_SAFE_UPDATES = 1;

