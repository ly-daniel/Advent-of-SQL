with letters as (select
	chr(value) v
from letters_a
union all
select
	chr(value)
from letters_b)

select
	string_agg(v,'')
from letters
where v ~ '[a-zA-Z\s,.!"''()\-\;:?]'
