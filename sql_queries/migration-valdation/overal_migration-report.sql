select 'Record count' as test_name, case 
        when (select count(customer_id) from customer_new) = 
        (select count(customer_id) from customer_old)
             then 'Pass'
             else 'Fail'
        end as test_results

union all

select 'Customer_id going from old to new' as test_name, case
      when (select count(*) 
      from ((select customer_id from customer_old) 
      EXCEPT (select customer_id from customer_new))) > 0
      then 'Fail'
      else 'Pass'
      end as test_results

union all

select 'Customer_id going from new to old' as test_name, case
      when (select count(*) 
      from ((select customer_id from customer_new) 
      EXCEPT (select customer_id from customer_old))) > 0
      then 'Fail'
      else 'Pass'
      end as test_results

union all

select 'Customer email migrated correctly' as test_name,
    case when((select count(*)
               from customer_old c_old
               inner join customer_new c_new  
               on c_old.customer_id = c_new.customer_id
               where c_old.email <> c_new.email)) > 0
               then 'Fail'
               else 'Pass'
               end as test_results

union all

select 'Email drop' as test_name,
     case when ((select count(*)
                 from customer_old c_old
                 inner join customer_new c_new
                 on c_old.customer_id = c_new.customer_id
                 where c_new.email is null and c_old.email is not Null)) > 0
                 then 'Fail'
                 else 'Pass'
                 end as test_results;
