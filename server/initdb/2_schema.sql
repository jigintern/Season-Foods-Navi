CREATE TABLE IF NOT EXISTS season_foods_navi.season_foods (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(255),
 months VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS season_foods_navi.prefecture (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS season_foods_navi.recipes (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(255),
 picture VARCHAR(255),
 foods VARCHAR(255),
 pref_id INT,

 FOREIGN KEY (pref_id) REFERENCES prefecture (id)
);


CREATE TABLE IF NOT EXISTS season_foods_navi.local_foods (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(255),
 picture VARCHAR(255),
 pref_id INT,

 FOREIGN KEY (pref_id) REFERENCES prefecture (id)
);


