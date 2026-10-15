create database if not exists telco_churn;
use telco_churn;

drop table if exists raw_telco;

create table raw_telco (
	customer_id					varchar(20),
    gender						varchar(10),
    age							varchar(5),
    under_30					varchar(5),
    senior_citizen				varchar(3),
    married						varchar(3),
    dependents					varchar(3),
    number_of_dependents		varchar(10),
    country						varchar(50),
    state						varchar(50),
    city						varchar(100),
    zip_code					varchar(10),
    latitude					varchar(20),
    longitude					varchar(20),
    population					varchar(20),
    quarter						varchar(5),
    referred_friend				varchar(5),
    number_referrals			varchar(10),
    tenure_months				varchar(10),
    offer						varchar(10),
    phone_service				varchar(5),
    avg_monthly_long_distance_charges		varchar(20),
    multiple_lines				varchar(5),
    internet_service			varchar(5),
    internet_type				varchar(20),
    avg_monthly_gb_download		varchar(20),
    online_security				varchar(5),
    online_backup				varchar(5),
    device_protection_plan		varchar(5),
    premium_tech_support		varchar(5),
    streaming_tv				varchar(5),
    streaming_movies			varchar(5),
    streaming_music				varchar(5),
    unlimited_data				varchar(5),
    contract					varchar(50),
    paperless_billing			varchar(5),
    payment_method				varchar(50),
    monthly_charge				varchar(50),
    total_charges				varchar(50),
    total_refunds				varchar(50),
    total_extra_data_charges	varchar(50),
    total_long_distance_charges	varchar(50),
    total_revenue				varchar(100),
    satisfaction_score			varchar(5),
    customer_status				varchar(20),
    churn_label					varchar(5),
    churn_score					varchar(10),
    cltv						varchar(10),
    churn_category				varchar(50),
    churn_reason				varchar(100)
    );
    
    
    select count(*) as total_rows
    from raw_telco;
    
    select count(distinct customer_id) as unique_customers
    from raw_telco;