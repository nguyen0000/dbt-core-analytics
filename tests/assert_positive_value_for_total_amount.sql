select 
    orderid, 
    sum(payment_amount)
from {{ source('stripe', 'payment') }}
group by orderid
having sum(payment_amount) <0