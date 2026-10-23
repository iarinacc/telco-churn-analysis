insert into zip_codes (zip_code, city, latitude, longitude, population)
select distinct
zip_code,
city,
cast(latitude as decimal(9,6)),
cast(longitude as decimal(9,6)),
cast(population as unsigned)
from raw_telco;

select count(*) from zip_codes;

insert into customers (customer_id, gender, age, under_30, senior_citizen, married, dependents, number_of_dependents, zip_code)
select
customer_id,
gender,
cast(age as unsigned),
under_30,
senior_citizen,
married,
dependents,
cast(number_of_dependents as unsigned),
zip_code
from raw_telco;

insert into services (customer_id, phone_service, multiple_lines, avg_monthly_long_distance_charges, internet_service, internet_type, avg_monthly_gb_download, online_security, online_backup, device_protection_plan, premium_tech_support, streaming_tv, streaming_movies, streaming_music, unlimited_data)
select
customer_id,
phone_service,
multiple_lines,
cast(avg_monthly_long_distance_charges as decimal(10,2)),
internet_service,
internet_type,
cast(avg_monthly_gb_download as unsigned),
online_security,
online_backup,
device_protection_plan,
premium_tech_support,
streaming_tv,
streaming_movies,
streaming_music,
unlimited_data
from raw_telco;

insert into accounts (customer_id, tenure_months, contract, offer, paperless_billing, payment_method, referred_friend, number_referrals, monthly_charge, total_charges, total_refunds, total_extra_data_charges, total_long_distance_charges, total_revenue)
select
customer_id,
cast(tenure_months as unsigned),
contract,
offer,
paperless_billing,
payment_method,
referred_friend,
cast(number_referrals as unsigned),
cast(monthly_charge as decimal(10,2)),
cast(total_charges as decimal(10,2)),
cast(total_refunds as decimal(10,2)),
cast(total_extra_data_charges as decimal(10,2)),
cast(total_long_distance_charges as decimal(10,2)),
cast(total_revenue as decimal(10,2))
from raw_telco;

insert into churn_status (customer_id, customer_status, churn_label, churn_value, churn_score, satisfaction_score, cltv, churn_category, churn_reason)
select
customer_id,
customer_status,
churn_label,
case when churn_label = 'Yes' then 1 else 0 end,
cast(churn_score as unsigned),
cast(satisfaction_score as unsigned),
cast(cltv as unsigned),
nullif(trim(churn_category), ''),
nullif(trim(replace(churn_reason, '\r', '')), '')
from raw_telco;

select count(*) from customers;
select count(*) from services;
select count(*) from accounts;
select count(*) from churn_status;
select count(*) from churn_status where churn_reason is null;

select count(*) from customers c
left join zip_codes z on c.zip_code = z.zip_code
where z.zip_code is null;

select count(*) from services
where internet_service = 'No'
and (online_security = 'Yes' or online_backup = 'Yes'
or device_protection_plan = 'Yes' or premium_tech_support = 'Yes'
or streaming_tv = 'Yes' or streaming_movies = 'Yes'
or streaming_music = 'Yes' or unlimited_data = 'Yes');

select customer_status, count(*) as customers
from churn_status
group by customer_status;
