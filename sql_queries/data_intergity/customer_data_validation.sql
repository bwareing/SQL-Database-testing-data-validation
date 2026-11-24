/******************************************************************
*Make sure email came through correctly  and was not null one 
*either table
*******************************************************************/
select c_old.customer_id,c_old.email as old_email, c_new.email as new_email,
case when c_new.customer_id is Null
   then 'Customer missing'
   else 'Pass'
   end as Customer_check
,
case when c_new.email = c_old.email
   then 'Pass'
   when c_new.email is Null and c_old.email is not Null then 'email dropped'
   when c_new.email is not Null and c_old.email is not Null and c_new.email <> c_old.email then 'email mismacth'
   when c_old.email is null then 'email not there orgnially'
   else 'Fail'
end as email_same 
from customer_old c_old
left join customer_new c_new 
on c_old.customer_id = c_new.customer_id;
/******************************************************************
* see if any extra emails got added during migration
********************************************************************/
select 'extra email added' as test_name,
case when (select count(*) from(
   select c_new.customer_id
   from customer_old c_old
   right join customer_new c_new
   on c_old.customer_id = c_new.customer_id
   where c_old.customer_id is null
)) > 0
then 'Fail'
else 'Pass'
end as extra_cumstomers;
/**********************************************************************
*make sure no customer of the same id exist or have the same email
************************************************************************/
select 'duplicate id' as test_name,
case 
    when (select count(*) 
    from (
    select customer_id 
    from customer_new
    group by customer_id
    having count(*) > 1
)duplicates
) > 0
then 'fail'
else 'pass'
end as duplicate_id

union all

select 'duplicate email' as test_name,
case 
    when(select count(*)
         from(
            select email
            from customer_new
            group by email
            having count(*) > 1
         )duplicate
         ) > 0
      then 'fail'
      else 'pass'
   end as duplicate_email;
/************************************************************************
*Make sure no null email exist in new table
**************************************************************************/
select 'Null email' as test_name, 
case 
   when(select count(*)
     from (
       select email
       from customer_new
       where email is Null
     )) > 0
     then 'fail'
     else 'pass'
     end as  email_null;
/*****************************************************************************
*Check email format is correct
******************************************************************************/
select 'Email @sign' as test_name,
   case when(select count(*)
        from (
         select email 
         from customer_new
         where email not like '%@%'
        )) > 0
        then 'fail'
        else 'pass'
        end as email_format_at_sign

 union all

 select 'Email . sign' as test_name,
   case when(select count(*)
        from (
         select email 
         from customer_new
         where email not like '%.%'
        )) > 0
        then 'fail'
        else 'pass'
        end as email_format_missing_period;
