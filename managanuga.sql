--
-- PostgreSQL database dump
--

\restrict QY9IzXcNal6HsVQyhG90olThvAk4gnK1wBhtnpPJbaZKe6zxRNAZVD9TdraHttM

-- Dumped from database version 18.4 (Homebrew)
-- Dumped by pg_dump version 18.4 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    entity_type character varying(20) NOT NULL,
    entity_id integer NOT NULL,
    address_type character varying(50),
    full_name character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    address_line1 text NOT NULL,
    address_line2 text,
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    postal_code character varying(20) NOT NULL,
    is_default boolean DEFAULT false
);


ALTER TABLE public.addresses OWNER TO apfdcllp;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO apfdcllp;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.cart_items (
    id integer NOT NULL,
    entity_type character varying(20) NOT NULL,
    entity_id integer NOT NULL,
    item_type character varying(20) NOT NULL,
    item_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cart_items OWNER TO apfdcllp;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO apfdcllp;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    item_type character varying(20),
    item_id integer,
    quantity integer,
    unit_price numeric(10,2)
);


ALTER TABLE public.order_items OWNER TO apfdcllp;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO apfdcllp;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    entity_type character varying(20),
    entity_id integer,
    total_amount numeric(10,2),
    status character varying(20) DEFAULT 'PLACED'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO apfdcllp;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO apfdcllp;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    order_id character varying(255) NOT NULL,
    payment_gateway character varying(50) NOT NULL,
    amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    gateway_order_id character varying(255),
    gateway_payment_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payments OWNER TO apfdcllp;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO apfdcllp;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    image text
);


ALTER TABLE public.products OWNER TO apfdcllp;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO apfdcllp;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: apfdcllp
--

CREATE TABLE public.users (
    id integer NOT NULL,
    mobile character varying(15) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO apfdcllp;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: apfdcllp
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO apfdcllp;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apfdcllp
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.addresses (id, entity_type, entity_id, address_type, full_name, phone, address_line1, address_line2, city, state, country, postal_code, is_default) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.cart_items (id, entity_type, entity_id, item_type, item_id, quantity, created_at) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.order_items (id, order_id, item_type, item_id, quantity, unit_price) FROM stdin;
1	1	PRODUCT	4	1	329.00
2	1	PRODUCT	3	1	399.00
3	1	PRODUCT	1	6	299.00
4	1	PRODUCT	2	2	349.00
5	2	PRODUCT	1	1	299.00
6	3	PRODUCT	1	1	299.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.orders (id, entity_type, entity_id, total_amount, status, created_at) FROM stdin;
1	USER	1	3220.00	PLACED	2026-07-13 11:53:18.178131
2	USER	1	299.00	PLACED	2026-07-13 16:04:50.345918
3	USER	1	299.00	PLACED	2026-07-13 16:04:50.390382
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.payments (id, order_id, payment_gateway, amount, status, gateway_order_id, gateway_payment_id, created_at) FROM stdin;
1	TEST123	RAZORPAY	299.00	PENDING	order_T6d47poxDmuVX3	\N	2026-06-27 16:22:07.85518
2	TEST123	RAZORPAY	299.00	PENDING	order_T6d9EZUDzY9UeR	\N	2026-06-27 16:26:58.076175
3	ORDER_1782562370321	RAZORPAY	688.00	PENDING	order_T6eRNxAGRHzj8E	\N	2026-06-27 17:42:50.587663
4	ORDER_1782562484089	RAZORPAY	1037.00	PENDING	order_T6eTO2qsKIyK7W	\N	2026-06-27 17:44:44.265847
5	ORDER_1782562488646	RAZORPAY	1037.00	PENDING	order_T6eTSuEfOGW6Hn	\N	2026-06-27 17:44:48.769639
6	ORDER_1782562959264	RAZORPAY	688.00	PENDING	order_T6ebknJL8iiRu1	\N	2026-06-27 17:52:39.571114
7	ORDER_1782563975138	RAZORPAY	688.00	PENDING	order_T6etdc5aAAYvHJ	\N	2026-06-27 18:09:35.343558
8	ORDER_1782564179018	RAZORPAY	688.00	PENDING	order_T6exE9LOt3KHub	\N	2026-06-27 18:12:59.253752
9	ORDER_1782564599519	RAZORPAY	688.00	PENDING	order_T6f4dArLCcbE9v	\N	2026-06-27 18:19:59.788353
10	ORDER_1782564692062	RAZORPAY	688.00	PAID	order_T6f6G6jZlBwDki	pay_T6fGkb97xnOCZ1	2026-06-27 18:21:32.243401
11	ORDER_1782565325319	RAZORPAY	688.00	PAID	order_T6fHPKdGXFp2RA	pay_T6fKVYLq9YmGAd	2026-06-27 18:32:05.449719
12	ORDER_1782565526496	RAZORPAY	688.00	PAID	order_T6fKwwtxj69AZ5	pay_T6fLK0e1iQoC7i	2026-06-27 18:35:26.653921
13	ORDER_1782565953314	RAZORPAY	688.00	PAID	order_T6fSSse8390eIV	pay_T6fStseqpr2VyG	2026-06-27 18:42:33.55984
14	ORDER_1782566028293	RAZORPAY	688.00	PENDING	order_T6fTmcePxbNZvT	\N	2026-06-27 18:43:48.412455
15	ORDER_1782567438044	RAZORPAY	1087.00	PAID	order_T6fsbYaPc9bJxa	pay_T6ftDctH2kQtLk	2026-06-27 19:07:18.297448
16	ORDER_1782567695152	RAZORPAY	1117.00	PAID	order_T6fx89S6qszCjp	pay_T6fxTBKJBTP8UR	2026-06-27 19:11:35.594563
17	ORDER_1783750672552	RAZORPAY	688.00	PAID	order_TC5s76FY7cNjRa	pay_TC5vwsuWHOLqGQ	2026-07-11 11:47:52.916071
18	ORDER_1783750943553	RAZORPAY	688.00	PENDING	order_TC5wslE77FbqfI	\N	2026-07-11 11:52:23.793816
19	ORDER_1783751221502	RAZORPAY	1037.00	PAID	order_TC61mGeYoyvPGp	pay_TC628SAxYrtTlv	2026-07-11 11:57:01.788058
20	ORDER_1783765435912	RAZORPAY	688.00	PAID	order_TCA41u6liXSlO7	pay_TCA4WfdIA2TypP	2026-07-11 15:53:56.194092
21	ORDER_1783765484317	RAZORPAY	688.00	PAID	order_TCA4sffU6JlA1g	pay_TCA5ACpqERE3ua	2026-07-11 15:54:44.524712
22	ORDER_1783765742939	RAZORPAY	688.00	PAID	order_TCA9RFDHI3ZokO	pay_TCA9nrtTaVPjLx	2026-07-11 15:59:03.400068
23	ORDER_1783766822751	RAZORPAY	688.00	PAID	order_TCASRhD7EjmyO9	pay_TCATrR7k8OfFzF	2026-07-11 16:17:03.073033
24	ORDER_1783768852190	RAZORPAY	688.00	PAID	order_TCB2Ayqgf7Ni1E	pay_TCB2cjYsttXfhA	2026-07-11 16:50:52.518464
25	ORDER_1783923755090	RAZORPAY	688.00	PAID	order_TCt1KO2EqQX3Hw	pay_TCt1nstVRNBhiN	2026-07-13 11:52:35.282138
26	ORDER_1783937714135	RAZORPAY	339.00	PAID	order_TCwz5Shj9CWJsw	pay_TCwzgF1y7TlCDU	2026-07-13 15:45:14.609977
27	ORDER_1783938853154	RAZORPAY	339.00	PAID	order_TCxJ8h44puvxyU	pay_TCxJW0JQINkrU9	2026-07-13 16:04:13.536587
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.products (id, name, price, stock, image) FROM stdin;
1	Sunflower Oil	299.00	100	sunflower.png
2	Groundnut Oil	349.00	100	groundnut.png
3	Coconut Oil	399.00	100	coconut.png
4	Sesame Oil	329.00	100	sesame.png
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: apfdcllp
--

COPY public.users (id, mobile, created_at) FROM stdin;
1	9876543210	2026-07-12 13:21:16.360633
2	9573957354	2026-07-12 13:56:19.929743
3	9347499591	2026-07-12 15:11:59.213496
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 11, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.order_items_id_seq', 6, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.orders_id_seq', 3, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.payments_id_seq', 27, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apfdcllp
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_mobile_key; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mobile_key UNIQUE (mobile);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.products(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apfdcllp
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict QY9IzXcNal6HsVQyhG90olThvAk4gnK1wBhtnpPJbaZKe6zxRNAZVD9TdraHttM

