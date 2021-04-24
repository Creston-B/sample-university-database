DELIMITER #

-- Show all university ranking system criterias by their parent system as [system id], [system name], [criteria id], [criteria name]

CREATE PROCEDURE show_all_ranking_systems()
BEGIN
  SELECT ranking_system.id AS "ranking_system id", ranking_system.system_name, ranking_criteria.id AS "ranking_criteria id", ranking_criteria.criteria_name FROM ranking_system LEFT JOIN ranking_criteria ON ranking_system.id = ranking_criteria.ranking_system_id;
END #

-- Show all universities in a specified country (country_id) as [country id], [country name], [university id], [university name]

CREATE PROCEDURE show_all_universities_in_country  (IN country_id INT(16))
BEGIN
  SELECT country.id AS "country id", country.country_name, university.id AS "university id", university.university_name FROM country LEFT JOIN university ON country.id = university.country_id WHERE country.id = country_id;
END #

-- Show the number of students at a specified university (university id) in a specified year (year) as [university id], [university name], [number of students], [year]

CREATE PROCEDURE show_number_of_students_in_year  (IN university_id INT(16), year INT(16))
BEGIN
  SELECT university.id AS 'university id', university.university_name, university_year.num_students, year FROM university_year LEFT JOIN university ON university.id = university_year.university_id WHERE university_year.university_id = university_id AND university_year.year = year;
END #

-- Show the top ranking university by a specified criteria (criteria id) in a specified year (year) as [university id], [university name], [system id], [system name], [criteria id], [criteria name], [score], [year]
-- First finds the highest score among all entries of the specified criteria and year
-- Uses the greatest score to return the university(-ies) that scored that amount

CREATE PROCEDURE show_top_ranking_university_in_year_by_criteria (IN criteria_id INT(16), IN year INT(16))
BEGIN
	DECLARE top_score INT(16);

	SELECT MAX(university_ranking_year.score) 
    INTO top_score 
	FROM university_ranking_year 
	WHERE university_ranking_year.ranking_criteria_id =  criteria_id AND university_ranking_year.year = year;

	SELECT university.id AS 'university id', university.university_name, ranking_system.id AS 'ranking_system id', ranking_system.system_name AS 'ranking_system name', ranking_criteria.id AS 'ranking_criteria id', ranking_criteria.criteria_name, university_ranking_year.score, year
	FROM university_ranking_year 
	LEFT JOIN university ON university_ranking_year.university_id = university.id
	LEFT JOIN ranking_criteria ON university_ranking_year.ranking_criteria_id = ranking_criteria.id 
	LEFT JOIN ranking_system ON ranking_criteria.ranking_system_id = ranking_system.id 
	WHERE ranking_criteria.id = criteria_id AND university_ranking_year.year = year AND university_ranking_year.score = top_score
	ORDER BY university_ranking_year.score DESC;
END #