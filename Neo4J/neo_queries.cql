-- Delete all nodes
Match (n) DETACH DELETE n;


-- Create graph nodes and Load data to graph from csv
LOAD CSV WITH HEADERS FROM 'file:/var/lib/neo4j/import/gtd_half_1.csv' AS line
CREATE (:gtd{eventid : line.eventid, iyear : line.iyear, imonth : line.imonth, iday : line.iday, country : line.country, country_txt : line.country_txt, region : line.region, region_txt : line.region_txt, provstate : line.provstate, city : line.city, summary : line.summary, multiple : line.multiple, success : line.success, suicide : line.suicide, attacktype : line.attacktype1, attacktype_txt : line.attacktype1_txt, targettype : line.targtype1, targettype_txt : line.targettype1_txt, nationality : line.natlty1, nationality_txt : line.natlty1_txt, gname : line.gname, motive : line.motive, individual : line.individual, claimed : line.claimed, claimmode : line.claimmode, claimmode_txt : line.claimmode_txt, weapon_type : line.weaptype1, weapon_type_txt : line.weaptype1_txt, nkill : line.nkill, nkillus : line.nkillus, nkillter : line.nkillter, nwound : line.nwound, nwoundus : line.nwoundus, nwoundter : line.nwoundter, property : line.property, propextent : line.propextent, propextent_txt : line.propextent_txt, ishostkid : line.ishostkid, ransom : line.ransom, hostkidoutcome : line.hostkidoutcome, hostkidoutcome_txt : line.hostkidoutcome_txt, notes : line.addnotes, scite1 : line.scite1, db_source : line.db_source})


-- Create Dimensions
MATCH (n)
WITH n
CREATE (:dateDIM{date_id : id(n), d_year : n.iyear, d_month : n.imonth, d_day : n.iday})

MATCH (n)
WITH n
CREATE (:citeDIM{cite_id : id(n), scite1 : n.scite1, db_source : n.db_source})

MATCH (n)
WITH n
CREATE (:detailDIM{detail_id : id(n), summary : n.summary, attack_type : n.attacktype, target_type : n.targettype })

MATCH (n)
WITH n
CREATE (:statDIM{stat_id : id(n), nkill : n.nkill, nwound: n.nwound})

MATCH (n)
WITH n
CREATE (:locDIM{location_id : id(n), country : n.country, region : n.region, prov_state : n.prov_state, city: n.city})

MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id : de.detail_id, stat_id : s.stat_id, number_of_attacks : count(*)})

-- Create Relationship b/w fact and dateDIM
MATCH (n:Fact), (m:dateDIM)
WHERE n.date_id = m.date_id
CREATE (n)-[r:Happened_During]->(m)
RETURN type(r),r.name

-- Create Relationship b/w fact and citeDIM
MATCH (n:Fact), (m:citeDIM)
WHERE n.cite_id = m.cite_id
CREATE (n)-[r:Cited_In]->(m)
RETURN type(r),r.name

-- Create Relationship b/w fact and detailDIM
MATCH (n:Fact), (m:detailDIM)
WHERE n.detail_id = m.detail_id
CREATE (n)-[r:Details_Of]->(m)
RETURN type(r),r.name

-- Create Relationship b/w fact and statDIM
MATCH (n:Fact), (m:statDIM)
WHERE n.stat_id = m.stat_id
CREATE (n)-[r:Stats_Of]->(m)
RETURN type(r),r.name

-- Create Relationship b/w fact and locDIM
MATCH (n:Fact), (m:locDIM)
WHERE n.location_id = m.location_id
CREATE (n)-[r:Happened_At]->(m)
RETURN type(r),r.name

MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id : de.detail_id, stat_id : s.stat_id, number_of_attacks : count(*)})




-- how many events were successful in a month?
MATCH (n) WHERE toInteger(n.success) = 1 RETURN n.imonth,count(*) as total ORDER BY total DESC


-- How many events related to suicide?
MATCH (n) WHERE toInteger(n.suicide) = 1 RETURN count(*) as total


-- What is the nationality of the group that committed most attacks in a region?
MATCH (n) WHERE n.gname <> 'Unknown' RETURN n.gname,n.nationality_txt,count(n.gname) as total ORDER BY total DESC


-- How many people were killed in a region?
MATCH (n) RETURN n.region,count(n.nkill) as total ORDER BY total DESC


-- How many kidnapping were successful by group name and attacktype is 6?
MATCH (n) WHERE toInteger(n.ransom) = 1 AND toInteger(n.success) = 1 AND toInteger(n.attacktype) = 6   RETURN n.gname,count(n.gname) as total ORDER BY total DESC


-- How many kidnapping were successful by group name?
MATCH (n) WHERE toInteger(n.ransom) = 1, toInteger(n.success) = 1  RETURN n.gname,count(n.gname) as total ORDER BY total DESC


-- Which city suffered what property damage?
MATCH (n) WHERE n.propextent_txt <> "Unknown" AND n.propextent_txt <> null RETURN n.city,n.propextent_txt
MATCH (n) WHERE n.propextent_txt <> "Unknown" AND n.propextent_txt <> "" RETURN n.city,n.propextent_txt, collect(n.propextent_txt) ORDER BY n.propextent_txt ASC


-- How many events as claimed by terrorist?
MATCH (n) WHERE toInteger(n.claimed) = 1 RETURN n.gname,count(*) as Total ORDER BY Total DESC


-- Highest number of attacks in a region
MATCH (n) WHERE n.region_txt <> "" RETURN n.region_txt,count(*) as Total ORDER BY Total DESC
