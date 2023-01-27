

select		school_code, count('a')
from		(
			select		school_code, teacher_total_count
			from		demo.raw_teacher_demographics
			group by	school_code, teacher_total_count
			) a
group by 	school_code
having		count('a') > 1;

/* The query above shows that, wherever school_code is not null,
	the teacher_total_count is consistent across rows. So we can use
	a distinct value for each school_code to get the total.
	
	That _could_ make this an extremely simple transformation.
	However, transformation 7c can reuse this table if we include
	demographic categories. So let's build a mart that we can use
	for both. */

drop table if exists demo.mart_teacher_demographics;

create table	demo.mart_teacher_demographics as

select		t.school_code,
			t.school_name,
			a.city,
			a.elementary_school_flag,
			a.middle_school_flag,
			a.high_school_flag,
			t.demographic_category_type,
			t.demographic_category,
			t.teacher_count,
			t.teacher_total_count
from		demo.raw_teacher_demographics t
inner join	demo.raw_school_list a
	on		t.school_code = a.school_code;
	
/* Now identify the total number of teachers at each school */

select		distinct
			school_code,
			school_name,
			city,
			elementary_school_flag,
			middle_school_flag,
			high_school_flag,
			teacher_total_count::int as teacher_total_count
from		demo.mart_teacher_demographics
where		teacher_total_count is not null --there are a few, exclude
order by	teacher_total_count::int desc;


	
--------	Testing		------------
/*
select count(distinct school_code)
from		demo.mart_teacher_demographics;

select	count(distinct school_code)
from		demo.mart_teacher_demographics
where		demographic_category = 'All';
select * from demo.raw_school_list where city = 'NaN';

select		distinct demographic_category_type,
			demographic_category
from		demo.raw_teacher_demographics
order by	demographic_category_type, 
			demographic_category;
*/