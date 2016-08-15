select
  i_item_id,
  s_state,
  avg(ss_quantity) agg1,
  avg(ss_list_price) agg2,
  avg(ss_coupon_amt) agg3,
  avg(ss_sales_price) agg4
from
  store_sales
  join store on (store_sales.ss_store_sk = store.s_store_sk)
  join customer_demographics on (store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk)
  join item on (store_sales.ss_item_sk = item.i_item_sk)
  join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
where
  ss_sold_date_sk between 2450815 and 2451179 
  and d_year = 1998
  and s_state in ('WI', 'CA', 'TX', 'FL', 'WA', 'TN')
  and cd_gender = 'F'
  and cd_marital_status = 'W'
  and cd_education_status = 'Primary'
group by
  i_item_id,
  s_state
order by
  i_item_id,
  s_state 
limit 100;
