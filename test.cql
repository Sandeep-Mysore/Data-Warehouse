LOAD CSV WITH HEADERS FROM 'file:/var/lib/neo4j/import/gtd_half_1.csv' AS line
CREATE (:gtd{eventid : line.eventid, iyear : line.iyear, imonth : line.imonth, iday : line.iday, country : line.country, country_txt : line.country_txt, region : line.region, region_txt : line.region_txt, provstate : line.provstate, city : line.city, summary : line.summary, multiple : line.multiple, success : line.success, suicide : line.suicide, attacktype : line.attacktype1, attacktype_txt : line.attacktype1_txt, targettype : line.targtype1, targettype_txt : line.targettype1_txt, nationality : line.natlty1, nationality_txt : line.natlty1_txt, gname : line.gname, motive : line.motive, individual : line.individual, claimed : line.claimed, claimmode : line.claimmode, claimmode_txt : line.claimmode_txt, weapon_type : line.weaptype1, weapon_type_txt : line.weaptype1_txt, nkill : line.nkill, nkillus : line.nkillus, nkillter : line.nkillter, nwound : line.nwound, nwoundus : line.nwoundus, nwoundter : line.nwoundter, property : line.property, propextent : line.propextent, propextent_txt : line.propextent_txt, ishostkid : line.ishostkid, ransom : line.ransom, hostkidoutcome : line.hostkidoutcome, hostkidoutcome_txt : line.hostkidoutcome_txt, notes : line.addnotes, scite1 : line.scite1, scite2 : line.scite2, scite3 : line.scite3, db_source : line.db_source})


MATCH (n)
CREATE (:dateDIM{date_id : line.id, d_year : line.iyear, d_month : line.imonth, d_day : line.iday})

MATCH (n)
CREATE (:citeDIM{cite_id : id(n), scite1 : n.scite1, db_source : n.db_source})

MATCH (n)
CREATE (:detailDIM{detail_id : id(n), summary : n.summary, attack_type : n.attacktype, target_type : n.targettype })

MATCH (n)
CREATE (:statDIM{stat_id : id(n), nkill : n.nkill, nwound: n.nwound})

MATCH (n)
CREATE (:locDIM{location_id : id(n), country : n.country, region : n.region, prov_state : n.prov_state, city: n.city})

MATCH (n)
CREATE (:Fact{date_id : , location_id : '', detail_id : '', result_id : '', stat_id : '', cite_id : '', number_of_attacks : ''}),

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


















CREATE (:Fact{date_id : , location_id : '', detail_id : '', result_id : '', stat_id : '', cite_id : '', number_of_attacks : ''}),
    (n:dateDIM{date_id : '', d_year : gtd.iyear, d_month : gtd.imonth, d_day : gtd.iday}),
    (n:citeDIM{cite_id : '', scite1 : '', scite2 : '', scite3 : '', db_source : ''}),
    (n:detailDIM{detail_id : '', summary : '', attack_type : '', target_type : '', }),
    (n:resultDIM{}),
    (n:statDIM{stat_id : '', nkill : '', nkillus: '', nkillter: ''}),
    (n:locDIM{location_id : '', country : '', region : '', prov_state : '', city : ''})

LOAD CSV WITH HEADERS FROM 'file:/home/deuser/neo4j/import/gtd_half_1.csv' AS line
CREATE (:gtd{eventid : line[0], iyear : line[1], imonth : line[2], iday : line[3], country : line[4], country_txt : line[5], region : line[6], region_txt : line[7], provstate : line[8], city : line[9], summary : line[10], multiple : line[11], success : line[12], suicide : line[13], attacktype : line[14], attacktype_txt : line[15], targettype : line[16], targettype_txt : line[17], nationality : line[18], nationality_txt : line[19], gname : line[20], motive : line[21], individual : line[22], claimed : line[23], claimmode : line[24], claimmode_txt : line[25], weapon_type : line[26], weapon_type_txt : line[27], nkill : line[28], nkillus : line[29], nkillter : line[30], nwound : line[31], nwoundus : line[32], nwoundter : line[33], property : line[34], propextent : line[35], propextent_txt : line[36], ishostkid : line[37], ransom : line[38], hostkidoutcome : line[39], hostkidoutcome_txt : line[40], notes : line[41], scite1 : line[42], scite2 : line[43], scite3 : line[44], db_source : line[45]})

LOAD CSV WITH HEADERS FROM 'file:/var/lib/neo4j/import/gtd_half_1.csv' AS line
CREATE (:gtd{eventid : line.eventid, iyear : line.iyear, imonth : line.imonth, iday : line.iday, country : line.country, country_txt : line.country_txt, region : line.region, region_txt : line.region_txt, provstate : line.provstate, city : line.city, summary : line.summary, multiple : line.multiple, success : line.success, suicide : line.suicide, attacktype : line.attacktype1, attacktype_txt : line.attacktype1_txt, targettype : line.targtype1, targettype_txt : line.targettype1_txt, nationality : line.natlty1, nationality_txt : line.natlty1_txt, gname : line.gname, motive : line.motive, individual : line.individual, claimed : line.claimed, claimmode : line.claimmode, claimmode_txt : line.claimmode_txt, weapon_type : line.weaptype1, weapon_type_txt : line.weaptype1_txt, nkill : line.nkill, nkillus : line.nkillus, nkillter : line.nkillter, nwound : line.nwound, nwoundus : line.nwoundus, nwoundter : line.nwoundter, property : line.property, propextent : line.propextent, propextent_txt : line.propextent_txt, ishostkid : line.ishostkid, ransom : line.ransom, hostkidoutcome : line.hostkidoutcome, hostkidoutcome_txt : line.hostkidoutcome_txt, notes : line.addnotes, scite1 : line.scite1, scite2 : line.scite2, scite3 : line.scite3, db_source : line.db_source})

LOAD CSV WITH HEADERS FROM gtd_half_1.csv AS line
CREATE (:gtd{eventid : line.eventid, iyear : line.iyear, imonth : line.imonth, iday : line.iday, country : line.country, country_txt : line.country_txt, region : line.region, region_txt : line.region_txt, provstate : line.provstate, city : line.city, summary : line.summary, multiple : line.multiple, success : line.success, suicide : line.suicide, attacktype : line.attacktype1, attacktype_txt : line.attacktype1_txt, targettype : line.targtype1, targettype_txt : line.targettype1_txt, nationality : line.nationality, nationality_txt : line.nationality_txt, gname : line.gname, motive : line.motive, individual : line.individual, claimed : line.claimed, claimmode : line.claimmode, claimmode_txt : line.claimmode_txt, weapon_type : line.weaptype1, weapon_type_txt : line.weaptype1_txt, nkill : line.nkill, nkillus : line.nkillus, nkillter : line.nkillter, nwound : line.nwound, nwoundus : line.nwoundus, nwoundter : line.nwoundter, property : line.property, propextent : line.propextent, propextent_txt : line.propextent_txt, ishostkid : line.ishostkid, ransom : line.ransom, hostkidoutcome : line.hostkidoutcome, hostkidoutcome_txt : line.hostkidoutcome_txt, notes : line.addnotes, scite1 : line.scite1, scite2 : line.scite2, scite3 : line.scite3, db_source : line.db_source}),


-- how many events were successful in a month?
MATCH (n) WHERE toInteger(n.suicide) >= 1 RETURN n
MATCH (n) WHERE toInteger(n.suicide) >= 1 RETURN n.imonth,count(*)

MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id:de.detail_id, stat_id: s.stat_id, number_of_kills: sum(toInteger(n.nkills))})

CALL db.labels() YIELD label
CALL apoc.cypher.run('MATCH (:`'+label+'`) RETURN count(*) as count',{nkill}) YIELD value
RETURN label, value.count
MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id:de.detail_id, stat_id: s.stat_id, number_of_attacks: sum(nkill})

CALL db.labels() YIELD label
CALL apoc.cypher.run('MATCH (:`'+label+'`) RETURN count(*) as count',$nkill) YIELD value
RETURN label, value.count
MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id:de.detail_id, stat_id: s.stat_id, number_of_kills: value})

CALL db.labels() YIELD label
CALL apoc.cypher.run('MATCH (:`'+label+'`) RETURN count(*) as count',$nkill) YIELD value
MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id:de.detail_id, stat_id: s.stat_id, number_of_kills: value.count})

MATCH (n:gtd),(da:dateDIM),(c:citeDIM),(l:locDIM),(de:detailDIM),(s:statDIM)
WHERE id(n) = da.date_id AND id(n) = c.cite_id AND id(n) = l.location_id AND id(n) = de.detail_id AND id(n) = s.stat_id
CREATE (:Fact{date_id : da.date_id, cite_id : c.cite_id, location_id : l.location_id, detail_id:de.detail_id, stat_id: s.stat_id, number_of_kills: nkill.count})

(a:Person),
(b:Person)
WHERE a.name = 'A' AND b.name = 'B'
CREATE (a)-[r:RELTYPE {name: a.name + '<->' + b.name}]->(b)
RETURN type(r), r.name

MATCH (n:Fact),(m:statDIM),(l:locDIM)
WHERE n.stat_id = m.stat_id AND n.location_id = l.location_id
RETURN n.region,count(n.nkill) as total
ORDER BY total DESC
