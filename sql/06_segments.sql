select 
contract, 
count(*) as customers,
round(sum(case when churn_value = 1 then 1 else 0 end) / count(*) * 100, 2) as churn_rate_pct
from vw_customer_analysis
group by contract
order by churn_rate_pct desc;

-- month-to-month: 3610 customers, churn rate 45.84%
-- one year: 1550 customers, churn rate 10.71%
-- two year: 1883 customers, churn rate 2.55%


select 
tenure_group, 
count(*) as customers,
round(sum(case when churn_value = 1 then 1 else 0 end) / count(*) * 100, 2) as churn_rate_pct
from vw_customer_analysis
group by tenure_group
order by churn_rate_pct desc;

-- tenure_group		customers	churn rate percentage
-- 		1-12		2186				47.44
-- 		13-24		1024				28.71
-- 		25-36		832					21.63
-- 		37-48		762					19.03
-- 		49-60		832					14.42
-- 		61-72		1407				6.61


select 
internet_type, 
count(*) as customers,
round(sum(case when churn_value = 1 then 1 else 0 end) / count(*) * 100, 2) as churn_rate_pct
from vw_customer_analysis
group by internet_type
order by churn_rate_pct desc;

-- fiber optic: 3035 cstomers, churn rate 40.72%
-- cable: 830 customers, churn rate 25.66%
-- dsl: 1652 customers, churn rate 18.58%
-- none: 1526 customers, churn rate 7.4%


select 
payment_method, 
count(*) as customers,
round(sum(case when churn_value = 1 then 1 else 0 end) / count(*) * 100, 2) as churn_rate_pct
from vw_customer_analysis
group by payment_method
order by churn_rate_pct desc;

-- mailed check: 385 customers, churn rate 36.88%
-- bank withdrawal: 3909 customers, churn rate 34%
-- credit card: 2749 customers, churn rate 14.48%


select 
offer, 
count(*) as customers,
round(sum(case when churn_value = 1 then 1 else 0 end) / count(*) * 100, 2) as churn_rate_pct
from vw_customer_analysis
group by offer
order by churn_rate_pct desc;

-- offer E: 805 customers, 52.92%
-- none: 3877 customers, 27.11%
-- offer D: 602 customers, 26.74%
-- offer C: 415 customers, 22.89%
-- offer B: 824 customers, 12.26%
-- offer A: 520 customers, 6.73%


select
premium_tech_support,
count(*) as total_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
where internet_service = 'Yes'
group by premium_tech_support;

-- premium tech support, Yes: 2044 customers, churn rate 15.17%
-- premium tech support, No: 3473, churn rate 41.64%

select
online_security,
count(*) as total_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
where internet_service = 'Yes'
group by online_security;

-- online security, Yes: 2019 customers, churn rate 14.61%
-- online security, No: 3498 customers, churn rate 41.77%


select 
number_of_services,
round(avg(churn_value) * 100, 2) as churn_rate
from vw_customer_analysis
group by number_of_services
order by churn_rate desc;

-- number of services: 1 - churn rate 50.22%
-- number of services: 2 - churn rate 40.77%
-- number of services: 3 - churn rate 38.27%
-- number of services: 5 - churn rate 30.57%
-- number of services: 6 - churn rate 20.81%
-- number of services: 7 - churn rate 11.35%
-- number of services: 0 - churn rate 9.40%
-- number of services: 8 - churn rate 4.89%


select
city, 
count(*) as total_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
group by city
having count(*) > 30
and round(sum(churn_value) / count(*) * 100, 2) > 30
order by churn_rate desc;

-- San Diego: 285 customers, 64.91% churn rate
-- Fallbrook: 43 customers, 60.47% churn rate
-- Temecula: 38 customers, 57.89% churn rate
-- Glendale: 40c customers, 32.5% churn rate
-- Escondido: 51 customers, 31.37% churn rate


select 
contract, internet_type,
count(*) as total_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
group by contract, internet_type
order by churn_rate desc
limit 5;

-- top 3 highest churn rate can be found in customers with a month-to-month contarct
-- who also have fiber optic (churn rate 58.82%),
-- cable (44.21% churn rate)
-- dsl (33.29% churn rate)


select 
contract, internet_type,
count(*) as total_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
group by contract, internet_type
order by churn_rate asc
limit 10;

-- among the lowest churn rates are predominantly customers with a two year contract


