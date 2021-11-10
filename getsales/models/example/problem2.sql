
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with prob2 as (



select 'Rideshare', * from (select  Event_Type, 
count(*)/LAG(count(*))
    OVER (ORDER BY count(*) desc ) AS ConversionRate from `my-project-getsales.getsales1.RidesharePartner` partner

group by Event_Type
order by count(*) desc) convrate
where Event_Type != 'Application'

UNION ALL 

select 'Dog Walker', * from (select  Event_Type, 
count(*)/LAG(count(*))
    OVER (ORDER BY count(*) desc ) AS ConversionRate from `my-project-getsales.getsales1.DogWalkPartner` partner

group by Event_Type

order by count(*) desc) convrate

where Event_Type != 'Application'

UNION ALL 

select 'Courier', * from (select  Event_Type, 
count(*)/LAG(count(*))
    OVER (ORDER BY count(*) desc ) AS ConversionRate from `my-project-getsales.getsales1.CourierPartner` partner

group by Event_Type

order by count(*) desc) convrate

where Event_Type != 'Application'



)

select *
from prob2

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
