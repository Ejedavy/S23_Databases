CREATE OR REPLACE FUNCTION retrievecustomers(startj int, endj int)
RETURNS setof customer AS $$
BEGIN
  IF startj < 0 or startj > 600 or endj < 0 or endj > 600 THEN
  RAISE EXCEPTION 'Start or End out of bounds';
  end if;
  RETURN QUERY SELECT * FROM customer
  WHERE address_id >= startj AND address_id <= endj;
END;
$$ LANGUAGE plpgsql;