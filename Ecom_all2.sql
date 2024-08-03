create table ecom_all2(
	order_line int,
	order_id varchar,
	order_date date,
	ship_date date,
	ship_mode varchar,
	customer_id varchar,
	product_id varchar,
	sales double precision,
	quantity double precision,
	discount double precision,
	profit double precision,
	customer_name varchar,	
	segment	varchar,
	age int	,
	country varchar,
	city varchar,
	state varchar,
	postal_code int,
	region varchar	,
	category varchar,
	sub_category varchar,
	product_name varchar

)

copy ecom_all2 from 'C:\DA-7\POWERBI\ecom_all2.csv' DELIMITER ',' csv header
 
select * from ecom_all2

select distinct order_line, order_id, order_date, ship_date, ship_mode, customer_id,
	product_id,sales,quantity, discount, profit from ecom_all2

create table sales as 
select distinct order_line, order_id, order_date, ship_date, ship_mode, customer_id,
	product_id,sales,quantity, discount, profit from ecom_all2


select * from sales

select * from ecom_all2

select distinct customer_id, customer_name,segment,age,country,city,state,postal_code, region from ecom_all2

create table customer as
select distinct customer_id, customer_name,segment,age,country,city,state,postal_code, region from ecom_all2


select * from customer

select * from sales as s
inner join customer as c
on s.customer_id = c.customer_id

select * from customer
select distinct postal_code, city,state,region, country from customer

create table product as
select distinct product_id,category,sub_category,product_name from ecom_all2

select * from product
select distinct category,sub_category,product_name from ecom_all2

create table sub_dim_product_category as
select distinct category,sub_category from product 
select * from sub_dim_product_category

alter table sub_dim_product_category
add column category_id serial primary key;
select * from product

select p.product_id,p.product_name,su.category_id from product as p
inner join sub_dim_product_category as su
on p.sub_category=su.sub_category

create table dim_product as
select p.product_id,p.product_name,su.category_id from product as p
inner join sub_dim_product_category as su
on p.sub_category=su.sub_category
select * from dim_product

select * from customer

select distinct postal_code, city, state, region from customer
	
create table dim_customer_region as 
select distinct postal_code, city, state, region from customer

select*from dim_customer_region

select* from customer

select customer_id, customer_name, age, postal_code from customer

create table dim_customer as
select customer_id, customer_name,age, postal_code from customer

select*from dim_customer
select distinct age from customer
	

select distinct age from customer
select distinct postal_code from customer

create table sub_dim_customer_age_category as 
select distinct age,
case
  when age<= 21 then 'teenage'
  when age<= 35 then 'adult'
  when age<= 55 then 'senior'
  else 'elder'
end as age_category 
from customer;
select * from sub_dim_customer_age_category