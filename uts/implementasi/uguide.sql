-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2019 at 11:34 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- SET AUTOCOMMIT = 0;
-- START TRANSACTION;
-- SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uguide`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE database uguide;

CREATE TABLE uguide.activity (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `sender_type` tinyint(1) NOT NULL,
  `title` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE uguide.feedback (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `tourist_id` int(11) NOT NULL,
  `guide_id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `rating` tinyint(1) NOT NULL,
  `comment` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE uguide.interest (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `guide_id` int(11) NOT NULL,
  `tourist_id` int(11) NOT NULL,
  `budget` int(11) NOT NULL,
  `plan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE uguide.service (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE uguide.transaction (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `date_paid` date DEFAULT NULL,
  `date_expired` date NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `proof` mediumblob,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `trip`
--

CREATE TABLE uguide.trip (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `guide_id` int(11) DEFAULT NULL,
  `tourist_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(256) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `date` date NOT NULL,
  `min_budget` int(11) NOT NULL,
  `max_budget` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `person` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE uguide.user (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_type` varchar(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` char(60) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `location` varchar(50) NOT NULL,
  `gender` char(1) NOT NULL,
  `rating` float DEFAULT '0',
  `picture` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `user`
--
--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity`
--
ALTER TABLE uguide.activity
  ADD KEY `fk_activitytrip` (`trip_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE uguide.feedback
  ADD KEY `fk_feedguide` (`guide_id`),
  ADD KEY `fk_feedtrip` (`trip_id`),
  ADD KEY `fk_feedtourist` (`tourist_id`) USING BTREE;

--
-- Indexes for table `interest`
--
ALTER TABLE uguide.interest
  ADD KEY `fk_intertrip` (`trip_id`),
  ADD KEY `fk_interguide` (`guide_id`),
  ADD KEY `fk_intertour` (`tourist_id`);

--
-- Indexes for table `service`
--
ALTER TABLE uguide.service
  ADD KEY `fk_servicetrip` (`trip_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE uguide.transaction
  ADD KEY `fk_transtrip` (`trip_id`);

--
-- Indexes for table `trip`
--
ALTER TABLE uguide.trip
  ADD KEY `fk_tripguide` (`guide_id`),
  ADD KEY `fk_triptourist` (`tourist_id`);

--
-- Indexes for table `user`
--
ALTER TABLE uguide.user
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity`
--
-- ALTER TABLE uguide.activity
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `feedback`
--
-- ALTER TABLE uguide.feedback
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `interest`
--
-- ALTER TABLE uguide.interest
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `service`
--
-- ALTER TABLE uguide.service
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `transaction`
--
-- ALTER TABLE uguide.transaction
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `trip`
--
-- ALTER TABLE uguide.trip
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user`
--
-- ALTER TABLE uguide.user
--   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity`
--
ALTER TABLE uguide.activity
  ADD CONSTRAINT `fk_activitytrip` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE uguide.feedback
  ADD CONSTRAINT `fk_feedguide` FOREIGN KEY (`guide_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_feedtrip` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`),
  ADD CONSTRAINT `fk_feeduser` FOREIGN KEY (`tourist_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `interest`
--
ALTER TABLE uguide.interest
  ADD CONSTRAINT `fk_interguide` FOREIGN KEY (`guide_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_intertour` FOREIGN KEY (`tourist_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_intertrip` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`);

--
-- Constraints for table `service`
--
ALTER TABLE uguide.service
  ADD CONSTRAINT `fk_servicetrip` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE uguide.transaction
  ADD CONSTRAINT `fk_transtrip` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`);

--
-- Constraints for table `trip`
--
ALTER TABLE uguide.trip
  ADD CONSTRAINT `fk_tripguide` FOREIGN KEY (`guide_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_triptourist` FOREIGN KEY (`tourist_id`) REFERENCES `user` (`id`);


INSERT INTO uguide.user (`user_type`, `username`, `password`, `email`, `fname`, `lname`, `phone`, `location`, `gender`, `rating`, `picture`) VALUES ('tourist', 'tourist', '$2y$15$trLXAfn0xL2U1oDjzInj6OvcUhkjgltwknmwfCY7km1HdbHDX3lIK', 'tourist@gmail.com', 'tourist', 'kulguy', '085738526026', 'Aceh', 'M', '0', 'dfsasdf');
INSERT INTO uguide.user (`user_type`, `username`, `password`, `email`, `fname`, `lname`, `phone`, `location`, `gender`, `rating`, `picture`) VALUES ('guide', 'guide', '$2y$15$trLXAfn0xL2U1oDjzInj6OvcUhkjgltwknmwfCY7km1HdbHDX3lIK', 'guide@gmail.com', 'guide', 'kulguy', '085738526027', 'Bali', 'M', '0', 'dfsasdf');
INSERT INTO uguide.user (`user_type`, `username`, `password`, `email`, `fname`, `lname`, `phone`, `location`, `gender`, `rating`, `picture`) VALUES ('moderator', 'moderator', '$2y$15$trLXAfn0xL2U1oDjzInj6OvcUhkjgltwknmwfCY7km1HdbHDX3lIK', 'moderator@gmail.com', 'moderator', 'kulguy', '085738526028', 'Bali', 'M', '0', 'dfsasdf');
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
