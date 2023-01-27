-- Table: demo.raw_student_enrollment

DROP TABLE IF EXISTS demo.raw_student_enrollment;

CREATE TABLE IF NOT EXISTS demo.raw_student_enrollment
(
    school_year text,
    organization_level text,
    county text,
    esd_name text,
    esd_organization_id text,
    district_code text,
    district_name text,
    district_organization_id text,
    school_code text,
    school_name text,
    school_organization_id text,
    current_school_type text,
    grade_level text,
    all_students text,
    female text,
    gender_x text,
    male text,
    american_indian_alaskan_native text,
    asian text,
    black_african_american text,
    hispanic_latino_of_any_race text,
    native_hawaiian_pacific_islander text,
    two_or_more_races text,
    white text,
    english_language_learners text,
    highly_capable text,
    homeless text,
    low_income text,
    migrant text,
    military_parent text,
    mobile text,
    section_504 text,
    students_with_disabilities text,
    non_english_language_learners text,
    non_highly_capable text,
    non_homeless text,
    non_low_income text,
    non_migrant text,
    non_military_parent text,
    non_mobile text,
    non_section_504 text,
    students_without_disabilities text,
    data_as_of timestamp,
    foster_care text,
    non_foster_care text
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS demo.raw_student_enrollment
    OWNER to ccer;
	
	
