-- Milestone 2 parts 6 and 7

-- step 6 DDL creating tables,
drop table junction;
create table junction
    (
        junctionName char(20) not null,
        location char(20) not null,
        isSkytrain char(1) not null,
        garageId char(5) unique,
        primary key(junctionName),
        foreign key (garageId) references bike_garage
    );

insert into junction value (
'Waterfront' , 'Vancouver','1', 'WaterfrontBike'
);
insert into junction value (
'Joyce' , 'Vancouver','1', 'JoyceBike'
);
insert into junction value (
'Main Street' , 'Vancouver','1', 'MainStreetBike'
);
insert into junction value (
'Marpole' , 'Vancouver', '0', 'NULL'
);
insert into junction value (
'KingGeorge' , 'Surrey','1', 'KingGeorgeBike'
);

drop table bus_loop;
create table bus_loop
    (
        junctionName char(20) not null,
        num_bus int,
        primary key(junctionName),
        foreign key (junctionName) references junction ON DELETE CASCADE
    );

insert into bus_loop value (
'KingGeorge' , '4'
);
insert into bus_loop value (
'Brighouse' , '7'
);
insert into bus_loop value (
'Main Street' , '10'
);
insert into bus_loop value (
'Joyce' , '7'
);
insert into bus_loop value (
'Marpole' , '10'
);

drop table sky_train;
create table sky_train
    (
        junctionName char(20) not null,
        primary key(junctionName),
        foreign key (junctionName) references junction ON DELETE CASCADE
    );
insert into sky_train value (
'Metrotown'
);
insert into sky_train value (
'Waterfront'
);
insert into sky_train value (
'King George'
);
insert into sky_train value (
'Joyce'
);
insert into sky_train value (
'Brighouse'
);

drop table bike_garage;
create table bike_garage
    (
        junctionName char(20) not null,
        garageId char(5) not null,
        num_bikes int not null,
        primary key(garageId),
        foreign key(junctionName) references junction
    );
insert into hosts_a values (
    'Joyce', 'JoyceBike', '25'
);
insert into hosts_a values (
    'Main Street', 'MainStreetBike', '30'
);
insert into hosts_a values (
    'KingGeorge', 'KingGeorgeBike', '40'
);
insert into hosts_a values (
    'Bridgeport', 'BridgeportBike', '20'
);
insert into hosts_a values (
    'Commercial', 'CommercialBike', '50'
);

drop table customer;
create table customer
    (
        customerID char(20) not null unique,
        customerName char(20) not null,
        stopId char(5),
        primary key(customerID),
        foreign key(stopID) references stopp
    );
insert into customer values (
    '1', 'Danny', '100'
);
insert into customer values (
    '2', 'Cartier', '156'
);
insert into customer values (
    '3', 'Ronald', '126'
);
insert into customer values (
    '8', 'Another Cartier', '186'
);
insert into customer values (
    '89', 'Another Ronald', '200'
);

drop table stopp;
create table stopp
    (
        junctionName char(20),
        stopId char(5) not null,
        location char(20) not null,
        direction char(5),
        primary key(stopId),
        foreign key(junctionName) references junction ON DELETE CASCADE
    );
insert into stopp values (
    'Joyce', '79', 'Vancouver', 'West'
);
insert into stopp values (
    'UBC', '90', 'Vancouver', 'East'
);
insert into stopp values (
    'Metrotown', '345', 'Burnaby', 'West'
);
insert into stopp values (
    'Metrotown', '12', 'Burnaby', 'North'
);
insert into stopp values (
    'SFU', '999', 'Burnaby', 'South'
);

drop table contains;          ------------------------ Relationship
create table contains
    (
        stopId char(5) not null,
        routeId char(5) not null,
        primary key(routeId, stopId),
        foreign key (routeId) references routee ON DELETE CASCADE,
        foreign key (stopId) references stopp ON DELETE CASCADE
    );

insert into contains values (
    '79', '1'
);
insert into contains values (
    '90', '2'
);
insert into contains values (
    '345', '3'
);
insert into contains values (
    '12', '4'
);
insert into contains values (
    '999', '5'
);

drop table routee;
create table routee
    (
        routeId char(5) not null,
        start char(20) not null,
        end char(20) not null,
        primary key(routeId)
    );

insert into routee values (
    '1', 'Joyce', 'UBC'
);
insert into routee values (
    '2', 'UBC', 'Joyce'
);
insert into routee values (
    '3', 'Metrotown', 'Marine Drive'
);
insert into routee values (
    '4', 'Metrotown', 'Brentwood'
);
insert into routee values (
    '5', 'SFU', 'Metrotown'
);

drop table vehicle;
create table vehicle
    (
        junctionName char(20) not null,
        serialNumber char(20) not null,
        routeId char(5),
        status char(20) not null,
        current_location char(20) not null,
        numPassengers int,
        primary key(serialNumber),
        foreign key (junctionName) references junction ON DELETE SET NULL,
        foreign key(routeID) references routee
    );
insert into vehicle values (
    'Joyce', 'v1', '1', 'Running', 'Vancouver', 30
);
insert into vehicle values (
    'UBC', 'v2', '2', 'Running', 'Vancouver', 30
);
insert into vehicle values (
    'Metrotown', 'v3', 'NULL', 'Broken', 'Burnaby', 'NULL'
);
insert into vehicle values (
    'Metrotown', 'v4', '4', 'Running', 'Burnaby', 30
);
insert into vehicle values (
    'SFU', 'v5', '5', 'Running', 'Burnaby', 30
);

drop table bus;
create table bus
    (
        serialNumber char(20) not null,
        employeeID char(20) not null,
        type char(20) not null,
        primary key(serialNumber),
        foreign key(serialNumber) references vehicle,
        foreign key(employeeID) references driver
    );
insert into bus values (
    'v1', 'e4', 'Rapid'
);
insert into bus values (
    'v2', 'e8', 'Express'
);
insert into bus values (
    'v3', 'e99', 'Regular'
);
insert into bus values (
    'v4', 'e34', 'Regular'
);
insert into bus values (
    'v5', 'e0', 'Regular'
);

drop table skytrain;
create table skytrain
    (
        serialNumber char(20) not null,
        line char(20) not null,
        primary key(serialNumber),
        foreign key(serialNumber) references vehicle
    );
insert into skytrain values (
    'v6', 'Canada'
);
insert into skytrain values (
    'v7', 'Canada'
);
insert into skytrain values (
    'v8', 'Expo'
);
insert into skytrain values (
    'v9', 'Evergreen'
);
insert into skytrain values (
    'v10', 'Millenium'
);

drop table driver;
create table driver
    (
        employeeID char(20) not null,
        driverName char(20) not null,
        serialNumber char(20),
        primary key(employeeID),
        foreign key(serialNumber) references bus
    );
insert into driver values (
    'e4', 'Danny', 'v1' 
);
insert into driver values (
    'e8', 'Cartier', 'v2' 
);
insert into driver values (
    'e99', 'Ronald', 'v3' 
);
insert into driver values (
    'e34', 'Giannis', 'v4' 
);
insert into driver values (
    'e0', 'Tatum', 'v4' 
);
