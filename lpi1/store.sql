-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 04, 2014 at 03:30 PM
-- Server version: 5.5.37
-- PHP Version: 5.3.10-1ubuntu3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `store`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `first_name`, `last_name`) VALUES
(1, 'jeff', 'jefferson'),
(2, 'stephen', 'johnson'),
(3, 'muhammed', 'thor'),
(4, 'jessica', 'simpson'),
(5, 'britney', 'alexa'),
(6, 'alexandra', 'alpha');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `date`) VALUES
(1, 1, '2014-06-04'),
(2, 2, '2014-06-02'),
(3, 3, '2014-06-28'),
(4, 4, '2014-02-15'),
(5, 5, '2014-06-17'),
(6, 6, '2015-04-03'),
(9, 1, '2014-10-15'),
(10, 2, '2014-06-01'),
(11, 3, '2014-06-09'),
(12, 3, '2014-01-04'),
(13, 5, '2014-06-09'),
(14, 5, '2014-06-20'),
(15, 5, '2014-06-04'),
(16, 5, '2014-06-04');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `type`, `price`) VALUES
(12345, 'My Greatest Hits', 'CD', 20),
(12346, 'Ninja Turtle', 'Toy', 29),
(12347, 'Couch', 'Furniture', 299),
(12348, 'Your Greatest Hits', 'Music CD', 9),
(12349, 'My Little Pony', 'Toy', 39),
(12350, 'Coffee Table', 'Toy', 399);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
