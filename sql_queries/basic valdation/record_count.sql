/********************************************
*get basic record counts
*********************************************/
select count(customer_id) from customer_old;
select count(customer_id) from customer_new;
select count(order_id) from orders;
/************************************************
*Counts are the same between customer old and new
************************************************/
select (select count(customer_id) from customer_old) as old_count,
       (select count(customer_id) from customer_new) as new_count,
case
   when (select count(customer_id) from customer_old) = 
   (select count(customer_id) from customer_new)
   then  'Pass'
   else 'Failed'
   end as test_results;
/*******************************************************
*make sure all customers came over from old to new tables
********************************************************/
SELECT customer_id
FROM customer_old

EXCEPT

SELECT customer_id
FROM customer_new;
/*********************************************************
*Make sure all customers in new are also in old
**********************************************************/
SELECT customer_id
FROM customer_new

EXCEPT

SELECT customer_id
FROM customer_old
