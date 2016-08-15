select  i_manufact_id ,sum(total_sales) total_sales
 from  (select * from (
select  
          item.i_manufact_id,sum(ss_ext_sales_price) total_sales
 from
  store_sales,
  date_dim,
        item,
        customer_address
        ,(select  i_manufact_id
        from  item
        where i_category in ('Books')) aba1
 where
    item.i_manufact_id = aba1.i_manufact_id
 and     ss_item_sk              = i_item_sk
 and     ss_sold_date_sk         = d_date_sk
 and     d_year                  = 1999
 and     d_moy                   = 3
 and     ss_addr_sk              = ca_address_sk
 and     ca_gmt_offset           = -5
 group by item.i_manufact_id) aaa
        union all
        select * from (
 select  
          item.i_manufact_id,sum(cs_ext_sales_price) total_sales
 from
  catalog_sales,
  date_dim,
        item,
        customer_address
        ,(select  i_manufact_id
        from   item
        where i_category in ('Books')) abc1
 where
    item.i_manufact_id = abc1.i_manufact_id
 and     cs_item_sk              = i_item_sk
 and     cs_sold_date_sk         = d_date_sk
 and     d_year                  = 1999
 and     d_moy                   = 3
 and     cs_bill_addr_sk         = ca_address_sk
 and     ca_gmt_offset           = -5
 group by item.i_manufact_id) bbb
        union all
        select * from (
 select  
          item.i_manufact_id,sum(ws_ext_sales_price) total_sales
 from
  web_sales,
  date_dim,
        item,
        customer_address
        ,(select i_manufact_id
      from item
      where i_category in ('Books')) abd1
 where
  item.i_manufact_id  = abd1.i_manufact_id
 and     ws_item_sk              = i_item_sk
 and     ws_sold_date_sk         = d_date_sk
 and     d_year                  = 1999
 and     d_moy                   = 3
 and     ws_bill_addr_sk         = ca_address_sk
 and     ca_gmt_offset           = -5
 group by item.i_manufact_id) aasd) tmp1
 group by i_manufact_id
 order by total_sales
 limit 100;
