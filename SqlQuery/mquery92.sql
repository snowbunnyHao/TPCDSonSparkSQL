select
   sum(ws_ext_discount_amt)  as Excess_Discount_Amount
from
    web_sales ws1
   ,item i1
   ,date_dim d1
   JOIN (select
            1.3 * avg(ws2.ws_ext_discount_amt) avg,ws_item_sk
         from
            web_sales ws2
           ,date_dim d2
         where d2.d_date between cast('1998-03-18' as date) and
                        (cast('1998-03-18' as date) + interval '90' day)          
          and d2.d_date_sk = ws2.ws_sold_date_sk
          group by ws_item_sk
      ) a1 on  a1.ws_item_sk = i1.i_item_sk   
where
i1.i_manufact_id = 269
and i1.i_item_sk = ws1.ws_item_sk
and d1.d_date between cast('1998-03-18' as date) and
      (cast('1998-03-18' as date) + interval '90' day)
and d1.d_date_sk = ws1.ws_sold_date_sk
and ws1.ws_ext_discount_amt
     > a1.avg
order by sum(ws_ext_discount_amt)
limit 100;