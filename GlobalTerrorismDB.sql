CREATE DATABASE GlobalTerrorismDB;

DROP TABLE Dates;
DROP TABLE Countries;
DROP TABLE Regions;
DROP TABLE ProvStates;
DROP TABLE Cities;
DROP TABLE AttackTypes;
DROP TABLE TargetTypes;
DROP TABLE Nationalities;
DROP TABLE WeaponTypes;
DROP TABLE ClaimModes;
DROP TABLE PropExtents;
DROP TABLE HostKidOutcomes;
DROP TABLE Events;
DROP TABLE Citations;

CREATE TABLE Dates (
    date_id serial,
    d_year int(4),
    d_month int(2),
    d_day int(2),
    PRIMARY KEY (time_id)
);

CREATE TABLE Regions (
    region_id int unique not null,
    region varchar (50) not null,
    PRIMARY KEY (region_id)
);

CREATE TABLE Countries (
    country_id int unique not null,
    country varchar (50) not null,
    region_id int,
    PRIMARY KEY (country_id),
    FOREIGN KEY (region_id) REFERENCES Regions
        ON DELETE SET NULL
);

CREATE TABLE ProvStates (
    prov_state_id serial,
    prov_state varchar (50) not null,
    country_id int,
    PRIMARY KEY (prov_state_id),
    FOREIGN KEY (country_id) REFERENCES Countries
        ON DELETE SET NULL
);

CREATE TABLE Cities (
    city_id serial,
    city varchar (50) not null,
    prov_state_id int,
    PRIMARY KEY (city_id),
    FOREIGN KEY (prov_state_id) REFERENCES ProvStates
        ON DELETE SET NULL
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

CREATE TABLE Events (
    event_id int unique not null,
    summary text,
    date_id int,
    region_id int,
    multiple boolean,
    success boolean,
    suicide boolean,
    attack_type_id int(1),
    target_type_id int(2),
    target varchar,
    nationality_id int,
    group_name varchar,
    motive text,
    gun_certain boolean,
    weapon_type_id int(2),
    individual boolean,
    add_notes text,
    claimed boolean,
    claim_mode_id int,
    nkill float,
    nkillus float,
    nkillter float,
    nwound float,
    nwoundus float,
    nwoundter float,
    property int,
    ishostkid boolean,
    ransom boolean,
    hostkid_outcome_id int,
    scite1 text,
    scite2 text,
    scite3 text,
    Db_source varchar,
    PRIMARY KEY (event_id),
    FOREIGN KEY (date_id) REFERENCES Dates
        ON DELETE SET NULL,
    FOREIGN KEY (region_id) REFERENCES Regions
        ON DELETE SET NULL,
    FOREIGN KEY (attack_type_id) REFERENCES AttackTypes
        ON DELETE SET NULL,
FOREIGN KEY (target_type_id) REFERENCES TargetTypes
        ON DELETE SET NULL,
    FOREIGN KEY (nationality_id) REFERENCES Nationalities
        ON DELETE SET NULL,
    FOREIGN KEY (weapon_type_id) REFERENCES WeaponTypes
        ON DELETE SET NULL,
    FOREIGN KEY (claim_mode_id) REFERENCES ClaimModes
        ON DELETE SET NULL,
    FOREIGN KEY (prop_extent_id) REFERENCES PropExtents
        ON DELETE SET NULL,
    FOREIGN KEY (hostkid_outcome_id) REFERENCES HostKidOutcomes
        ON DELETE SET NULL
);
