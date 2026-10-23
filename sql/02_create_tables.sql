select 
zip_code,
count(distinct city) as cities,
count(distinct latitude) as latitudes,
count(distinct longitude) as longitudes, 
count(distinct population) as populations
from raw_telco
group by zip_code
having count(distinct city) > 1
or count(distinct latitude) > 1
or count(distinct longitude) > 1
or count(distinct population) > 1;

drop table if exists zip_code;

create table zip_codes (
zip_code char(5) not null,
city 	varchar(100) not null,
latitude 	decimal(9,6) not null,
longitude 	decimal(9,6) not null,
population	int not null,
primary key (zip_code)
);

drop table if exists customers;

create table customers (
customer_id 	varchar(20) not null,
gender 	varchar(10) not null,
age 	int not null, 
under_30 	varchar(3) not null, 
senior_citizen 	varchar(3) not null, 
married 	varchar(3) not null, 
dependents 	varchar(3) not null, 
number_of_dependents	int not null,
zip_code 	char(5) not null,
primary key (customer_id),
foreign key (zip_code) references zip_codes (zip_code)
);

drop table if exists accounts;

create table accounts (
customer_id 	varchar(20) not null,
tenure_months 	int not null,
contract 	varchar(20) not null,
offer 	varchar(10) not null, 
paperless_billing 	varchar(3) not null, 
payment_method 	varchar(20) not null, 
referred_friend 	varchar(3) not null,
number_referrals 	int not null, 
monthly_charge 	decimal(10,2) not null,
total_charges 	decimal(10,2) not null,
total_refunds decimal(10,2) not null, 
total_extra_data_charges 	decimal(10,2) not null, 
total_long_distance_charges 	decimal(10,2) not null,
total_revenue 	decimal(10,2) not null,
primary key (customer_id),
foreign key (customer_id) references customers (customer_id)
); 

drop table if exists services;

create table services (
customer_id 	varchar(20) not null,
phone_service 	varchar(3) not null,
multiple_lines 	varchar(3) not null,
avg_monthly_long_distance_charges 	decimal(10,2) not null,
internet_service 	varchar(3) not null,
internet_type 	varchar(20) not null,
avg_monthly_gb_download 	int not null,
online_security 	varchar(3) not null,
online_backup 	varchar(3) not null,
device_protection_plan 	varchar(3) not null,
premium_tech_support 	varchar(3) not null,
streaming_tv 	varchar(3) not null,
streaming_movies 	varchar(3) not null,
streaming_music 	varchar(3) not null,
unlimited_data 	varchar(3) not null,
primary key (customer_id),
foreign key (customer_id) references customers (customer_id)
);

drop table if exists churn_status;

create table churn_status (
customer_id 	varchar(20) not null,
customer_status 	varchar(20) not null,
churn_label 	varchar(3) not null,
churn_value 	tinyint not null,
churn_score 	int not null,
satisfaction_score 	int not null,
cltv 	int not null,
churn_category 	varchar(20),
churn_reason 	varchar(100),
primary key (customer_id),
foreign key (customer_id) references customers (customer_id)
);

-- due to having a single value for all customers, country (United States), state (California) and quarter (Q3)
-- were not included to the final table, for they carry no useful information in analyzing the data