

/* Ideally I would limit this to include a check based on grade_level, 
	to ensure that I'm counting e.g., the right grades from K-8 schools 
	in each level, but I'm short on time */

with mart as
			(
			select		e.school_code, e.school_name, a.city,
						a.elementary_school_flag,
						a.middle_school_flag,
						a.high_school_flag,
						sum(case when e.demographic = 'Black/ African American' 
							then student_count else 0 end) as black,
						sum(case when e.demographic = 'American Indian/Alaskan Native'
							then student_count else 0 end) as native_american,
						sum(case when e.demographic = 'Hispanic/ Latino of Any Race(s)'
							then student_count else 0 end) as latine,
			/* Note: I included both "All Students" and "Students with Race Defined"
			because, in the staged data, not all the race values add up to the 
			All Students values in all cases. On quick scan, it appears that 
			all of the CCER schools total up, but I wanted to include both as a check*/
						sum(case when e.demographic_category = 'Race'
							then student_count else 0 end) as students_with_race_defined,
						sum(case when e.demographic = 'All Students' 
							then student_count else 0 end) as all_students
			from		demo.stg_student_enrollment e
			inner join	demo.raw_school_list a
				on		e.school_code = a.school_code
			where		e.demographic_category in ('Race', 'All Students')
			group by 	e.school_code,
						e.school_name,
						a.city,
						a.elementary_school_flag,
						a.middle_school_flag,
						a.high_school_flag
			),

high_school_black as (

select		'High school' as level,
			school_code, school_name, city,
			'Black' as race,
			round(black*1.0/all_students*1.0, 4) as pct
from		mart
where		high_school_flag = '1'
order by 	pct desc
limit 		5),

high_school_native_american as (
	
select		'High school' as level,
			school_code, school_name, city,
			'Native American' as race,
			round(native_american*1.0/all_students*1.0, 4) as pct
from		mart
where		high_school_flag = '1'
order by	pct desc
limit 		5),

high_school_latine as (
	
select		'High school' as level,
			school_code, school_name, city,
			'Latine' as race,
			round(latine*1.0/all_students*1.0, 4) as pct
from		mart
where		high_school_flag = '1'
order by	pct desc
limit 		5),

middle_school_black as (

select		'Middle school' as level,
			school_code, school_name, city,
			'Black' as race,
			round(black*1.0/all_students*1.0, 4) as pct
from		mart
where		middle_school_flag = '1'
order by 	pct desc
limit 		5),

middle_school_native_american as (
	
select		'Middle school' as level,
			school_code, school_name, city,
			'Native American' as race,
			round(native_american*1.0/all_students*1.0, 4) as pct
from		mart
where		middle_school_flag = '1'
order by	pct desc
limit 		5),

middle_school_latine as (
	
select		'Middle school' as level,
			school_code, school_name, city,
			'Latine' as race,
			round(latine*1.0/all_students*1.0, 4) as pct
from		mart
where		middle_school_flag = '1'
order by	pct desc
limit 		5),

elementary_school_black as (

select		'Elementary school' as level,
			school_code, school_name, city,
			'Black' as race,
			round(black*1.0/all_students*1.0, 4) as pct
from		mart
where		Elementary_school_flag = '1'
order by 	pct desc
limit 		5),

Elementary_school_native_american as (
	
select		'Elementary school' as level,
			school_code, school_name, city,
			'Native American' as race,
			round(native_american*1.0/all_students*1.0, 4) as pct
from		mart
where		Elementary_school_flag = '1'
order by	pct desc
limit 		5),

Elementary_school_latine as (
	
select		'Elementary school' as level,
			school_code, school_name, city,
			'Latine' as race,
			round(latine*1.0/all_students*1.0, 4) as pct
from		mart
where		Elementary_school_flag = '1'
order by	pct desc
limit 		5)

select		*
from		high_school_black
union all
select		*
from		high_school_native_american
union all
select		*
from		high_school_latine
union all
select		*
from		middle_school_black
union all
select		*
from		middle_school_native_american
union all
select		*
from		middle_school_latine
union all
select		*
from		elementary_school_black
union all
select		*
from		elementary_school_native_american
union all
select		*
from		elementary_school_latine
order by	race, level, pct desc;



---------	Testing		------------
/*



select		*
FROM		DEMO.RAW_SCHOOL_LIST
where		d_road_map_region_flag <> '1';

select		*
from		demo.raw_school_list
where		elementary_school_flag::int + middle_school_flag::int +
			high_school_flag::int > 1;
			
select distinct demographic, demographic_category
from		demo.stg_student_enrollment
order by	demographic_category, demographic;

*/