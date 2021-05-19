CREATE DATABASE gtd_DW;

DROP TABLE IF EXISTS dateDIM;
DROP TABLE IF EXISTS locDIM;
DROP TABLE IF EXISTS detailDIM;
DROP TABLE IF EXISTS resultDIM;
DROP TABLE IF EXISTS statDIM;
DROP TABLE IF EXISTS citeDIM;
DROP TABLE IF EXISTS Fact;

CREATE TABLE dateDIM(
    date_id int unique not null,
    d_year int(4),
    d_month int(2),
    d_day int(2),
    PRIMARY KEY (date_id)
);

CREATE TABLE locDIM(
    location_id int unique not null,
    country varchar (400),
    region varchar (400),
    prov_state varchar (400),
    city varchar (400),
    PRIMARY KEY (location_id)
);

CREATE TABLE detailDIM(
    detail_id int unique not null,
    summary text,
    attack_type varchar (400),
    target_type varchar (400),
    weapon_type varchar (400),
    nationality varchar (400),
    group_name varchar (400),
    motive text,
    add_notes text,
    PRIMARY KEY (detail_id)
);

CREATE TABLE resultDIM(
    result_id int unique not null,
    multiple varchar (400),
    success varchar (400) ,
    suicide varchar (400) ,
    individual varchar (400),
    property varchar (400),
    claimed varchar (400),
    ransom varchar (400) ,
    ishostkid varchar (50),
    claim_mode varchar (400),
    prop_extent varchar (400) ,
    hostkid_outcome varchar (50),
    PRIMARY KEY (result_id)
);

CREATE TABLE statDIM(
    stat_id int unique not null,
    nkill varchar (400),
    nkillus varchar (400),
    nkillter varchar (400),
    nwound varchar (400),
    nwoundus varchar (400),
    nwoundter varchar (400),
    PRIMARY KEY (stat_id) 
);

CREATE TABLE citeDIM(
    cit_id int unique not null,
    scite1 text,
    scite2 text,
    scite3 text,
    db_source varchar (400),
    PRIMARY KEY (cite_id)    
);

CREATE TABLE Fact(
    date_id int,
    location_id int,
    detail_id int,
    result_id int,
    stat_id int,
    cite_id int,
    number_of_attacks int,
    CONSTRAINT fk_fact_dates FOREIGN KEY (date_id) REFERENCES dateDIM(date_id) ON DELETE CASCADE,
    CONSTRAINT fk_fact_locations FOREIGN KEY (location_id) REFERENCES locDIM(location_id) ON DELETE CASCADE,
    CONSTRAINT fk_fact_details FOREIGN KEY (detail_id) REFERENCES detailDIM(detail_id) ON DELETE CASCADE,
    CONSTRAINT fk_fact_results FOREIGN KEY (result_id) REFERENCES resultDIM(result_id) ON DELETE CASCADE,
    CONSTRAINT fk_fact_stats FOREIGN KEY (stat_id) REFERENCES statDIM(stat_id) ON DELETE CASCADE,
	CONSTRAINT fk_fact_cite FOREIGN KEY (cite_id) REFERENCES citeDIM(cite_id) ON DELETE CASCADE
);
