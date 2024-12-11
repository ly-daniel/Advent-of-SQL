select
	*
from
(select 
	date,
	sum(case when drink_name = 'Eggnog' then quantity end)eggnog,
	sum(case when drink_name = 'Hot Cocoa' then quantity end)hot_cocoa,
	sum(case when drink_name = 'Peppermint Schnapps' then quantity end)pepermint_schnapps
from drinks
group by date
order by date)
where hot_cocoa = 38 and 
pepermint_schnapps = 298 and 
eggnog = 198