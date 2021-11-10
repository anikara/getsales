
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with prob5 as (

select count(*) from (select distinct soc.phone, soc.email
from `my-project-getsales.getsales1.socialmediaad` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Social Media'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and soc.Timestamp >= datetime_add(cp.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare'  and soc.Timestamp >= datetime_add(rs.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'   and soc.Timestamp >= datetime_add(dw.timestamp, INTERVAL 28 DAY)
UNION ALL 
select distinct soc.phone, soc.email
from `my-project-getsales.getsales1.jobboardad` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Job Board'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and soc.Timestamp >= datetime_add(cp.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare'  and soc.Timestamp >= datetime_add(rs.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'   and soc.Timestamp >= datetime_add(dw.timestamp, INTERVAL 28 DAY)
UNION ALL 

select distinct soc.phone, soc.email
from `my-project-getsales.getsales1.SearchAd` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Search'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and soc.Timestamp >= datetime_add(cp.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare'  and soc.Timestamp >= datetime_add(rs.timestamp, INTERVAL 28 DAY)
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'   and soc.Timestamp >= datetime_add(dw.timestamp, INTERVAL 28 DAY)) allopps


)

select *
from prob5

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
