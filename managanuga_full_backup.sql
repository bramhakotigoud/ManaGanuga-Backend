--
-- PostgreSQL database dump
--

\restrict DpVdQZlz4ojNiXYzugc88oTiVfCivgk2dyS9KMxLQuZDKZtAJZL408fAFjDbHLO

-- Dumped from database version 18.4 (Debian 18.4-1.pgdg13+1)
-- Dumped by pg_dump version 18.4

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
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: benefits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.benefits (
    id integer NOT NULL,
    membership_id integer NOT NULL,
    customer_id character varying(50) NOT NULL,
    beneficiary_id character varying(50) NOT NULL,
    beneficiary_role character varying(20) NOT NULL,
    benefit_percent numeric(5,2) NOT NULL,
    benefit_amount numeric(12,2) NOT NULL,
    status character varying(20) DEFAULT 'CREDITED'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.benefits OWNER TO postgres;

--
-- Name: benefits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.benefits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.benefits_id_seq OWNER TO postgres;

--
-- Name: benefits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.benefits_id_seq OWNED BY public.benefits.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    is_active integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type character varying(50),
    reference_id integer,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    item_type character varying(20),
    item_id integer,
    quantity integer,
    unit_price numeric(10,2)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    entity_type character varying(20),
    entity_id integer,
    total_amount numeric(10,2),
    status character varying(20) DEFAULT 'PLACED'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    warehouse_id integer,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    tracking_number character varying(100),
    courier_name character varying(100),
    address_id integer,
    admin_verified boolean DEFAULT false,
    admin_accepted boolean DEFAULT false,
    delivery_method character varying(30),
    user_id character varying(50)
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    order_id character varying(255) NOT NULL,
    payment_gateway character varying(50) NOT NULL,
    amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    gateway_order_id character varying(255),
    gateway_payment_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_type character varying(20) DEFAULT 'ORDER'::character varying,
    membership_plan_id integer
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    image text,
    weight numeric(10,2) DEFAULT 1,
    category_id integer,
    is_active integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: subscription_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_plans (
    id integer NOT NULL,
    plan_name character varying(50) NOT NULL,
    plan_price numeric(10,2) NOT NULL,
    wallet_bonus numeric(10,2) NOT NULL,
    monthly_claim numeric(10,2) NOT NULL,
    discount_percentage integer NOT NULL,
    monthly_limit_litres integer CONSTRAINT subscription_plans_eligible_bottles_not_null NOT NULL,
    validity_months integer DEFAULT 12,
    description text,
    is_active boolean DEFAULT true,
    display_order integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subscription_plans OWNER TO postgres;

--
-- Name: subscription_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_plans_id_seq OWNER TO postgres;

--
-- Name: subscription_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_plans_id_seq OWNED BY public.subscription_plans.id;


--
-- Name: user_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_info (
    id integer NOT NULL,
    user_id character varying(20) NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    email character varying(150),
    address text,
    city character varying(100),
    state character varying(100),
    pincode character varying(10),
    subscription character varying(50)
);


ALTER TABLE public.user_info OWNER TO postgres;

--
-- Name: user_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_info_id_seq OWNER TO postgres;

--
-- Name: user_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_info_id_seq OWNED BY public.user_info.id;


--
-- Name: user_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_login (
    id integer NOT NULL,
    user_id character varying(20) NOT NULL,
    username character varying(100) NOT NULL,
    mobile_no character varying(15) NOT NULL,
    password character varying(250) NOT NULL,
    role character varying(30) NOT NULL,
    is_active boolean DEFAULT true,
    created_by character varying(30),
    assigned_by character varying(30),
    relationship_type character varying(30),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_login OWNER TO postgres;

--
-- Name: user_login_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_login_id_seq OWNER TO postgres;

--
-- Name: user_login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_login_id_seq OWNED BY public.user_login.id;


--
-- Name: user_memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_memberships (
    id integer NOT NULL,
    user_id integer NOT NULL,
    plan_id integer NOT NULL,
    payment_id integer,
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    wallet_balance numeric(10,2) DEFAULT 0,
    discount_percent integer DEFAULT 0,
    monthly_claim numeric(10,2) DEFAULT 0,
    monthly_limit_litres integer DEFAULT 8,
    used_litres integer DEFAULT 0,
    start_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expiry_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_reset_date date DEFAULT CURRENT_DATE,
    monthly_claim_used numeric(10,2) DEFAULT 0,
    terms_and_conditions boolean DEFAULT false NOT NULL,
    assigned_by character varying(50),
    assigned_role character varying(20)
);


ALTER TABLE public.user_memberships OWNER TO postgres;

--
-- Name: user_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_memberships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_memberships_id_seq OWNER TO postgres;

--
-- Name: user_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_memberships_id_seq OWNED BY public.user_memberships.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    mobile character varying(15) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    role character varying(20) DEFAULT 'USER'::character varying,
    fcm_token text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id integer NOT NULL,
    user_id character varying(20) NOT NULL,
    wallet_type character varying(20) NOT NULL,
    balance numeric(12,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT wallets_type_check CHECK (((wallet_type)::text = ANY ((ARRAY['VENDOR'::character varying, 'RESELLER'::character varying])::text[])))
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallets_id_seq OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouses (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address text,
    city character varying(100),
    pincode character varying(10),
    latitude numeric,
    longitude numeric,
    phone character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    contact_name character varying(100),
    state character varying(100)
);


ALTER TABLE public.warehouses OWNER TO postgres;

--
-- Name: warehouses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warehouses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouses_id_seq OWNER TO postgres;

--
-- Name: warehouses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warehouses_id_seq OWNED BY public.warehouses.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: benefits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benefits ALTER COLUMN id SET DEFAULT nextval('public.benefits_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: subscription_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_plans ALTER COLUMN id SET DEFAULT nextval('public.subscription_plans_id_seq'::regclass);


--
-- Name: user_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_info ALTER COLUMN id SET DEFAULT nextval('public.user_info_id_seq'::regclass);


--
-- Name: user_login id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login ALTER COLUMN id SET DEFAULT nextval('public.user_login_id_seq'::regclass);


--
-- Name: user_memberships id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_memberships ALTER COLUMN id SET DEFAULT nextval('public.user_memberships_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- Name: warehouses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouses ALTER COLUMN id SET DEFAULT nextval('public.warehouses_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, entity_type, entity_id, address_type, full_name, phone, address_line1, address_line2, city, state, country, postal_code, is_default) FROM stdin;
1	USER	1	Home	Purushottam	9876543210	H.no:91	nearbus stand	Hyderabad	Telangana	India	500081	t
\.


--
-- Data for Name: benefits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.benefits (id, membership_id, customer_id, beneficiary_id, beneficiary_role, benefit_percent, benefit_amount, status, created_at) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, entity_type, entity_id, item_type, item_id, quantity, created_at) FROM stdin;
78	USER	1	PRODUCT	2	2	2026-08-11 18:59:51.828258
79	USER	1	PRODUCT	1	3	2026-08-12 01:32:48.253936
80	USER	1	PRODUCT	4	1	2026-08-12 04:55:14.157311
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description, is_active, created_at) FROM stdin;
1	Oils	Edible and Cooking Oils	1	2026-08-04 08:57:57.904592
3	Spices	Traditional Spices and Spice Products	0	2026-08-04 08:57:57.904592
2	Millets	Healthy-Millet based Products	0	2026-08-04 08:57:57.904592
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, title, message, type, reference_id, is_read, created_at) FROM stdin;
1	1	Test Notification	ManaGanuga notification system is working!	GENERAL	\N	t	2026-08-10 07:45:22.580802
3	1	Test Notification	Automatic notification test	GENERAL	\N	f	2026-08-10 11:16:39.68848
2	5	Order Placed Successfully	Your order #74 has been placed successfully.	ORDER_PLACED	74	t	2026-08-10 10:26:17.601897
4	5	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	222	t	2026-08-10 12:28:59.923226
5	5	Order Placed Successfully	Your order #75 has been placed successfully.	ORDER_PLACED	75	t	2026-08-10 12:28:59.952499
6	5	Mana Ganuga 🔥	This is a real-time test notification!	GENERAL	\N	t	2026-08-10 18:31:35.797456
7	5	Mana Ganuga 🔥	REAL TIME TEST NOTIFICATION	GENERAL	\N	t	2026-08-10 18:44:32.117768
8	5	Mana Ganuga 🔥	REAL TIME TEST NOTIFICATION	GENERAL	\N	t	2026-08-10 18:52:14.073792
9	5	Mana Ganuga 🔥	REAL TIME TEST NOTIFICATION	GENERAL	\N	t	2026-08-10 19:05:29.8341
10	5	Mana Ganuga 🔥	REAL TIME TEST NOTIFICATION	GENERAL	\N	t	2026-08-10 19:11:39.829374
11	5	Mana Ganuga 🔥	REAL TIME TEST NOTIFICATION	GENERAL	\N	t	2026-08-10 19:17:54.421284
12	5	Mana Ganuga 🔥	REAL TIME TEST	GENERAL	\N	t	2026-08-10 20:00:20.550667
13	5	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	223	t	2026-08-11 04:19:18.159303
14	5	Order Placed Successfully	Your order #76 has been placed successfully.	ORDER_PLACED	76	t	2026-08-11 04:19:18.201369
15	5	Mana Ganuga 🔥	REAL TIME TEST	GENERAL	\N	f	2026-08-11 04:24:06.193973
16	15	Mana Ganuga 🔥	REAL TIME TEST	GENERAL	\N	t	2026-08-11 04:49:11.217225
17	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	224	t	2026-08-11 04:53:35.277669
18	15	Order Placed Successfully	Your order #77 has been placed successfully.	ORDER_PLACED	77	t	2026-08-11 04:53:35.319477
19	15	Mana Ganuga 🔥	BACKGROUND PUSH TEST	GENERAL	\N	t	2026-08-11 04:55:11.114546
20	15	Mana Ganuga 🔥	BACKGROUND PUSH TEST	GENERAL	\N	t	2026-08-11 04:58:55.264701
21	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	225	t	2026-08-11 05:00:25.103061
22	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	227	t	2026-08-11 05:03:16.690423
23	15	Order Placed Successfully	Your order #78 has been placed successfully.	ORDER_PLACED	78	t	2026-08-11 05:03:16.739873
24	15	Mana Ganuga 🔥	BACKGROUND PUSH TEST	GENERAL	\N	t	2026-08-11 05:06:51.230002
25	15	Mana Ganuga 🔥	BACKGROUND PUSH TEST	GENERAL	\N	t	2026-08-11 05:07:25.840075
26	15	Mana Ganuga 🔥	BACKGROUND PUSH TEST	GENERAL	\N	t	2026-08-11 05:09:20.906682
27	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	228	t	2026-08-11 05:12:58.68703
28	15	Order Placed Successfully	Your order #79 has been placed successfully.	ORDER_PLACED	79	t	2026-08-11 05:12:58.734094
29	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	229	t	2026-08-11 05:47:08.396364
30	15	Order Placed Successfully	Your order #80 has been placed successfully.	ORDER_PLACED	80	t	2026-08-11 05:47:08.432306
31	15	BACKGROUND TEST	Testing background notification	GENERAL	\N	t	2026-08-11 05:53:01.194272
32	15	FOREGROUND TEST	Testing foreground FCM	GENERAL	\N	t	2026-08-11 06:00:30.455927
33	15	FOREGROUND TEST	Popup while app is open!	GENERAL	\N	t	2026-08-11 06:10:29.172152
34	15	BACKGROUND TEST	App is in background!	GENERAL	\N	t	2026-08-11 06:12:06.845798
35	15	LOCKED TEST	Your iPhone is locked!	GENERAL	\N	t	2026-08-11 06:12:21.243205
36	15	LOCKED TEST	Your iPhone is locked!	GENERAL	\N	t	2026-08-11 06:12:32.750633
37	15	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	230	t	2026-08-11 06:15:15.62219
38	15	Order Placed Successfully	Your order #81 has been placed successfully.	ORDER_PLACED	81	t	2026-08-11 06:15:15.681358
39	6	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	231	t	2026-08-11 18:39:37.832212
40	6	Order Placed Successfully	Your order #82 has been placed successfully.	ORDER_PLACED	82	t	2026-08-11 18:39:37.849096
41	6	Payment Successful	Your payment was successfully completed.	PAYMENT_SUCCESS	232	f	2026-08-11 18:40:54.207446
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, item_type, item_id, quantity, unit_price) FROM stdin;
100	71	PRODUCT	1	2	299.00
101	72	PRODUCT	3	2	399.00
102	73	PRODUCT	3	2	399.00
103	74	PRODUCT	1	2	299.00
104	74	PRODUCT	2	2	349.00
105	75	PRODUCT	1	2	299.00
106	75	PRODUCT	2	2	349.00
107	76	PRODUCT	1	2	299.00
108	77	PRODUCT	1	1	299.00
109	78	PRODUCT	1	1	299.00
110	78	PRODUCT	2	2	349.00
111	79	PRODUCT	1	1	299.00
112	79	PRODUCT	2	1	349.00
113	80	PRODUCT	1	1	299.00
114	80	PRODUCT	2	1	349.00
115	81	PRODUCT	1	1	299.00
116	81	PRODUCT	2	1	349.00
117	82	PRODUCT	1	3	299.00
118	82	PRODUCT	2	3	349.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, entity_type, entity_id, total_amount, status, created_at, warehouse_id, payment_status, tracking_number, courier_name, address_id, admin_verified, admin_accepted, delivery_method, user_id) FROM stdin;
82	USER	1	1944.00	PLACED	2026-08-11 18:39:37.83915	\N	pending	\N	\N	\N	f	f	\N	\N
71	USER	0	598.00	PROCESSING	2026-08-10 06:49:06.028676	1	PENDING	\N	\N	\N	t	t	SELF	MGC260801
72	USER	0	798.00	PROCESSING	2026-08-10 06:51:20.977093	1	PENDING	\N	\N	\N	t	t	SELF	MGC260803
73	USER	0	798.00	PROCESSING	2026-08-10 09:24:08.855562	1	PENDING	\N	\N	\N	t	t	SELF	MGC260801
74	USER	1	1296.00	PROCESSING	2026-08-10 10:26:17.581825	\N	pending	\N	\N	\N	t	t	SELF	\N
76	USER	1	598.00	PLACED	2026-08-11 04:19:18.183653	\N	pending	\N	\N	\N	f	f	\N	\N
77	USER	1	299.00	PLACED	2026-08-11 04:53:35.301641	\N	pending	\N	\N	\N	f	f	\N	\N
78	USER	1	997.00	PLACED	2026-08-11 05:03:16.717002	\N	pending	\N	\N	\N	f	f	\N	\N
79	USER	1	648.00	PLACED	2026-08-11 05:12:58.712148	\N	pending	\N	\N	\N	f	f	\N	\N
80	USER	1	648.00	PLACED	2026-08-11 05:47:08.415656	\N	pending	\N	\N	\N	f	f	\N	\N
81	USER	1	648.00	PLACED	2026-08-11 06:15:15.653404	\N	pending	\N	\N	\N	f	f	\N	\N
75	USER	1	1296.00	PROCESSING	2026-08-10 12:28:59.937816	\N	pending	\N	\N	\N	t	t	SELF	\N
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, order_id, payment_gateway, amount, status, gateway_order_id, gateway_payment_id, created_at, payment_type, membership_plan_id) FROM stdin;
1	TEST123	RAZORPAY	299.00	PENDING	order_T6d47poxDmuVX3	\N	2026-06-27 16:22:07.85518	ORDER	\N
2	TEST123	RAZORPAY	299.00	PENDING	order_T6d9EZUDzY9UeR	\N	2026-06-27 16:26:58.076175	ORDER	\N
3	ORDER_1782562370321	RAZORPAY	688.00	PENDING	order_T6eRNxAGRHzj8E	\N	2026-06-27 17:42:50.587663	ORDER	\N
4	ORDER_1782562484089	RAZORPAY	1037.00	PENDING	order_T6eTO2qsKIyK7W	\N	2026-06-27 17:44:44.265847	ORDER	\N
5	ORDER_1782562488646	RAZORPAY	1037.00	PENDING	order_T6eTSuEfOGW6Hn	\N	2026-06-27 17:44:48.769639	ORDER	\N
6	ORDER_1782562959264	RAZORPAY	688.00	PENDING	order_T6ebknJL8iiRu1	\N	2026-06-27 17:52:39.571114	ORDER	\N
7	ORDER_1782563975138	RAZORPAY	688.00	PENDING	order_T6etdc5aAAYvHJ	\N	2026-06-27 18:09:35.343558	ORDER	\N
8	ORDER_1782564179018	RAZORPAY	688.00	PENDING	order_T6exE9LOt3KHub	\N	2026-06-27 18:12:59.253752	ORDER	\N
9	ORDER_1782564599519	RAZORPAY	688.00	PENDING	order_T6f4dArLCcbE9v	\N	2026-06-27 18:19:59.788353	ORDER	\N
10	ORDER_1782564692062	RAZORPAY	688.00	PAID	order_T6f6G6jZlBwDki	pay_T6fGkb97xnOCZ1	2026-06-27 18:21:32.243401	ORDER	\N
11	ORDER_1782565325319	RAZORPAY	688.00	PAID	order_T6fHPKdGXFp2RA	pay_T6fKVYLq9YmGAd	2026-06-27 18:32:05.449719	ORDER	\N
12	ORDER_1782565526496	RAZORPAY	688.00	PAID	order_T6fKwwtxj69AZ5	pay_T6fLK0e1iQoC7i	2026-06-27 18:35:26.653921	ORDER	\N
13	ORDER_1782565953314	RAZORPAY	688.00	PAID	order_T6fSSse8390eIV	pay_T6fStseqpr2VyG	2026-06-27 18:42:33.55984	ORDER	\N
14	ORDER_1782566028293	RAZORPAY	688.00	PENDING	order_T6fTmcePxbNZvT	\N	2026-06-27 18:43:48.412455	ORDER	\N
15	ORDER_1782567438044	RAZORPAY	1087.00	PAID	order_T6fsbYaPc9bJxa	pay_T6ftDctH2kQtLk	2026-06-27 19:07:18.297448	ORDER	\N
16	ORDER_1782567695152	RAZORPAY	1117.00	PAID	order_T6fx89S6qszCjp	pay_T6fxTBKJBTP8UR	2026-06-27 19:11:35.594563	ORDER	\N
17	ORDER_1783750672552	RAZORPAY	688.00	PAID	order_TC5s76FY7cNjRa	pay_TC5vwsuWHOLqGQ	2026-07-11 11:47:52.916071	ORDER	\N
18	ORDER_1783750943553	RAZORPAY	688.00	PENDING	order_TC5wslE77FbqfI	\N	2026-07-11 11:52:23.793816	ORDER	\N
19	ORDER_1783751221502	RAZORPAY	1037.00	PAID	order_TC61mGeYoyvPGp	pay_TC628SAxYrtTlv	2026-07-11 11:57:01.788058	ORDER	\N
20	ORDER_1783765435912	RAZORPAY	688.00	PAID	order_TCA41u6liXSlO7	pay_TCA4WfdIA2TypP	2026-07-11 15:53:56.194092	ORDER	\N
21	ORDER_1783765484317	RAZORPAY	688.00	PAID	order_TCA4sffU6JlA1g	pay_TCA5ACpqERE3ua	2026-07-11 15:54:44.524712	ORDER	\N
22	ORDER_1783765742939	RAZORPAY	688.00	PAID	order_TCA9RFDHI3ZokO	pay_TCA9nrtTaVPjLx	2026-07-11 15:59:03.400068	ORDER	\N
23	ORDER_1783766822751	RAZORPAY	688.00	PAID	order_TCASRhD7EjmyO9	pay_TCATrR7k8OfFzF	2026-07-11 16:17:03.073033	ORDER	\N
24	ORDER_1783768852190	RAZORPAY	688.00	PAID	order_TCB2Ayqgf7Ni1E	pay_TCB2cjYsttXfhA	2026-07-11 16:50:52.518464	ORDER	\N
25	ORDER_1783923755090	RAZORPAY	688.00	PAID	order_TCt1KO2EqQX3Hw	pay_TCt1nstVRNBhiN	2026-07-13 11:52:35.282138	ORDER	\N
26	ORDER_1783937714135	RAZORPAY	339.00	PAID	order_TCwz5Shj9CWJsw	pay_TCwzgF1y7TlCDU	2026-07-13 15:45:14.609977	ORDER	\N
27	ORDER_1783938853154	RAZORPAY	339.00	PAID	order_TCxJ8h44puvxyU	pay_TCxJW0JQINkrU9	2026-07-13 16:04:13.536587	ORDER	\N
28	ORDER_1784035394591	RAZORPAY	688.00	PENDING	order_TDOioYgFnKz4pH	\N	2026-07-14 13:23:15.682109	ORDER	\N
29	ORDER_1784035447780	RAZORPAY	688.00	PENDING	order_TDOjkaoubGhgMD	\N	2026-07-14 13:24:08.840365	ORDER	\N
30	ORDER_1784035603013	RAZORPAY	688.00	PENDING	order_TDOmU2Pfxx8TwX	\N	2026-07-14 13:26:44.080925	ORDER	\N
31	ORDER_1784037481023	RAZORPAY	688.00	PENDING	order_TDPJZARQY8kwvv	\N	2026-07-14 13:58:03.197167	ORDER	\N
32	ORDER_1784037485662	RAZORPAY	688.00	PENDING	order_TDPJcfglktyD1g	\N	2026-07-14 13:58:06.344837	ORDER	\N
33	ORDER_1784037887029	RAZORPAY	788.00	PENDING	order_TDPQhCokeJ4Lch	\N	2026-07-14 14:04:48.144586	ORDER	\N
34	ORDER_1784038481186	RAZORPAY	389.00	PENDING	order_TDPb9elrAQUdA3	\N	2026-07-14 14:14:42.174025	ORDER	\N
35	ORDER_1784039764179	RAZORPAY	688.00	PENDING	order_TDPxk9bCMgFGIW	\N	2026-07-14 14:36:05.229097	ORDER	\N
36	ORDER_1784040272420	RAZORPAY	1037.00	PAID	order_TDQ6h7p2cNwuMj	pay_TDQ7QavWcAA3r3	2026-07-14 14:44:33.635287	ORDER	\N
37	ORDER_1784097860050	RAZORPAY	688.00	PAID	order_TDgSYbxm5JTD77	pay_TDgT04FwoIP4rB	2026-07-15 06:44:21.340507	ORDER	\N
38	ORDER_1784099601316	RAZORPAY	688.00	PAID	order_TDgxD3nO6HyRyk	pay_TDgxXtB8jUDy97	2026-07-15 07:13:22.335978	ORDER	\N
39	ORDER_1784100085107	RAZORPAY	688.00	PAID	order_TDh5jM6ZlTSTDI	pay_TDh66GGgikz1Zf	2026-07-15 07:21:26.373919	ORDER	\N
40	ORDER_1784100279524	RAZORPAY	339.00	PAID	order_TDh99pDBvUg7gq	pay_TDhvGiwosQppKP	2026-07-15 07:24:41.028438	ORDER	\N
41	ORDER_1784115099032	RAZORPAY	1037.00	PAID	order_TDlM3f45p3e8XY	pay_TDlNCqU7rTKWRH	2026-07-15 11:31:40.22832	ORDER	\N
42	ORDER_1784115702677	RAZORPAY	389.00	PAID	order_TDlWgPVsdyO2QQ	pay_TDlYKq2YufOxwH	2026-07-15 11:41:43.705664	ORDER	\N
43	ORDER_1784118790481	RAZORPAY	389.00	PENDING	order_TDmP32fBPLGm3N	\N	2026-07-15 12:33:11.653781	ORDER	\N
44	ORDER_1784118929860	RAZORPAY	389.00	PENDING	order_TDmRUxdbLTLx8B	\N	2026-07-15 12:35:30.867912	ORDER	\N
45	ORDER_1784119092208	RAZORPAY	389.00	PENDING	order_TDmUM9yRHPmnvv	\N	2026-07-15 12:38:13.200961	ORDER	\N
46	ORDER_1784129874145	RAZORPAY	1.00	PAID	order_TDpYBQVX2dT4Dl	pay_TDpb7VE6ilxoOZ	2026-07-15 15:37:55.423272	ORDER	\N
47	ORDER_1784276644231	RAZORPAY	1.00	PENDING	order_TEVEAFeRjov8ZC	\N	2026-07-17 08:24:06.158929	ORDER	\N
48	11	RAZORPAY	500.00	PENDING	order_TEVVfu23EeEUxa	\N	2026-07-17 08:40:42.929036	ORDER	\N
49	11	RAZORPAY	500.00	PENDING	order_TEVWdrmAswktsL	\N	2026-07-17 08:41:37.290021	ORDER	\N
50	ORDER_1784283702046	RAZORPAY	1.00	PENDING	order_TEXEQ2MCpfzQqT	\N	2026-07-17 10:21:43.858165	ORDER	\N
51	ORDER_1784283865879	RAZORPAY	1.00	PENDING	order_TEXHIWaMD1aP8G	\N	2026-07-17 10:24:27.359555	ORDER	\N
52	ORDER_1784283989096	RAZORPAY	1.00	PENDING	order_TEXJT01HmZgWa2	\N	2026-07-17 10:26:30.557444	ORDER	\N
53	ORDER_1784285094366	RAZORPAY	1.00	PENDING	order_TEXcvVKrx3uhwr	\N	2026-07-17 10:44:55.875272	ORDER	\N
54	ORDER_1784285136382	RAZORPAY	1.00	PENDING	order_TEXdfMuPPEBKG5	\N	2026-07-17 10:45:37.856936	ORDER	\N
55	11	RAZORPAY	500.00	PENDING	order_TEYMnjnckmJays	\N	2026-07-17 11:28:24.964276	ORDER	\N
56	21	RAZORPAY	500.00	PENDING	order_TEZIJ7AHBSIPpx	\N	2026-07-17 12:22:49.463488	ORDER	\N
57	22	RAZORPAY	500.00	PENDING	order_TEZKqrdOERNr8C	\N	2026-07-17 12:25:13.917339	ORDER	\N
58	11	RAZORPAY	500.00	PAID	order_TEZLFELpiCAihM	pay_TEZMSWpbRBwBX1	2026-07-17 12:25:36.330834	ORDER	\N
59	11	RAZORPAY	500.00	PAID	order_TEZNuprnGnrVgv	pay_TEZOeoZ4XTCNLv	2026-07-17 12:28:08.392905	ORDER	\N
60	23	RAZORPAY	500.00	PENDING	order_TEZTf5Ptllt54m	\N	2026-07-17 12:33:35.900525	ORDER	\N
61	11	RAZORPAY	500.00	PAID	order_TEZTpHNLGcAxsF	pay_TEZTyI1BJHSnvc	2026-07-17 12:33:42.155377	ORDER	\N
62	24	RAZORPAY	500.00	PENDING	order_TEZb3ATZ8CpLC9	\N	2026-07-17 12:40:34.531896	ORDER	\N
63	11	RAZORPAY	500.00	PAID	order_TEZbLKeihJLAHd	pay_TEZbUGzL3nUfJx	2026-07-17 12:40:50.560701	ORDER	\N
64	25	RAZORPAY	500.00	PENDING	order_TEZgbkCAoWYcci	\N	2026-07-17 12:45:49.992256	ORDER	\N
65	11	RAZORPAY	500.00	PAID	order_TEZgoHAU0rQyIS	pay_TEZgyJVDWYj2be	2026-07-17 12:45:59.638139	ORDER	\N
66	26	RAZORPAY	500.00	PENDING	order_TEZmti9tZFEjdE	\N	2026-07-17 12:51:47.682142	ORDER	\N
67	11	RAZORPAY	500.00	PAID	order_TEZo8PzUMTwPwc	pay_TEZoIj3In216Ei	2026-07-17 12:52:57.299231	ORDER	\N
68	27	RAZORPAY	500.00	PENDING	order_TEZrNYu1MKraaX	\N	2026-07-17 12:56:01.321838	ORDER	\N
69	11	RAZORPAY	500.00	PAID	order_TEZydpaeD3KIso	pay_TEZyoAnJ09O70r	2026-07-17 13:02:54.073983	ORDER	\N
70	11	RAZORPAY	500.00	PAID	order_TEaC76M8olphHv	pay_TEaCFkpNS8gz6R	2026-07-17 13:15:39.084836	ORDER	\N
71	11	RAZORPAY	500.00	PAID	order_TEaD7MvLO0z5Yz	pay_TEaDEQFBGEezPG	2026-07-17 13:16:36.24916	ORDER	\N
72	28	RAZORPAY	500.00	PENDING	order_TEaG7PZfsJ9YOo	\N	2026-07-17 13:19:26.576541	ORDER	\N
73	11	RAZORPAY	500.00	PAID	order_TEaKTw9r0rcIHY	pay_TEaLScGwRG96cd	2026-07-17 13:23:34.539106	ORDER	\N
74	11	RAZORPAY	500.00	PENDING	order_TEaMqmMqUWLBdC	\N	2026-07-17 13:25:49.189911	ORDER	\N
75	11	RAZORPAY	500.00	PENDING	order_TEaNs4Nbw2XOMp	\N	2026-07-17 13:26:47.146966	ORDER	\N
114	36	RAZORPAY	500.00	PAID	order_TGSoDgeVuS4K14	pay_TGSoTbaA93k8Dg	2026-07-22 07:20:10.948293	ORDER	\N
76	11	RAZORPAY	500.00	PAID	order_TEaS5AgVHBROyN	pay_TEaSGHPl1KbztF	2026-07-17 13:30:46.267864	ORDER	\N
77	28	RAZORPAY	500.00	PENDING	order_TEaYwOOUmoGcl2	\N	2026-07-17 13:37:15.87728	ORDER	\N
78	28	RAZORPAY	500.00	PAID	order_TEaZ7WvB1xDRaX	pay_TEaZETGnamNIaT	2026-07-17 13:37:24.481788	ORDER	\N
79	28	RAZORPAY	500.00	PAID	order_TEqFqvde1LjcZB	pay_TEqGI2yF4Ua3KX	2026-07-18 04:58:17.895389	ORDER	\N
80	29	RAZORPAY	500.00	PENDING	order_TEqIKvvqccVZ69	\N	2026-07-18 05:00:38.526157	ORDER	\N
81	29	RAZORPAY	500.00	PAID	order_TEqIgQdklQdid1	pay_TEqIpOQZv4sGfV	2026-07-18 05:00:58.261083	ORDER	\N
82	17	RAZORPAY	500.00	PAID	order_TEqQRWGJ1975Mq	pay_TEqQbTseMwbzOb	2026-07-18 05:08:18.903737	ORDER	\N
83	18	RAZORPAY	500.00	PAID	order_TEqWkkH1f074Dq	pay_TEqWsPtOExSTn2	2026-07-18 05:14:17.40522	ORDER	\N
84	19	RAZORPAY	500.00	PAID	order_TEr2aU76FwUWRD	pay_TEr2ksLt5ucWK4	2026-07-18 05:44:26.006628	ORDER	\N
85	20	RAZORPAY	500.00	PAID	order_TEr7Jb0E4K6nQf	pay_TEr7Sn7pFwEiAo	2026-07-18 05:48:53.954333	ORDER	\N
86	21	RAZORPAY	500.00	PAID	order_TErSAaNTgRi0XL	pay_TErSQygO4SQEjW	2026-07-18 06:08:38.76167	ORDER	\N
87	22	RAZORPAY	500.00	PAID	order_TErd094w51mDcQ	pay_TErdAqy9HVi5dM	2026-07-18 06:18:54.394246	ORDER	\N
88	23	RAZORPAY	500.00	PAID	order_TErgN2u8Vh9cQ5	pay_TErgVGT1Qvk4ZK	2026-07-18 06:22:05.273311	ORDER	\N
89	24	RAZORPAY	500.00	PAID	order_TEriAY9XMf3E34	pay_TEriJ4vl3G90fu	2026-07-18 06:23:47.691629	ORDER	\N
90	ORDER_1784359972001	RAZORPAY	1599.00	PENDING	order_TEstBnCIdv1wIb	\N	2026-07-18 07:32:53.505774	ORDER	\N
91	ORDER_1784360080263	RAZORPAY	1.00	PENDING	order_TEsv5t9zzgZcRa	\N	2026-07-18 07:34:41.706676	ORDER	\N
92	ORDER_1784360715932	RAZORPAY	1.00	PAID	order_TEt6HnM57PadY9	pay_TEt8v4j0MdohLd	2026-07-18 07:45:17.370741	ORDER	\N
93	ORDER_1784361486134	RAZORPAY	1.00	PENDING	order_TEtJqTrI0Gh7yY	\N	2026-07-18 07:58:07.613746	ORDER	\N
94	ORDER_1784432759741	RAZORPAY	1.00	PENDING	order_TFDYel2L6Lxzu4	\N	2026-07-19 03:46:01.117865	ORDER	\N
95	26	RAZORPAY	500.00	PAID	order_TFgxRm3OB5kOrq	pay_TFgxgkqSj7Si09	2026-07-20 08:31:38.172257	ORDER	\N
96	27	RAZORPAY	500.00	PAID	order_TFhDF0rfoff6rO	pay_TFhDNZHK3xzlHM	2026-07-20 08:46:34.788062	ORDER	\N
97	28	RAZORPAY	500.00	PAID	order_TFhV5NciTp0jTM	pay_TFhVEjxHT2lrmR	2026-07-20 09:03:28.245989	ORDER	\N
98	29	RAZORPAY	500.00	PAID	order_TFhfs1DK0GeXLV	pay_TFhfzwLlL47tC4	2026-07-20 09:13:41.048835	ORDER	\N
99	30	RAZORPAY	500.00	PAID	order_TFi8wk1z0DObC3	pay_TFi974BmB8gBkk	2026-07-20 09:41:12.489831	ORDER	\N
100	30	RAZORPAY	500.00	PENDING	order_TFipIn001ZK2cN	\N	2026-07-20 10:21:16.681105	ORDER	\N
101	30	RAZORPAY	500.00	PENDING	order_TFizPbAaKC8rsZ	\N	2026-07-20 10:30:50.91181	ORDER	\N
102	30	RAZORPAY	500.00	PENDING	order_TFj0G92y26SDqW	\N	2026-07-20 10:31:39.054284	ORDER	\N
103	30	RAZORPAY	500.00	PENDING	order_TFj2WRmhPtzOFd	\N	2026-07-20 10:33:47.588727	ORDER	\N
104	30	RAZORPAY	500.00	PENDING	order_TFj4ipG7nTUdKp	\N	2026-07-20 10:35:52.528072	ORDER	\N
105	30	RAZORPAY	500.00	PENDING	order_TFj5HocMrVt64x	\N	2026-07-20 10:36:24.611243	ORDER	\N
106	30	RAZORPAY	500.00	PENDING	order_TFjBo1wnCQSRYP	\N	2026-07-20 10:42:34.908432	ORDER	\N
107	30	RAZORPAY	500.00	PENDING	order_TFjH1kV9oE42x1	\N	2026-07-20 10:47:31.47497	ORDER	\N
108	31	RAZORPAY	500.00	PAID	order_TFjNXlT5kYElK1	pay_TFjNkeDfGdU4nh	2026-07-20 10:53:43.221077	ORDER	\N
109	32	RAZORPAY	500.00	PAID	order_TG8sXmS2Zk1yqV	pay_TG8sk6MkxWlS5v	2026-07-21 11:50:24.373291	ORDER	\N
110	33	RAZORPAY	500.00	PAID	order_TG96XSgX6UkiTf	pay_TG96peZqMnqxoq	2026-07-21 12:03:39.205532	ORDER	\N
111	34	RAZORPAY	500.00	PAID	order_TGRGWdu13aF82d	pay_TGRGkG8tG6VoGe	2026-07-22 05:49:35.432229	ORDER	\N
112	35	RAZORPAY	500.00	PAID	order_TGROW8gS4A770b	pay_TGROgBJsXzwaEf	2026-07-22 05:57:10.468437	ORDER	\N
113	ORDER_1784701749796	RAZORPAY	1.00	PENDING	order_TGRwNV7FyWtVT6	\N	2026-07-22 06:29:11.273078	ORDER	\N
115	ORDER_1784720269767	RAZORPAY	1.00	PAID	order_TGXCQtK8ROup0B	pay_TGXCsKwxODlP0W	2026-07-22 11:37:51.238744	order	\N
116	ORDER_1784721538499	RAZORPAY	1.00	PAID	order_TGXYloapWjbT9i	pay_TGXZ5rdKskeBC6	2026-07-22 11:58:59.973352	order	\N
117	ORDER_1784723672811	RAZORPAY	1.00	PAID	order_TGYALXKEEx0Dtr	pay_TGYB7ml2LarTss	2026-07-22 12:34:34.30915	order	\N
118	ORDER_1784724325432	RAZORPAY	1.00	PAID	order_TGYLpX0uLFITDu	pay_TGYM7fPtJJjU4J	2026-07-22 12:45:26.58375	order	\N
119	ORDER_1784725151351	RAZORPAY	1.00	PAID	order_TGYaNMa2Vglwv9	pay_TGYak0hff4p3df	2026-07-22 12:59:12.784408	order	\N
120	ORDER_1784726153409	RAZORPAY	1.00	PAID	order_TGYs1Ar1YJE9hC	pay_TGYtJ9S6Eg4d3X	2026-07-22 13:15:54.861674	order	\N
121	ORDER_1784726689033	RAZORPAY	1.00	PENDING	order_TGZ1S1bqwsaLOP	\N	2026-07-22 13:24:50.732057	order	\N
122	ORDER_1784726802829	RAZORPAY	1.00	PAID	order_TGZ3S1ZLwDkxCP	pay_TGZ3mrQX1cHFLQ	2026-07-22 13:26:44.275612	order	\N
123	ORDER_1784727313074	RAZORPAY	1.00	PAID	order_TGZCQbEjUs1V0B	pay_TGZCoI2Yhzqxzz	2026-07-22 13:35:14.159639	order	\N
124	ORDER_1784728906107	RAZORPAY	1.00	PAID	order_TGZeTuchHLo32p	pay_TGZeq4R23Q1HrB	2026-07-22 14:01:47.60759	order	\N
125	ORDER_1784729745496	RAZORPAY	1.00	PAID	order_TGZtG3wGKRKksH	pay_TGZtgWxqSmKnot	2026-07-22 14:15:46.921385	order	\N
126	ORDER_1784731782835	RAZORPAY	1.00	PAID	order_TGaT81SDeZoNEG	pay_TGaTa6R4NQepeP	2026-07-22 14:49:44.363997	order	\N
127	ORDER_1785149514580	RAZORPAY	1.00	PENDING	order_TIV5WsofpgUWhM	\N	2026-07-27 10:51:56.076342	membership	2
128	ORDER_1785149515936	RAZORPAY	1.00	PENDING	order_TIV5XOc2Vjhlug	\N	2026-07-27 10:51:56.536808	membership	2
129	ORDER_1785149515749	RAZORPAY	1.00	PENDING	order_TIV5Y3fbxViKZJ	\N	2026-07-27 10:51:57.146668	membership	2
130	ORDER_1785224207382	RAZORPAY	1.00	PENDING	order_TIqIXaNMAzxF6G	\N	2026-07-28 07:36:49.027481	membership	1
131	ORDER_1785224215377	RAZORPAY	1.00	PENDING	order_TIqIgNN486qATo	\N	2026-07-28 07:36:57.085213	membership	1
132	ORDER_1785224291826	RAZORPAY	1.00	PENDING	order_TIqK1qgLX4zvTc	\N	2026-07-28 07:38:13.599217	order	\N
133	ORDER_1785232667392	RAZORPAY	1.00	PENDING	order_TIshTui07oLcSk	\N	2026-07-28 09:57:48.937348	membership	1
134	ORDER_1785232694249	RAZORPAY	1.00	PENDING	order_TIshx5FyCNXMnm	\N	2026-07-28 09:58:15.651997	membership	1
135	ORDER_1785232739214	RAZORPAY	1.00	PENDING	order_TIsikGIrcBApuJ	\N	2026-07-28 09:59:00.720194	membership	1
136	ORDER_1785237547747	RAZORPAY	1.00	PENDING	order_TIu5Otu5Las9KC	\N	2026-07-28 11:19:09.113856	membership	1
137	ORDER_1785237673691	RAZORPAY	1.00	PENDING	order_TIu7crMNxhDvWf	\N	2026-07-28 11:21:15.562078	membership	1
138	ORDER_1785237704707	RAZORPAY	1.00	PENDING	order_TIu8AMRYBmxqHl	\N	2026-07-28 11:21:46.305094	membership	1
139	ORDER_1785237996497	RAZORPAY	1.00	PENDING	order_TIuDIlylLS0Oy2	\N	2026-07-28 11:26:37.971943	membership	1
140	ORDER_1785239190965	RAZORPAY	1.00	PENDING	order_TIuYKy6gZ55Z58	\N	2026-07-28 11:46:32.793418	membership	1
141	ORDER_1785239199148	RAZORPAY	1.00	PENDING	order_TIuYTcp9sKmwTX	\N	2026-07-28 11:46:40.652539	membership	1
142	ORDER_1785240759132	RAZORPAY	1.00	PENDING	order_TIuzwO3YJcIJJa	\N	2026-07-28 12:12:40.677348	membership	1
143	ORDER_1785244309301	RAZORPAY	1.00	PENDING	order_TIw0SEXgJUoMa9	\N	2026-07-28 13:11:51.453485	membership	2
144	ORDER_1785310540437	RAZORPAY	1.00	PENDING	order_TJEoTmEjHNsZiG	\N	2026-07-29 07:35:41.9065	membership	1
145	ORDER_1785310678753	RAZORPAY	1.00	PENDING	order_TJEqukaNbJwojl	\N	2026-07-29 07:38:00.260019	order	\N
146	ORDER_1785315281646	RAZORPAY	1.00	PENDING	order_TJG9x1oKjddgml	\N	2026-07-29 08:54:43.116186	order	\N
147	ORDER_1785325632919	RAZORPAY	1.00	PENDING	order_TJJ6BwtwwDBJJa	\N	2026-07-29 11:47:14.469815	membership	1
148	ORDER_1785344928173	RAZORPAY	1.00	PENDING	order_TJOZtVbdBIq6gJ	\N	2026-07-29 17:08:49.644579	membership	1
149	ORDER_1785416155878	RAZORPAY	1.00	PENDING	order_TJintkzRx8m3CM	\N	2026-07-30 12:55:57.355911	order	\N
150	ORDER_1785425498654	RAZORPAY	1.00	PAID	order_TJlSNkQs4tpkfl	pay_TJlWFlNuLP4mXi	2026-07-30 15:31:40.050038	order	\N
151	ORDER_1785474945149	RAZORPAY	1.00	PENDING	order_TJzUuXWTLGCy6M	\N	2026-07-31 05:15:46.303275	membership	1
152	ORDER_1785475222588	RAZORPAY	1.00	PENDING	order_TJzZnZlEvAiV9k	\N	2026-07-31 05:20:24.017469	membership	4
153	ORDER_1785481257195	RAZORPAY	1.00	PENDING	order_TK1I2jSif9PVN0	\N	2026-07-31 07:00:58.627938	membership	5
154	ORDER_1785482805524	RAZORPAY	1.00	PENDING	order_TK1jJF4EK58ASI	\N	2026-07-31 07:26:47.39498	order	\N
155	ORDER_1785482807404	RAZORPAY	1.00	PENDING	order_TK1jJy65kxDye1	\N	2026-07-31 07:26:48.043549	order	\N
156	ORDER_1785484308557	RAZORPAY	1.00	PENDING	order_TK29lPvGEt4sCT	\N	2026-07-31 07:51:49.9819	membership	1
157	ORDER_1785484315321	RAZORPAY	1.00	PENDING	order_TK29skEYfMiqzZ	\N	2026-07-31 07:51:56.683347	membership	1
158	ORDER_1785487424965	RAZORPAY	1.00	PENDING	order_TK32deVZrrYH0p	\N	2026-07-31 08:43:46.905239	membership	1
159	ORDER_1785501354448	RAZORPAY	1.00	PAID	order_TK6zs28UKSsZDh	pay_TK70EAXB8UOlE9	2026-07-31 12:35:56.107818	membership	1
160	ORDER_1785560213240	RAZORPAY	1.00	PENDING	order_TKNi6jwoNzzMAi	\N	2026-08-01 04:56:54.62446	membership	1
161	ORDER_1785560479393	RAZORPAY	1.00	PAID	order_TKNmnGgZu2s1GF	pay_TKNp8PP7xbRwKc	2026-08-01 05:01:20.782884	membership	1
162	ORDER_1785561077392	RAZORPAY	1.00	PENDING	order_TKNxJyhd3qgi8O	\N	2026-08-01 05:11:18.748177	membership	1
163	ORDER_1785562143459	RAZORPAY	1.00	PENDING	order_TKOG5cOZHQdhx0	\N	2026-08-01 05:29:04.797871	membership	1
164	ORDER_1785562394515	RAZORPAY	1.00	PAID	order_TKOKVdoE96yDAn	pay_TKOKyqCbu59QRM	2026-08-01 05:33:15.848508	membership	2
165	ORDER_1785575527834	RAZORPAY	1.00	PENDING	order_TKS3jTsRexQtyn	\N	2026-08-01 09:12:09.428881	order	\N
166	ORDER_1785733740788	RAZORPAY	1.00	PAID	order_TLAz9u1DO537Ls	pay_TLAzYmxAFIrG9b	2026-08-03 05:09:02.242235	order	\N
167	ORDER_1785734400550	RAZORPAY	1.00	PAID	order_TLBAltf2QyoUnC	pay_TLBB22RJjBSW49	2026-08-03 05:20:01.90052	order	\N
168	ORDER_1785737985045	RAZORPAY	1.00	PENDING	order_TLCBsfDeeYwHGk	\N	2026-08-03 06:19:46.466814	membership	1
169	ORDER_1785758041749	RAZORPAY	1.00	PENDING	order_TLHsz3e9sQGThZ	\N	2026-08-03 11:54:02.794081	membership	1
170	ORDER_1785758045648	RAZORPAY	1.00	PENDING	order_TLHt2hFwP1hfUc	\N	2026-08-03 11:54:06.122156	membership	1
171	ORDER_1785758066089	RAZORPAY	1.00	PENDING	order_TLHtPYnPqjpNNg	\N	2026-08-03 11:54:27.06744	order	\N
172	ORDER_1785758095194	RAZORPAY	1.00	PENDING	order_TLHtvPRi65Xoof	\N	2026-08-03 11:54:56.244315	membership	1
173	ORDER_1785758170743	RAZORPAY	1.00	PENDING	order_TLHvFs5ocsNJ31	\N	2026-08-03 11:56:11.79262	membership	1
174	ORDER_1785758175582	RAZORPAY	1.00	PENDING	order_TLHvKlSCybyiPz	\N	2026-08-03 11:56:16.285763	membership	1
175	ORDER_1785758191501	RAZORPAY	1.00	PENDING	order_TLHvcTMxCcI5YM	\N	2026-08-03 11:56:32.500574	order	\N
176	ORDER_1785758744671	RAZORPAY	1.00	PENDING	order_TLI5MJXJ3PmItE	\N	2026-08-03 12:05:45.702647	membership	1
177	ORDER_1785758750925	RAZORPAY	1.00	PENDING	order_TLI5T7KA2xpsDY	\N	2026-08-03 12:05:51.930236	membership	1
178	ORDER_1785758760522	RAZORPAY	1.00	PENDING	order_TLI5dZ3Qn2AQej	\N	2026-08-03 12:06:01.500223	order	\N
179	ORDER_1785758778906	RAZORPAY	1.00	PENDING	order_TLI5xm8pyqDokQ	\N	2026-08-03 12:06:20.02287	membership	1
180	ORDER_1785759408822	RAZORPAY	1.00	PENDING	order_TLIH3GQUMvViz1	\N	2026-08-03 12:16:49.867058	membership	1
181	ORDER_1785759426900	RAZORPAY	1.00	PAID	order_TLIHNNO36VD7uF	pay_TLIHiHCCOQutxo	2026-08-03 12:17:08.285411	membership	5
182	ORDER_1785761475336	RAZORPAY	1.00	PENDING	order_TLIrQxCaZl5cGu	\N	2026-08-03 12:51:16.373231	order	\N
183	ORDER_1785761491069	RAZORPAY	1.00	PAID	order_TLIri6arnQ54at	pay_TLIs3pD3WPDYuV	2026-08-03 12:51:32.080423	membership	3
184	ORDER_1785818513843	RAZORPAY	1.00	PAID	order_TLZ3dKZQTwjQ0Q	pay_TLZ43WTrvqXx4a	2026-08-04 04:41:55.170911	membership	1
185	ORDER_1785821736783	RAZORPAY	667.60	PENDING	order_TLZyNppQbo62SQ	\N	2026-08-04 05:35:38.576981	order	\N
186	ORDER_1785821751083	RAZORPAY	667.60	PENDING	order_TLZycynO9ufG5g	\N	2026-08-04 05:35:52.440803	order	\N
187	36	RAZORPAY	500.00	PENDING	order_TLaHKSo9jVHmFe	\N	2026-08-04 05:53:36.272293	ORDER	\N
188	ORDER_1785824635696	RAZORPAY	667.60	PENDING	order_TLanPbDv9S3HwB	\N	2026-08-04 06:23:56.998985	order	\N
189	ORDER_1785824877189	RAZORPAY	667.60	PENDING	order_TLarfD6DBvNGV6	\N	2026-08-04 06:27:58.497967	order	\N
190	ORDER_1785824903902	RAZORPAY	667.60	PENDING	order_TLas8KGbFlqUwA	\N	2026-08-04 06:28:25.169963	order	\N
191	ORDER_1785825002047	RAZORPAY	667.60	PENDING	order_TLatrX2XPonz4G	\N	2026-08-04 06:30:03.395582	order	\N
192	ORDER_1785825972115	RAZORPAY	667.60	PENDING	order_TLbAwNHxlft52c	\N	2026-08-04 06:46:13.425423	order	\N
193	ORDER_1785825998761	RAZORPAY	667.60	PENDING	order_TLbBPRxEg58bCk	\N	2026-08-04 06:46:40.067117	membership	3
194	ORDER_1785826012217	RAZORPAY	667.60	PENDING	order_TLbBe9p2SBaT0Q	\N	2026-08-04 06:46:53.535402	membership	3
195	ORDER_1785826320415	RAZORPAY	667.60	PENDING	order_TLbH4jdfKp2yem	\N	2026-08-04 06:52:01.88728	membership	3
196	ORDER_1785826487854	RAZORPAY	667.60	PENDING	order_TLbK1FEEo3sh8i	\N	2026-08-04 06:54:49.086421	membership	3
197	ORDER_1785827993824	RAZORPAY	667.60	PENDING	order_TLbkXRmBXqOZRj	\N	2026-08-04 07:19:55.409587	membership	2
198	ORDER_1785828497598	RAZORPAY	1.00	PENDING	order_TLbtOrOaPfHYYy	\N	2026-08-04 07:28:18.779064	MEMBERSHIP	2
199	ORDER_1785828510836	RAZORPAY	1.00	PAID	order_TLbtd8nXJoIxzV	pay_TLbuTeIrrCd8ji	2026-08-04 07:28:31.860239	MEMBERSHIP	3
200	ORDER_1785832597824	RAZORPAY	1.00	PENDING	order_TLd3aNhar6JS0W	\N	2026-08-04 08:36:38.970953	MEMBERSHIP	1
201	ORDER_1785835320947	RAZORPAY	1.00	PAID	order_TLdpWcqwgKrqbs	pay_TLdqQmt2iBgZY7	2026-08-04 09:22:01.866614	MEMBERSHIP	2
202	48	RAZORPAY	500.00	PAID	order_TM3NZnscqtsWG2	pay_TM3NmB7qwB1QrW	2026-08-05 10:21:38.003648	ORDER	\N
203	59	RAZORPAY	500.00	PAID	order_TMAEl1VdOsYUWM	pay_TMAEwawcJ4Hwpt	2026-08-05 17:04:08.400251	ORDER	\N
204	59	RAZORPAY	500.00	PAID	order_TMALxE7bjEdKCE	pay_TMAM4SwvLMWpxO	2026-08-05 17:10:57.326824	ORDER	\N
205	29	RAZORPAY	500.00	PENDING	order_TMAVS8DwIff00P	\N	2026-08-05 17:19:56.9803	ORDER	\N
206	205	RAZORPAY	500.00	PAID	order_TMAWmYaWngZOt0	pay_TMAX1RAsneyc7M	2026-08-05 17:21:12.345018	ORDER	\N
207	60	RAZORPAY	500.00	PAID	order_TMAbNi8TD06clH	pay_TMAbXmGN62Q7Oz	2026-08-05 17:25:33.282852	ORDER	\N
208	61	RAZORPAY	500.00	PAID	order_TMB1pyZ0YFKZbK	pay_TMB1zNk1w4K0Sj	2026-08-05 17:50:36.205776	ORDER	\N
209	ORDER_1786020729910	RAZORPAY	698.00	PENDING	order_TMUTlLdEhQ98tV	\N	2026-08-06 12:52:11.333999	ORDER	\N
210	ORDER_1786089991670	RAZORPAY	1.00	PENDING	order_TMo99WVG7UGPmo	\N	2026-08-07 08:06:33.02776	MEMBERSHIP	1
211	ORDER_1786112452073	RAZORPAY	1.00	PENDING	order_TMuWZx4qgBWWkv	\N	2026-08-07 14:20:53.312805	MEMBERSHIP	1
212	ORDER_1786112507341	RAZORPAY	1.00	PAID	order_TMuXY1ySBtkNAV	pay_TMuXoc1GGtoXtk	2026-08-07 14:21:48.311303	MEMBERSHIP	1
213	ORDER_1786112949746	RAZORPAY	1.00	PAID	order_TMufKulcfzdXuX	pay_TMufYzW52cydIJ	2026-08-07 14:29:10.678715	MEMBERSHIP	1
214	ORDER_1786125212886	RAZORPAY	1.00	PAID	order_TMy9FAIaw1Q5ve	pay_TMy9lVHAXG1EbN	2026-08-07 17:53:34.294177	MEMBERSHIP	1
215	62	RAZORPAY	500.00	PAID	order_TNEwdniIOHdcsP	pay_TNEwpLNqdqaHdf	2026-08-08 10:19:27.721668	ORDER	\N
216	63	RAZORPAY	500.00	PAID	order_TNFNtjz34LGa0e	pay_TNFO1Wn7xC4ODK	2026-08-08 10:45:15.983202	ORDER	\N
217	11	RAZORPAY	500.00	PAID	order_TNFcJBwSW6AuQp	pay_TNFcUCCARK6GLK	2026-08-08 10:58:54.63505	ORDER	\N
218	63	RAZORPAY	500.00	PAID	order_TNFfyIIkDA6U2Y	pay_TNFg9W2XngBESA	2026-08-08 11:02:22.581259	ORDER	\N
219	64	RAZORPAY	500.00	PAID	order_TNFqieomGTrUtN	pay_TNFqqizifk3VVl	2026-08-08 11:12:32.998064	ORDER	\N
220	ORDER_1786357158489	RAZORPAY	648.00	PENDING	order_TO20lkBQFvX3EM	\N	2026-08-10 10:19:19.494043	ORDER	\N
221	ORDER_1786357490053	RAZORPAY	648.00	PAID	order_TO26bbKrjc0xbh	pay_TO276W3chMAbLd	2026-08-10 10:24:50.985117	ORDER	\N
222	ORDER_1786364806288	RAZORPAY	648.00	PAID	order_TO4BPcBIYKHPgS	pay_TO4Cn149XFkXla	2026-08-10 12:26:47.237247	ORDER	\N
223	ORDER_1786421885492	RAZORPAY	299.00	PAID	order_TOKOKXFJ7EVF9e	pay_TOKOd2UBgw96a3	2026-08-11 04:18:06.85093	ORDER	\N
224	ORDER_1786423957748	RAZORPAY	299.00	PAID	order_TOKyoSrVWyfkwe	pay_TOKz6g78GYDoNj	2026-08-11 04:52:39.066904	ORDER	\N
225	ORDER_1786424366532	RAZORPAY	299.00	PAID	order_TOL60cv8yla0oe	pay_TOL6J5ie56F5nv	2026-08-11 04:59:27.806488	ORDER	\N
226	ORDER_1786424527889	RAZORPAY	698.00	PENDING	order_TOL8qkq4kmFCh8	\N	2026-08-11 05:02:09.160717	ORDER	\N
227	ORDER_1786424541988	RAZORPAY	698.00	PAID	order_TOL96BKvGxy1YP	pay_TOL9PgjE04jcFr	2026-08-11 05:02:23.296285	ORDER	\N
228	ORDER_1786425100665	RAZORPAY	648.00	PAID	order_TOLIvyP2IDKAxj	pay_TOLJFzsy14hiFW	2026-08-11 05:11:41.944932	ORDER	\N
229	ORDER_1786427160226	RAZORPAY	648.00	PAID	order_TOLtC5kwSNXLKx	pay_TOLtWSx331CQeg	2026-08-11 05:46:01.523875	ORDER	\N
230	ORDER_1786428852006	RAZORPAY	648.00	PAID	order_TOMMyl0BdwcFcQ	pay_TOMNGjf88tn0JG	2026-08-11 06:14:13.31642	ORDER	\N
231	ORDER_1786473242063	RAZORPAY	648.00	PAID	order_TOYyUUTMQc39nr	pay_TOZ3V0MUFzXCZC	2026-08-11 18:34:03.387033	ORDER	\N
232	ORDER_1786473618529	RAZORPAY	648.00	PAID	order_TOZ57Sf6ipmjtH	pay_TOZ5JtZqTbp8ez	2026-08-11 18:40:19.884189	ORDER	\N
233	ORDER_1786510549757	RAZORPAY	1.00	PENDING	order_TOjZJgXE0Da8ye	\N	2026-08-12 04:55:51.240239	ORDER	\N
234	ORDER_1786510635854	RAZORPAY	1.00	PENDING	order_TOjapeqpoymMnb	\N	2026-08-12 04:57:17.315987	ORDER	\N
235	ORDER_1786510670010	RAZORPAY	1.00	PENDING	order_TOjbQskojC4dWK	\N	2026-08-12 04:57:51.418548	ORDER	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price, stock, image, weight, category_id, is_active) FROM stdin;
2	Groundnut Oil	349.00	155	groundnut.png	1.00	1	1
1	Sunflower Oil	299.00	175	sunflower.png	1.00	1	1
3	Coconut Oil	399.00	86	coconut.png	1.00	1	1
4	Sesame Oil	329.00	103	sesame.png	1.00	1	1
\.


--
-- Data for Name: subscription_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_plans (id, plan_name, plan_price, wallet_bonus, monthly_claim, discount_percentage, monthly_limit_litres, validity_months, description, is_active, display_order, created_at, updated_at) FROM stdin;
1	Basic	1599.00	1500.00	125.00	20	8	12	20% discount on up to 2 bottles once every month	t	1	2026-07-16 08:39:18.003336	2026-07-16 08:39:18.003336
2	Silver	2599.00	2400.00	200.00	25	8	12	25% discount on up to 3 bottles once every month	t	2	2026-07-16 08:39:18.003336	2026-07-16 08:39:18.003336
3	Gold	3599.00	3300.00	275.00	30	8	12	30% discount on up to 4 bottles once every month	t	3	2026-07-16 08:39:18.003336	2026-07-16 08:39:18.003336
5	Max Saver	5599.00	5100.00	425.00	40	8	12	40% discount on up to 6 bottles once every month	t	5	2026-07-16 08:39:18.003336	2026-08-11 16:05:31.254384
4	Platinum	4599.00	4200.00	350.00	35	8	12	35% discount on up to 5 bottles once every month	t	4	2026-07-16 08:39:18.003336	2026-08-11 16:13:37.724069
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_info (id, user_id, first_name, last_name, email, address, city, state, pincode, subscription) FROM stdin;
36	MGSA260802	Super	Admin	superadmin@gmail.com	Hyderabad	manikonda	telangana	852741	None
37	MGA260803	Admin	Managanuga	admin@gmail.com	Hyderabad	manikonda	telangana	852741	None
38	MGV260803	Vendor	Managanuga	vendor@gmail.com	Hyderabad	manikonda	telangana	852741	None
39	MGRS260803	Reseller	Managanuga	reseller@gmail.com	Hyderabad	manikonda	telangana	852741	None
40	MGC260806	Customer	Managanuga	customer@gmail.com	Hyderabad	manikonda	telangana	852741	None
42	MGC260808	sushma	reddy	Sh@gmail.com	Hyderabad	manikonda	telangana	852741	None
43	MGA260804	Admin2	Managanuga	admin2@gmail.com	Hyderabad	manikonda	telangana	852741	None
44	MGV260804	Vendor	Managanuga	vendor2@gmail.com	Hyderabad	manikonda	telangana	852741	None
45	MGRS260804	Reseller2	Managanuga	reseller2@gmail.com	Hyderabad	manikonda	telangana	852741	None
46	MGC260809	Customer2	Managanuga	customer2@gmail.com	Hyderabad	manikonda	telangana	852741	Basic
\.


--
-- Data for Name: user_login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_login (id, user_id, username, mobile_no, password, role, is_active, created_by, assigned_by, relationship_type, created_at) FROM stdin;
66	MGSA260802	superadmin@gmail.com	5555555555	SuperAdmin@2026	SUPER_ADMIN	t	SUPER_ADMIN	SUPER_ADMIN	SUPER_ADMIN	2026-08-12 05:16:45.306346
67	MGA260803	admin@gmail.com	4321567890	Admin@2026	ADMIN	t	SUPER_ADMIN	SUPER_ADMIN	ADMIN	2026-08-12 09:09:32.027977
68	MGV260803	vendor@gmail.com	3456789088	Vendor@2026	VENDOR	t	ADMIN	ADMIN	VENDOR	2026-08-12 09:13:41.238099
11	100	Vendor	9999999999	vendor123	VENDOR	t	\N	\N	\N	2026-08-05 05:49:27.324201
69	MGRS260803	reseller@gmail.com	6987453211	Reseller@2026	RESELLER	t	MGV260803	MGV260803	RESELLER	2026-08-12 09:27:02.558052
72	MGC260808	Sh@gmail.com	+919676268155	123456	CUSTOMER	t	SUPER_ADMIN	MGSA260802	CUSTOMER	2026-08-12 11:58:15.94182
70	MGC260806	customer@gmail.com	5678432100	Customer@2026	CUSTOMER	t	MGRS260803	MGRS260803	CUSTOMER	2026-08-12 09:38:26.899693
4	6	9701437141	9701437141	AEHH2CD1	USER	t	100	\N	\N	2026-07-31 05:18:34.265756
5	7	9676143767	9676143767	2OUCQM4G	USER	t	100	\N	\N	2026-07-31 07:20:00.159586
73	MGA260804	admin2@gmail.com	5678431111	123456	ADMIN	t	ADMIN	MGA260803	ADMIN	2026-08-12 12:12:16.624605
74	MGV260804	vendor2@gmail.com	5222431111	123456	VENDOR	t	VENDOR	MGV260803	VENDOR	2026-08-12 12:15:09.166355
16	001	Reseller	8888888888	Reseller123	RESELLER	t	\N	\N	\N	2026-08-07 05:51:10.761161
75	MGRS260804	reseller2@gmail.com	5222761111	123456	RESELLER	t	RESELLER	MGRS260803	RESELLER	2026-08-12 12:17:17.786712
76	MGC260809	Customer2 Managanuga	5999991111	5999991111	CUSTOMER	t	SUPER_ADMIN	\N	CUSTOMER	2026-08-12 12:19:11.84011
77	18	Test Customer A	9000000001	MGTest@1001	CUSTOMER	t	\N	\N	CUSTOMER	2026-08-12 12:45:03.83218
78	19	Test Customer B	9000000002	MGTest@1002	CUSTOMER	t	MGV260803	MGV260803	CUSTOMER	2026-08-12 12:45:03.83218
79	20	Test Customer C	9000000003	MGTest@1003	CUSTOMER	t	MGRS260803	MGRS260803	CUSTOMER	2026-08-12 12:45:03.83218
24	12	9014779142	9014779142	3VEX2ASD	USER	t	\N	\N	\N	2026-08-08 06:44:32.794264
80	21	Test Customer D	9000000004	MGTest@1004	CUSTOMER	t	MGRS260801	MGRS260801	CUSTOMER	2026-08-12 12:45:03.83218
62	16	BramhaKoti	9347499591	G7KEX8M7	CUSTOMER	t	\N	\N	\N	2026-08-11 07:55:42.417047
\.


--
-- Data for Name: user_memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_memberships (id, user_id, plan_id, payment_id, status, wallet_balance, discount_percent, monthly_claim, monthly_limit_litres, used_litres, start_date, expiry_date, created_at, updated_at, last_reset_date, monthly_claim_used, terms_and_conditions, assigned_by, assigned_role) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, mobile, created_at, role, fcm_token) FROM stdin;
7	9676143767	2026-07-31 07:20:00.153843	USER	\N
1	8888888888	2026-08-07 10:21:09.232764	RESELLER	\N
12	9014779142	2026-08-08 06:44:32.785523	USER	\N
16	9347499591	2026-08-11 07:55:42.407343	USER	cJaDR76RIUpWuCLE8D1Z7M:APA91bHT1R5-tYVLMDY4y8-coxkFTpTLUYspsavFql3lMLJQQKxXN6aZX710kqgj8XVnmJoPepMlpSDEXM_QdgFjlDvMDDrkAIvyPYW93z_VEKXaf2r5F60
17	5678432100	2026-08-12 12:16:26.14875	USER	\N
18	9000000001	2026-08-12 12:44:56.597457	CUSTOMER	\N
19	9000000002	2026-08-12 12:44:56.597457	CUSTOMER	\N
20	9000000003	2026-08-12 12:44:56.597457	CUSTOMER	\N
21	9000000004	2026-08-12 12:44:56.597457	CUSTOMER	\N
100	9999999999	2026-08-05 10:36:19.584133	VENDOR	cJaDR76RIUpWuCLE8D1Z7M:APA91bHT1R5-tYVLMDY4y8-coxkFTpTLUYspsavFql3lMLJQQKxXN6aZX710kqgj8XVnmJoPepMlpSDEXM_QdgFjlDvMDDrkAIvyPYW93z_VEKXaf2r5F60
6	9701437141	2026-07-31 05:18:34.262125	USER	cWp7BaijwEQfr9JninkLzm:APA91bERcC0UXAKlCV0QC-K8yAXBkAKbdixdADXgnwj-p2nCLaKnZfByIWrPXtHk3g7MFjQOJLWNWhLW6ax0_MVXpCtKG3f24zzohRRHw1irTO3RGvEVpo8
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, wallet_type, balance, created_at, updated_at) FROM stdin;
1	MGV260803	VENDOR	0.00	2026-08-12 09:51:44.450914	2026-08-12 09:51:44.450914
2	100	VENDOR	0.00	2026-08-12 09:51:44.450914	2026-08-12 09:51:44.450914
3	MGRS260803	RESELLER	0.00	2026-08-12 09:51:44.450914	2026-08-12 09:51:44.450914
4	001	RESELLER	0.00	2026-08-12 09:51:44.450914	2026-08-12 09:51:44.450914
\.


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warehouses (id, name, address, city, pincode, latitude, longitude, phone, created_at, contact_name, state) FROM stdin;
2	Balanagar Factory	Balanagar, Hyderabad	Hyderabad	\N	17.4725	78.4485	\N	2026-07-17 10:19:53.279502	\N	\N
3	Hitech City Warehouse	HITEC City, Hyderabad	Hyderabad	\N	17.4435	78.3772	\N	2026-07-17 10:19:53.279502	\N	\N
1	Himayatnagar Factory	Hitech city	Hyderabad	500081	17.4006	78.4867	9876543210	2026-07-17 10:19:53.279502	warehouse manager	Telangana
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, true);


--
-- Name: benefits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.benefits_id_seq', 1, false);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 80, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 3, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 41, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 118, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 82, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 235, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, true);


--
-- Name: subscription_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_plans_id_seq', 6, true);


--
-- Name: user_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_info_id_seq', 46, true);


--
-- Name: user_login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_login_id_seq', 80, true);


--
-- Name: user_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_memberships_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 21, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 8, true);


--
-- Name: warehouses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warehouses_id_seq', 3, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: benefits benefits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: subscription_plans subscription_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_plans
    ADD CONSTRAINT subscription_plans_pkey PRIMARY KEY (id);


--
-- Name: user_info user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (id);


--
-- Name: user_info user_info_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_user_id_key UNIQUE (user_id);


--
-- Name: user_login user_login_mobile_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_mobile_no_key UNIQUE (mobile_no);


--
-- Name: user_login user_login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_pkey PRIMARY KEY (id);


--
-- Name: user_login user_login_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_user_id_key UNIQUE (user_id);


--
-- Name: user_login user_login_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_username_key UNIQUE (username);


--
-- Name: user_memberships user_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_memberships
    ADD CONSTRAINT user_memberships_pkey PRIMARY KEY (id);


--
-- Name: users users_mobile_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mobile_key UNIQUE (mobile);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_unique UNIQUE (user_id);


--
-- Name: warehouses warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (id);


--
-- Name: benefits benefits_beneficiary_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_beneficiary_fk FOREIGN KEY (beneficiary_id) REFERENCES public.user_login(user_id) ON DELETE CASCADE;


--
-- Name: benefits benefits_customer_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_customer_fk FOREIGN KEY (customer_id) REFERENCES public.user_login(user_id) ON DELETE CASCADE;


--
-- Name: benefits benefits_membership_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_membership_fk FOREIGN KEY (membership_id) REFERENCES public.user_memberships(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.products(id);


--
-- Name: orders fk_order_address; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_address FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: products fk_products_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: user_info fk_user_info; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT fk_user_info FOREIGN KEY (user_id) REFERENCES public.user_login(user_id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(id);


--
-- Name: wallets wallets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_login(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict DpVdQZlz4ojNiXYzugc88oTiVfCivgk2dyS9KMxLQuZDKZtAJZL408fAFjDbHLO

