select * from (

select 
   sum(ss_net_profit) as total_sum
   ,s_state
   ,s_county
   ,0 as lochierarchy
   ,rank() over (partition by 0,case when true then s_state end order by sum(ss_net_profit) desc) as rank_within_parent
 from (
select ss_net_profit, ss_store_sk from store_sales
   , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd where ssd.d_date_sk = ss_sold_date_sk
) tmp_sssd, store
 ,( select new_s_state
from  (select  s_state as new_s_state,
                  rank() over (partition by s_state order by sum(ss_net_profit) desc) as ranking
                   from (select ss_net_profit, ss_store_sk 
                         from store_sales
                             , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd 
                        where ssd.d_date_sk = ss_sold_date_sk
                        ) tmp_sssd, store
                  where  s_store_sk  = ss_store_sk
                  group by s_state
                  ) tmp1 
  where ranking <= 5) state0
 where
 s_store_sk  = ss_store_sk
 and s_state = state0.new_s_state
  group by s_state,s_county


                  union


                  select 
                     sum(ss_net_profit) as total_sum
                     ,s_state
                     ,NULL as s_county
                     ,1 as lochierarchy
                     ,rank() over (
                   	partition by 1,
                   	case when false then s_state end 
                   	order by sum(ss_net_profit) desc) as rank_within_parent
                   from (
                  select ss_net_profit, ss_store_sk from store_sales
                     , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd where ssd.d_date_sk = ss_sold_date_sk
                  ) tmp_sssd, store
                   ,( select new_s_state
from  (select  s_state as new_s_state,
                  rank() over (partition by s_state order by sum(ss_net_profit) desc) as ranking
                   from (select ss_net_profit, ss_store_sk 
                         from store_sales
                             , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd 
                        where ssd.d_date_sk = ss_sold_date_sk
                        ) tmp_sssd, store
                  where  s_store_sk  = ss_store_sk
                  group by s_state
                  ) tmp1 
  where ranking <= 5) state1
                     where
                     s_store_sk  = ss_store_sk
                     and s_state = state1.new_s_state
 group by s_state


union


select 
   sum(ss_net_profit) as total_sum
   ,NULL as s_state
   ,NULL as s_county
   ,2 as lochierarchy
   ,rank() over (
        partition by 2
        
        order by sum(ss_net_profit) desc) as rank_within_parent
 from (
select ss_net_profit, ss_store_sk from store_sales
   , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd where ssd.d_date_sk = ss_sold_date_sk
) tmp_sssd, store
 ,( select new_s_state
from  (select  s_state as new_s_state,
                  rank() over (partition by s_state order by sum(ss_net_profit) desc) as ranking
                   from (select ss_net_profit, ss_store_sk 
                         from store_sales
                             , (select d_date_sk from date_dim where d_month_seq between 1212 and 1212+11) ssd 
                        where ssd.d_date_sk = ss_sold_date_sk
                        ) tmp_sssd, store
                  where  s_store_sk  = ss_store_sk
                  group by s_state
                  ) tmp1 
  where ranking <= 5) state2
 where
 s_store_sk  = ss_store_sk
 and s_state = state2.new_s_state
 group by NULL
)
order by
   lochierarchy desc
  ,case when lochierarchy = 0 then s_state end
  ,rank_within_parent
