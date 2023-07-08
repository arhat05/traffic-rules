DROP DATABASE IF EXISTS trafficRulesDatabase;
CREATE DATABASE trafficRulesDatabase;
USE trafficRulesDatabase;

DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
    licensePlate VARCHAR(10) NOT NULL PRIMARY KEY,
    driver VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    make VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    weight INT NOT NULL
);

DROP TABLE IF EXISTS trafficRules;
CREATE TABLE trafficRules (
    ruleId INT NOT NULL PRIMARY KEY,
    rule_desc VARCHAR(100) NOT NULL,
    fine INT NOT NULL,
    create_date DATE NOT NULL,
    update_date DATE NOT NULL
);

DROP TABLE IF EXISTS location;
CREATE TABLE location (
    locationId INT NOT NULL PRIMARY KEY,
    loc_name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS dashcam;
CREATE TABLE dashcam (
    dashcamId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    timestamp TIMESTAMP NOT NULL,
    licensePlate VARCHAR(10) NOT NULL,
    speed_limit INT NOT NULL,
    car_speed INT NOT NULL,
    stop_sign BOOLEAN NOT NULL,
    traffic_light ENUM('red', 'yellow', 'green') NOT NULL,
    locationId INT NOT NULL,
    noParking BOOLEAN NOT NULL,
    noUturn BOOLEAN NOT NULL,
    yield BOOLEAN NOT NULL,
    FOREIGN KEY (locationId) REFERENCES location(locationId),
    FOREIGN KEY (licensePlate) REFERENCES cars(licensePlate)
);

DROP TABLE IF EXISTS violation;
CREATE TABLE violation (
    violationId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ruleId INT NOT NULL,
    licensePlate VARCHAR(10) NOT NULL,
    locationId INT NOT NULL,
    date_committed DATE NOT NULL,
    fine INT NOT NULL,
    time TIMESTAMP NOT NULL,
    accident BOOLEAN NOT NULL,
    FOREIGN KEY (ruleId) REFERENCES trafficRules(ruleId),
    FOREIGN KEY (licensePlate) REFERENCES cars(licensePlate),
    FOREIGN KEY (locationId) REFERENCES location(locationId)
);

