

/* From building the schools dimension, we know that there are schools
in the teacher demographics dataset that are not contained in the schools
dataset, but the reverse is not true. Therefore, let's use that knowledge
and build the districts dimension from the teacher demographics data as well. */

drop table if exists districts;

create temporary table districts as

select		district_code,
			district_name,
			district_organization_id,
			organization_level,
			county
from		demo.raw_teacher_demographics
where		organization_level = 'District'
group by 	district_code,
			district_name,
			district_organization_id,
			organization_level,
			county;

/* Check for uniqueness */
select district_code, count('a')
from	districts
group by district_code
having 	count('a') > 1;
-- 0

drop table if exists demo.dim_districts;

create table demo.dim_districts as
select		*
from		districts
order by	district_code;

create index ind_dim_districts_district_code
on			demo.dim_districts (district_code);

drop table districts;


select * from demo.dim_districts;
			