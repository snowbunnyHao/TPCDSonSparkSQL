select  c_customer_id
    from (select sr_customer_sk as ctr_customer_sk
                , sr_store_sk as ctr_store_sk
                , sum(SR_FEE) as ctr_total_return
        from store_returns
        JOIN date_dim ON store_returns.sr_returned_date_sk = date_dim.d_date_sk
        where d_year =2000
        group by sr_customer_sk,sr_store_sk) ctr1
    JOIN store ON ctr1.ctr_store_sk = store.s_store_sk
    JOIN customer ON ctr1.ctr_store_sk = customer.c_customer_sk
    JOIN (select avg(SR_FEE)*1.2 as avgavg
                , sr_customer_sk as ctr_customer_sk
                , sr_store_sk as ctr_store_sk
                , sum(SR_FEE) as ctr_total_return
        from store_returns
        JOIN date_dim ON store_returns.sr_returned_date_sk = date_dim.d_date_sk
        where d_year =2000
        group by sr_customer_sk,sr_store_sk
         ) avgF ON ctr1.ctr_store_sk = avgF.ctr_store_sk and ctr1.ctr_total_return > avgF.avgavg
    where s_state = 'TN'
    order by c_customer_id
    limit 100;