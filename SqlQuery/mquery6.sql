select  a.ca_state state, count(*) cnt
 from customer c
     JOIN store_sales s ON c.c_customer_sk = s.ss_customer_sk
     JOIN date_dim d ON s.ss_sold_date_sk = d.d_date_sk 
     JOIN item i ON s.ss_item_sk = i.i_item_sk
     JOIN customer_address a ON a.ca_address_sk = c.c_current_addr_sk
     JOIN (select avg(j.i_current_price)*1.2,j.i_category as avgavg from item j group by i_category) avga on i.i_current_price > avga.avgavg
     JOIN (select distinct (d_month_seq) as dst from date_dim where d_year = 2000 and d_moy = 2) tmpb on d.d_month_seq = tmpb.dst
 group by a.ca_state
 having count(*) >= 10
 order by cnt 
 limit 100;