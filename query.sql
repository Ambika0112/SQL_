create database powerBi;

use powerBi;

-- total sales and profit by year 2021
#select year(orderdate) from sales_data;
select sum(sales_amount), sum(profit),region , year(orderDate) as year from sales_data group by region,year ;

--  top 5 customer based on total purchase

select s.customerId,sum( sales_amount) from customer_data c
join sales_data s on s.customerId = c.customerId
group by s.customerId
order by sum(sales_amount) desc ;

-- Products with >20% discount but positive profit
select productName from sales_data s
join product_data p on p.productId = s.productId
where `Discount (%)` > 20 and profit > 0;

-- Region-wise average discount
select region, avg(`discount (%)`) from sales_data group by region;


-- Product category with highest profit margin
with joined_table as(
select sum(profit)as total_profit ,p.productId from product_data p
join sales_data s on s.productId = p.productId
group by productId
)
select productname , total_profit from product_data p
join joined_table jt on jt.productId = p.productId;