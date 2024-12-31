with songs as (select
song_title,
count(*) plays,
sum(case when song_duration = duration then 0 else 1 end) skipped
from user_plays up
join users u
on up.user_id = u.user_id
join songs s
on up.song_id = s.song_id
group by song_title)

select
*
from songs
order by plays desc, skipped