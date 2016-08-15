select
  cd_gender,
  cd_marital_status,
  cd_education_status,
  count(*) cnt1,
  cd_purchase_estimate,
  count(*) cnt2,
  cd_credit_rating,
  count(*) cnt3,
  cd_dep_count,
  count(*) cnt4,
  cd_dep_employed_count,
  count(*) cnt5,
  cd_dep_college_count,
  count(*) cnt6
 from
  customer c
  JOIN customer_address ca
  join customer_demographics
  JOIN (select count(*) c1,ss_customer_sk
          from store_sales,date_dim
          where 
                ss_sold_date_sk = d_date_sk and
                ss_sold_date_sk between 2451970 and 2452091 and
                d_year = 2001 and
                d_moy between 3 and 3+3
          group by ss_customer_sk) exist1 on c.c_customer_sk = ss_customer_sk
  JOIN (select count(*) c2, ws_bill_customer_sk
            from (select ws_bill_customer_sk
                  from web_sales 
                  JOIN date_dim on ws_sold_date_sk between 2451970 and 2452091 and ws_sold_date_sk = d_date_sk and d_year = 2001 and d_moy between 3 and 3+3
                  ) tab1
            group by ws_bill_customer_sk) exist2 on ws_bill_customer_sk = c.c_customer_sk

 where
  c.c_current_addr_sk = ca.ca_address_sk and
  ca_county in ('Benton County','Owen County','Hamilton County','Boone County','Asotin County') and
  cd_demo_sk = c.c_current_cdemo_sk and exist1.c1>0 and exist2.c2>0
 group by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 order by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 limit 100;