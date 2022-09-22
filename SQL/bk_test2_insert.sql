--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2022-04-13 11:09:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 25615)
-- Name: store; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA store;


ALTER SCHEMA store OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 25684)
-- Name: extended_sales(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.extended_sales(p_itemno character) RETURNS TABLE(quantity integer, total money)
    LANGUAGE plpgsql IMMUTABLE STRICT SECURITY DEFINER
    AS $$
BEGIN 
	RETURN QUERY SELECT s."Quantity", s."TotalCost" 
				FROM store."Order" AS s 
				WHERE s."ProductID" = p_itemno; 
END; 
$$;


ALTER FUNCTION public.extended_sales(p_itemno character) OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 25616)
-- Name: test(integer, integer); Type: FUNCTION; Schema: store; Owner: postgres
--

CREATE FUNCTION store.test(val1 integer, val2 integer, OUT result integer) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$DECLARE vmultiplier int4 := 3;
BEGIN
	result := val1 * vmultiplier + val2;
END; $$;


ALTER FUNCTION store.test(val1 integer, val2 integer, OUT result integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 25617)
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer" (
    "Customerid" character(6) NOT NULL
);


ALTER TABLE public."Customer" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25620)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    productid character(6) NOT NULL,
    name character varying(30)
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25623)
-- Name: Customer; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE store."Customer" (
    "CustomerID" character(6) NOT NULL,
    "LastName" character varying(20),
    "FirstName" character varying(10),
    "Address" character varying(50),
    "City" character varying(20),
    "State" character(2),
    "Zip" character(5),
    "Phone" character varying(15)
);


ALTER TABLE store."Customer" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25626)
-- Name: Order; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE store."Order" (
    "ProductID" character(6) NOT NULL,
    "OrderID" character(6) NOT NULL,
    "CustomerID" character(6) NOT NULL,
    "PurchaseDate" date,
    "Quantity" integer,
    "TotalCost" money
);


ALTER TABLE store."Order" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 25629)
-- Name: Product; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE store."Product" (
    "ProductID" character(6) NOT NULL,
    "ProductName" character varying(40),
    "Model" character varying(10),
    "Manufacturer" character varying(40),
    "UnitPrice" money,
    "Inventory" integer
);


ALTER TABLE store."Product" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25675)
-- Name: customer_order; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.customer_order AS
 SELECT c."FirstName",
    c."LastName",
    p."ProductID",
    p."ProductName",
    o."Quantity"
   FROM store."Customer" c,
    store."Order" o,
    store."Product" p
  WHERE ((c."CustomerID" = o."CustomerID") AND (o."ProductID" = p."ProductID"));


ALTER TABLE public.customer_order OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 25679)
-- Name: sub_customer; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sub_customer AS
 SELECT c."CustomerID",
    c."FirstName",
    c."LastName"
   FROM store."Customer" c
  WHERE ((c."City")::text = 'Hammond'::text);


ALTER TABLE public.sub_customer OWNER TO postgres;

--
-- TOC entry 3019 (class 0 OID 25617)
-- Dependencies: 201
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Customer" VALUES ('1     ');
INSERT INTO public."Customer" VALUES ('2     ');


--
-- TOC entry 3020 (class 0 OID 25620)
-- Dependencies: 202
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES ('1     ', 'laptop 1');
INSERT INTO public."Product" VALUES ('2     ', 'laptop 2');
INSERT INTO public."Product" VALUES ('3     ', 'laptop 3');


--
-- TOC entry 3021 (class 0 OID 25623)
-- Dependencies: 203
-- Data for Name: Customer; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO store."Customer" VALUES ('BLU003', 'Katie', 'AAAA', '342 Pine', 'Hammond', 'IN', '46200', '555-9242');
INSERT INTO store."Customer" VALUES ('BLU001', 'Jessica 222', 'Blum', '229 State', 'Whiting', 'IN', '46300', '555-0921');
INSERT INTO store."Customer" VALUES ('BLU008', 'Blum8', 'Barbara', '879 Oak', 'Gary', 'IN', '46100', '555-4321');
INSERT INTO store."Customer" VALUES ('BLU006', 'Blum6', 'Katie', '342 Pine', 'Hammond', 'IN', '46200', '555-9242');
INSERT INTO store."Customer" VALUES ('BLU007', 'Blum7', 'Jessica', '229 State', 'Whiting', 'IN', '46300', '555-0921');
INSERT INTO store."Customer" VALUES ('WIL001', 'Frank', 'Williams', '456 Oak St.', 'Hammond', 'IN', '46102', NULL);
INSERT INTO store."Customer" VALUES ('AA001 ', 'Nguyen', 'Oanh', NULL, NULL, NULL, NULL, NULL);
INSERT INTO store."Customer" VALUES ('WIL002', 'ds', 's', NULL, NULL, NULL, NULL, NULL);
INSERT INTO store."Customer" VALUES ('VU001 ', 'Vu', 'Phuong', NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 3022 (class 0 OID 25626)
-- Dependencies: 204
-- Data for Name: Order; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO store."Order" VALUES ('LAP002', 'ODR002', 'BLU003', '2012-02-03', 2, '$2.00');
INSERT INTO store."Order" VALUES ('LAP001', 'ORD003', 'WIL001', '2012-06-06', 2, '$1.30');
INSERT INTO store."Order" VALUES ('LAP003', '003   ', 'WIL002', '2022-04-06', 2, NULL);


--
-- TOC entry 3023 (class 0 OID 25629)
-- Dependencies: 205
-- Data for Name: Product; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO store."Product" VALUES ('LAP001', 'Vaio CR31Z', 'CR', 'Sony Vaio', '$1.30', 5);
INSERT INTO store."Product" VALUES ('LAP002', 'HP AZE', 'HP', NULL, '$1.00', 18);
INSERT INTO store."Product" VALUES ('LAP003', 'HP 34', 'HP', 'HP', '$1,000.00', 200);


--
-- TOC entry 2876 (class 2606 OID 25633)
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY ("Customerid");


--
-- TOC entry 2878 (class 2606 OID 25635)
-- Name: Product pk_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT pk_product PRIMARY KEY (productid);


--
-- TOC entry 2880 (class 2606 OID 25753)
-- Name: Customer pk_customer; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Customer"
    ADD CONSTRAINT pk_customer PRIMARY KEY ("CustomerID");


--
-- TOC entry 2882 (class 2606 OID 25777)
-- Name: Order pk_order; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT pk_order PRIMARY KEY ("OrderID");


--
-- TOC entry 2884 (class 2606 OID 25757)
-- Name: Product pk_product; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Product"
    ADD CONSTRAINT pk_product PRIMARY KEY ("ProductID");


--
-- TOC entry 2886 (class 2606 OID 25783)
-- Name: Order fk_order2customer; Type: FK CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT fk_order2customer FOREIGN KEY ("CustomerID") REFERENCES public."Customer"("Customerid") NOT VALID;


--
-- TOC entry 2885 (class 2606 OID 25778)
-- Name: Order fk_order2product; Type: FK CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT fk_order2product FOREIGN KEY ("ProductID") REFERENCES public."Product"(productid) NOT VALID;


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA store; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA store TO sales;
GRANT USAGE ON SCHEMA store TO salesman;
GRANT USAGE ON SCHEMA store TO salesman_new;
GRANT USAGE ON SCHEMA store TO joe;
GRANT USAGE ON SCHEMA store TO salesman0;


--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 208
-- Name: FUNCTION test(val1 integer, val2 integer, OUT result integer); Type: ACL; Schema: store; Owner: postgres
--

GRANT ALL ON FUNCTION store.test(val1 integer, val2 integer, OUT result integer) TO joe;


--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE "Customer"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public."Customer" TO salesman0;


--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE "Customer"; Type: ACL; Schema: store; Owner: postgres
--

GRANT INSERT,DELETE,UPDATE ON TABLE store."Customer" TO salesman;
GRANT SELECT ON TABLE store."Customer" TO salesman WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE store."Customer" TO sales;
SET SESSION AUTHORIZATION salesman;
GRANT SELECT ON TABLE store."Customer" TO oanhnt;
RESET SESSION AUTHORIZATION;
GRANT INSERT,DELETE,UPDATE ON TABLE store."Customer" TO salesman_new;
GRANT SELECT ON TABLE store."Customer" TO salesman_new WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE store."Customer" TO salesman0;


--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE "Order"; Type: ACL; Schema: store; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE store."Order" TO salesman_new;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE store."Order" TO salesman0;


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE "Product"; Type: ACL; Schema: store; Owner: postgres
--

GRANT SELECT ON TABLE store."Product" TO sales;
GRANT SELECT ON TABLE store."Product" TO salesman_new;
GRANT SELECT ON TABLE store."Product" TO salesman0;


-- Completed on 2022-04-13 11:09:15

--
-- PostgreSQL database dump complete
--

