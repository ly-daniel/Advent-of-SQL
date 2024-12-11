with percentage as (select 
	production_date,
	toys_produced,
	lag(toys_produced) over() as previous_day,
	toys_produced - lag(toys_produced) over(order by production_date) production_change,
	round(100*(toys_produced - lag(toys_produced) over(order by production_date))/(lag(toys_produced) over(order by production_date)::numeric),2) percentage_change
from toy_production)

select
	*,
	rank() over(order by percentage_change desc)
from percentage
where previous_day is not null