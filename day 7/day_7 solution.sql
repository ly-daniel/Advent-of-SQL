with rankings as (select
	*,
	rank() over(partition by primary_skill order by years_experience desc, elf_id) max_skill_rank,
	rank() over(partition by primary_skill order by years_experience, elf_id) min_skill_rank
from workshop_elves)

select
	maxs.elf_id max_elf_id,
	mins.elf_id min_elf_id,
	maxs.primary_skill shared_skill
from
(select
	*
from rankings
where max_skill_rank = 1) maxs
join
(select
	*
from rankings
where min_skill_rank = 1) mins
on maxs.max_skill_rank = mins.min_skill_rank and maxs.primary_skill = mins.primary_skill