# noinspection SqlNoDataSourceInspectionForFile

# Granting privileges for debezium to connect
CREATE USER IF NOT EXISTS'debezium'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'debezium'@'%';
FLUSH PRIVILEGES;

# Creating demo database and granting privileges
CREATE DATABASE IF NOT EXISTS demo;
GRANT ALL PRIVILEGES ON demo.* TO 'debezium'@'%';

USE `demo`;

/*Dropping older files */

DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `customers`;

/*Table structure for table `customers` */


CREATE TABLE `customers` (
  `customerNumber` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int(11) DEFAULT NULL,
  `creditLimit` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customers` */


INSERT INTO `customers` (`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`, `addressLine2`, `city`, `state`, `postalCode`, `country`, `salesRepEmployeeNumber`, `creditLimit`) VALUES
(101, 'John Doe', 'Doe', 'John', '123-456-7890', '123 Main St', '', 'Anytown', 'CA', '12345', 'USA', 1156, 50000.00),
(102, 'Jane Smith', 'Smith', 'Jane', '555-555-5555', '456 High St', '', 'Smallville', 'KS', '67890', 'USA', 1165, 75000.00),
(103, 'Bob Johnson', 'Johnson', 'Bob', '555-123-4567', '789 Broad St', '', 'Big City', 'IL', '54321', 'USA', 1188, 100000.00),
(104, 'Sarah Lee', 'Lee', 'Sarah', '555-867-5309', '321 Oak St', '', 'Little Town', 'GA', '34567', 'USA', 1165, 60000.00),
(105, 'David Brown', 'Brown', 'David', '555-555-1212', '987 Elm St', '', 'Smallville', 'KS', '67890', 'USA', 1165, 90000.00),
(106, 'Mary Johnson', 'Johnson', 'Mary', '555-321-7654', '111 Pine St', '', 'Big City', 'IL', '54321', 'USA', 1188, 120000.00),
(107, 'Tom Smith', 'Smith', 'Tom', '555-555-1234', '222 Oak St', '', 'Little Town', 'GA', '34567', 'USA', 1165, 70000.00),
(108, 'Karen Davis', 'Davis', 'Karen', '555-987-6543', '333 Maple St', '', 'Smallville', 'KS', '67890', 'USA', 1165, 80000.00),
(109, 'Kevin Johnson', 'Johnson', 'Kevin', '555-555-4321', '444 Elm St', '', 'Big City', 'IL', '54321', 'USA', 1188, 110000.00),
(110, 'Melanie Smith', 'Smith', 'Melanie', '555-111-2222', '555 Pine St', '', 'Little Town', 'GA', '34567', 'USA', 1165, 65000.00);


/*Table structure for table `orders`, with ON DELETE CASCADE, when you will delete a Customer, the DB will handle the drop
  of its orders.*/

CREATE TABLE `orders` (
  `orderNumber` int(11) NOT NULL,
  `orderDate` date NOT NULL,
  `requiredDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `customerNumber` int(11) NOT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `orders` */
INSERT INTO `orders` (`orderNumber`, `orderDate`, `requiredDate`, `shippedDate`, `status`, `comments`, `customerNumber`)
VALUES
  (10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', 'Check on availability.', 101),
  (10101, '2003-01-09', '2003-01-18', '2003-01-11', 'Shipped', 'Can we ensure that the packaging is done properly so as not to damage the goods?', 102),
  (10102, '2003-01-10', '2003-01-18', '2003-01-14', 'Shipped', 'Please double-check the shipping address. Thank you!', 103),
  (10103, '2003-01-29', '2003-02-07', '2003-02-02', 'Shipped', 'Order was damaged during shipping. Need replacement.', 104),
  (10104, '2003-01-31', '2003-02-09', '2003-02-01', 'Shipped', 'Thanks for the speedy delivery!', 105),
  (10105, '2003-02-11', '2003-02-19', '2003-02-12', 'Shipped', 'Please include an invoice with the shipment.', 106),
  (10106, '2003-02-17', '2003-02-25', '2003-02-21', 'Shipped', 'We have a deadline to meet, please expedite shipment.', 107),
  (10107, '2003-02-24', '2003-03-04', '2003-02-26', 'Shipped', 'Please ensure that the shipment is properly labelled for customs purposes.', 108),
  (10108, '2003-03-03', '2003-03-11', '2003-03-06', 'Shipped', 'Please mark the package as fragile, thank you!', 109),
  (10109, '2003-03-10', '2003-03-18', '2003-03-14', 'Shipped', 'Please include a gift receipt in the package.', 110);
