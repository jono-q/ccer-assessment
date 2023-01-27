
  create view "ccer"."demo"."schools__dbt_tmp" as (
    with ccer_schools as (

    select      *
    from        demo.raw_school_list
),

dim_schools as (

    select      *
    from        demo.dim_schools

    ),

final as (

    select      cs.school_code,
                ds.school_name,
                cs.district_code,
                cs.elementary_school_flag,
                cs.middle_school_flag,
                cs.high_school_flag   
    from        demo.ccer_schools cs
    inner join  demo.dim_schools ds
        on      cs.school_code = ds.school_code

)

select * from final
  );