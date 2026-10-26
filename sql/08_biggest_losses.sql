select
offer,
count(*) as customers,
round(avg(churn_value) * 100, 2) as churn_rate_pct,
round(avg(tenure_months), 1) as avg_tenure_months,
round(avg(case when tenure_months <= 12 then 1 else 0 end) * 100, 2) as pct_first_year
from vw_customer_analysis
group by offer
order by churn_rate_pct desc;

-- offer E has a bigger churn rate but also all its clients are new
-- offer A and B who have the lowest churn rate also have loyal customers
-- time spent with the company is a bigger indicator for churn than offers


with customers_flagged as (
select
customer_id,
churn_value,
monthly_charge,
case
when contract = 'Month-to-Month'
and tenure_months <= 12
and premium_tech_support = 'No'
then 'High-risk' else 'Other'
end as risk_profile
from vw_customer_analysis
where is_existing_customer = 1
),
profile_summary as (
select
risk_profile,
count(*) as total_customers,
sum(churn_value) as churned_customers, 
round(avg(churn_value) * 100, 2) as churn_rate_pct,
round(sum(case when churn_value = 1 then monthly_charge else 0 end), 2) as monthly_revenue_lost
from customers_flagged
group by risk_profile
)
select
risk_profile,
total_customers,
churn_rate_pct,
monthly_revenue_lost,
round(total_customers / sum(total_customers) over () * 100, 2) as pct_of_customers
from profile_summary;

-- high-risk customers (month-to-month contract, first year, no premium tech support)
-- high-risk customers represent 20% of existing customers and 49% of all churns


select
churn_category,
count(*) as churned_customers,
round(sum(monthly_charge), 2) as monthly_revenue_lost,
round(sum(monthly_charge) / sum(sum(monthly_charge)) over () * 100, 2) as pct_of_revenue_lost,
round(avg(monthly_charge), 2) as avg_monthly_charge
from vw_customer_analysis
where churn_value = 1
group by churn_category
order by monthly_revenue_lost desc;


select
churn_category,
count(*) as churned_customers,
round(sum(monthly_charge), 2) as monthly_revenue_lost,
round(sum(monthly_charge) / sum(sum(monthly_charge)) over () * 100, 2) as pct_of_revenue_lost,
round(avg(monthly_charge), 2) as avg_monthly_charge
from vw_customer_analysis
where churn_value = 1
group by churn_category
order by monthly_revenue_lost desc;

-- competitor, as a reason for churn, is the most expensive (46.6% monthly revenue lost)
-- customers who leave for competitors were also the ones to pay the most
-- customers who leave because of price actually paid less than the other churners
-- dissatisfaction costs slightly more than attitude

select
tenure_months,
count(*) as churned_customers,
sum(count(*)) over (order by tenure_months) as running_total_churned,
round(sum(count(*)) over (order by tenure_months) / sum(count(*)) over () * 100, 2) as cumulative_pct_churners
from vw_customer_analysis
where churn_value = 1
group by tenure_months
order by tenure_months;

-- the first month is the most important; 1 in 5 customers churn
-- half of all people who churn do so within the first 10 months
-- after about 3 years, churn rate lowers and becomes more stable
