select count(*) as total_customers, 
sum(churn_value) as churned_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis;

-- churn rate (all customers) is 26.54%

select count(*) as total_customers,
sum(churn_value) as churned_customers,
round(sum(churn_value) / count(*) * 100, 2) as churn_rate
from vw_customer_analysis
where is_existing_customer = 1;

-- churn rate (existing cutomers, without Joined) is 28.37%


select
sum(case when churn_value = 1 then monthly_charge else 0 end) as monthly_revenue_lost,
sum(monthly_charge) as total_monthly_revenue,
round(sum(case when churn_value = 1 then monthly_charge else 0 end)	/ sum(monthly_charge) * 100, 2) as pct_monthly_revenue_lost
from vw_customer_analysis;

-- monthly revenue lost is 139130.85
-- total monthly revenue is 456116.60
-- percentage lost is 30.5%


select 
sum(case when churn_value = 1 then cltv else 0 end) as total_cltv_lost,
round(avg(case when churn_value = 1 then cltv else null end),2) as avg_cltv_churned,
round(avg(case when customer_status = 'Stayed' then cltv else null end),2) as avg_cltv_stayed
from vw_customer_analysis;

-- total cltv lost: 7755256
-- average cltv of churned customers: 4149.41
-- 4530.19


select
customer_status,
count(*) as customers,
round(count(*) / (select count(*) from vw_customer_analysis) * 100, 2) as pct_of_customers
from vw_customer_analysis
group by customer_status;

-- stayed: 4720, 67.02%
-- churned: 1869, 26.54%
-- joined: 454, 6.45%