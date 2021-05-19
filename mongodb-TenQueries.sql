-- how many events were successful in a month?
select imonth, count(*)
from events
where success = '1'
group by imonth

-- How many events related to suicide?
select Count(*) from events
where suicide = '1';

-- What is the nationality of the group that committed most attacks in a region?
select gname, count(gname), natlty1_txt
from events
where gname <> "Unknown"
group by gname, natlty1_txt
order by count(gname) desc
limit 1;

-- How many people were killed in an attack?
-- How many people were killed in a region?
select region, count(nkill)
from events
group by region;

-- How many kidnapping were successful by group name?
select count(gname), gname, ransomamt
from events
where attacktype1 = "6"
and success = "1"
group by gname, ransomamt;

-- Which city suffered what property damage?
select city, propextent_txt
from events
where propextent_txt <> "Unknown"
and propextent_txt <> null
group by city, propextent_txt
order by propextent_txt asc;

-- How many events as claimed by terrorist?
select gname, count(*)
from events
where claimed = "1"
group by gname
order by gname asc

-- Highest number of attacks in a region
select region_txt, count(*)
from locDIM
where region_txt <> null
group by region_txt;