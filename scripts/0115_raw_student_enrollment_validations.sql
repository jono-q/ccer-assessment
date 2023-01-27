select count('a') from demo.raw_student_enrollment;
-- 20357, matches count from website source
-- https://data.wa.gov/education/Report-Card-Enrollment-2020-21-School-Year/nvpc-yr7b

select * from demo.raw_school_list;


select		*
from		demo.raw_student_enrollment
limit 	100;


select 	school_year, count('a')
from	demo.raw_student_enrollment
group by school_year;
/*"2020-21"	20357 */

select	organization_level,
		count('a')
from	demo.raw_student_enrollment
group by organization_level;
/*	
[null] 		16
"State"		16
"School"	15825
"District"	4500 */

select 	esd_name,
		count('a')
from	demo.raw_student_enrollment
group by esd_name;
/* "
Educational Service District 112"	1818
"State Total"	16
"Educational Service District 105"	1203
[null]	454
"North Central Educational Service District 171"	1274
"Educational Service District 101"	2703
"Capital Region ESD 113"	1870
"Washington State Charter School Commission"	116
"Educational Service District 123"	1343
"Spokane Public Schools Charter Authorizer"	26
"Northwest Educational Service District 189"	2840
"Olympic Educational Service District 114"	1060
"Puget Sound Educational Service District 121"	5634
*/

select 	count('a')
from	demo.raw_student_enrollment
where	female::int + gender_x::int + male::int <> all_students::int;
-- 0

select	--count('a')
		american_indian_alaskan_native::int +
		asian::int + black_african_american::int +
		hispanic_latino_of_any_race::int +
		native_hawaiian_pacific_islander::int +
		two_or_more_races::int +
		white::int - all_students::int as count_diff,
		*
from	demo.raw_student_enrollment
where	american_indian_alaskan_native::int +
		asian::int + black_african_american::int +
		hispanic_latino_of_any_race::int +
		native_hawaiian_pacific_islander::int +
		two_or_more_races::int +
		white::int <> all_students::int;
/*
Successfully run. Total query runtime: 658 msec.
100 rows affected
*/


select	count('a')
from	demo.raw_student_enrollment
where	highly_capable::int + non_highly_capable::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	homeless::int + non_homeless::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	low_income::int + non_low_income::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	migrant::int + non_migrant::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	military_parent::int + non_military_parent::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	mobile::int + non_mobile::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	section_504::int + non_section_504::int <> all_students::int;
-- 0

select	count('a')
from	demo.raw_student_enrollment
where	students_with_disabilities::int + students_without_disabilities::int <> all_students::int;
-- 0

select	--count('a')
		foster_care::int + non_foster_care::int - all_students::int as diff,
		*
from	demo.raw_student_enrollment
where	foster_care::int + non_foster_care::int <> all_students::int;
/*
Successfully run. Total query runtime: 931 msec.
7079 rows affected.
*/
