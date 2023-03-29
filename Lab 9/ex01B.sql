-- bankname field 
ALTER TABLE Accounts ADD COLUMN BankName VARCHAR(30)

-- bank names
UPDATE Accounts SET BankName = 'SberBank' WHERE id = 1 OR id = 3
UPDATE Accounts Set BankName = 'Tinkoff' WHERE id = 2

-- internal fee amount 
CREATE OR REPLACE FUNCTION internal_fee(from_id INT, to_id INT)
RETURNS NUMERIC AS $$
DECLARE
    from_val TEXT;
    to_val TEXT;
BEGIN
    SELECT bankname INTO from_val FROM accounts WHERE id = from_id;
    SELECT bankname INTO to_val FROM accounts WHERE id = to_id;
    IF from_val = to_val THEN
        RETURN 0;
    ELSE
        RETURN 30;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- fees record 
INSERT INTO Accounts (id, name, credit, currency) VALUES 
	(4, 'Fees', 0, 'RUB')
;

-- transactions 
BEGIN;
    -- T1
    UPDATE Accounts SET credit = credit - 500 - internal_fee(1, 3) WHERE id = 1;
    UPDATE Accounts SET credit = credit + 500 WHERE id = 3;
    UPDATE Accounts SET credit = credit + internal_fee(1, 3) WHERE id = 4;

BEGIN;
    -- T2 
    UPDATE Accounts SET credit = credit - 700 - internal_fee(2, 1) WHERE id = 2;
    UPDATE Accounts SET credit = credit + 700 WHERE id = 1;
    UPDATE Accounts SET credit = credit + internal_fee(2, 1) WHERE id = 4;

BEGIN;
    -- T3 
    UPDATE Accounts SET credit = credit - 100 - internal_fee(2, 3) WHERE id = 2;
    UPDATE Accounts SET credit = credit + 100 WHERE id = 3;
    UPDATE Accounts SEt credit = credit + internal_fee(2, 3) WHERE id = 4;

ROLLBACK; -- rollback transaction

COMMIT; 

-- account credits
SELECT credit from Accounts
