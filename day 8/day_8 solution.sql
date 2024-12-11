with recursive managers as(
select
	*,
	1 as levels
from staff
where manager_id is null

union all

select
	s.staff_id,
	s.staff_name,
	s.manager_id,
	m.levels + 1
from staff s
join managers m
on s.manager_id = m.staff_id
)
select
	levels
from managers
order by levels desc
limit 1