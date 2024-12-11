with avg_gifts as (select
	*,
	avg(price) over() avg_price
from gifts)

select
	*
from children c
join avg_gifts ag
on c.child_id = ag.child_id 
where price > avg_price
order by price