select   i_item_id,sum(total_sales) total_sales
 from  (select * from (
 select i.i_item_id,sum(ss_ext_sales_price) total_sales
 from store_sales,date_dim,customer_address,item i
 ,(select i_item_id
                      from item
          where i_category in ('Children')) x
 where i.i_item_id = x.i_item_id 
           and     ss_item_sk = i_item_sk
           and     ss_sold_date_sk = d_date_sk
           and     d_year = 1999
           and     d_moy = 9
           and     ss_addr_sk = ca_address_sk
           and     ca_gmt_offset = -6 
           group by i.i_item_id) ss 
        union all
        select * from (
 select i.i_item_id,sum(cs_ext_sales_price) total_sales
 from catalog_sales,date_dim,customer_address,item i
      ,(select i_item_id
                      from  item where i_category in ('Children')) y
 where i.i_item_id = y.i_item_id
 and     cs_item_sk              = i_item_sk
 and     cs_sold_date_sk         = d_date_sk
 and     d_year                  = 1999
 and     d_moy                   = 9
 and     cs_bill_addr_sk         = ca_address_sk
 and     ca_gmt_offset           = -6 
 group by i.i_item_id) cs 
        union all
        select * from (
 select i.i_item_id,sum(ws_ext_sales_price) total_sales
 from web_sales,date_dim,customer_address,item i
      ,(select i_item_id
from
 item
where i_category in ('Children')) z
 where i.i_item_id = z.i_item_id
 and     ws_item_sk              = i_item_sk
 and     ws_sold_date_sk         = d_date_sk
 and     d_year                  = 1999
 and     d_moy                   = 9
 and     ws_bill_addr_sk         = ca_address_sk
 and     ca_gmt_offset           = -6
 group by i.i_item_id) ws) tmp1
 group by i_item_id
 order by i_item_id
      ,total_sales
limit 100
;