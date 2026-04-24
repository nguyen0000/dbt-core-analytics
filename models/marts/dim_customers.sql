with customers as (
  
select * from {{ref('stg_jaffle_shop__customers')}}

),

orders as (

select * from {{ref('stg_jaffle_shop__orders')}}
    
),

payment as (

select      O.customer_id,sum(amount) as lifetime_value
from        {{ref('stg_jaffle_shop__orders')}} as O left join {{ref('stg_stripe__payment')}} as P on O.order_id = P.orderid
group by    1
    
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        C.customer_id,
        C.first_name,
        C.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(lifetime_value,0) as lifetime_value

    from customers as C

    left join customer_orders   using (customer_id)
    left join payment as P          on C.customer_id = P.customer_id

)

select * from final