/*Check what organization levels exist in the data */
 select distinct organization_level from demo.stg_student_enrollment;


/* Get a list of distinct schools from student enrollment data */

drop table if exists student_schools;
create temporary table student_schools as

select		school_code,
			school_name,
			school_organization_id,
			district_code,
			organization_level,
			county
from		demo.stg_student_enrollment
group by	school_code,
			school_name,
			school_organization_id,
			district_code,
			organization_level,
			county;

/* Ensure uniqueness */
select		school_code, count('a')
from		student_schools
where		school_code <> '' and school_code is not null
group by	school_code
having		count('a') > 1;
-- 0

/* Get a distinct list of schools from teacher demographic data */

drop table if exists teacher_schools;
create temporary table teacher_schools as

select		school_code,
			school_name,
			school_organization_id,
			district_code,
			organization_level,
			organization_id,
			county,
			current_school_type,
			teacher_total_count
from		demo.raw_teacher_demographics
group by	school_code,
			school_name,
			school_organization_id,
			district_code,
			organization_level,
			organization_id,
			county,
			current_school_type,
			teacher_total_count;
			
/* Ensure uniqueness */			
select		school_code, count('a')
from		teacher_schools
where		school_code is not null and school_code <> ''
group by	school_code
having		count('a') > 1;
-- 0

/* The school data from teacher demographics contains more rows.
	Let's make sure we aren't missing anything between the sets. */
	
select		s.school_code
from		(select * from student_schools where school_code <> '') s
left join	(select * from teacher_schools where school_code <> '') t
	on		s.school_code = t.school_code
where		t.school_code is null;
-- 0

select		t.school_code
from		(select * from teacher_schools where school_code <> '') t
left join	(select * from student_schools where school_code <> '') s
	on		s.school_code = t.school_code
where		s.school_code is null;
-- 347

/* There are more records in teacher_schools than student_schools,
	and no extra information in student_schools that doesn't exist in teacher_schools. 
	Therefore, create the schools dimension table exclusively from teacher_schools. */
	
drop table if exists demo.dim_schools;

create table demo.dim_schools as
select		*
from		teacher_schools
where		school_code is not null and school_code <> '';

create index 	ind_dim_schools_school_code
on				demo.dim_schools (school_code);

/* Ensure that we ended up only with schools, since we didn't specify this
	in criteria */
select distinct organization_level from demo.dim_schools;
-- just 'School'!