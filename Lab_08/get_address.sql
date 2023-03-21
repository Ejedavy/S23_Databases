CREATE OR REPLACE FUNCTION get_addresses()
RETURNS setof address AS $$
BEGIN 
  RETURN QUERY SELECT * FROM address
  WHERE city_id >= 400 AND city_id <= 600 AND address ILIKE '%11%';
END;
$$ LANGUAGE plpgsql;