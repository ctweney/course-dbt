## How many users do we have?
```snowflake-sql
select count(*) from users;
// result: 30 
```

## On average, how many orders do we receive per hour?
```snowflake-sql
select min(CREATED_AT) as EARLIEST, max(CREATED_AT) as LATEST,
       datediff('hour', EARLIEST, LATEST) as TOTAL_HOURS,
       count(*) as TOTAL_ORDERS,
       TOTAL_ORDERS / TOTAL_HOURS as AVERAGE_ORDERS_PER_HOUR
from ORDERS;
// result: 7.680851
```

## On average, how long does an order take from being placed to being delivered?
```snowflake-sql
select avg(datediff('hour', created_at, delivered_at)) AS delivery_delay
from ORDERS;
// result: 93.403279
```

## How many users have only made one purchase? Two purchases? Three+ purchases?
```snowflake-sql
with ORDER_COUNTS as (
    select U.USER_ID, count(O.*) as ORDER_COUNT
    from USERS U, ORDERS O 
    where U.USER_ID = O.USER_ID
    group by U.USER_ID
    order by ORDER_COUNT DESC )
select null, 
(select count(*) 
from ORDER_COUNTS
where ORDER_COUNT = 1) AS single_order_users,
(select count(*) 
from ORDER_COUNTS
where ORDER_COUNT = 2) AS two_order_users,
(select count(*) 
from ORDER_COUNTS
where ORDER_COUNT > 2) AS three_or_more_order_users;

-- results:
-- SINGLE_ORDER_USERS = 22
-- TWO_ORDER_USERS	= 3 
-- THREE_OR_MORE_ORDER_USERS = 0
```

## On average, how many unique sessions do we have per hour?
```snowflake-sql
select min(CREATED_AT) as EARLIEST, max(CREATED_AT) as LATEST,
       datediff('hour', EARLIEST, LATEST) as TOTAL_HOURS,
       count(distinct session_id) as TOTAL_SESSIONS,
       TOTAL_SESSIONS / TOTAL_HOURS as AVERAGE_SESSIONS_PER_HOUR
from EVENTS;
// result: 10.140351
```
