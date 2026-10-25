select
churn_category,
count(*) as churned_customers,
round(count(*) / (select count(*) from vw_customer_analysis where churn_value = 1) * 100, 2) as pct_of_churned
from vw_customer_analysis
where churn_value = 1
group by churn_category
order by churned_customers desc;

-- 45% churned due to competitors
-- 16.8% churned due to attitude of staff member/s
-- 16.21% churned due to dissatisfaction
-- 11.29% churned doe to price
-- 10.7% churned due to another reason


select
churn_reason,
count(*) as churned_customers
from vw_customer_analysis
where churn_value = 1
group by churn_reason
order by count(*) desc
limit 5;

-- top 5 reasons for churn include: Competitor had better devices, competitor made better offer,
-- attitude of support person, don't know, competitor offered more data


select
case when internet_type = 'Fiber Optic' then 'Fiber Optic' else 'Other' end as internet_group,
count(*) as churned_customers,
round(sum(case when churn_category = 'Competitor' then 1 else 0 end) / count(*) * 100, 2) as pct_competitor,
round(sum(case when churn_category = 'Attitude' then 1 else 0 end) / count(*) * 100, 2) as pct_attitude,
round(sum(case when churn_category = 'Dissatisfaction' then 1 else 0 end) / count(*) * 100, 2) as pct_dissatisfaction,
round(sum(case when churn_category = 'Price' then 1 else 0 end) / count(*) * 100, 2) as pct_price,
round(sum(case when churn_category = 'Other' then 1 else 0 end) / count(*) * 100, 2) as pct_other
from vw_customer_analysis
where churn_value = 1
group by internet_group;

-- fiber optic customers churn more because of competitors only (47.49% vs. 40.13%)