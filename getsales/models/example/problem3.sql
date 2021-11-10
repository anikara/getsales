
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with prob3 as (

select platform, partner, avg(Total_Spend)/count(IDs) as ConversionRate from 
(select 
ads.platform, ads.partner, coalesce(cp.Event_ID, rs.Event_ID, dw.Event_ID) as IDs, ads.Total_Spend from `my-project-getsales.getsales1.socialmediaad` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Social Media'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and cp.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare' and rs.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'  and dw.Event_Type = 'First Trip') counts1
group by platform, partner

UNION ALL

select platform, partner, avg(Total_Spend)/count(IDs) as ConversionRate from 
(select 
ads.platform, ads.partner, coalesce(cp.Event_ID, rs.Event_ID, dw.Event_ID) as IDs, ads.Total_Spend from `my-project-getsales.getsales1.jobboardad` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Job Board'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and cp.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare' and rs.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'  and dw.Event_Type = 'First Trip') counts1
group by platform, partner

UNION ALL

select platform, partner, avg(Total_Spend)/count(IDs) as ConversionRate from 
(select 
ads.platform, ads.partner, coalesce(cp.Event_ID, rs.Event_ID, dw.Event_ID) as IDs, ads.Total_Spend from `my-project-getsales.getsales1.SearchAd` soc
inner join `my-project-getsales.getsales1.ads` ads on ads.Ad_ID = soc.Ad_ID and ads.platform = 'Search'
left join `my-project-getsales.getsales1.CourierPartner` cp on cp.phone = soc.phone and cp.Email = soc.Email and ads.partner = 'Courier' and cp.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.RidesharePartner` rs on rs.phone = soc.phone and ads.partner = 'Rideshare' and rs.Event_Type = 'First Trip'
left join `my-project-getsales.getsales1.DogWalkPartner` dw on dw.Email = soc.Email and ads.partner = 'Dog Walker'  and dw.Event_Type = 'First Trip') counts1
group by platform, partner



)

select *
from prob3

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
