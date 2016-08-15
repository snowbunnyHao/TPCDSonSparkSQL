select  * from
 (
select t1.* from
(select 'store' channel, i_brand_id,i_class_id,i_category_id
        ,sum(ss_quantity*ss_list_price) sales, count(*) number_sales
 from store_sales 
     ,item
     ,date_dim
     ,(select avg(quantity*list_price) average_sales
  from (select ss_quantity quantity
             ,ss_list_price list_price
       from store_sales
           ,date_dim
       where ss_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and ss_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity  quantity
             ,cs_list_price list_price
       from catalog_sales
           ,date_dim
       where cs_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and cs_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity quantity
             ,ws_list_price list_price
       from web_sales
           ,date_dim
       where ws_sold_date_sk = d_date_sk
         and ws_sold_date_sk between 2450815 and 2451910
         and d_year between 1998 and 1998 + 2) x) aaa
     ,(select ss_item_sk from  (select i_item_sk ss_item_sk
       from item,
       (
      select brand_id, class_id, category_id 
      from (
      select brand_id, class_id, category_id, sum(q5.c3) c3,count(*) c4
      from
      (
      select brand_id, class_id, category_id, 1 as c3
      from
      (
      select brand_id, class_id, category_id
      from
      (
      select brand_id, class_id, category_id, q2.c3 c3, q2.c4 c4
      from
      (
      select brand_id, class_id, category_id, sum(q1.c3) c3,count(*) c4
      from
      (
      select iss.i_brand_id brand_id
           ,iss.i_class_id class_id
           ,iss.i_category_id category_id, 1 as c3
       from store_sales
           ,item iss
           ,date_dim d1
       where ss_item_sk = iss.i_item_sk
         and ss_sold_date_sk = d1.d_date_sk
         and ss_sold_date_sk between 2451180 and 2452275
         and d1.d_year between 1999 AND 1999 + 2
       union all
       select ics.i_brand_id brand_id
           ,ics.i_class_id class_id
           ,ics.i_category_id category_id, -1 as c3
       from catalog_sales
           ,item ics
           ,date_dim d2
       where cs_item_sk = ics.i_item_sk
         and cs_sold_date_sk = d2.d_date_sk
         and cs_sold_date_sk between 2451180 and 2452275
         and d2.d_year between 1999 AND 1999 + 2
      ) as q1
      group by brand_id, class_id, category_id
      ) as q2
      where ((q2.c4 - case when (q2.c3 >= 0) then q2.c3 else -(q2.c3) end) >= 2)
      ) as q3
      ) as q4
      union all
       select iws.i_brand_id i_brand_id
           ,iws.i_class_id i_class_id
           ,iws.i_category_id i_category_id, -1 as c3
       from web_sales
           ,item iws
           ,date_dim d3
       where ws_item_sk = iws.i_item_sk
         and ws_sold_date_sk = d3.d_date_sk
         and ws_sold_date_sk between 2451180 and 2452275
         and d3.d_year between 1999 AND 1999 + 2
      ) as q5
      group by brand_id, class_id, category_id
      ) as q6
      where ((q6.c4 - case when (q6.c3 >= 0) then q6.c3 else -(q6.c3) end) >= 2)
      ) x
       where i_brand_id = brand_id
            and i_class_id = class_id
            and i_category_id = category_id
      ) yyyyyyyyy) xxx
      ,(select d_week_seq
                           from date_dim
                           where d_year = 1998 + 1
                             and d_moy = 12
                             and d_dom = 16) yyy
 where store_sales.ss_item_sk = xxx.ss_item_sk
   and store_sales.ss_item_sk = i_item_sk
   and store_sales.ss_sold_date_sk = d_date_sk
   and yyy.d_week_seq  = yyy.d_week_seq 
 group by i_brand_id,i_class_id,i_category_id ) t1,
(select average_sales from (select avg(quantity*list_price) average_sales
  from (select ss_quantity quantity
             ,ss_list_price list_price
       from store_sales
           ,date_dim
       where ss_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and ss_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity quantity
             ,cs_list_price list_price
       from catalog_sales
           ,date_dim
       where cs_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and cs_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity quantity
             ,ws_list_price list_price
       from web_sales
           ,date_dim
       where ws_sold_date_sk = d_date_sk
         and ws_sold_date_sk between 2450815 and 2451910
         and d_year between 1998 and 1998 + 2) x) asdfa) t2
where t1.sales > t2.average_sales
) this_year,

 (
select t1.* from (
select 'store' channel, i_brand_id,i_class_id
        ,i_category_id, sum(ss_quantity*ss_list_price) sales, count(*) number_sales
 from store_sales
     ,item
     ,date_dim
     ,(select avg(quantity*list_price) average_sales
  from (select ss_quantity quantity
             ,ss_list_price list_price
       from store_sales
           ,date_dim
       where ss_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and ss_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity  quantity
             ,cs_list_price list_price
       from catalog_sales
           ,date_dim
       where cs_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and cs_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity quantity
             ,ws_list_price list_price
       from web_sales
           ,date_dim
       where ws_sold_date_sk = d_date_sk
         and ws_sold_date_sk between 2450815 and 2451910
         and d_year between 1998 and 1998 + 2) x) vfvfdv
     ,(select ss_item_sk from  (select i_item_sk ss_item_sk
 from item,
 (
select brand_id, class_id, category_id 
from (
select brand_id, class_id, category_id, sum(q5.c3) c3,count(*) c4
from
(
select brand_id, class_id, category_id, 1 as c3
from
(
select brand_id, class_id, category_id
from
(
select brand_id, class_id, category_id, q2.c3 c3, q2.c4 c4
from
(
select brand_id, class_id, category_id, sum(q1.c3) c3,count(*) c4
from
(
select iss.i_brand_id brand_id
     ,iss.i_class_id class_id
     ,iss.i_category_id category_id, 1 as c3
 from store_sales
     ,item iss
     ,date_dim d1
 where ss_item_sk = iss.i_item_sk
   and ss_sold_date_sk = d1.d_date_sk
   and ss_sold_date_sk between 2451180 and 2452275
   and d1.d_year between 1999 AND 1999 + 2
 union all
 select ics.i_brand_id brand_id
     ,ics.i_class_id class_id
     ,ics.i_category_id category_id, -1 as c3
 from catalog_sales
     ,item ics
     ,date_dim d2
 where cs_item_sk = ics.i_item_sk
   and cs_sold_date_sk = d2.d_date_sk
   and cs_sold_date_sk between 2451180 and 2452275
   and d2.d_year between 1999 AND 1999 + 2
) as q1
group by brand_id, class_id, category_id
) as q2
where ((q2.c4 - case when (q2.c3 >= 0) then q2.c3 else -(q2.c3) end) >= 2)
) as q3
) as q4
union all
 select iws.i_brand_id i_brand_id
     ,iws.i_class_id i_class_id
     ,iws.i_category_id i_category_id, -1 as c3
 from web_sales
     ,item iws
     ,date_dim d3
 where ws_item_sk = iws.i_item_sk
   and ws_sold_date_sk = d3.d_date_sk
   and ws_sold_date_sk between 2451180 and 2452275
   and d3.d_year between 1999 AND 1999 + 2
) as q5
group by brand_id, class_id, category_id
) as q6
where ((q6.c4 - case when (q6.c3 >= 0) then q6.c3 else -(q6.c3) end) >= 2)
) x
 where i_brand_id = brand_id
      and i_class_id = class_id
      and i_category_id = category_id
) aaaaaadsds) zzz
,(select d_week_seq
                     from date_dim
                     where d_year = 1998
                       and d_moy = 12
                       and d_dom = 16) zzzyyy
 where store_sales.ss_item_sk = zzz.ss_item_sk
   and store_sales.ss_item_sk = i_item_sk
   and store_sales.ss_sold_date_sk = d_date_sk
   and zzzyyy.d_week_seq = zzzyyy.d_week_seq
 group by i_brand_id,i_class_id,i_category_id) t1,
(select average_sales from (select avg(quantity*list_price) average_sales
  from (select ss_quantity quantity
             ,ss_list_price list_price
       from store_sales
           ,date_dim
       where ss_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and ss_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity  quantity
             ,cs_list_price list_price
       from catalog_sales
           ,date_dim
       where cs_sold_date_sk = d_date_sk
         and d_year between 1998 and 1998 + 2
         and cs_sold_date_sk between 2450815 and 2451910
       union all
       select ws_quantity quantity
             ,ws_list_price list_price
       from web_sales
           ,date_dim
       where ws_sold_date_sk = d_date_sk
         and ws_sold_date_sk between 2450815 and 2451910
         and d_year between 1998 and 1998 + 2) x) adg3g3rg4) t2
where t1.sales > t2.average_sales
) last_year
 where this_year.i_brand_id= last_year.i_brand_id
   and this_year.i_class_id = last_year.i_class_id
   and this_year.i_category_id = last_year.i_category_id
 order by this_year.channel, this_year.i_brand_id, this_year.i_class_id, this_year.i_category_id
   limit 100 ;
