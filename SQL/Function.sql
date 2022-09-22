CREATE OR REPLACE FUNCTION test(IN val1 int4, IN val2 int4, out result
int4) AS
$$DECLARE vmultiplier int4 := 3;
BEGIN
result := val1 * vmultiplier + val2;
END;
$$
LANGUAGE plpgsql
IMMUTABLE
RETURNS NULL ON NULL INPUT
SECURITY INVOKER ;
select test(null, 1);

CREATE FUNCTION add(integer, integer) RETURNS
integer AS
'select $1 + $2;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;
select add(1,1);

CREATE OR REPLACE FUNCTION increment (i integer)
RETURNS integer AS
$$ BEGIN RETURN i + 1; END; $$
LANGUAGE plpgsql;
select increment(1);

CREATE OR REPLACE FUNCTION dup(in int, out f1 int, out f2 text) AS
$$ SELECT $1, CAST($1 AS text) || ' is number' $$
LANGUAGE SQL;
SELECT * FROM dup(2);

CREATE TYPE  p_result AS (f1 int, f2 text);
CREATE OR REPLACE FUNCTION dup1(int) RETURNS dup_result AS
$$ SELECT $1, CAST($1 AS text) || ' is number' $$
LANGUAGE SQL;
SELECT * FROM dup1(42);



