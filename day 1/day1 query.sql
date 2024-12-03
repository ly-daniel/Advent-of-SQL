with wish_list as (SELECT 
	list_id,
	child_id,
	submitted_date,
    wishes -> 'colors' ->> 0 first_color,
	json_array_length(wishes -> 'colors') as length_colors,
	wishes ->> 'first_choice' as first_choice,
	wishes ->> 'second_choice' as second_choice
from wish_lists)

select
	name,
	first_choice primary_wish,
	second_choice backup_wish,
	first_color favorite_color,
	length_colors color_count,
	case 
		when difficulty_to_make = 1 then 'Simple Gift'
		when difficulty_to_make = 2 then 'Moderate Gift'
		else 'Complex Gift'
	end gift_complexity,
	case 
		when category = 'educational' then 'Learning Workshop'
		when category like '%outdoor%' then 'Outside Workshop'
		else 'General Workshop'
	end workshop_assignment
from wish_list wl
join children c
on wl.child_id = c.child_id
join toy_catalogue tc
on tc.toy_name = wl.first_choice
order by name
limit 5