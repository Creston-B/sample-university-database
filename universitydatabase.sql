-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2021 at 08:52 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `universitydatabase`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_ranking_systems` ()  BEGIN
  SELECT ranking_system.id AS "ranking_system id", ranking_system.system_name, ranking_criteria.id AS "ranking_criteria id", ranking_criteria.criteria_name FROM ranking_system LEFT JOIN ranking_criteria ON ranking_system.id = ranking_criteria.ranking_system_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_universities_in_country` (IN `country_id` INT(16))  BEGIN
  SELECT country.id AS "country id", country.country_name, university.id AS "university id", university.university_name FROM country LEFT JOIN university ON country.id = university.country_id WHERE country.id = country_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_number_of_students_in_year` (IN `university_id` INT(16), `year` INT(16))  BEGIN
  SELECT university.id AS 'university id', university.university_name, university_year.num_students, year FROM university_year LEFT JOIN university ON university.id = university_year.university_id WHERE university_year.university_id = university_id AND university_year.year = year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_top_ranking_university_in_year_by_criteria` (IN `criteria_id` INT(16), IN `year` INT(16))  BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(16) NOT NULL,
  `country_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `country_name`) VALUES
(1, 'Canada'),
(2, 'United States'),
(3, 'Mexico'),
(4, 'Germany'),
(5, 'United Kingdom');

-- --------------------------------------------------------

--
-- Table structure for table `ranking_criteria`
--

CREATE TABLE `ranking_criteria` (
  `id` int(16) NOT NULL,
  `ranking_system_id` int(16) NOT NULL,
  `criteria_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ranking_criteria`
--

INSERT INTO `ranking_criteria` (`id`, `ranking_system_id`, `criteria_name`) VALUES
(500, 100, 'Academic Results'),
(501, 100, 'Student Polling'),
(502, 100, 'Graduates with Jobs in Field'),
(503, 101, 'Academic Results'),
(504, 101, 'Student Polling');

-- --------------------------------------------------------

--
-- Table structure for table `ranking_system`
--

CREATE TABLE `ranking_system` (
  `id` int(16) NOT NULL,
  `system_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ranking_system`
--

INSERT INTO `ranking_system` (`id`, `system_name`) VALUES
(100, 'QS World University Rankings'),
(101, 'Academic Ranking of World Universities');

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE `university` (
  `id` int(16) NOT NULL,
  `university_name` varchar(40) NOT NULL,
  `country_id` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `university`
--

INSERT INTO `university` (`id`, `university_name`, `country_id`) VALUES
(1000, 'University of Manitoba', 1),
(1001, 'University of Ottawa', 1),
(1002, 'University of Calgary', 1),
(1003, 'University of Victoria', 1),
(1004, 'University of Michigan', 2),
(1005, 'Michigan State University', 2),
(1006, 'University of Minnesota', 2),
(1007, 'Massachusetts Institute of Technology', 2),
(1008, 'University of Guadalajara', 3),
(1009, 'Tecnológico de Monterrey', 3),
(1010, 'Universidad Nacional Autónoma de México', 3),
(1011, 'University of Cologne', 4),
(1012, 'Technische Universität München', 4),
(1013, 'Karlsruher Institut für Technologie', 4),
(1014, 'University of Cambridge', 5),
(1015, 'University of Oxford', 5),
(1016, 'University of Sussex', 5),
(1017, 'University of Redundancy University', 5);

-- --------------------------------------------------------

--
-- Table structure for table `university_ranking_year`
--

CREATE TABLE `university_ranking_year` (
  `university_id` int(16) NOT NULL,
  `ranking_criteria_id` int(16) NOT NULL,
  `year` int(16) NOT NULL,
  `score` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `university_ranking_year`
--

INSERT INTO `university_ranking_year` (`university_id`, `ranking_criteria_id`, `year`, `score`) VALUES
(1000, 500, 2018, 78),
(1000, 500, 2019, 75),
(1000, 500, 2020, 77),
(1000, 501, 2018, 89),
(1000, 501, 2019, 83),
(1000, 501, 2020, 90),
(1000, 502, 2018, 78),
(1000, 502, 2019, 90),
(1000, 502, 2020, 81),
(1000, 503, 2018, 80),
(1000, 503, 2019, 75),
(1000, 503, 2020, 86),
(1000, 504, 2018, 76),
(1000, 504, 2019, 88),
(1000, 504, 2020, 79),
(1001, 500, 2018, 87),
(1001, 500, 2019, 78),
(1001, 500, 2020, 77),
(1001, 501, 2018, 85),
(1001, 501, 2019, 86),
(1001, 501, 2020, 75),
(1001, 502, 2018, 78),
(1001, 502, 2019, 73),
(1001, 502, 2020, 77),
(1001, 503, 2018, 73),
(1001, 503, 2019, 86),
(1001, 503, 2020, 69),
(1001, 504, 2018, 88),
(1001, 504, 2019, 83),
(1001, 504, 2020, 83),
(1002, 500, 2018, 96),
(1002, 500, 2019, 86),
(1002, 500, 2020, 82),
(1002, 501, 2018, 89),
(1002, 501, 2019, 90),
(1002, 501, 2020, 82),
(1002, 502, 2018, 89),
(1002, 502, 2019, 92),
(1002, 502, 2020, 93),
(1002, 503, 2018, 90),
(1002, 503, 2019, 85),
(1002, 503, 2020, 96),
(1002, 504, 2018, 79),
(1002, 504, 2019, 84),
(1002, 504, 2020, 84),
(1003, 500, 2018, 51),
(1003, 500, 2019, 57),
(1003, 500, 2020, 64),
(1003, 501, 2018, 48),
(1003, 501, 2019, 48),
(1003, 501, 2020, 56),
(1003, 502, 2018, 53),
(1003, 502, 2019, 61),
(1003, 502, 2020, 62),
(1003, 503, 2018, 49),
(1003, 503, 2019, 59),
(1003, 503, 2020, 55),
(1003, 504, 2018, 53),
(1003, 504, 2019, 64),
(1003, 504, 2020, 53),
(1004, 500, 2018, 60),
(1004, 500, 2019, 46),
(1004, 500, 2020, 56),
(1004, 501, 2018, 60),
(1004, 501, 2019, 46),
(1004, 501, 2020, 51),
(1004, 502, 2018, 58),
(1004, 502, 2019, 41),
(1004, 502, 2020, 46),
(1004, 503, 2018, 52),
(1004, 503, 2019, 55),
(1004, 503, 2020, 57),
(1004, 504, 2018, 56),
(1004, 504, 2019, 55),
(1004, 504, 2020, 60),
(1005, 500, 2018, 96),
(1005, 500, 2019, 85),
(1005, 500, 2020, 93),
(1005, 501, 2018, 95),
(1005, 501, 2019, 90),
(1005, 501, 2020, 91),
(1005, 502, 2018, 91),
(1005, 502, 2019, 97),
(1005, 502, 2020, 97),
(1005, 503, 2018, 90),
(1005, 503, 2019, 91),
(1005, 503, 2020, 89),
(1005, 504, 2018, 99),
(1005, 504, 2019, 91),
(1005, 504, 2020, 97),
(1006, 500, 2018, 60),
(1006, 500, 2019, 72),
(1006, 500, 2020, 62),
(1006, 501, 2018, 59),
(1006, 501, 2019, 61),
(1006, 501, 2020, 56),
(1006, 502, 2018, 58),
(1006, 502, 2019, 74),
(1006, 502, 2020, 56),
(1006, 503, 2018, 72),
(1006, 503, 2019, 68),
(1006, 503, 2020, 73),
(1006, 504, 2018, 63),
(1006, 504, 2019, 72),
(1006, 504, 2020, 68),
(1007, 500, 2018, 94),
(1007, 500, 2019, 89),
(1007, 500, 2020, 99),
(1007, 501, 2018, 95),
(1007, 501, 2019, 85),
(1007, 501, 2020, 83),
(1007, 502, 2018, 84),
(1007, 502, 2019, 89),
(1007, 502, 2020, 90),
(1007, 503, 2018, 97),
(1007, 503, 2019, 88),
(1007, 503, 2020, 94),
(1007, 504, 2018, 89),
(1007, 504, 2019, 92),
(1007, 504, 2020, 99),
(1008, 500, 2018, 63),
(1008, 500, 2019, 61),
(1008, 500, 2020, 54),
(1008, 501, 2018, 51),
(1008, 501, 2019, 47),
(1008, 501, 2020, 47),
(1008, 502, 2018, 60),
(1008, 502, 2019, 54),
(1008, 502, 2020, 63),
(1008, 503, 2018, 54),
(1008, 503, 2019, 59),
(1008, 503, 2020, 48),
(1008, 504, 2018, 64),
(1008, 504, 2019, 62),
(1008, 504, 2020, 62),
(1009, 500, 2018, 51),
(1009, 500, 2019, 53),
(1009, 500, 2020, 55),
(1009, 501, 2018, 68),
(1009, 501, 2019, 52),
(1009, 501, 2020, 51),
(1009, 502, 2018, 68),
(1009, 502, 2019, 53),
(1009, 502, 2020, 57),
(1009, 503, 2018, 63),
(1009, 503, 2019, 56),
(1009, 503, 2020, 69),
(1009, 504, 2018, 67),
(1009, 504, 2019, 69),
(1009, 504, 2020, 61),
(1010, 500, 2018, 88),
(1010, 500, 2019, 99),
(1010, 500, 2020, 95),
(1010, 501, 2018, 90),
(1010, 501, 2019, 90),
(1010, 501, 2020, 94),
(1010, 502, 2018, 94),
(1010, 502, 2019, 92),
(1010, 502, 2020, 96),
(1010, 503, 2018, 90),
(1010, 503, 2019, 95),
(1010, 503, 2020, 98),
(1010, 504, 2018, 90),
(1010, 504, 2019, 89),
(1010, 504, 2020, 88),
(1011, 500, 2018, 93),
(1011, 500, 2019, 87),
(1011, 500, 2020, 89),
(1011, 501, 2018, 98),
(1011, 501, 2019, 95),
(1011, 501, 2020, 89),
(1011, 502, 2018, 96),
(1011, 502, 2019, 86),
(1011, 502, 2020, 94),
(1011, 503, 2018, 91),
(1011, 503, 2019, 94),
(1011, 503, 2020, 98),
(1011, 504, 2018, 90),
(1011, 504, 2019, 91),
(1011, 504, 2020, 86),
(1012, 500, 2018, 68),
(1012, 500, 2019, 62),
(1012, 500, 2020, 54),
(1012, 501, 2018, 59),
(1012, 501, 2019, 69),
(1012, 501, 2020, 55),
(1012, 502, 2018, 53),
(1012, 502, 2019, 53),
(1012, 502, 2020, 67),
(1012, 503, 2018, 60),
(1012, 503, 2019, 59),
(1012, 503, 2020, 54),
(1012, 504, 2018, 66),
(1012, 504, 2019, 52),
(1012, 504, 2020, 64),
(1013, 500, 2018, 90),
(1013, 500, 2019, 95),
(1013, 500, 2020, 91),
(1013, 501, 2018, 89),
(1013, 501, 2019, 97),
(1013, 501, 2020, 88),
(1013, 502, 2018, 95),
(1013, 502, 2019, 87),
(1013, 502, 2020, 90),
(1013, 503, 2018, 92),
(1013, 503, 2019, 91),
(1013, 503, 2020, 91),
(1013, 504, 2018, 88),
(1013, 504, 2019, 97),
(1013, 504, 2020, 98),
(1014, 500, 2018, 96),
(1014, 500, 2019, 83),
(1014, 500, 2020, 96),
(1014, 501, 2018, 91),
(1014, 501, 2019, 95),
(1014, 501, 2020, 91),
(1014, 502, 2018, 94),
(1014, 502, 2019, 96),
(1014, 502, 2020, 93),
(1014, 503, 2018, 87),
(1014, 503, 2019, 98),
(1014, 503, 2020, 86),
(1014, 504, 2018, 98),
(1014, 504, 2019, 91),
(1014, 504, 2020, 88),
(1015, 500, 2018, 63),
(1015, 500, 2019, 50),
(1015, 500, 2020, 45),
(1015, 501, 2018, 48),
(1015, 501, 2019, 62),
(1015, 501, 2020, 46),
(1015, 502, 2018, 53),
(1015, 502, 2019, 62),
(1015, 502, 2020, 59),
(1015, 503, 2018, 59),
(1015, 503, 2019, 45),
(1015, 503, 2020, 47),
(1015, 504, 2018, 44),
(1015, 504, 2019, 47),
(1015, 504, 2020, 45),
(1016, 500, 2018, 72),
(1016, 500, 2019, 76),
(1016, 500, 2020, 68),
(1016, 501, 2018, 72),
(1016, 501, 2019, 85),
(1016, 501, 2020, 67),
(1016, 502, 2018, 77),
(1016, 502, 2019, 73),
(1016, 502, 2020, 76),
(1016, 503, 2018, 82),
(1016, 503, 2019, 70),
(1016, 503, 2020, 67),
(1016, 504, 2018, 66),
(1016, 504, 2019, 69),
(1016, 504, 2020, 72),
(1017, 500, 2019, 80),
(1017, 500, 2020, 88),
(1017, 501, 2018, 86),
(1017, 501, 2019, 87),
(1017, 501, 2020, 75),
(1017, 502, 2018, 75),
(1017, 502, 2019, 76),
(1017, 502, 2020, 87),
(1017, 503, 2018, 91),
(1017, 503, 2019, 90),
(1017, 503, 2020, 82),
(1017, 504, 2018, 91),
(1017, 504, 2019, 77),
(1017, 504, 2020, 89);

-- --------------------------------------------------------

--
-- Table structure for table `university_year`
--

CREATE TABLE `university_year` (
  `university_name` varchar(40) NOT NULL,
  `university_id` int(16) NOT NULL,
  `year` int(11) NOT NULL,
  `num_students` int(16) DEFAULT NULL,
  `student_staff_ratio` int(16) DEFAULT NULL,
  `pct_international_students` int(16) DEFAULT NULL,
  `pct_female_students` int(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `university_year`
--

INSERT INTO `university_year` (`university_name`, `university_id`, `year`, `num_students`, `student_staff_ratio`, `pct_international_students`, `pct_female_students`) VALUES
('', 1000, 2018, 2962, 81, 12, 45),
('', 1000, 2019, 2264, 70, 14, 46),
('', 1000, 2020, 2064, 94, 18, 45),
('', 1001, 2018, 2031, 91, 11, 45),
('', 1001, 2019, 2449, 84, 16, 51),
('', 1001, 2020, 2683, 113, 9, 45),
('', 1002, 2018, 2265, 95, 14, 48),
('', 1002, 2019, 2817, 49, 17, 53),
('', 1002, 2020, 2803, 30, 7, 49),
('', 1003, 2018, 2835, 22, 18, 52),
('', 1003, 2019, 2989, 30, 10, 47),
('', 1003, 2020, 2560, 79, 19, 49),
('', 1004, 2018, 2800, 94, 17, 49),
('', 1004, 2019, 2809, 84, 5, 54),
('', 1004, 2020, 2998, 62, 18, 50),
('', 1005, 2018, 2507, 109, 16, 49),
('', 1005, 2019, 2752, 71, 14, 50),
('', 1005, 2020, 2302, 67, 6, 50),
('', 1006, 2018, 2932, 49, 9, 45),
('', 1006, 2019, 2374, 65, 9, 45),
('', 1006, 2020, 2648, 112, 15, 49),
('', 1007, 2018, 2614, 67, 5, 52),
('', 1007, 2019, 2296, 34, 19, 54),
('', 1007, 2020, 2463, 95, 17, 50),
('', 1008, 2018, 3667, 75, 11, 54),
('', 1008, 2019, 4237, 57, 11, 46),
('', 1008, 2020, 4233, 112, 8, 48),
('', 1009, 2018, 2586, 105, 6, 54),
('', 1009, 2019, 2409, 82, 6, 48),
('', 1009, 2020, 2674, 97, 13, 50),
('', 1010, 2018, 3548, 113, 12, 46),
('', 1010, 2019, 3075, 57, 6, 46),
('', 1010, 2020, 3366, 36, 7, 50),
('', 1011, 2018, 2175, 30, 13, 45),
('', 1011, 2019, 2658, 115, 11, 52),
('', 1011, 2020, 2175, 115, 14, 48),
('', 1012, 2018, 5748, 64, 10, 46),
('', 1012, 2019, 5874, 51, 14, 47),
('', 1012, 2020, 5413, 69, 13, 54),
('', 1013, 2018, 2362, 94, 10, 47),
('', 1013, 2019, 2339, 106, 11, 51),
('', 1013, 2020, 2319, 62, 15, 48),
('', 1014, 2018, 1726, 107, 16, 50),
('', 1014, 2019, 1132, 68, 19, 51),
('', 1014, 2020, 1491, 81, 15, 47),
('', 1015, 2018, 2030, 55, 17, 50),
('', 1015, 2019, 2569, 83, 5, 52),
('', 1015, 2020, 2068, 89, 7, 54),
('', 1016, 2018, 1024, 51, 8, 47),
('', 1016, 2019, 1986, 20, 19, 47),
('', 1016, 2020, 1691, 105, 12, 48),
('', 1017, 2018, 9164, 25, 17, 50),
('', 1017, 2019, 9052, 72, 12, 46),
('', 1017, 2020, 9648, 73, 9, 46);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ranking_system_id` (`ranking_system_id`);

--
-- Indexes for table `ranking_system`
--
ALTER TABLE `ranking_system`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `university_ranking_year`
--
ALTER TABLE `university_ranking_year`
  ADD KEY `university_id` (`university_id`),
  ADD KEY `ranking_criteria_id` (`ranking_criteria_id`);

--
-- Indexes for table `university_year`
--
ALTER TABLE `university_year`
  ADD KEY `university_id` (`university_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=505;

--
-- AUTO_INCREMENT for table `ranking_system`
--
ALTER TABLE `ranking_system`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `university`
--
ALTER TABLE `university`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  ADD CONSTRAINT `ranking_criteria_ibfk_1` FOREIGN KEY (`ranking_system_id`) REFERENCES `ranking_system` (`id`);

--
-- Constraints for table `university`
--
ALTER TABLE `university`
  ADD CONSTRAINT `university_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);

--
-- Constraints for table `university_ranking_year`
--
ALTER TABLE `university_ranking_year`
  ADD CONSTRAINT `university_ranking_year_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`),
  ADD CONSTRAINT `university_ranking_year_ibfk_2` FOREIGN KEY (`ranking_criteria_id`) REFERENCES `ranking_criteria` (`id`);

--
-- Constraints for table `university_year`
--
ALTER TABLE `university_year`
  ADD CONSTRAINT `university_year_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
