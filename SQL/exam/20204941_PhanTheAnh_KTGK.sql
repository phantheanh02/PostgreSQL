-- Họ và tên: Phan Thế Anh
-- MSSV: 20204941

-- Câu 1:  Đưa ra danh sách các khách hàng nữ mà có thu nhập (income) ít nhất là 100000
    SELECT * FROM customers
    WHERE  gender = 'F'AND income >= 100000 ;
    --23	"NPSFGQ"	"NAYJFNKHRQ"	"8606105897 Dell Way"		"LGSIFTG"	"NY"	11455	"US"	1	"NAYJFNKHRQ@dell.com"	"8606105897"	5	"6406863798853011"	"2009/09"	"user23"	"pASswORd"	56	100000	"F"
    --24	"GBNXPN"	"VYTIJBAAMH"	"1759698957 Dell Way"		"SVNMCEM"	"WA"	13905	"US"	1	"VYTIJBAAMH@dell.com"	"1759698957"	2	"7402193841524423"	"2011/02"	"user24"	"pASswORd"	88	100000	"F"
    --68	"RNOIPO"	"XKBWSWASWL"	"2521982461 Dell Way"		"WMAORTL"	"AZ"	29353	"US"	1	"XKBWSWASWL@dell.com"	"2521982461"	4	"9546184672508390"	"2009/12"	"user68"	"pASswORd"	69	100000	"F"
    --71	"MFTJBS"	"IWHWKYZIJM"	"7151078438 Dell Way"		"AQNQNCO"	"VA"	86660	"US"	1	"IWHWKYZIJM@dell.com"	"7151078438"	2	"1909482368268072"	"2009/11"	"user71"	"pASswORd"	66	100000	"F"
    --106	"EKHMVX"	"IYWKAUNLLY"	"5127891259 Dell Way"		"ZGCDXUB"	"NH"	90730	"US"	1	"IYWKAUNLLY@dell.com"	"5127891259"	2	"8246030778624118"	"2011/10"	"user106"	"pASswORd"	67	100000	"F"
    -- số bản ghi: 1963
-- Câu 2: Hãy đưa ra danh sách sản phẩm đã được đặt mua ngày hiện thời.
    SELECT DISTINCT pd.title, pd.actOR 
    FROM products pd
    JOIN orderlines USING(prod_id)
    WHERE orderdate = CURRENT_DATE;
    -- Kết quả rỗng
    -- Số bản ghi: 0
-- Câu 3:
    SELECT DISTINCT c.customerid, concat(c.firstname, ' ', c.lAStname) AS fullname,  count(orderid) AS soluong
    FROM customers c
    LEFT JOIN orders USING(customerid)
    GROUP BY c.customerid
    ORDER BY soluong DESC
    
--19887	"HUCQKX XWLTUMCUNV"	6
--6242	"QBGMPB WAYWCETVVP"	5
--11792	"XZIFQM TEELCTPUJJ"	5
--15483	"HNPCWT IGWTHXHABY"	5
--13774	"VXMNLL AKSFOITYMD"	5
-- Số bản ghi: 20000
-- Câu 4
    SELECT DISTINCT c.customerid, concat(c.firstname, ' ', c.lAStname) AS fullname
    FROM customers c
    LEFT JOIN orders USING(customerid)
    WHERE orders.orderdate < '2004-12-01' 
    OR orders.orderdate > '2004-12-31'
--8836	"LOUCEB QTHSWHIUKS"
--6509	"VSXDTV PELCHKOMZD"
--5536	"DKUABU FIEMDLZZJH"
--17751	"SJXJFC UPEFTNUKHO"
--13723	"INNRIH CCTVBUJBME"
-- Số bản ghi: 8470
-- Câu 5
    SELECT count(DISTINCT c.customerid)
    FROM customers c
    LEFT JOIN orders od USING(customerid)
    WHERE od.orderid IS NULL
-- 11004
-- Số bản ghi: 1
-- Câu 6 
    SELECT avg(income) AS avg_income
    FROM customers c
    JOIN orders od USING(customerid)
    JOIN orderlines USING(orderid)
    JOIN products pd USING(prod_id)
    WHERE pd.title = 'AIRPORT ROBBERS'
--60000.000000000000
-- Số bản ghi: 1
-- Câu 7
    SELECT odl.orderid, odl.orderdate, pd.title
    FROM orderlines odl
    JOIN products pd USING(prod_id)
    WHERE pd.title = 'ADAPTATION SECRETS'
    OR pd.title = 'AFFAIR GENTLEMEN';
--1	"2004-01-27"	"AFFAIR GENTLEMEN"
--1	"2004-01-27"	"ADAPTATION SECRETS"
--267	"2004-01-27"	"AFFAIR GENTLEMEN"
--1467	"2004-02-22"	"AFFAIR GENTLEMEN"
--1753	"2004-02-21"	"AFFAIR GENTLEMEN"
-- Số bản ghi: 19

-- Câu 8
    SELECT pd.prod_id, pd.title, pd.actOR, pd.price, ivt.quan_in_stock
    FROM products pd
    JOIN inventORy ivt USING(prod_id)
    WHERE ivt.quan_in_stock < 5;
--189	"ACADEMY CREATURES"	"JENNIFER BRANDO"	27.99	2
--223	"ACADEMY DESIRE"	"SIDNEY DERN"	28.99	0
--419	"ACADEMY HOCUS"	"SALLY FIELD"	15.99	3
--452	"ACADEMY ILLUSION"	"GROUCHO BAILEY"	10.99	3
--543	"ACADEMY MADIGAN"	"ALBERT BOGART"	17.99	1
-- Số bản ghi: 109
-- Câu 9
SELECT * FROM 
(
    SELECT country, count(customerid) AS soluong 
	FROM customers
    GROUP BY country
) tongkhach
LEFT JOIN 
(
	SELECT country, count(customerid) AS count_orderid 
	FROM customers
	inner JOIN orders USING (customerid)
	GROUP BY country
	HAVING count(customerid) >= 2
) khachmua2lan USING (country)

--"South Africa"	935	590
--"Australia"	1034	639
--"UK"	1002	598
--"Germany"	1004	579
--"Japan"	989	572
-- Só bản ghi:11
-- Câu 10
    SELECT pd.prod_id, pd.title, pd.actOR, pd.price,  pd.special, pd.common_prod_id
    FROM products pd
    JOIN orderlines USING(prod_id)
    JOIN orders USING(orderid)
    JOIN customers od USING(customerid)
    WHERE gender = 'M'
    AND pd.price = 
    (
        SELECT max(price)
        FROM products pd
        JOIN orderlines USING(prod_id)
        JOIN orders USING(orderid)
        JOIN customers od USING(customerid)
        WHERE gender = 'M'
    );

--4955	"AFRICAN WALLS"	"CHRISTIAN HOPPER"	29.99	0	3738
--7498	"AIRPORT KILLER"	"JADA WAHLBERG"	29.99	0	472
--9444	"ALADDIN HUSTLER"	"JESSICA RYDER"	29.99	0	6971
--5767	"AGENT SCALAWAG"	"ADAM PESCI"	29.99	0	3905
--6190	"AIRPLANE CREEPERS"	"MICHAEL NORTON"	29.99	0	2745
-- Số bản ghi: 1468
-- Câu 11
SELECT 
(
	SELECT sum(totalamount)/count(customerid) AS nam
	FROM customers 
	JOIN orders USING(customerid)
	WHERE gender='M'
) ,
(
	SELECT sum(totalamount)/count(customerid) AS nu
	FROM customers 
	JOIN orders USING(customerid)
	WHERE gender='F'
) 
--213.6823938542871303	214.2201546998486632
-- Số bản ghi: 1
-- II. TRIGGER
	CREATE OR REPLACE FUNCTION tf_bf_check() RETURNS TRIGGER AS
	$$ 
	BEGIN
	END;
	$$
	LANGUAGE plpgsql;
	-- create triger
	CREATE TRIGGER bf_check_insert
	BEFORE INSERT OR UPDATE ON orders
	FOR EACH ROW
	when(quan_in_stocknew is not NULL )
	EXCUTE PROCEDURE tf_bf_check();