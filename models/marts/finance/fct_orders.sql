select  order_id,
        customer_id,
        payment_amount
from    {{ref('stg_jaffle_shop__orders')}}  left join {{ref('stg_stripe__payment')}}  using (order_id)
where payment_status = 'success'