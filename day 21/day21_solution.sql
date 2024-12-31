with quarter_sales as (select
	case 
		when extract(month from sale_date) in (1,2,3) then 1
		when extract(month from sale_date) in (4,5,6) then 2
		when extract(month from sale_date) in (7,8,9) then 3
		else 4 end quarter,
	extract(year from sale_date) yr,
	sum(amount) q_sales
from sales
group by 1,2
order by 2,1),

yoy_cte as (select
	quarter,
	yr,
	round((q_sales-lag(q_sales) over())/lag(q_sales) over(),2) pct_growth
from quarter_sales),

rank_cte as (select
*,
rank() over(order by pct_growth desc) pct_rank
from yoy_cte
where pct_growth is not null)

select
*
from rank_cte
where pct_rank = 1