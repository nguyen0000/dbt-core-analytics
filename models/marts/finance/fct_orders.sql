select  orderid as order_id,
        O.customer_id,
        amount
from    {{ref('stg_jaffle_shop__orders')}} as O left join {{ref('stg_jaffle_shop__customers')}} as C using (customer_id)
                                                left join {{ref('stg_stripe__payment')}}        as P on O.order_id      = P.orderid

