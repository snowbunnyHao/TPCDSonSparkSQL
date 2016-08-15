select  segment, count(*) as num_customers, segment*50 as segment_base 
 from  (select cast((revenue/50) as int) as segment
  from   ( select  c_customer_sk,
        sum(ss_ext_sales_price) as revenue
 from   (
 select  c_customer_sk
        , c_current_addr_sk
 from
        ( select c_customer_sk, c_current_addr_sk
        from   catalog_sales,
         date_dim,
         item,
         customer
 where   cs_sold_date_sk = d_date_sk
         and cs_item_sk = i_item_sk
         and i_category = 'Jewelry'
         and i_class = 'consignment'
         and c_customer_sk = cs_bill_customer_sk
         and d_moy = 3
         and d_year = 1999
          union all
          select c_customer_sk, c_current_addr_sk     
          from   web_sales,
         date_dim,
         item,
         customer
 where   ws_sold_date_sk = d_date_sk
         and ws_item_sk = i_item_sk
         and i_category = 'Jewelry'
         and i_class = 'consignment'
         and c_customer_sk = ws_bill_customer_sk
         and d_moy = 3
         and d_year = 1999
         ) cs_or_ws_sales
 ) my_customers,
        store,
        customer_address,
        (select ss_customer_sk, ss_ext_sales_price 
        from store_sales, date_dim
        ,(select distinct d_month_seq+1 as a
                                 from   date_dim where d_year = 1999 and d_moy = 3) a1
        ,(select distinct d_month_seq+3 as a
                                 from   date_dim where d_year = 1999 and d_moy = 3) a2
        where   ss_sold_date_sk = d_date_sk
    and d_month_seq between a1.a and a2.a ) x
 where  c_current_addr_sk = ca_address_sk
        and  ca_county = s_county
        and ca_state = s_state
        and c_customer_sk = ss_customer_sk
 group by c_customer_sk) my_revenue
 ) segments
 group by segment
 order by segment
limit 100
