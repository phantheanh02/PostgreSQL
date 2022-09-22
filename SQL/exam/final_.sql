
-- 1.
select orders.orderid, concat(customers.firstname, ' ', customers.lastname) as fullname,
orders.orderdate, orders.totalamount FROM orders
inner join customers using(customerid)
WHERE orders.orderdate >= '2004-06-01' AND orders.orderdate < '2004-07-01'


-- 2.

select * from products WHERE title ilike '%airport%'

-- 3.
select categoryname, count(prod_id) from categories
left join products using(category)
group by category

-- 4.
select * from products WHERE prod_id NOT IN(select distinct prod_id from orderlines WHERE orderdate >= '2004-12-01' and orderdate < '2005-01-01')


-- 5.
select count(distinct customerid) FROM orders 

-- 6.
select max(customers.age) as max_age, min(customers.age) as min_age, avg(customers.age) as avg_age
FROM customers
INNER JOIN orders using(customerid)
INNER JOIN orderlines using(orderid)
INNER JOIN products using(prod_id)
WHERE products.title = 'AIRPORT ROBBERS'

-- 7.
select products.title, count(prod_id) from orderlines 
inner join products using(prod_id)
where orderdate = '2004-06-02'
group by prod_id,products.title
order by count(prod_id) desc

-- 8.
select distinct customers.customerid, concat(customers.firstname,' ', customers.lastname) as name  from customers
inner join orders using(customerid)
WHERE totalamount > 300

-- 9.
select * from (
    select country, count(customerid) as count_customerid from customers
    group by country
) tbl1
left join (
select country, count(orderid) as count_orderid from customers
inner join orders using (customerid)
group by country
) tbl2 using (country) 

-- 10.
select prod_id, products.title, sum(orderlines.quantity) from orders
inner join orderlines using(orderid)
inner join products using(prod_id)
inner join customers using(customerid)
WHERE customers.gender = 'F'
group by prod_id, title
order by sum(orderlines.quantity) desc
limit 1


-- 11.
select avg(
    case when gender = 'F' then income end
) as f_income, 
avg(
    case when gender = 'M' then income end
) as m_income

from orders
inner join customers using(customerid)
WHERE totalamount > 2000