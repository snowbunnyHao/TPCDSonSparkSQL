select i_item_desc,i_category
      ,i_item_id
      ,i_class
      ,i_current_price
      ,sum(ws_ext_sales_price) as itemrevenue
      ,sum(ws_ext_sales_price)*100/sum(sum(ws_ext_sales_price)) over
       (partition by i_class) as revenueratio
from  
  web_sales
  JOIN date_dim ON ws_sold_date_sk=d_date_sk
  JOIN item ON ws_item_sk=i_item_sk
where i_category in ('Jewelry', 'Sports', 'Books')
  and d_date between cast('2001-01-12' as date)
  and (cast('2001-01-12' as date) + INTERVAL '30' day)
group by
  i_item_id
        ,i_item_desc
        ,i_category
        ,i_class
        ,i_current_price
order by
         i_category
        ,i_class
        ,i_item_id
        ,i_item_desc
        ,revenueratio
limit 100