DELIMITER #
CREATE PROCEDURE show_all_ranking_systems()
BEGIN
  SELECT ranking_system.id AS "ranking_system id", ranking_system.system_name, ranking_criteria.id AS "ranking_criteria id", ranking_criteria.criteria_name FROM ranking_system LEFT JOIN ranking_criteria ON ranking_system.id = ranking_criteria.ranking_system_id;
END #

CREATE PROCEDURE show_all_universities_in_country  (IN country_id INT(16))
BEGIN
  SELECT country.id AS "country id", country.country_name, university.id AS "university id", university.university_name FROM country LEFT JOIN university ON country.id = university.country_id WHERE country.id = country_id;
END #

CREATE PROCEDURE show_number_of_students_in_year  (IN university_id INT(16), year INT(16))
BEGIN
  SELECT university.id AS 'university id', university.university_name, university_year.num_students, year FROM university_year LEFT JOIN university ON university.id = university_year.university_id WHERE university_year.university_id = university_id AND university_year.year = year;
END #

CREATE PROCEDURE show_top_ranking_university_in_year_by_criteria (IN criteria_id INT(16), IN year INT(16))
BEGIN
	DECLARE top_score INT(16);

	SELECT university_ranking_year.score 
    INTO top_score 
	FROM university_ranking_year 
	WHERE university_ranking_year.ranking_criteria_id =  criteria_id AND university_ranking_year.year = year
	ORDER BY university_ranking_year.score DESC
	LIMIT 1;

	SELECT university.id AS 'university id', university.university_name, ranking_system.id AS 'ranking_system id', ranking_system.system_name AS 'ranking_system name', ranking_criteria.id AS 'ranking_criteria id', ranking_criteria.criteria_name, university_ranking_year.score, year
	FROM university_ranking_year 
	LEFT JOIN university ON university_ranking_year.university_id = university.id
	LEFT JOIN ranking_criteria ON university_ranking_year.ranking_criteria_id = ranking_criteria.id 
	LEFT JOIN ranking_system ON ranking_criteria.ranking_system_id = ranking_system.id 
	WHERE ranking_criteria.id = criteria_id AND university_ranking_year.year = year AND university_ranking_year.score = top_score
	ORDER BY university_ranking_year.score DESC;
END #