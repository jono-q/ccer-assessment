-- Table: demo.raw_school_list

DROP TABLE IF EXISTS demo.raw_school_list;

CREATE TABLE IF NOT EXISTS demo.raw_school_list
(
    academic_year text, 
	school_code text, 
	district_code text,
	d_road_map_region_flag text,
	elementary_school_flag text, 
	middle_school_flag text, 
	high_school_flag text, 
	street_address text,                                                                                        
	city text,                                                                                                 
	"state" text, 
	zip text,   
	lat text,                                     
	long text
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS demo.raw_school_list
    OWNER to ccer;
	
	
