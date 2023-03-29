CREATE TABLE Accounts (
	id INT UNIQUE PRIMARY KEY, 
	name VARCHAR(50),
	credit INTEGER, 
	currency VARCHAR(10)
);

INSERT INTO Accounts (id, name, credit, currency) VALUES 
	(1, 'Wilson', 1000, 'RUB'), 
	(2, 'Ivan', 1000, 'RUB'),
	(3, 'Mike', 1000, 'RUB')
;

BEGIN;
	-- T1
	UPDATE Accounts SET credit = credit - 500 WHERE id = 1;
	UPDATE Accounts SET credit = credit + 500 WHERE id = 3;
	
BEGIN;
	-- T2
	UPDATE Accounts SET credit = credit - 700 WHERE id = 2;
	UPDATE Accounts SET credit = credit + 700 WHERE id = 1;
	
BEGIN;
	-- T3 
	UPDATE Accounts SET credit = credit - 100 WHERE id = 2;
	UPDATE Accounts SET credit = credit + 100 WHERE id = 3;

ROLLBACK; -- to rollback the changes 

COMMIT; -- to commit 

-- credit for accounts 
SELECT credit from accounts
