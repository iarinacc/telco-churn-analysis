create or replace view vw_customer_analysis as
select
	-- customer
	c.customer_id,
	c.gender,
	c.age,
	c.under_30,
	c.senior_citizen,
	c.married,
	c.dependents,
	c.number_of_dependents,
	-- location
	c.zip_code,
	z.city,
	z.latitude,
	z.longitude,
	z.population,
	-- services
	s.phone_service,
	s.multiple_lines,
	s.avg_monthly_long_distance_charges,
	s.internet_service,
	s.internet_type,
	s.avg_monthly_gb_download,
	s.online_security,
	s.online_backup,
	s.device_protection_plan,
	s.premium_tech_support,
	s.streaming_tv,
	s.streaming_movies,
	s.streaming_music,
	s.unlimited_data,
	case when s.online_security = 'Yes' then 1 else 0 end
	+ case when s.online_backup = 'Yes' then 1 else 0 end
	+ case when s.device_protection_plan = 'Yes' then 1 else 0 end
	+ case when s.premium_tech_support = 'Yes' then 1 else 0 end
	+ case when s.streaming_tv = 'Yes' then 1 else 0 end
	+ case when s.streaming_movies = 'Yes' then 1 else 0 end
	+ case when s.streaming_music = 'Yes' then 1 else 0 end
	+ case when s.unlimited_data = 'Yes' then 1 else 0 end
	as number_of_services,
	-- account
	a.tenure_months,
    case
    when a.tenure_months <=12 then '1-12'
    when a.tenure_months <=24 then '13-24'
    when a.tenure_months <=36 then '25-36'
    when a.tenure_months <=48 then '37-48'
    when a.tenure_months <=60 then '49-60'
    else '61-72'
    end as tenure_group,
	case
	when a.tenure_months <= 12 then 1
	when a.tenure_months <= 24 then 2
	when a.tenure_months <= 36 then 3
	when a.tenure_months <= 48 then 4
	when a.tenure_months <= 60 then 5
	else 6
	end as tenure_group_order,
	a.contract,
	a.offer,
	a.paperless_billing,
	a.payment_method,
	a.referred_friend,
	a.number_referrals,
	a.monthly_charge,
    case 
    when a.monthly_charge <=20 then '1-20'
	when a.monthly_charge <=40 then '21-40'
    when a.monthly_charge <=60 then '41-60'
    when a.monthly_charge <=80 then '61-80'
    when a.monthly_charge <=100 then '81-100'
    else '101-120'
    end as monthly_charge_group,
    case
	when a.monthly_charge <= 20 then 1
	when a.monthly_charge <= 40 then 2
	when a.monthly_charge <= 60 then 3
	when a.monthly_charge <= 80 then 4
	when a.monthly_charge <= 100 then 5
	else 6
	end as monthly_charge_group_order,
	a.total_charges,
	a.total_refunds,
	a.total_extra_data_charges,
	a.total_long_distance_charges,
	a.total_revenue,
	-- churn
	cs.customer_status,
case 
when cs.customer_status = 'Joined' then 0
else 1
end as is_existing_customer,
	cs.churn_label,
	cs.churn_value,
	cs.churn_score,
	cs.satisfaction_score,
	cs.cltv,
	cs.churn_category,
	cs.churn_reason
from customers c
join zip_codes z on c.zip_code = z.zip_code
join services s on c.customer_id = s.customer_id
join accounts a on c.customer_id = a.customer_id
join churn_status cs on c.customer_id = cs.customer_id;

select count(*) from vw_customer_analysis;

select is_existing_customer, count(*) as customers
from vw_customer_analysis
group by is_existing_customer;
