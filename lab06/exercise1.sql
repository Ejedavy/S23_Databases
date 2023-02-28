CREATE TABLE ITEM(
	itemId INT,
	itemName varchar(30),
	price INT,
	primary key (itemId)
);

Create table customer(
	customerId INT,
	customerName varchar(30),
	city varchar(15),
	primary key (customerId)
);
Create table orders(
	orderId INT,
	customerId INT,
	date Timestamp,
	primary key (orderId));

CREATE TABLE RECORD(
	orderId INT,
	itemId INT,
	quantity INT,
	foreign key (orderId) references ORDERs (orderId),
	foreign key (itemId) references ITEM(itemId),
	PRIMARY KEY (orderId, itemId)
);



INSERT INTO item VALUES 
  ('3786', 'Net', 35.00),
  ('4011', 'Racket', 65.00),
  ('9132', 'Pack-3', 4.75),
  ('5794', 'Pack-6', 5.00),
  ('3141', 'Cover', 10.00);

INSERT INTO customer VALUES 
  ('101', 'Martin', 'Prague'),
  ('107', 'Herman', 'Madrid'),
  ('110', 'Pedro', 'Moscow');

INSERT INTO orders VALUES 
  ('2301', '101', '2011-02-23'),
  ('2302', '107', '2011-02-25'),
  ('2303', '110', '2011-02-27');
  
INSERT INTO record VALUES 
  ('2301', '3786', '3'),
  ('2301', '4011', '6'),
  ('2301', '9132', '8'),
  ('2302', '5794', '4'),
  ('2303', '4011', '2'),
  ('2303', '3141', '2');
  
select record.orderId, SUM(record.quantity * item.price) as total_amount from record JOIN item ON record.itemId = item.itemId group by record.orderId order by total_amount LIMIT 1;

select orders.customerId, Sum(record.quantity) as quantity from record join orders on record.orderId = orders.orderId group by orders.customerId order by quantity DESC LIMIT 1;