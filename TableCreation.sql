CREATE TABLE country (
    id INT(16) NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(40) NOT NULL,
    PRIMARY KEY(id)
) AUTO_INCREMENT=100;

CREATE TABLE university (
    id INT(16) NOT NULL AUTO_INCREMENT,
    university_name VARCHAR(40) NOT NULL,
	country_id INT(16) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(id),
    PRIMARY KEY(id)
) AUTO_INCREMENT=1000;

CREATE TABLE university_year (
    university_name VARCHAR(40) NOT NULL,
	university_id INT(16) NOT NULL,
	year INT NOT NULL,
	num_students INT(16),
	student_staff_ratio INT(16),
	pct_international_students INT(16),
	pct_female_students INT(16),
    FOREIGN KEY (university_id) REFERENCES university(id)
); 

CREATE TABLE ranking_system (
    id INT(16) NOT NULL AUTO_INCREMENT,
    system_name VARCHAR(40) NOT NULL,
    PRIMARY KEY(id)
) AUTO_INCREMENT=100;

CREATE TABLE ranking_criteria (
    id INT(16) NOT NULL AUTO_INCREMENT,
	ranking_system_id INT(16) NOT NULL, 
    criteria_name VARCHAR(40) NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY (ranking_system_id) REFERENCES ranking_system(id)
) AUTO_INCREMENT=500;

CREATE TABLE university_ranking_year (
	university_id INT(16) NOT NULL,
    ranking_criteria_id INT(16) NOT NULL,
    year INT(16) NOT NULL,
    score INT(16) NOT NULL, 
	FOREIGN KEY (university_id) REFERENCES university(id),
    FOREIGN KEY (ranking_criteria_id) REFERENCES ranking_criteria(id)
);