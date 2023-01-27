
/* We can re-use the demo.mart_teacher_demographics table that 
we created in model 7b */


select distinct demographic_category, demographic_category_type
from 		demo.mart_teacher_demographics
where		elementary_school_flag = '1'
and			demographic_category is not null and demographic_category <> 'All'
order by 	demographic_category_type, demographic_category;


with	female as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'Gender'
		and			demographic_category = 'Female'
		order by	pct desc
		limit		5
),
		male as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'Gender'
		and			demographic_category = 'Male'
		order by	pct desc
		limit		5
		),
		gender_not_provided as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'Gender'
		and			demographic_category = 'Not Provided'
		order by	pct desc
		limit		5
		),
		native_american as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'American Indian/Alaskan Native'
		order by	pct desc
		limit		5
		),
		asian as (
			select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Asian'
		order by	pct desc
		limit		5
		),
		black as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Black/African American'
		order by	pct desc
		limit		5
		),
		latine as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Hispanic/Latino of any race(s)'
		order by	pct desc
		limit		5
		),
		hawaiian_pi as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Native Hawaiian/Other Pacific Islander'
		order by	pct desc
		limit		5),
		race_not_provided as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Not Provided'
		order by	pct desc
		limit		5
		),
		two_or_more_races as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'Two or more races'
		order by	pct desc
		limit		5
		),
		white as (
		select		school_code,
					school_name,
					city,
					demographic_category_type,
					demographic_category,
					(teacher_count::int * 1.0)/ (teacher_total_count::int * 1.0) as pct
		from		demo.mart_teacher_demographics
		where		elementary_school_flag = '1'
		and			demographic_category_type = 'RaceEthnicity'
		and			demographic_category = 'White'
		order by	pct desc
		limit		5
		)
		
select		*
from		female
union all
select		*
from		male
union all
select		*
from		gender_not_provided
union all
select		*
from		native_american
union all
select		*
from		asian
union all
select		*
from		black
union all
select		*
from		latine
union all
select		*
from		hawaiian_pi
union all	
select		*
from		race_not_provided
union all
select		*
from		two_or_more_races
union all
select		*
from		white;


