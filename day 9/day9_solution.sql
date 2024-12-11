with avg_score as (select 
	reindeer_name,
	exercise_name,
	avg(speed_record) average
from reindeers r
join training_sessions ts
on r.reindeer_id = ts.reindeer_id
where reindeer_name <> 'Rudolph'
group by reindeer_name, exercise_name)

select
	reindeer_name,
	round(average,2)
from
(select
	*,
	rank() over(order by average desc) rank_avg
from avg_score)
where rank_avg between 1 and 3
