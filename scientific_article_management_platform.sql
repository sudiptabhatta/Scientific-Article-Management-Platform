-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2021 at 01:17 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scientific article management platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `ID` int(10) NOT NULL,
  `Cid` int(10) NOT NULL,
  `Uid` int(10) NOT NULL,
  `Title` varchar(200) DEFAULT NULL,
  `Body` varchar(1000) DEFAULT NULL,
  `Image_Path` varchar(200) DEFAULT NULL,
  `Created` datetime DEFAULT NULL,
  `approved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`ID`, `Cid`, `Uid`, `Title`, `Body`, `Image_Path`, `Created`, `approved`) VALUES
(1, 5, 5, 'Social Graph and TAO', ' There is no need for an introduction to Facebook. Facebook has more than 1 billion active users who record their relationships, share their interests, upload and comment on text, images and videos. In this blog, I will mainly discuss two aspects of Facebook’s backend system:\r\nHow the social graph is modeled and stored, that is, the database schema adopted by Facebook.\r\nHow Facebook scaled its infrastructure, including servers, cache and databases, to serve 1 billion reads and millions of writes per second.', 'http://localhost:3000/uploads\\profile_pic-1611702412532.jpeg', '2021-01-27 05:06:52', 0),
(2, 1, 5, 'Entangled winds…', ' Tramontane, greco, levante, sirocco, ostro, libeccio, ponente and maestro: these are some of the names that have been used in the past, and are still used today, to identify the North, Northeast, East, Southeast, South, Southwest, West and Northwest wind directions, respectively. More precisely, I should say ‘wind spatial directions’ as ‘a wind direction’ is of course a direction within our three-dimensional Euclidean space: the theater we all use to stage part of our everyday physical reality.However, a wind direction, as a notion, is not equivalent to that of a space direction. This because space directions are all equivalent for physical entities (this is the well-known isotropy of space), whereas wind directions are usually associated with specific space directions, typically the above mentioned eight directions of the traditional mariner’s compass rose, which resulted from our countless experiences, over the millenaries, as inhabitants of the surface of this beautiful (pale blue ', 'http://localhost:3000/uploads\\profile_pic-1611702926841.jpeg', '2021-01-27 05:15:26', 0),
(3, 5, 5, 'Build a Simple Todo App with React ⚛', ' We will build this app in Codepen, which will provide us a quick way to get the environment setup and view live changes we make to the app as we code it. To begin, head on over to Codepen’s website and select the button on the left panel to create a new pen.\r\nTo make sure we can use React in Codepen, we need to add the proper dependencies to our app. To do this, first select the ‘Settings’ button at the top of the page. Then select the ‘Javascript’ tab. From here you want to set the Javascript preprocessor to ‘Babel’ and add the react and react-dom external scripts. But one more thing before we get into it… It’s always a good idea to have a plan of what you are going to build before you start typing. Especially when building a user interface with React. We want to have some idea of what the interface will look like so we can know what components we need to build and what data each component will be responsible for handling.\r\n', 'http://localhost:3000/uploads\\profile_pic-1611703144263.png', '2021-01-27 05:19:04', 0),
(4, 2, 5, 'How Is My COVID-19 Classified as Mild, Moderate, or Severe?', ' This morning I learned that Larry King died, perhaps due to COVID-19 given that he was hospitalized for disease-related management. The sad reality of the current pandemic is that there are few treatments. We have a great way to prevent infections with vaccines (read my review here addressing what to expect from them, including side effects), but the high mortality of the infection persists.\r\nGiven the breadth of even limited treatment of COVID-19, which is dependent on disease severity, I will be breaking up a review of COVID-19 treatment and classification of COVID-19 into separate articles.\r\nThis article will review the classification of COVID-19 severity, as published by the World Health Organization¹. I located this source using the evidence-based medical database, Dynamed².', 'http://localhost:3000/uploads\\profile_pic-1611703276252.jpeg', '2021-01-27 05:21:16', 0),
(5, 3, 5, 'Announcing Audioshake —An AI to Open up Music for New Uses', ' Today we launch Audioshake, a powerful AI that can take a recording from any point in time and deconstruct it into separated vocal and instrument tracks (often called “stems”).\r\nMusicians today lose out on many opportunities for their music because of missing or lost stems. This happens across the spectrum in the music industry — from damaged or lost master tracks of world-famous artists, to the indie band who recorded on their computer and only passed along the final song (the “mix-down”) to the label.\r\nBut a song is much more than what we hear on the radio. There are the instrumentals we sing along to in karaoke, or that provide the background mood music in commercials, games, and movies. Re-mixes that bring together iconic vocals from different songs. And samples that begin as catchy beats in one song and decades later are imagined and re-imagined again by new artists.\r\nTo make these kinds of uses happen, you need stems — the isolated instruments of a track. As an artist or label, ', 'http://localhost:3000/uploads\\profile_pic-1611703541796.png', '2021-01-27 05:25:41', 0),
(6, 5, 3, 'What exactly is Node.js?', ' Node.js is a JavaScript runtime environment. Sounds great, but what does that mean? How does that work?\r\nThe Node run-time environment includes everything you need to execute a program written in JavaScript.Node.js came into existence when the original developers of JavaScript extended it from something you could only run in the browser to something you could run on your machine as a standalone application.\r\nNow you can do much more with JavaScript than just making websites interactive.\r\nJavaScript now has the capability to do things that other scripting languages like Python can do.\r\nBoth your browser JavaScript and Node.js run on the V8 JavaScript runtime engine. This engine takes your JavaScript code and converts it into a faster machine code. Machine code is low-level code which the computer can run without needing to first interpret it.\r\nWhy Node.js?\r\nHere’s a formal definition as given on the official Node.js website:\r\nNode.js® is a JavaScript runtime built on Chrome’s V8 JavaSc', 'http://localhost:3000/uploads\\profile_pic-1611705782410.jpeg', '2021-01-27 06:03:02', 0),
(7, 2, 3, 'Why Covid-19 Is Worse for Men', ' Dr. Tom Frieden, a former director of the U.S. Centers for Disease Control and Prevention (CDC), published an insightful update on the current state of the pandemic in the U.S. He notes that while it seems the U.S. is over the holiday surge, cases and hospitalizations and deaths are still very high. With the new variants spreading, people need to proceed with caution. ', 'http://localhost:3000/uploads\\profile_pic-1611705936474.png', '2021-01-27 06:05:36', 0),
(8, 3, 3, 'Will Artificial Super-Intelligence Pose a Threat to Humanity’s Existence?', ' On March 15, 2016, world Go champion Lee Sedol walked out of The Four Seasons Hotel arena in Seoul, South Korea, a distraught man. For 18 years, Lee had defended his title against countless opponents from all over the world to earn the rank of “grandmaster.”\r\nThis time around, he wasn’t lucky. In the final game of their historic match, AlphaGo, an AI program developed by Google’s subsidiary DeepMind, defeated Grandmaster Lee Sedol.\r\nThis unexpected win marked a significant moment for artificial intelligence. Over the last twenty-five years, machines have beaten the best humans at checkers, chess, Orthello, etc. But this was the first time it happened with Go.\r\nThe 2500-year-old Chinese board game is more complex for computers since it requires some level of intuition, creativity, and strategic thinking. Programming such human qualities into computers has for a long time been considered one of the biggest challenges in the field of AI.\r\nAlphaGo Program was different though. From a prim', 'http://localhost:3000/uploads\\profile_pic-1611706101783.jpg', '2021-01-27 06:08:21', 0);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `ID` int(10) NOT NULL,
  `Category_Name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`ID`, `Category_Name`) VALUES
(1, 'Physics'),
(2, 'Virus'),
(3, 'AI'),
(4, 'Web Security'),
(5, 'Technology'),
(6, 'Chemistry');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `CommentID` int(10) NOT NULL,
  `Aid` int(10) NOT NULL,
  `Uid` int(10) NOT NULL,
  `Comment` varchar(200) DEFAULT NULL,
  `Created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`CommentID`, `Aid`, `Uid`, `Comment`, `Created`) VALUES
(1, 1, 2, 'Nice Article', '2021-01-16 00:00:00'),
(2, 1, 3, 'hi.', '2021-01-16 00:00:00'),
(3, 1, 0, 'great', '2021-01-17 01:02:30');

-- --------------------------------------------------------

--
-- Table structure for table `followers`
--

CREATE TABLE `followers` (
  `FollowID` int(10) NOT NULL,
  `Uid1` int(10) NOT NULL,
  `Uid2` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `followers`
--

INSERT INTO `followers` (`FollowID`, `Uid1`, `Uid2`) VALUES
(1, 4, 2),
(3, 5, 2),
(44, 3, 5),
(45, 2, 3),
(46, 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `researchers`
--

CREATE TABLE `researchers` (
  `ID` int(10) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(300) NOT NULL,
  `Specialization` varchar(100) DEFAULT NULL,
  `privilege` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `researchers`
--

INSERT INTO `researchers` (`ID`, `Name`, `Email`, `Password`, `Specialization`, `privilege`) VALUES
(1, 'Sudipta Bhatta', 'sudiptabhatta05@gmail.com', '$2a$10$93meYVmuqAnL9PJvEWPjRO6W9IKPgWOrXw/Lzyi2Pb3KKQ/m6R5/6', '1', 1),
(2, 'Tahsin Tawsif', 'tahsintawsif@gmail.com', '$2a$10$93meYVmuqAnL9PJvEWPjRO6W9IKPgWOrXw/Lzyi2Pb3KKQ/m6R5/6', '2', 0),
(3, 'Shuvo Bhatta', 'shuvobhatta@gmail.com', '$2a$10$93meYVmuqAnL9PJvEWPjRO6W9IKPgWOrXw/Lzyi2Pb3KKQ/m6R5/6', '2', 0),
(4, 'Susmita Bhatta', 'susmitabhatta@gmail.com', '$2a$10$93meYVmuqAnL9PJvEWPjRO6W9IKPgWOrXw/Lzyi2Pb3KKQ/m6R5/6', '3', 0),
(5, 'Aishwaria Bhatta', 'aishwariabhatta@yahoo.com', '$2a$10$mENZ7WBWAS0IPmZAx./qNecA6AfIvCDfZSeCTqbgK9LnlFv.mzDL2', '5', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`CommentID`);

--
-- Indexes for table `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`FollowID`);

--
-- Indexes for table `researchers`
--
ALTER TABLE `researchers`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `CommentID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `followers`
--
ALTER TABLE `followers`
  MODIFY `FollowID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `researchers`
--
ALTER TABLE `researchers`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
