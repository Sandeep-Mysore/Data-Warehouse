CREATE DATABASE gtd_full;
CREATE TABLE gtd_full_dataset(
    event_id double NOT NULL,
    d_year INT(4),
    d_month INT(2),
    d_day INT(2),
    country_id INT NOT NULL,
    country varchar (50),
    region_id varchar (50),
    region varchar (50),
    prov_state varchar (50) ,
    city varchar (50),
    summary text,
    multiple varchar (50),
    success varchar (50) ,
    suicide varchar (50) ,
    attack_type_id varchar (50),
    attack_type varchar (50) ,
    target_type_id varchar (50) ,
    target_type varchar (50),
    nationality_id varchar (50),
    nationality varchar (50),
    group_name varchar (300),
    motive text,
    individual varchar (50),
    claimed varchar (50),
    claim_mode_id varchar (50),
    claim_mode varchar (50),
    weapon_type_id varchar (50),
    weapon_type varchar (50),
    nkill varchar (50) ,
    nkillus varchar (50) ,
    nkillter varchar (50) ,
    nwound varchar (50),
    nwoundus varchar (50) ,
    nwoundter varchar (50) ,
    property varchar (50),
    prop_extent_id varchar (50) ,
    prop_extent varchar (50) ,
    ishostkid varchar (50) ,
    ransom varchar (50) ,
    hostkid_outcome_id varchar (50),
    hostkid_outcome varchar (50),
    add_notes text,
    scite1 text,
    scite2 text,
    scite3 text,
    Db_source varchar (50)
);




CREATE DATABASE gtd_half;

DROP TABLE IF EXISTS Dates;
DROP TABLE IF EXISTS Countries;
DROP TABLE IF EXISTS Regions;
DROP TABLE IF EXISTS ProvStates;
DROP TABLE IF EXISTS Cities;
DROP TABLE IF EXISTS AttackTypes;
DROP TABLE IF EXISTS TargetTypes;
DROP TABLE IF EXISTS Nationalities;
DROP TABLE IF EXISTS WeaponTypes;
DROP TABLE IF EXISTS ClaimModes;
DROP TABLE IF EXISTS PropExtents;
DROP TABLE IF EXISTS HostKidOutcomes;
DROP TABLE IF EXISTS EventDetail;
DROP TABLE IF EXISTS Citations;


CREATE TABLE Regions (
    region_id int unique not null,
    region varchar (50) not null,
    PRIMARY KEY (region_id)
);

CREATE TABLE Countries (
    country_id int unique not null,
    country varchar (50) not null,
    region_id int not null,
    PRIMARY KEY (country_id),
    CONSTRAINT fk_countries_regions FOREIGN KEY (region_id) REFERENCES Regions(region_id) ON DELETE CASCADE
);

CREATE TABLE ProvStates (
    prov_state_id int not null,
    prov_state varchar (50) not null,
    country_id int not null,
    PRIMARY KEY (prov_state_id),
    CONSTRAINT fk_provstates_countries FOREIGN KEY (country_id) REFERENCES Countries(country_id) ON DELETE CASCADE
);

CREATE TABLE Cities (
    city_id int not null,
    city varchar (50) not null,
    prov_state_id int not null,
    PRIMARY KEY (city_id),
    CONSTRAINT fk_cities_provstates FOREIGN KEY (prov_state_id) REFERENCES ProvStates(prov_state_id) ON DELETE CASCADE
);

CREATE TABLE AttackTypes (
    attack_type_id int unique not null,
    attack_type varchar (50) not null,
    PRIMARY KEY (attack_type_id)
);

CREATE TABLE TargetTypes (
    target_type_id int unique not null,
    target_type varchar (50) not null,
    PRIMARY KEY (target_type_id)
);

CREATE TABLE Nationalities (
    nationality_id int unique not null,
    nationality varchar (50) not null,
    PRIMARY KEY (nationality_id)
);

CREATE TABLE WeaponTypes (
    weapon_type_id int unique not null,
    weapon_type varchar (50) not null,
    PRIMARY KEY (weapon_type_id)
);

CREATE TABLE ClaimModes (
    claim_mode_id int unique not null,
    claim_mode varchar (50) not null,
    PRIMARY KEY (claim_mode_id)
);

CREATE TABLE PropExtents (
    prop_extent_id int unique not null,
    prop_extent varchar (50) not null,
    PRIMARY KEY (prop_extent_id)
);

CREATE TABLE HostKidOutcomes (
    hostkid_outcome_id int unique not null,
    hostkid_outcome varchar (50) not null,
    PRIMARY KEY (hostkid_outcome_id)
);

CREATE TABLE EventsDetail (
    event_id double not null,
    summary text,
    date_id int not null,
    region_id int not null,
    multiple boolean,
    success boolean,
    suicide boolean,
    attack_type_id int(1) not null,
    target_type_id int(2) not null,
    target varchar (50),
    nationality_id int not null,
    group_name varchar (50),
    motive TEXT,
    weapon_type_id int(2) not null,
    individual boolean,
    add_notes text,
    claimed boolean,
    claim_mode_id int not null,
    nkill float,
    nkillus float,
    nkillter float,
    nwound float,
    nwoundus float,
    nwoundter float,
    property int,
    ishostkid boolean,
    ransom boolean,
    hostkid_outcome_id int not null,
    prop_extent_id int,
    scite1 text,
    scite2 text,
    scite3 text,
    Db_source varchar(50),
    PRIMARY KEY (event_id),
    CONSTRAINT fk_eventsdetail_dates FOREIGN KEY (date_id) REFERENCES Dates(date_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_regions FOREIGN KEY (region_id) REFERENCES Regions(region_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_attacktypes FOREIGN KEY (attack_type_id) REFERENCES AttackTypes(attack_type_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_targettypes FOREIGN KEY (target_type_id) REFERENCES TargetTypes(target_type_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_nationalities FOREIGN KEY (nationality_id) REFERENCES Nationalities(nationality_id) ON DELETE CASCADE,
	CONSTRAINT fk_eventsdetail_weapontypes FOREIGN KEY (weapon_type_id) REFERENCES WeaponTypes(weapon_type_id) ON DELETE CASCADE,
	CONSTRAINT fk_eventsdetail_claimmodes FOREIGN KEY (claim_mode_id) REFERENCES ClaimModes(claim_mode_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_propextents FOREIGN KEY (prop_extent_id) REFERENCES PropExtents(prop_extent_id) ON DELETE CASCADE,
    CONSTRAINT fk_eventsdetail_hostkidoutcomes FOREIGN KEY (hostkid_outcome_id) REFERENCES HostKidOutcomes(hostkid_outcome_id) ON DELETE CASCADE
);

CREATE TABLE fact (
    event_id int not null,
    date_id int not null,
    d_year int(4),
    country_id int unique not null,
    summary text,
    attack_type_id varchar (400),
    target_type_id varchar (400),
    weapon_type_id varchar (400),
    nationality_id varchar (400),
    group_name varchar (400),
    success varchar(400),
    suicide varchar (400),
    property varchar (400),
    claimed varchar (400),
    ransom varchar (400) ,
    ishostkid varchar (400),
    nkill varchar (400) ,
    nwound varchar (400),
    scite1 text,
    Db_source varchar (400)
);

CREATE TABLE timedim (
    date_id int not null,
    d_year int(4),
    d_month int(2),
    d_day int(2),
    PRIMARY KEY (date_id)
);

CREATE TABLE locdim (
    country_id int unique not null,
    country varchar (400),
    region_id int unique not null,
    region varchar (400),
    prov_state_id int not null,
    prov_state varchar (400),
    city_id int not null,
    city varchar (400),
);

CREATE TABLE detaildim (
    summary text;
    attack_type_id varchar (400),
    attack_type varchar (400) ,
    target_type_id varchar (400) ,
    target_type varchar (400),
    weapon_type_id varchar (400),
    weapon_type varchar (400),
    nationality_id varchar (400),
    nationality varchar (400),
    group_name varchar (400),
    motive text,
    add_notes text
);

CREATE TABLE resultdim (
    multiple varchar (400),
    success varchar (400) ,
    suicide varchar (400) ,
    individual varchar (400),
    property varchar (400),
    claimed varchar (400),
    ransom varchar (400) ,
    ishostkid varchar (50),
    claim_mode_id varchar (400),
    claim_mode varchar (400),
    prop_extent_id varchar (400) ,
    prop_extent varchar (400) ,
    hostkid_outcome_id varchar (50),
    hostkid_outcome varchar (50),
);

CREATE TABLE statsdim (
    nkill varchar (400) ,
    nkillus varchar (400) ,
    nkillter varchar (400) ,
    nwound varchar (400),
    nwoundus varchar (400) ,
    nwoundter varchar (400) ,
);

CREATE TABLE citedim (
    scite1 text,
    scite2 text,
    scite3 text,
    Db_source varchar (400)
);

'''
INSERT INTO Countries(country_id,country)
SELECT DISTINCT CAST (country_id as UNSIGNED), country
FROM gtd_full_dataset

INSERT INTO Nationalities(nationality_id,nationality)
SELECT DISTINCT nationality_id , nationality
FROM gtd_full_dataset

INSERT INTO Regions(region_id,region)
SELECT DISTINCT region_id , region
FROM gtd_full_dataset

INSERT INTO Regions(region_id,region)
SELECT DISTINCT region_id , region
FROM gtd_full_dataset
'''
