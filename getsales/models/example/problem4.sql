
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with prob4 as (

select count(*) from (
select distinct allusers.email, allusers.phone,
CASE WHEN rs.Event_ID IS NOT NULL THEN 1 ELSE 0 END + 
CASE WHEN cp.Event_ID IS NOT NULL THEN 1 ELSE 0 END + 
CASE WHEN dw.Event_ID IS NOT NULL THEN 1 ELSE 0 END AS sumallusers

 from (select DISTINCT Phone, Email from `my-project-getsales.getsales1.socialmediaad`
UNION ALL 
select DISTINCT Phone, Email from `my-project-getsales.getsales1.jobboardad`
UNION ALL 
select  DISTINCT Phone, Email from `my-project-getsales.getsales1.SearchAd`) allusers

left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.Phone = allusers.Phone
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = allusers.Email
left join `my-project-getsales.getsales1.CourierPartner`cp on cp.Email = allusers.Email and cp.Phone = allusers.Phone) counts
where sumallusers >1


)

select *
from prob4

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
