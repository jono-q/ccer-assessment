DROP TABLE IF EXISTS demo.raw_teacher_demographics;

CREATE TABLE IF NOT EXISTS demo.raw_teacher_demographics
(
    row_id text,
    school_year text,
    organization_level text,
    organization_id text,
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
    teacher_total_count text,
    demographic_category_type text,
    demographic_category_id text,
    demographic_category text,
    teacher_count text,
    teacher_percent text,
    sum_years_experience text,
    avg_years_experience text,
    ma_plus_count text,
    ma_plus_percent text,
    is_ee_validated text,
    data_as_of timestamp
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS demo.raw_teacher_demographics
    OWNER to ccer;