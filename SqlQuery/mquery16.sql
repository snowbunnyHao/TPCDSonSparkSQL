select
   count(distinct cs1.cs_warehouse_sk) as order_count
  ,sum(cs_ext_ship_cost) as total_shipping_cost
  ,sum(cs_net_profit) as total_net_profit
from
   catalog_sales cs1
  ,date_dim
  ,customer_address
  ,call_center
  JOIN (select count(*) c1,cs_warehouse_sk
            from catalog_sales cs2
            group by cs_warehouse_sk) ct1 on cs1.cs_warehouse_sk <> ct1.cs_warehouse_sk
  JOIN (select count(*) c2,cr_order_number
               from catalog_returns cr1
               group by  cr_order_number) ct2 on cs1.cs_warehouse_sk = ct2.cr_order_number
where
    d_date between cast('2000-02-01' as timestamp) and
           (cast('2000-02-01' as timestamp))
and cs1.cs_ship_date_sk = d_date_sk
and cs1.cs_ship_addr_sk = ca_address_sk
and ca_state = 'TX'
and cs1.cs_call_center_sk = cc_call_center_sk
and cc_county in ('Williamson County','Walker County','Ziebach County','Ziebach County',
                  'Ziebach County'
)
and ct1.c1 > 0
and ct2.c2 = 0
order by count(distinct cs1.cs_warehouse_sk)
limit 100;
