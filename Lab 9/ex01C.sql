-- Ledger table
CREATE TABLE Ledger (
	ID SERIAL PRIMARY KEY, 
	fromId INT, 
	toId INT, 
	Fee INT, 
	Amount INT, 
	TransactionDateTime timestamp
);

-- Modified transaction part A 
BEGIN;
	-- T1
	UPDATE Accounts SET credit = credit - 500 WHERE id = 1;
	UPDATE Accounts SET credit = credit + 500 WHERE id = 3;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(1, 3, 0, 500, CURRENT_TIMESTAMP);

BEGIN;
	-- T2
	UPDATE Accounts SET credit = credit - 700 WHERE id = 2;
	UPDATE Accounts SET credit = credit + 700 WHERE id = 1;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(2, 1, 0, 700, CURRENT_TIMESTAMP);

BEGIN;
	-- T3 
	UPDATE Accounts SET credit = credit - 100 WHERE id = 2;
	UPDATE Accounts SET credit = credit + 100 WHERE id = 3;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(2, 3, 0, 100, CURRENT_TIMESTAMP);
					
ROLLBACK; -- to rollback the changes 

COMMIT; -- to commit 

-- Modified transaction part B
BEGIN;
	-- T1
	UPDATE Accounts SET credit = credit - 500 - internal_fee(1, 3) WHERE id = 1;
	UPDATE Accounts SET credit = credit + 500 WHERE id = 3;
	UPDATE Accounts SET credit = credit + internal_fee(1, 3) WHERE id = 4;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(1, 3, internal_fee(1, 3), 500, CURRENT_TIMESTAMP);

BEGIN;
	-- T2 
	UPDATE Accounts SET credit = credit - 700 - internal_fee(2, 1) WHERE id = 2;
	UPDATE Accounts SET credit = credit + 700 WHERE id = 1;
	UPDATE Accounts SET credit = credit + internal_fee(2, 1) WHERE id = 4;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(2, 1, internal_fee(2, 1), 700, CURRENT_TIMESTAMP);

BEGIN;
	-- T3 
	UPDATE Accounts SET credit = credit - 100 - internal_fee(2, 3) WHERE id = 2;
	UPDATE Accounts SET credit = credit + 100 WHERE id = 3;
	UPDATE Accounts SEt credit = credit + internal_fee(2, 3) WHERE id = 4;
	INSERT INTO Ledger (fromId, toId, fee, amount, TransactionDateTime) VALUES 
	 					(2, 3, internal_fee(2, 3), 100, CURRENT_TIMESTAMP);
					
ROLLBACK; -- rollback transaction

COMMIT; 
