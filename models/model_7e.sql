
with	base as (

select		school_code,
			school_name,
			city,
			sum(case when demographic_category_type = 'RaceEthnicity'
			   and demographic_category <> 'White'
			   then teacher_count::int else 0 end) as poc,
			max(teacher_total_count::int) as teacher_total_count
from		demo.mart_teacher_demographics
where		demographic_category_type = 'RaceEthnicity'
group by	school_code,
			school_name,
			city
			)
select		school_code,
			school_name,
			city,
			(poc *1.0) / (teacher_total_count * 1.0) as pct_poc
from		base
order by	pct_poc desc
limit 10;
			