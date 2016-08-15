 select c_customer_id,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag
       ,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address
       ,c_last_review_date,ctr_total_return
 from (select  wr_returning_customer_sk as ctr_customer_sk
         ,ca_state as ctr_state,
     sum(wr_return_amt) as ctr_total_return
  from web_returns
      ,date_dim
      ,customer_address
  where wr_returned_date_sk = d_date_sk
   and d_year =2002
   and wr_returning_addr_sk = ca_address_sk
  group by wr_returning_customer_sk, ca_state
) ctr1
     ,customer_address
     ,customer
     JOIN ( select avg(ctr_total_return)*1.2 avg
               from (select  wr_returning_customer_sk as ctr_customer_sk
         ,ca_state as ctr_state,
     sum(wr_return_amt) as ctr_total_return
  from web_returns
      ,date_dim
      ,customer_address
  where wr_returned_date_sk = d_date_sk
   and d_year =2002
   and wr_returning_addr_sk = ca_address_sk
  group by wr_returning_customer_sk, ca_state
) ctr2) ctr3 on ctr1.ctr_total_return > ctr3.avg
 where ca_address_sk = c_current_addr_sk
       and ca_state = 'IL'
       and ctr1.ctr_customer_sk = c_customer_sk
 order by c_customer_id,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag
                  ,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address
                  ,c_last_review_date,ctr_total_return
 limit 100;