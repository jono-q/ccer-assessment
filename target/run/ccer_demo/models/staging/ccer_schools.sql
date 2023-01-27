
  create view "ccer"."demo"."ccer_schools__dbt_tmp" as (
    select  *
from    raw_school_list
  );