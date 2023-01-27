
/* This staging pivots the demographics fields and converts student counts to integers.
	This will make working with the demographics easier, and implicitly
	validates that all our demographic count fields are correctly typed */

drop table if exists demo.stg_student_enrollment;

create table demo.stg_student_enrollment as

select		school_year,
			organization_level,
			county,
			esd_name,
			esd_organization_id,
			district_code,
			district_name,
			district_organization_id,
			school_code,
			school_name,
			school_organization_id,
			current_school_type
			grade_level,
			unnest(array[
				'All Students',
				'Female', 'Gender X', 'Male',
				'American Indian/Alaskan Native', 'Asian', 'Black/ African American', 
					'Hispanic/ Latino of Any Race(s)', 'Native Hawaiian/ Other Pacific Islander',
					'Two or More Races', 'White', 
				'English Language Learners', 'Non-English Language Learners',
				'Highly Capable', 'Non-Highly Capable',
				'Homeless', 'Non-Homeless',
				'Low-Income', 'Non-Low Income',	
				'Migrant', 'Non Migrant',
				'Military Parent', 'Non Military Parent',
				'Mobile', 'Non Mobile',
				'Section 504', 'Non Section 504', 	
				'Students with Disabilities','Students without Disabilities',
				'Foster_Care', 'Non_Foster_Care'
			]) as demographic,
			unnest(array[
				all_students::int,
				female::int, gender_x::int, male::int,
				american_indian_alaskan_native::int, asian::int, black_african_american::int,
					hispanic_latino_of_any_race::int, native_hawaiian_pacific_islander::int,
					two_or_more_races::int, white::int,
				english_language_learners::int, non_english_language_learners::int,
				highly_capable::int, non_highly_capable::int,
				homeless::int, non_homeless::int,
				low_income::int, non_low_income::int,
				migrant::int, non_migrant::int,
				military_parent::int, non_military_parent::int,
				mobile::int, non_mobile::int,
				section_504::int, non_section_504::int,
				students_with_disabilities::int, students_without_disabilities::int,
				foster_care::int, non_foster_care::int
			]) as student_count,
			unnest(array[
				'All Students',
				'Gender', 'Gender', 'Gender',
				'Race', 'Race',
					'Race', 'Race', 'Race',
					'Race', 'Race',
				'English language learner status', 'English language learner status',
				'Highly capable status', 'Highly capable status',
				'Homeless status', 'Homeless status',
				'Low income status', 'Low income status',
				'Migrant status', 'Migrant status',
				'Military parent status', 'Military parent status',
				'Mobile status', 'Mobile status',
				'Section 504 status', 'Section 504 status',
				'Students with disabilities status', 'Students with disabilities status',
				'Foster care status', 'Foster care status'
			]) as demographic_category
from		demo.raw_student_enrollment;

create index 	ind_stg_student_enrollment_school_code
on 				demo.stg_student_enrollment (school_code);

create index	ind_stg_student_enrollment_district_code
on				demo.stg_student_enrollment (district_code);