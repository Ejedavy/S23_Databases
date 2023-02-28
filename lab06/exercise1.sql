CREATE TABLE Orders (
  id int,
  customerID int,
  date timestamp,
  primary key (id)
);

CREATE TABLE Item(
  id int,
  itemName varchar not null,
  price int,
  primary key (id)
);


CREATE TABLE Customer(
  id int,
  name varchar not null,
  city varchar not null,
  primary key (id)
);


CREATE TABLE Record (
  orderID int,
  itemID int,
  quantity int,
  foreign key (orderID) references Orders (id),
  foreign key (itemID) references Item(id), 
  primary key (orderID, itemID)
);






