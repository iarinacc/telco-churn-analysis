describe vw_customer_analysis;
select count(*) from vw_customer_analysis;

drop table if exists churn_scores;

create table churn_scores (
customer_id 	varchar(20) not null,
churn_probability 	decimal(5,4) not null,
risk_group 	varchar(10) not null,
primary key (customer_id),
foreign key (customer_id) references customers (customer_id)
);