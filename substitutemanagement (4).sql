-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 02, 2025 at 04:19 PM
-- Server version: 8.0.40
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `substitutemanagement`
--

-- --------------------------------------------------------

--
-- Table structure for table `leave`
--

CREATE TABLE `leave` (
  `leaveId` int NOT NULL,
  `absentTeacherId` int NOT NULL,
  `leaveStartDate` date NOT NULL,
  `leaveEndDate` date NOT NULL,
  `leaveReason` varchar(30) NOT NULL,
  `leaveNotes` varchar(200) NOT NULL,
  `leaveStatus` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leave`
--

INSERT INTO `leave` (`leaveId`, `absentTeacherId`, `leaveStartDate`, `leaveEndDate`, `leaveReason`, `leaveNotes`, `leaveStatus`) VALUES
(1044, 107, '2025-03-16', '2025-03-17', 'Special Leave', 'test2', 'Rejected'),
(1045, 100, '2025-03-20', '2025-03-23', 'Medical Leave', 'e', 'Rejected'),
(1047, 100, '2025-03-19', '2025-03-19', 'Medical Leave', '1', 'Rejected'),
(1052, 100, '2025-03-19', '2025-03-19', 'Special Leave', '1', 'Approved'),
(1053, 100, '2025-03-20', '2025-03-20', 'Medical Leave', '4', 'Rejected'),
(1054, 130, '2025-03-19', '2025-03-20', 'Special Leave', 't1', 'Approved'),
(1055, 130, '2025-03-26', '2025-03-27', 'Medical Leave', 't2', 'Rejected'),
(1056, 107, '2025-03-19', '2025-03-20', 'Special Leave', 'm', 'Rejected'),
(1057, 100, '2025-03-17', '2025-03-19', 'Medical Leave', '1', 'Approved'),
(1058, 100, '2025-03-18', '2025-03-18', 'Annual Leave', '', 'Rejected'),
(1059, 100, '2025-03-18', '2025-03-19', 'Medical Leave', '', 'Rejected'),
(1060, 100, '2025-03-17', '2025-03-18', 'Medical Leave', '', 'Rejected'),
(1061, 107, '2025-03-24', '2025-03-24', 'Medical Leave', 'm', 'Approved'),
(1062, 107, '2025-03-25', '2025-03-25', 'Special Leave', 'm', 'Rejected'),
(1065, 100, '2025-04-24', '2025-04-24', 'Special Leave', '', 'Approved'),
(1066, 100, '2025-04-24', '2025-04-27', 'Special Leave', 'r', 'Rejected'),
(1067, 107, '2025-05-19', '2025-05-19', 'Event Leave', 'No need substitution\r\n', 'Pending'),
(1068, 146, '2025-05-19', '2025-05-19', 'Medical Leave', '', 'Approved'),
(1071, 100, '2025-05-28', '2025-05-28', 'Medical Leave', '', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `scheduleId` int NOT NULL,
  `scheduleDay` varchar(9) NOT NULL,
  `schedulePeriod` int NOT NULL,
  `scheduleSubject` varchar(5) DEFAULT NULL,
  `className` varchar(5) DEFAULT NULL,
  `teacherId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`scheduleId`, `scheduleDay`, `schedulePeriod`, `scheduleSubject`, `className`, `teacherId`) VALUES
(100000, 'Sunday', 1, ' ', ' ', 107),
(100001, 'Sunday', 2, 'PK', '6Y/6R', 107),
(100002, 'Sunday', 3, ' ', ' ', 107),
(100003, 'Sunday', 4, ' ', ' ', 107),
(100004, 'Sunday', 5, ' ', ' ', 107),
(100005, 'Sunday', 6, ' ', ' ', 107),
(100006, 'Sunday', 7, ' ', ' ', 107),
(100007, 'Sunday', 8, ' ', ' ', 107),
(100008, 'Sunday', 9, ' ', ' ', 107),
(100009, 'Sunday', 10, ' ', ' ', 107),
(100010, 'Sunday', 11, ' ', ' ', 107),
(100011, 'Monday', 1, 'PK', '6J', 107),
(100012, 'Monday', 2, ' ', ' ', 107),
(100013, 'Monday', 3, ' ', ' ', 107),
(100014, 'Monday', 4, ' ', ' ', 107),
(100015, 'Monday', 5, ' ', ' ', 107),
(100016, 'Monday', 6, ' ', ' ', 107),
(100017, 'Monday', 7, ' ', ' ', 107),
(100018, 'Monday', 8, ' ', ' ', 107),
(100019, 'Monday', 9, ' ', ' ', 107),
(100020, 'Monday', 10, ' ', ' ', 107),
(100021, 'Monday', 11, ' ', ' ', 107),
(100022, 'Tuesday', 1, 'PK', '4Y', 107),
(100023, 'Tuesday', 2, 'PK', '5J', 107),
(100024, 'Tuesday', 3, ' ', ' ', 107),
(100025, 'Tuesday', 4, ' ', ' ', 107),
(100026, 'Tuesday', 5, ' ', ' ', 107),
(100027, 'Tuesday', 6, ' SC', '3G ', 107),
(100028, 'Tuesday', 7, ' SC', '3G ', 107),
(100029, 'Tuesday', 8, ' ', ' ', 107),
(100030, 'Tuesday', 9, ' ', ' ', 107),
(100031, 'Tuesday', 10, ' ', ' ', 107),
(100032, 'Tuesday', 11, ' ', ' ', 107),
(100033, 'Wednesday', 1, 'PK', '4R', 107),
(100034, 'Wednesday', 2, ' ', ' ', 107),
(100035, 'Wednesday', 3, ' SC', ' SG', 107),
(100036, 'Wednesday', 4, ' SC', ' SG', 107),
(100037, 'Wednesday', 5, ' ', ' ', 107),
(100038, 'Wednesday', 6, ' ', ' ', 107),
(100039, 'Wednesday', 7, ' ', ' ', 107),
(100040, 'Wednesday', 8, ' ', ' ', 107),
(100041, 'Wednesday', 9, ' ', ' ', 107),
(100042, 'Wednesday', 10, ' ', ' ', 107),
(100043, 'Wednesday', 11, ' ', ' ', 107),
(100044, 'Thursday', 1, 'PK', '5Y/5R', 107),
(100045, 'Thursday', 2, 'PK', '4J', 107),
(100046, 'Thursday', 3, ' ', ' ', 107),
(100047, 'Thursday', 4, ' ', ' ', 107),
(100048, 'Thursday', 5, ' ', ' ', 107),
(100049, 'Thursday', 6, ' ', ' ', 107),
(100050, 'Thursday', 7, ' ', ' ', 107),
(100051, 'Thursday', 8, ' ', ' ', 107),
(100052, 'Thursday', 9, ' ', ' ', 107),
(100053, 'Thursday', 10, ' ', ' ', 107),
(100054, 'Thursday', 11, ' ', ' ', 107),
(100055, 'Sunday', 1, ' ', ' ', 100),
(100056, 'Sunday', 2, ' ', ' ', 100),
(100057, 'Sunday', 3, ' ', ' ', 100),
(100058, 'Sunday', 4, ' ', ' ', 100),
(100059, 'Sunday', 5, ' ', ' ', 100),
(100060, 'Sunday', 6, NULL, NULL, 100),
(100061, 'Sunday', 7, NULL, NULL, 100),
(100062, 'Sunday', 8, 'MT', '5Y', 100),
(100063, 'Sunday', 9, 'MT', '5Y', 100),
(100064, 'Sunday', 10, ' ', ' ', 100),
(100065, 'Sunday', 11, ' ', ' ', 100),
(100066, 'Monday', 1, ' ', ' ', 100),
(100067, 'Monday', 2, ' ', ' ', 100),
(100068, 'Monday', 3, 'MT', '3Y', 100),
(100069, 'Monday', 4, 'MT', '3Y', 100),
(100070, 'Monday', 5, ' ', ' ', 100),
(100071, 'Monday', 6, ' ', ' ', 100),
(100072, 'Monday', 7, ' ', ' ', 100),
(100073, 'Monday', 8, ' ', ' ', 100),
(100074, 'Monday', 9, 'PJ', '3Y', 100),
(100075, 'Monday', 10, NULL, NULL, 100),
(100076, 'Monday', 11, NULL, NULL, 100),
(100077, 'Tuesday', 1, 'MT', '5Y', 100),
(100078, 'Tuesday', 2, 'MT', '5Y', 100),
(100079, 'Tuesday', 3, ' ', ' ', 100),
(100080, 'Tuesday', 4, ' ', ' ', 100),
(100081, 'Tuesday', 5, ' ', ' ', 100),
(100082, 'Tuesday', 6, 'MT', '3J/3Y', 100),
(100083, 'Tuesday', 7, 'MT', '3J/3Y', 100),
(100084, 'Tuesday', 8, NULL, NULL, 100),
(100085, 'Tuesday', 9, ' ', ' ', 100),
(100086, 'Tuesday', 10, ' ', ' ', 100),
(100087, 'Tuesday', 11, NULL, NULL, 100),
(100088, 'Wednesday', 1, ' ', ' ', 100),
(100089, 'Wednesday', 2, NULL, NULL, 100),
(100090, 'Wednesday', 3, ' ', ' ', 100),
(100091, 'Wednesday', 4, 'PJ', '3Y', 100),
(100092, 'Wednesday', 5, ' ', ' ', 100),
(100093, 'Wednesday', 6, ' ', ' ', 100),
(100094, 'Wednesday', 7, ' ', ' ', 100),
(100095, 'Wednesday', 8, NULL, NULL, 100),
(100096, 'Wednesday', 9, NULL, NULL, 100),
(100097, 'Wednesday', 10, ' ', ' ', 100),
(100098, 'Wednesday', 11, ' ', ' ', 100),
(100099, 'Thursday', 1, NULL, NULL, 100),
(100100, 'Thursday', 2, NULL, NULL, 100),
(100101, 'Thursday', 3, ' ', ' ', 100),
(100102, 'Thursday', 4, ' ', ' ', 100),
(100103, 'Thursday', 5, ' ', ' ', 100),
(100104, 'Thursday', 6, 'MT', '3Y', 100),
(100105, 'Thursday', 7, 'MT', '3Y', 100),
(100106, 'Thursday', 8, 'MT', '5Y', 100),
(100107, 'Thursday', 9, 'MT', '5Y', 100),
(100108, 'Thursday', 10, ' ', ' ', 100),
(100109, 'Thursday', 11, ' ', ' ', 100),
(101292, 'Sunday', 1, NULL, NULL, 148),
(101293, 'Sunday', 2, 'MZ', '2J', 148),
(101294, 'Sunday', 3, NULL, NULL, 148),
(101295, 'Sunday', 4, 'BC', '1G', 148),
(101296, 'Sunday', 5, NULL, NULL, 148),
(101297, 'Sunday', 6, NULL, NULL, 148),
(101298, 'Sunday', 7, NULL, NULL, 148),
(101299, 'Sunday', 8, 'BC', '1G', 148),
(101300, 'Sunday', 9, 'BC', '1G', 148),
(101301, 'Sunday', 10, 'MT', '2J', 148),
(101302, 'Sunday', 11, 'MT', '2J', 148),
(101303, 'Monday', 1, NULL, NULL, 148),
(101304, 'Monday', 2, NULL, NULL, 148),
(101305, 'Monday', 3, NULL, NULL, 148),
(101306, 'Monday', 4, NULL, NULL, 148),
(101307, 'Monday', 5, NULL, NULL, 148),
(101308, 'Monday', 6, 'MT', '2J', 148),
(101309, 'Monday', 7, 'MT', '2J', 148),
(101310, 'Monday', 8, NULL, NULL, 148),
(101311, 'Monday', 9, 'BC', '1G', 148),
(101312, 'Monday', 10, 'BC', '1G', 148),
(101313, 'Monday', 11, 'BC', '1G', 148),
(101314, 'Tuesday', 1, NULL, NULL, 148),
(101315, 'Tuesday', 2, NULL, NULL, 148),
(101316, 'Tuesday', 3, 'SJ', '5R', 148),
(101317, 'Tuesday', 4, 'SJ', '5R', 148),
(101318, 'Tuesday', 5, NULL, NULL, 148),
(101319, 'Tuesday', 6, 'BC', '1G', 148),
(101320, 'Tuesday', 7, 'BC', '1G', 148),
(101321, 'Tuesday', 8, NULL, NULL, 148),
(101322, 'Tuesday', 9, 'SC', '1R', 148),
(101323, 'Tuesday', 10, 'SC', '1R', 148),
(101324, 'Tuesday', 11, NULL, NULL, 148),
(101325, 'Wednesday', 1, NULL, NULL, 148),
(101326, 'Wednesday', 2, NULL, NULL, 148),
(101327, 'Wednesday', 3, NULL, NULL, 148),
(101328, 'Wednesday', 4, NULL, NULL, 148),
(101329, 'Wednesday', 5, NULL, NULL, 148),
(101330, 'Wednesday', 6, 'MT', '2J/2Y', 148),
(101331, 'Wednesday', 7, 'MT', '2J/2Y', 148),
(101332, 'Wednesday', 8, 'BC', '1G', 148),
(101333, 'Wednesday', 9, 'BC', '1G', 148),
(101334, 'Wednesday', 10, NULL, NULL, 148),
(101335, 'Wednesday', 11, NULL, NULL, 148),
(101336, 'Thursday', 1, 'BC', '1G', 148),
(101337, 'Thursday', 2, 'BC', '1G', 148),
(101338, 'Thursday', 3, NULL, NULL, 148),
(101339, 'Thursday', 4, NULL, NULL, 148),
(101340, 'Thursday', 5, NULL, NULL, 148),
(101341, 'Thursday', 6, NULL, NULL, 148),
(101342, 'Thursday', 7, NULL, NULL, 148),
(101343, 'Thursday', 8, 'SC', '1R', 148),
(101344, 'Thursday', 9, 'SC', '1R', 148),
(101345, 'Thursday', 10, 'SC', '1R', 148),
(101346, 'Thursday', 11, 'PK', '1R', 148),
(101347, 'Sunday', 1, NULL, NULL, 146),
(101348, 'Sunday', 2, 'SC', '3R', 146),
(101349, 'Sunday', 3, 'SC', '3R', 146),
(101350, 'Sunday', 4, 'SC', '3R', 146),
(101351, 'Sunday', 5, NULL, NULL, 146),
(101352, 'Sunday', 6, NULL, NULL, 146),
(101353, 'Sunday', 7, NULL, NULL, 146),
(101354, 'Sunday', 8, NULL, NULL, 146),
(101355, 'Sunday', 9, NULL, NULL, 146),
(101356, 'Sunday', 10, NULL, NULL, 146),
(101357, 'Sunday', 11, NULL, NULL, 146),
(101358, 'Monday', 1, NULL, NULL, 146),
(101359, 'Monday', 2, 'RBT', '6J', 146),
(101360, 'Monday', 3, 'RBT', '6J', 146),
(101361, 'Monday', 4, NULL, NULL, 146),
(101362, 'Monday', 5, NULL, NULL, 146),
(101363, 'Monday', 6, 'PM', '3R/3G', 146),
(101364, 'Monday', 7, 'PM', '3R/3G', 146),
(101365, 'Monday', 8, NULL, NULL, 146),
(101366, 'Monday', 9, NULL, NULL, 146),
(101367, 'Monday', 10, NULL, NULL, 146),
(101368, 'Monday', 11, NULL, NULL, 146),
(101369, 'Tuesday', 1, NULL, NULL, 146),
(101370, 'Tuesday', 2, NULL, NULL, 146),
(101371, 'Tuesday', 3, NULL, NULL, 146),
(101372, 'Tuesday', 4, NULL, NULL, 146),
(101373, 'Tuesday', 5, NULL, NULL, 146),
(101374, 'Tuesday', 6, 'SC', '3R', 146),
(101375, 'Tuesday', 7, 'SC', '3R', 146),
(101376, 'Tuesday', 8, NULL, NULL, 146),
(101377, 'Tuesday', 9, NULL, NULL, 146),
(101378, 'Tuesday', 10, NULL, NULL, 146),
(101379, 'Tuesday', 11, NULL, NULL, 146),
(101380, 'Wednesday', 1, NULL, NULL, 146),
(101381, 'Wednesday', 2, NULL, NULL, 146),
(101382, 'Wednesday', 3, NULL, NULL, 146),
(101383, 'Wednesday', 4, NULL, NULL, 146),
(101384, 'Wednesday', 5, NULL, NULL, 146),
(101385, 'Wednesday', 6, NULL, NULL, 146),
(101386, 'Wednesday', 7, NULL, NULL, 146),
(101387, 'Wednesday', 8, 'SC', '6J', 146),
(101388, 'Wednesday', 9, 'SC', '6J', 146),
(101389, 'Wednesday', 10, NULL, NULL, 146),
(101390, 'Wednesday', 11, NULL, NULL, 146),
(101391, 'Thursday', 1, NULL, NULL, 146),
(101392, 'Thursday', 2, NULL, NULL, 146),
(101393, 'Thursday', 3, NULL, NULL, 146),
(101394, 'Thursday', 4, NULL, NULL, 146),
(101395, 'Thursday', 5, NULL, NULL, 146),
(101396, 'Thursday', 6, 'PM', '3R/3G', 146),
(101397, 'Thursday', 7, 'PM', '3R/3G', 146),
(101398, 'Thursday', 8, 'SC', '6J', 146),
(101399, 'Thursday', 9, 'SC', '6J', 146),
(101400, 'Thursday', 10, NULL, NULL, 146),
(101401, 'Thursday', 11, NULL, NULL, 146),
(101402, 'Sunday', 1, NULL, NULL, 147),
(101403, 'Sunday', 2, NULL, NULL, 147),
(101404, 'Sunday', 3, NULL, NULL, 147),
(101405, 'Sunday', 4, NULL, NULL, 147),
(101406, 'Sunday', 5, NULL, NULL, 147),
(101407, 'Sunday', 6, 'MT', '4R', 147),
(101408, 'Sunday', 7, 'MT', '4R', 147),
(101409, 'Sunday', 8, NULL, NULL, 147),
(101410, 'Sunday', 9, NULL, NULL, 147),
(101411, 'Sunday', 10, NULL, NULL, 147),
(101412, 'Sunday', 11, NULL, NULL, 147),
(101413, 'Monday', 1, NULL, NULL, 147),
(101414, 'Monday', 2, NULL, NULL, 147),
(101415, 'Monday', 3, NULL, NULL, 147),
(101416, 'Monday', 4, NULL, NULL, 147),
(101417, 'Monday', 5, NULL, NULL, 147),
(101418, 'Monday', 6, NULL, NULL, 147),
(101419, 'Monday', 7, NULL, NULL, 147),
(101420, 'Monday', 8, NULL, NULL, 147),
(101421, 'Monday', 9, NULL, NULL, 147),
(101422, 'Monday', 10, 'PJ', '3G', 147),
(101423, 'Monday', 11, 'PJ', '2R', 147),
(101424, 'Tuesday', 1, NULL, NULL, 147),
(101425, 'Tuesday', 2, NULL, NULL, 147),
(101426, 'Tuesday', 3, NULL, NULL, 147),
(101427, 'Tuesday', 4, NULL, NULL, 147),
(101428, 'Tuesday', 5, NULL, NULL, 147),
(101429, 'Tuesday', 6, 'SC', '3G', 147),
(101430, 'Tuesday', 7, 'SC', '3G ', 147),
(101431, 'Tuesday', 8, 'SC', '3G', 147),
(101432, 'Tuesday', 9, NULL, NULL, 147),
(101433, 'Tuesday', 10, NULL, NULL, 147),
(101434, 'Tuesday', 11, 'PJ', '3G', 147),
(101435, 'Wednesday', 1, NULL, NULL, 147),
(101436, 'Wednesday', 2, 'PJ', '4R', 147),
(101437, 'Wednesday', 3, 'SC', '3G', 147),
(101438, 'Wednesday', 4, 'SC', '3G', 147),
(101439, 'Wednesday', 5, NULL, NULL, 147),
(101440, 'Wednesday', 6, NULL, NULL, 147),
(101441, 'Wednesday', 7, NULL, NULL, 147),
(101442, 'Wednesday', 8, 'MT', '4R', 147),
(101443, 'Wednesday', 9, 'MT', '4R', 147),
(101444, 'Wednesday', 10, NULL, NULL, 147),
(101445, 'Wednesday', 11, NULL, NULL, 147),
(101446, 'Thursday', 1, 'MT', '4R', 147),
(101447, 'Thursday', 2, 'MT', '4R', 147),
(101448, 'Thursday', 3, NULL, NULL, 147),
(101449, 'Thursday', 4, NULL, NULL, 147),
(101450, 'Thursday', 5, NULL, NULL, 147),
(101451, 'Thursday', 6, NULL, NULL, 147),
(101452, 'Thursday', 7, NULL, NULL, 147),
(101453, 'Thursday', 8, NULL, NULL, 147),
(101454, 'Thursday', 9, NULL, NULL, 147),
(101455, 'Thursday', 10, 'PJ', '2R', 147),
(101456, 'Thursday', 11, 'PJ', '2R', 147),
(101457, 'Sunday', 1, NULL, NULL, 149),
(101458, 'Sunday', 2, 'BM', '1G', 149),
(101459, 'Sunday', 3, 'BM', '1G', 149),
(101460, 'Sunday', 4, NULL, NULL, 149),
(101461, 'Sunday', 5, NULL, NULL, 149),
(101462, 'Sunday', 6, NULL, NULL, 149),
(101463, 'Sunday', 7, NULL, NULL, 149),
(101464, 'Sunday', 8, 'BC', '1J', 149),
(101465, 'Sunday', 9, 'BC', '1J', 149),
(101466, 'Sunday', 10, NULL, NULL, 149),
(101467, 'Sunday', 11, NULL, NULL, 149),
(101468, 'Monday', 1, 'BM', '1R/1G', 149),
(101469, 'Monday', 2, 'BM', '1R/1G', 149),
(101470, 'Monday', 3, 'BC', '1J', 149),
(101471, 'Monday', 4, 'BC', '1J', 149),
(101472, 'Monday', 5, NULL, NULL, 149),
(101473, 'Monday', 6, NULL, NULL, 149),
(101474, 'Monday', 7, NULL, NULL, 149),
(101475, 'Monday', 8, 'RBT', '4Y', 149),
(101476, 'Monday', 9, 'RBT', '4Y', 149),
(101477, 'Monday', 10, NULL, NULL, 149),
(101478, 'Monday', 11, 'BC', '1J', 149),
(101479, 'Tuesday', 1, 'BC', '1J', 149),
(101480, 'Tuesday', 2, 'BC', '1J', 149),
(101481, 'Tuesday', 3, NULL, NULL, 149),
(101482, 'Tuesday', 4, NULL, NULL, 149),
(101483, 'Tuesday', 5, NULL, NULL, 149),
(101484, 'Tuesday', 6, NULL, NULL, 149),
(101485, 'Tuesday', 7, NULL, NULL, 149),
(101486, 'Tuesday', 8, 'BM', '1G', 149),
(101487, 'Tuesday', 9, 'BM', '1G', 149),
(101488, 'Tuesday', 10, 'RBT', '6R', 149),
(101489, 'Tuesday', 11, 'RBT', '6R', 149),
(101490, 'Wednesday', 1, 'BC', '1J', 149),
(101491, 'Wednesday', 2, 'BC', '1J', 149),
(101492, 'Wednesday', 3, 'BC', '1J', 149),
(101493, 'Wednesday', 4, 'BC', '1J', 149),
(101494, 'Wednesday', 5, NULL, NULL, 149),
(101495, 'Wednesday', 6, NULL, NULL, 149),
(101496, 'Wednesday', 7, NULL, NULL, 149),
(101497, 'Wednesday', 8, NULL, NULL, 149),
(101498, 'Wednesday', 9, NULL, NULL, 149),
(101499, 'Wednesday', 10, 'BM', '1J/Y', 149),
(101500, 'Wednesday', 11, 'BM', '1J/1Y', 149),
(101501, 'Thursday', 1, NULL, NULL, 149),
(101502, 'Thursday', 2, NULL, NULL, 149),
(101503, 'Thursday', 3, NULL, NULL, 149),
(101504, 'Thursday', 4, NULL, NULL, 149),
(101505, 'Thursday', 5, NULL, NULL, 149),
(101506, 'Thursday', 6, 'BM', '1J/1Y', 149),
(101507, 'Thursday', 7, 'BM', '1J/1Y', 149),
(101508, 'Thursday', 8, 'BC', '1J', 149),
(101509, 'Thursday', 9, 'BC', '1J', 149),
(101510, 'Thursday', 10, NULL, NULL, 149),
(101511, 'Thursday', 11, NULL, NULL, 149);

-- --------------------------------------------------------

--
-- Table structure for table `substitution`
--

CREATE TABLE `substitution` (
  `substitutionId` int NOT NULL,
  `substitutionDate` date NOT NULL,
  `leaveId` int DEFAULT NULL,
  `substitutionRequestId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `substitution`
--

INSERT INTO `substitution` (`substitutionId`, `substitutionDate`, `leaveId`, `substitutionRequestId`) VALUES
(10069, '2025-03-16', NULL, 50029),
(10070, '2025-03-16', 1044, NULL),
(10071, '2025-03-17', 1044, NULL),
(10073, '2025-03-21', 1045, NULL),
(10074, '2025-03-22', 1045, NULL),
(10075, '2025-03-23', 1045, NULL),
(10076, '2025-03-18', NULL, 50031),
(10078, '2025-03-19', NULL, 50033),
(10080, '2025-03-19', 1047, NULL),
(10086, '2025-03-25', NULL, 50036),
(10099, '2025-03-19', 1056, NULL),
(10100, '2025-03-20', 1056, NULL),
(10102, '2025-03-18', NULL, 50037),
(10107, '2025-03-19', 1052, NULL),
(10108, '2025-03-19', 1054, NULL),
(10109, '2025-03-20', 1054, NULL),
(10110, '2025-03-24', 1061, NULL),
(10111, '2025-04-15', NULL, 50038),
(10114, '2025-04-17', NULL, 50039),
(10115, '2025-04-24', NULL, 50040),
(10116, '2025-04-24', 1065, NULL),
(10117, '2025-04-24', NULL, 50041),
(10118, '2025-04-28', NULL, 50042),
(10119, '2025-04-29', NULL, 50043),
(10120, '2025-05-19', NULL, 50044),
(10121, '2025-05-19', 1068, NULL),
(10122, '2025-05-18', NULL, 50045),
(10124, '2025-05-28', NULL, 50046),
(10125, '2025-05-28', NULL, 50047),
(10126, '2025-05-28', 1071, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `substitutionassignments`
--

CREATE TABLE `substitutionassignments` (
  `substitutionId` int NOT NULL,
  `scheduleId` int NOT NULL,
  `substituteTeacherId` int DEFAULT NULL,
  `remarks` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'PENDING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `substitutionassignments`
--

INSERT INTO `substitutionassignments` (`substitutionId`, `scheduleId`, `substituteTeacherId`, `remarks`, `status`) VALUES
(10069, 100060, 130, NULL, 'PENDING'),
(10069, 100062, NULL, 'Event', 'PENDING'),
(10070, 100001, 102, 'Cancelled', 'PENDING'),
(10075, 100060, 107, NULL, 'CONFIRMED'),
(10075, 100061, 130, NULL, 'CONFIRMED'),
(10075, 100062, NULL, 'Split Class', 'CONFIRMED'),
(10075, 100063, NULL, 'Split Class', 'CONFIRMED'),
(10078, 100091, NULL, 'Split Class', 'PENDING'),
(10080, 100091, NULL, 'Event', 'PENDING'),
(10080, 100095, NULL, 'Cancelled', 'PENDING'),
(10080, 100096, 130, NULL, 'PENDING'),
(10086, 100077, 130, 'Combine Class', 'CONFIRMED'),
(10086, 100078, 130, NULL, 'CONFIRMED'),
(10086, 100082, NULL, 'Cancelled', 'CONFIRMED'),
(10086, 100083, NULL, 'Split Class', 'CONFIRMED'),
(10086, 100084, NULL, 'Split Class', 'CONFIRMED'),
(10102, 100022, 130, NULL, 'CONFIRMED'),
(10107, 100089, NULL, NULL, 'PENDING'),
(10107, 100091, NULL, NULL, 'PENDING'),
(10107, 100095, NULL, NULL, 'PENDING'),
(10107, 100096, NULL, NULL, 'PENDING'),
(10110, 100011, NULL, NULL, 'PENDING'),
(10111, 100023, 102, 'Combine Class', 'CONFIRMED'),
(10114, 100105, NULL, NULL, 'PENDING'),
(10114, 100106, NULL, NULL, 'PENDING'),
(10115, 100106, NULL, NULL, 'PENDING'),
(10116, 100099, NULL, NULL, 'PENDING'),
(10116, 100100, NULL, NULL, 'PENDING'),
(10116, 100104, NULL, NULL, 'PENDING'),
(10116, 100105, NULL, NULL, 'PENDING'),
(10116, 100106, NULL, NULL, 'PENDING'),
(10116, 100107, NULL, NULL, 'PENDING'),
(10117, 100100, NULL, NULL, 'PENDING'),
(10117, 100104, NULL, NULL, 'PENDING'),
(10118, 100074, NULL, NULL, 'PENDING'),
(10119, 100082, NULL, 'Event', 'CONFIRMED'),
(10119, 100083, 130, NULL, 'CONFIRMED'),
(10119, 100087, 107, NULL, 'CONFIRMED'),
(10120, 101311, NULL, NULL, 'PENDING'),
(10120, 101312, NULL, NULL, 'PENDING'),
(10120, 101313, NULL, NULL, 'PENDING'),
(10121, 101359, NULL, NULL, 'PENDING'),
(10121, 101360, NULL, NULL, 'PENDING'),
(10121, 101363, NULL, NULL, 'PENDING'),
(10121, 101364, NULL, NULL, 'PENDING'),
(10122, 100062, 146, NULL, 'PENDING'),
(10122, 100063, 147, NULL, 'PENDING'),
(10124, 101387, NULL, NULL, 'PENDING'),
(10124, 101388, NULL, NULL, 'PENDING'),
(10125, 101490, NULL, NULL, 'PENDING'),
(10125, 101491, NULL, NULL, 'PENDING'),
(10126, 100091, NULL, NULL, 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `substitutionrequest`
--

CREATE TABLE `substitutionrequest` (
  `substitutionRequestId` int NOT NULL,
  `requestTeacherId` int NOT NULL,
  `substitutionRequestDate` date NOT NULL,
  `substitutionRequestReason` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `substitutionRequestNotes` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `substitutionrequest`
--

INSERT INTO `substitutionrequest` (`substitutionRequestId`, `requestTeacherId`, `substitutionRequestDate`, `substitutionRequestReason`, `substitutionRequestNotes`) VALUES
(50029, 100, '2025-03-16', 'Personal Reason', 'test1'),
(50031, 100, '2025-03-18', 'Medical Appointment', 's'),
(50033, 100, '2025-03-19', 'Event', ''),
(50034, 107, '2025-03-16', 'Event', 'q'),
(50036, 100, '2025-03-25', 'Medical Appointment', ''),
(50037, 107, '2025-03-18', 'Medical Appointment', 'm'),
(50038, 107, '2025-04-15', 'Event', 'no need to arrange for a substitution.'),
(50039, 100, '2025-04-17', 'Event', ''),
(50040, 100, '2025-04-24', 'Medical Appointment', '4'),
(50041, 100, '2025-04-24', 'Medical Appointment', 'r'),
(50042, 100, '2025-04-28', 'Medical Appointment', ''),
(50043, 100, '2025-04-29', 'Medical Appointment', ''),
(50044, 148, '2025-05-19', 'Event', ''),
(50045, 100, '2025-05-18', 'Personal Reason', ''),
(50046, 146, '2025-05-28', 'Event', ''),
(50047, 149, '2025-05-28', 'Medical Appointment', '');

-- --------------------------------------------------------

--
-- Table structure for table `substitutionrequestperiod`
--

CREATE TABLE `substitutionrequestperiod` (
  `substitutionRequestPeriodId` int NOT NULL,
  `substitutionRequestId` int NOT NULL,
  `substitutionRequestPeriod` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `substitutionrequestperiod`
--

INSERT INTO `substitutionrequestperiod` (`substitutionRequestPeriodId`, `substitutionRequestId`, `substitutionRequestPeriod`) VALUES
(70048, 50029, 6),
(70049, 50029, 7),
(70050, 50029, 8),
(70051, 50031, 1),
(70052, 50031, 2),
(70055, 50033, 2),
(70056, 50033, 4),
(70057, 50034, 2),
(70060, 50036, 1),
(70061, 50036, 2),
(70062, 50036, 6),
(70063, 50036, 7),
(70064, 50036, 8),
(70065, 50037, 1),
(70066, 50038, 2),
(70067, 50039, 7),
(70068, 50039, 8),
(70069, 50040, 8),
(70070, 50040, 11),
(70071, 50041, 2),
(70072, 50041, 6),
(70073, 50042, 9),
(70074, 50042, 10),
(70075, 50043, 6),
(70076, 50043, 7),
(70077, 50043, 11),
(70078, 50044, 9),
(70079, 50044, 10),
(70080, 50044, 11),
(70081, 50045, 8),
(70082, 50045, 9),
(70083, 50046, 8),
(70084, 50046, 9),
(70085, 50047, 1),
(70086, 50047, 2);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacherId` int NOT NULL,
  `teacherName` varchar(50) NOT NULL,
  `teacherEmail` varchar(50) NOT NULL,
  `teacherContact` varchar(15) NOT NULL,
  `teacherRole` varchar(30) NOT NULL,
  `telegramId` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacherId`, `teacherName`, `teacherEmail`, `teacherContact`, `teacherRole`, `telegramId`) VALUES
(100, 'Wee Jia Yi', 'angkhexin@gmail.com', '012-0482973', 'Assistant Principal', '1039878250'),
(102, 'Kueh Chin Chen', 'm-1375165@moe-dl.edu.my', '012-0391921', 'Teacher', '6417107498'),
(107, 'Alex Lee', 'alex@gmail.com', '012-9181902', 'Principal', '1039878250'),
(130, 'Sarah Aisyah', 'sarah@gmail.com', '012-91829771', 'Part Time', ''),
(146, 'Tai Yin Bee', 'yinbee@gmail.com', '012-9181902', 'Teacher', ''),
(147, 'Koo Shen Chon', 'shenchon@gmail.com', '012-9188198', 'Teacher', ''),
(148, 'Chong Yin Mei', 'yinmei@gmail.com', '012-9181801', 'Teacher', ''),
(149, 'Eun Hooi Min', 'hooimin@gmail.com', '012-9480918', 'Teacher', '');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(15) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `teacherId` int NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_expiry` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `teacherId`, `token`, `token_expiry`) VALUES
('alexlee', '$2a$10$UPd9./LtyRtukW.W33OaP.qYVxE60GI7Grn/yxOIhu993DAm7Oyai', 107, NULL, NULL),
('hooimin', '$2a$10$YoFErqWBab3QZoFmTo9ruOVU2JfDGks1iMXYopMfFyqglxbX/N5Yy', 149, NULL, NULL),
('jiayi', '$2a$10$Hs64a76a4xIB2Xb9grZKiOmQN7fJ1atLVg4NVsKFqhU5pYswoCbh6', 100, NULL, NULL),
('kuehcc', '$2a$10$MqC8xniy/YlpCwowHWNcwuNPkZdy09hE9w44uJPg5yuxBnIxtToGu', 102, NULL, NULL),
('sarah', '$2a$10$2jGURrz0oAwJs/a.WYUa0eiv65OxcQR6JJmdSr5N7Lv0nq/TD5qV2', 130, NULL, NULL),
('shenzhon', '$2a$10$d0oSWg3caG/8jJpCERUjr.sLVuf7.JxO44Tb..i1KVCLzxvsHvk.u', 147, NULL, NULL),
('yinbee', '$2a$10$JYlrADmK6NxiiK9.x1TD2evxNk0u6KQgrvGo/S.0dqXs8g6SF7peq', 146, NULL, NULL),
('yinmei', '$2a$10$XdhGerrXjHKjgJmksWJLleP9b9eqWbIWa/zXxh/vOEMw1fCL8kUBi', 148, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `leave`
--
ALTER TABLE `leave`
  ADD PRIMARY KEY (`leaveId`),
  ADD KEY `fk_leave_teacher` (`absentTeacherId`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`scheduleId`),
  ADD KEY `fk_schedule_teacher` (`teacherId`);

--
-- Indexes for table `substitution`
--
ALTER TABLE `substitution`
  ADD PRIMARY KEY (`substitutionId`),
  ADD KEY `substitutionRequestId` (`substitutionRequestId`),
  ADD KEY `leaveId` (`leaveId`);

--
-- Indexes for table `substitutionassignments`
--
ALTER TABLE `substitutionassignments`
  ADD PRIMARY KEY (`substitutionId`,`scheduleId`),
  ADD KEY `substituteTeacherId` (`substituteTeacherId`),
  ADD KEY `scheduleId` (`scheduleId`);

--
-- Indexes for table `substitutionrequest`
--
ALTER TABLE `substitutionrequest`
  ADD PRIMARY KEY (`substitutionRequestId`),
  ADD KEY `requestTeacherId` (`requestTeacherId`);

--
-- Indexes for table `substitutionrequestperiod`
--
ALTER TABLE `substitutionrequestperiod`
  ADD PRIMARY KEY (`substitutionRequestPeriodId`),
  ADD KEY `substitutionRequestId` (`substitutionRequestId`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacherId`),
  ADD UNIQUE KEY `teacherEmail` (`teacherEmail`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`),
  ADD KEY `fk_user_teacher` (`teacherId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `leave`
--
ALTER TABLE `leave`
  MODIFY `leaveId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1073;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `scheduleId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101512;

--
-- AUTO_INCREMENT for table `substitution`
--
ALTER TABLE `substitution`
  MODIFY `substitutionId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10127;

--
-- AUTO_INCREMENT for table `substitutionrequest`
--
ALTER TABLE `substitutionrequest`
  MODIFY `substitutionRequestId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50048;

--
-- AUTO_INCREMENT for table `substitutionrequestperiod`
--
ALTER TABLE `substitutionrequestperiod`
  MODIFY `substitutionRequestPeriodId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70087;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacherId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `leave`
--
ALTER TABLE `leave`
  ADD CONSTRAINT `fk_leave_teacher` FOREIGN KEY (`absentTeacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `fk_schedule_teacher` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `substitution`
--
ALTER TABLE `substitution`
  ADD CONSTRAINT `substitution_ibfk_1` FOREIGN KEY (`substitutionRequestId`) REFERENCES `substitutionrequest` (`substitutionRequestId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `substitution_ibfk_2` FOREIGN KEY (`leaveId`) REFERENCES `leave` (`leaveId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `substitutionassignments`
--
ALTER TABLE `substitutionassignments`
  ADD CONSTRAINT `substitutionassignments_ibfk_2` FOREIGN KEY (`scheduleId`) REFERENCES `schedule` (`scheduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `substitutionassignments_ibfk_3` FOREIGN KEY (`substituteTeacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `substitutionassignments_ibfk_4` FOREIGN KEY (`substitutionId`) REFERENCES `substitution` (`substitutionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `substitutionassignments_ibfk_5` FOREIGN KEY (`scheduleId`) REFERENCES `schedule` (`scheduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `substitutionassignments_ibfk_6` FOREIGN KEY (`substitutionId`) REFERENCES `substitution` (`substitutionId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `substitutionrequest`
--
ALTER TABLE `substitutionrequest`
  ADD CONSTRAINT `substitutionrequest_ibfk_1` FOREIGN KEY (`requestTeacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `substitutionrequestperiod`
--
ALTER TABLE `substitutionrequestperiod`
  ADD CONSTRAINT `substitutionrequestperiod_ibfk_1` FOREIGN KEY (`substitutionRequestId`) REFERENCES `substitutionrequest` (`substitutionRequestId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_teacher` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
