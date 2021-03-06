select  c_customer_id,c_salutation,c_first_name,c_last_name,ca_street_number,ca_street_name
                   ,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset
                   ,ca_location_type,ctr_total_return
 from (
 select  cr_returning_customer_sk as ctr_customer_sk
        ,ca_state as ctr_state,
        sum(cr_return_amt_inc_tax) as ctr_total_return
 from catalog_returns
     ,date_dim
     ,customer_address
 where catalog_returns.cr_returned_date_sk = date_dim.d_date_sk
   and d_year =1998
   and catalog_returns.cr_returning_addr_sk = customer_address.ca_address_sk
 group by cr_returning_customer_sk, ca_state 
) ctr1
     ,customer_address
     ,customer
     JOIN ( select avg(ctr_total_return)*1.2 as avg,ctr_state
           from (
 select  cr_returning_customer_sk as ctr_customer_sk
        ,ca_state as ctr_state,
        sum(cr_return_amt_inc_tax) as ctr_total_return
 from catalog_returns
     ,date_dim
     ,customer_address
 where catalog_returns.cr_returned_date_sk = date_dim.d_date_sk
   and d_year =1998
   and catalog_returns.cr_returning_addr_sk = customer_address.ca_address_sk
 group by cr_returning_customer_sk, ca_state 
) ctr2
           group by ctr_state) a1 on ctr1.ctr_state = a1.ctr_state
 where ctr1.ctr_total_return >  a1.avg
       and ca_address_sk = c_current_addr_sk
       and ca_state = 'IL'
       and ctr1.ctr_customer_sk = c_customer_sk
 order by c_customer_id,c_salutation,c_first_name,c_last_name,ca_street_number,ca_street_name
                   ,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset
                  ,ca_location_type,ctr_total_return
limit 100