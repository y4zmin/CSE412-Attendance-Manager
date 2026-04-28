--
-- PostgreSQL database dump
--

\restrict AClIJk5MY0SPFYzyn1vTrfdVbWG6KvU15ebjSU38SApNVXT7kFgnmafksQW9Wg9

-- Dumped from database version 14.20 (Homebrew)
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-04 14:04:36 MST

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: hrishiresham
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO hrishiresham;

--
-- TOC entry 829 (class 1247 OID 16575)
-- Name: attendancetype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.attendancetype AS ENUM (
    'present',
    'absent',
    'late',
    'excused'
);


ALTER TYPE public.attendancetype OWNER TO postgres;

--
-- TOC entry 832 (class 1247 OID 16584)
-- Name: classtype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.classtype AS ENUM (
    'school',
    'work'
);


ALTER TYPE public.classtype OWNER TO postgres;

--
-- TOC entry 835 (class 1247 OID 16590)
-- Name: usertype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.usertype AS ENUM (
    'student',
    'teacher',
    'employee',
    'manager'
);


ALTER TYPE public.usertype OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16599)
-- Name: attendancerecord; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendancerecord (
    attendanceid integer NOT NULL,
    userid integer NOT NULL,
    classid integer NOT NULL,
    meetdate date NOT NULL,
    attendance public.attendancetype NOT NULL,
    recorder integer NOT NULL
);


ALTER TABLE public.attendancerecord OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16602)
-- Name: attendancerecord_attendanceid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendancerecord_attendanceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendancerecord_attendanceid_seq OWNER TO postgres;

--
-- TOC entry 3860 (class 0 OID 0)
-- Dependencies: 210
-- Name: attendancerecord_attendanceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendancerecord_attendanceid_seq OWNED BY public.attendancerecord.attendanceid;


--
-- TOC entry 211 (class 1259 OID 16603)
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    classid integer NOT NULL,
    classname character varying(20) NOT NULL,
    classdesc text NOT NULL,
    category public.classtype NOT NULL,
    creator integer NOT NULL
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16608)
-- Name: classes_classid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_classid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classes_classid_seq OWNER TO postgres;

--
-- TOC entry 3861 (class 0 OID 0)
-- Dependencies: 212
-- Name: classes_classid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_classid_seq OWNED BY public.classes.classid;


--
-- TOC entry 213 (class 1259 OID 16609)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    enrollmentid integer NOT NULL,
    userid integer NOT NULL,
    classid integer NOT NULL,
    enrolledat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16613)
-- Name: enrollment_enrollmentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_enrollmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_enrollmentid_seq OWNER TO postgres;

--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 214
-- Name: enrollment_enrollmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_enrollmentid_seq OWNED BY public.enrollment.enrollmentid;


--
-- TOC entry 215 (class 1259 OID 16614)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(10) NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    password character varying(8) NOT NULL,
    usertype public.usertype NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16617)
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO postgres;

--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- TOC entry 3684 (class 2604 OID 16618)
-- Name: attendancerecord attendanceid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord ALTER COLUMN attendanceid SET DEFAULT nextval('public.attendancerecord_attendanceid_seq'::regclass);


--
-- TOC entry 3685 (class 2604 OID 16619)
-- Name: classes classid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN classid SET DEFAULT nextval('public.classes_classid_seq'::regclass);


--
-- TOC entry 3686 (class 2604 OID 16620)
-- Name: enrollment enrollmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment ALTER COLUMN enrollmentid SET DEFAULT nextval('public.enrollment_enrollmentid_seq'::regclass);


--
-- TOC entry 3688 (class 2604 OID 16621)
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- TOC entry 3846 (class 0 OID 16599)
-- Dependencies: 209
-- Data for Name: attendancerecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendancerecord (attendanceid, userid, classid, meetdate, attendance, recorder) FROM stdin;
1	1	1	2026-01-13	present	2
2	4	1	2026-01-13	present	2
3	5	1	2026-01-13	late	2
4	8	1	2026-01-13	present	2
5	1	1	2026-01-15	absent	2
6	4	1	2026-01-15	present	2
7	5	1	2026-01-15	present	2
8	8	1	2026-01-15	excused	2
9	4	2	2026-01-14	present	2
10	5	2	2026-01-14	present	2
11	6	2	2026-01-14	absent	2
12	4	2	2026-01-16	late	2
13	5	2	2026-01-16	present	2
14	6	2	2026-01-16	present	2
15	1	3	2026-01-13	present	3
16	5	3	2026-01-13	present	3
17	7	3	2026-01-13	late	3
18	9	3	2026-01-13	present	3
19	1	3	2026-01-15	present	3
20	5	3	2026-01-15	absent	3
21	7	3	2026-01-15	present	3
22	9	3	2026-01-15	excused	3
23	6	4	2026-01-14	present	3
24	7	4	2026-01-14	present	3
25	8	4	2026-01-14	absent	3
26	9	4	2026-01-14	present	3
27	6	4	2026-01-16	present	3
28	7	4	2026-01-16	late	3
29	8	4	2026-01-16	present	3
30	9	4	2026-01-16	present	3
\.


--
-- TOC entry 3848 (class 0 OID 16603)
-- Dependencies: 211
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (classid, classname, classdesc, category, creator) FROM stdin;
1	CSE412	Database Management	school	2
2	CSE355	Intro to Theoretical CS	school	2
3	MAT267	Calculus for Engineers	school	3
4	PHY121	University Physics I	school	3
\.


--
-- TOC entry 3850 (class 0 OID 16609)
-- Dependencies: 213
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (enrollmentid, userid, classid, enrolledat) FROM stdin;
1	1	1	2026-04-04 13:59:39.693774
2	1	3	2026-04-04 13:59:39.693774
3	4	1	2026-04-04 13:59:39.693774
4	4	2	2026-04-04 13:59:39.693774
5	5	1	2026-04-04 13:59:39.693774
6	5	2	2026-04-04 13:59:39.693774
7	5	3	2026-04-04 13:59:39.693774
8	6	2	2026-04-04 13:59:39.693774
9	6	4	2026-04-04 13:59:39.693774
10	7	3	2026-04-04 13:59:39.693774
11	7	4	2026-04-04 13:59:39.693774
12	8	1	2026-04-04 13:59:39.693774
13	8	4	2026-04-04 13:59:39.693774
14	9	3	2026-04-04 13:59:39.693774
15	9	4	2026-04-04 13:59:39.693774
\.


--
-- TOC entry 3852 (class 0 OID 16614)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, username, firstname, lastname, password, usertype) FROM stdin;
1	yrodri47	Yazmin	Rodriguez	password	student
2	jsmith12	Jake	Smith	pass1234	teacher
3	mlopez09	Maria	Lopez	pass1234	teacher
4	kpatel55	Kiran	Patel	pass1234	student
5	ajones88	Aiden	Jones	pass1234	student
6	tnguyen03	Tina	Nguyen	pass1234	student
7	bwilson22	Brian	Wilson	pass1234	student
8	cgarcia77	Carla	Garcia	pass1234	student
9	dlee19	David	Lee	pass1234	student
10	ekim45	Emily	Kim	pass1234	student
\.


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 210
-- Name: attendancerecord_attendanceid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendancerecord_attendanceid_seq', 30, true);


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 212
-- Name: classes_classid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_classid_seq', 4, true);


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 214
-- Name: enrollment_enrollmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_enrollmentid_seq', 15, true);


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 10, true);


--
-- TOC entry 3690 (class 2606 OID 16623)
-- Name: attendancerecord attendancerecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_pkey PRIMARY KEY (attendanceid);


--
-- TOC entry 3692 (class 2606 OID 16625)
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (classid);


--
-- TOC entry 3694 (class 2606 OID 16627)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (enrollmentid);


--
-- TOC entry 3696 (class 2606 OID 16629)
-- Name: enrollment enrollment_userid_classid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_userid_classid_key UNIQUE (userid, classid);


--
-- TOC entry 3698 (class 2606 OID 16631)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 3700 (class 2606 OID 16633)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3701 (class 2606 OID 16634)
-- Name: attendancerecord attendancerecord_classid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_classid_fkey FOREIGN KEY (classid) REFERENCES public.classes(classid) ON DELETE CASCADE;


--
-- TOC entry 3702 (class 2606 OID 16639)
-- Name: attendancerecord attendancerecord_recorder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_recorder_fkey FOREIGN KEY (recorder) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 3703 (class 2606 OID 16644)
-- Name: attendancerecord attendancerecord_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 3704 (class 2606 OID 16649)
-- Name: classes classes_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_creator_fkey FOREIGN KEY (creator) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 3705 (class 2606 OID 16654)
-- Name: enrollment enrollment_classid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_classid_fkey FOREIGN KEY (classid) REFERENCES public.classes(classid) ON DELETE CASCADE;


--
-- TOC entry 3706 (class 2606 OID 16659)
-- Name: enrollment enrollment_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 3859 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: hrishiresham
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2026-04-04 14:04:36 MST

--
-- PostgreSQL database dump complete
--

\unrestrict AClIJk5MY0SPFYzyn1vTrfdVbWG6KvU15ebjSU38SApNVXT7kFgnmafksQW9Wg9

