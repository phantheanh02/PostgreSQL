--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Name: store; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA store;


ALTER SCHEMA store OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer" (
    "Customerid" character(6) NOT NULL,
    "LastName" character varying(40),
    "FirstName" character varying(40),
    "Address" character varying(40),
    "City" character varying(40),
    "State" character(2),
    "Zip" character(5),
    "Phone" character varying(10)
);


ALTER TABLE public."Customer" OWNER TO postgres;

--
-- Name: Customer; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE store."Customer" (
    "Customerid" character(6) NOT NULL,
    "LastName" character varying(40),
    "FirstName" character varying(40),
    "Address" character varying(40),
    "City" character varying(40),
    "State" character(2),
    "Zip" character(5),
    "Phone" character varying(10)
);


ALTER TABLE store."Customer" OWNER TO postgres;

--
-- Name: Order; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE store."Order" (
    "ProductID" character(10) NOT NULL,
    "OrderID" character(10) NOT NULL,
    "CustomerID" character(10),
    "PurChaseDate" date,
    "Quantity" integer,
    "TotalCost" money
);


ALTER TABLE store."Order" OWNER TO postgres;

--
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
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customer" ("Customerid", "LastName", "FirstName", "Address", "City", "State", "Zip", "Phone") FROM stdin;
Kh1   	A	B	VN	HN	HN	10000	123456
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: store; Owner: postgres
--

COPY store."Customer" ("Customerid", "LastName", "FirstName", "Address", "City", "State", "Zip", "Phone") FROM stdin;
BLU003	AAAA	Kaite	342 Pine	Hammond	IN	46200	131-4534
BLU005	Bbbbbb	Rich	123 Main St.	Chicago	IL	60633	555-4445
WIL001	Williams	Frank	456 Oak st.	Hammond	IN	46102	\N
BLU001	Hello	Jessica	229 State	Whiting\n	IN	46300	555-5555
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: store; Owner: postgres
--

COPY store."Order" ("ProductID", "OrderID", "CustomerID", "PurChaseDate", "Quantity", "TotalCost") FROM stdin;
LAP002    	ODR002    	BLU003    	2012-02-03	2	$2.00
LAP001    	ODR001    	BLU001    	2012-08-21	1	$1.30
LAP003    	ODR003\n   	WIL001    	2012-06-06	1	$1.30
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: store; Owner: postgres
--

COPY store."Product" ("ProductID", "ProductName", "Model", "Manufacturer", "UnitPrice", "Inventory") FROM stdin;
LAP001	Vaio CR31Z\n	CR	Sony Vaio	$1.30	5
LAP002	HP AZE	HP	\N	$1.00	18
LAP003	HP 34	HP	HP	$10.00	200
\.


--
-- Name: Customer pk2_customer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT pk2_customer PRIMARY KEY ("Customerid");


--
-- Name: Order Order_key; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT "Order_key" PRIMARY KEY ("OrderID");


--
-- Name: Product Product_key; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Product"
    ADD CONSTRAINT "Product_key" PRIMARY KEY ("ProductID");


--
-- Name: Customer pk_customer; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Customer"
    ADD CONSTRAINT pk_customer PRIMARY KEY ("Customerid");


--
-- Name: Order fk_order_2customer; Type: FK CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT fk_order_2customer FOREIGN KEY ("CustomerID") REFERENCES store."Customer"("Customerid") NOT VALID;


--
-- Name: SCHEMA store; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA store TO salesman;
GRANT ALL ON SCHEMA store TO accountant;


--
-- Name: TABLE "Customer"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Customer" TO salesman;


--
-- Name: TABLE "Customer"; Type: ACL; Schema: store; Owner: postgres
--

GRANT INSERT,DELETE,UPDATE ON TABLE store."Customer" TO salesman;
GRANT SELECT ON TABLE store."Customer" TO salesman WITH GRANT OPTION;
GRANT SELECT ON TABLE store."Customer" TO accountant WITH GRANT OPTION;


--
-- Name: TABLE "Order"; Type: ACL; Schema: store; Owner: postgres
--

GRANT INSERT,DELETE,UPDATE ON TABLE store."Order" TO salesman;
GRANT SELECT ON TABLE store."Order" TO salesman WITH GRANT OPTION;
GRANT INSERT,DELETE,UPDATE ON TABLE store."Order" TO accountant;
GRANT SELECT ON TABLE store."Order" TO accountant WITH GRANT OPTION;


--
-- Name: TABLE "Product"; Type: ACL; Schema: store; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE store."Product" TO accountant;
GRANT SELECT ON TABLE store."Product" TO salesman WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

