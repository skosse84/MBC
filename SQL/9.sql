
use mytest;

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11)  DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(11)  DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `property_value` (
  `product_id` int(11) NOT NULL,
  `property_id` int(11)   NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`product_id`, `property_id`),
  UNIQUE KEY `id_UNIQUE` (`product_id`, `property_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

DELETE FROM category;
DELETE FROM product;
DELETE FROM property;
DELETE FROM property_value;

INSERT category(name) VALUES ('Food');
INSERT category(name) VALUES ('Clothing');
INSERT category(name) VALUES ('Cars');

INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Cars'), 'BMW', 999);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Cars'), 'Lada', 100);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Cars'), 'AUDI', 999);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Clothing'), 'Jacket', 15);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Clothing'), 'Dress', 10);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Clothing'), 'Shirt', 25);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Food'), 'Hot-dog', 3);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Food'), 'Salat', 5);
INSERT product(category_id, name, price) VALUES ((SELECT id FROM category WHERE name='Food'), 'Orange', 1);

INSERT property(name) VALUES ('weight');
INSERT property(name) VALUES ('date');
INSERT property(name) VALUES ('series');
INSERT property(name) VALUES ('season');
INSERT property(name) VALUES ('country');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='BMW'), (SELECT id FROM property WHERE name='weight'), 1500);

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='BMW'), (SELECT id FROM property WHERE name='date'), 2002);

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='BMW'), (SELECT id FROM property WHERE name='series'), 3);

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='AUDI'), (SELECT id FROM property WHERE name='weight'), 1400);

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Lada'), (SELECT id FROM property WHERE name='weight'), 1100);

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Hot-dog'), (SELECT id FROM property WHERE name='date'), '2020-11-02');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Salat'), (SELECT id FROM property WHERE name='date'), '2020-10-25');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Orange'), (SELECT id FROM property WHERE name='date'), '2020-10-05');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Orange'), (SELECT id FROM property WHERE name='country'), 'Georgia');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Jacket'), (SELECT id FROM property WHERE name='weight'), '2019-11-02');

INSERT property_value(product_id, property_id, value)
VALUES ((SELECT id FROM product WHERE name='Shirt'), (SELECT id FROM property WHERE name='weight'), '2018-08-08');

SELECT value
FROM property_value
WHERE product_id = (SELECT ID FROM product WHERE name = 'BMW');

SELECT cat.name, pr.name, MAX(prod.name)
FROM category cat
JOIN product prod ON prod.category_id = cat.id
JOIN property_value pr_val ON pr_val.product_id = prod.id
JOIN property pr ON pr_val.property_id = pr.id
GROUP BY cat.name, pr.name
HAVING COUNT(prod.name) = 1
