                   --  SUPERSTORE  --

select * from superstore_data;

-- Total Sale 
select sum(`Price Per Each` * Quantity * (1-Discount)) as Total_sale from superstore_data;


-- Total Buy Price
select sum(`Buy Price` * Quantity) as Total_buy_price from superstore_data;


-- Total Profit 
select sum(`Price Per Each` * Quantity * (1-Discount))-sum(`Buy Price` * Quantity) as Total_profit from superstore_data;


-- Total Products 
select count(Distinct `Product Name`) as Total_product from superstore_data;


-- Total Orders
select count(Distinct `Order ID`) as Total_Orders from superstore_data;


-- Total Customer
select count(distinct `Customer Name`) as Total_Customer from superstore_data;


-- Top 5 Customers by Order
SELECT `Customer Name`, COUNT(`Order ID`) as Orders FROM superstore_data
GROUP BY `Customer Name`
ORDER BY COUNT(`Order ID`) DESC
LIMIT 5;


-- Top 5 Profitable Product
SELECT `Product Name`, sum(`Price Per Each` * Quantity * (1-Discount))-sum(`Buy Price` * Quantity) as Profit FROM superstore_data
GROUP BY `Product Name`
ORDER BY Profit DESC
LIMIT 5; 


-- Order by Product
select `Product Name`, count(`Order ID`) as Orders from superstore_data
group by `Product Name` 
order by Orders DESC;


-- Total products by category
select Category, Count(`Product ID`) as Total_Products from superstore_data
group by Category
order by Total_Products;


-- Total Products by sub-category
select Category,`Sub-Category`,count(`Sub-Category`) Total_Products from superstore_data
group by Category,`Sub-Category`;


-- Total orders by region
select Region, count(`Order ID`) as Total_Orders from superstore_data
group by Region;


-- Display the product category, product sub-category and the sale within each sub-category.
select Category,`Sub-Category`, sum(Quantity*`Price Per Each`*(1-Discount)) as Sale from superstore_data
group by Category,`Sub-Category`;


--  Write a query to list the distict products
select distinct `Product Name` from superstore_data;


--  Write a query to find which product has highest number of Customers
select `Product Name`,count(`Customer ID`) as Customers from superstore_data
group by `Product Name`
order by Customers desc
limit 1;


-- -- Write a query to list all the products purchased by 'William Brown'
select `Product Name`, count(Quantity) as Qty from superstore_data
where `Customer Name` like 'William Brown'
group by `Product Name`;


-- Write a query to pull the customer who order the 2nd highest number of products.
select `Customer Name`, count(`Order ID`) as Orders from superstore_data
group by `Customer Name`
order by Orders desc
limit 1,1;


-- Find the region with highest number of customers.
select Region,count(`Customer Name`) as No_of_Customers from superstore_data
group by Region
order by No_of_Customers desc
limit 1;


-- Write a query to find for every year how many orders shipped 
select year(`Ship Date`) as Year , count(`Order ID`) Total_orders from superstore_data
group by Year
order by Year;


-- Display the number of customers in each region in decreasing order of no_of_customers. 
	-- The result should contain columns Region, no_of_customers
select Region, count(`Customer ID`) as No_of_customer from superstore_data
group by Region
order by No_of_customer desc;
     

-- Write a query to find Customers and its Total Purches
select `Customer ID`,`Customer Name`,sum(`Price Per Each` * Quantity * (1-Discount)) as Total_Purches from superstore_data
group by `Customer ID`,`Customer Name`
order by Total_Purches desc;
   
   
-- Write a query to find year wise sale 
select year(`Order Date`), sum(`Price Per Each` * Quantity * (1-Discount)) as Total_Sale from superstore_data
group by year(`Order Date`);

-- Write a query to find max number of orders from which month 
select year(`Order Date`) as Year , monthname(`Order Date`) as Month, count(`Order ID`) as Orders from superstore_data
group by year(`Order Date`),monthname(`Order Date`)
order by Orders desc
limit 1;

   
--  Create a stored procedure that takes a customer's ID as input and returns Customer Name , Segment and total number of orders
delimiter $
create procedure Customer_Details(`Customer ID` int) 
begin
select `Customer ID`,`Customer Name`,Segment,count(`Order ID`) as Total_Orders from superstore_data
group by `Customer ID`,`Customer Name`,Segment
order by Total_Orders desc;
end $
delimiter ;

call Customer_Details(152118); 













