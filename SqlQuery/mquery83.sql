select sum(ws_net_paid) as total_sum
   ,i_category
   ,i_class
   ,i_category+i_class as lochierarchy
   ,rank() over (partition by i_category+i_class,case when i_class = 0 then i_category endorder by sum(ws_net_paid) desc) as rank_within_parent
 from
    web_sales
   ,date_dim d1
   ,item
 where
    d1.d_month_seq between 1212 and 1212+11
 and d1.d_date_sk = ws_sold_date_sk
 and i_item_sk  = ws_item_sk
 group by i_category,i_class with rollup
 order by
   lochierarchy desc,
   case when lochierarchy = 0 then i_category end,
   rank_within_parent
 limit 100