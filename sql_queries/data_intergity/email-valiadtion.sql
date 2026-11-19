/******************************************************************
*Make sure email came through correctly  and was not null one 
*either table
*******************************************************************/
select c_old.email as old_email, c_new.email as new_email,
case when c_new.customer_id is Null
   then 'Customer missing'
   else 'Pass'
   end as Customer_check
,
case when c_new.email = c_old.email
   then 'Pass'
   when c_new.email is Null or c_old.email is Null then 'email missing'
   else 'Fail'
end as email_same 
from customer_old c_old
left join customer_new c_new 
on c_old.customer_id = c_new.customer_id;
