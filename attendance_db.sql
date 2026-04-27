--
-- PostgreSQL database dump
--

\restrict ijRO0CyzNMR3F5uQLIkInLGe4qOHXhDD0Y8LnoSHh4TZNOanaRYm0JGJhnlx09C

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-03-27 14:43:11

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
-- TOC entry 865 (class 1247 OID 16662)
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
-- TOC entry 862 (class 1247 OID 16656)
-- Name: classtype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.classtype AS ENUM (
    'school',
    'work'
);


ALTER TYPE public.classtype OWNER TO postgres;

--
-- TOC entry 859 (class 1247 OID 16646)
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
-- TOC entry 226 (class 1259 OID 16729)
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
-- TOC entry 225 (class 1259 OID 16728)
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
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 225
-- Name: attendancerecord_attendanceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendancerecord_attendanceid_seq OWNED BY public.attendancerecord.attendanceid;


--
-- TOC entry 222 (class 1259 OID 16687)
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
-- TOC entry 221 (class 1259 OID 16686)
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
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 221
-- Name: classes_classid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_classid_seq OWNED BY public.classes.classid;


--
-- TOC entry 224 (class 1259 OID 16706)
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
-- TOC entry 223 (class 1259 OID 16705)
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
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 223
-- Name: enrollment_enrollmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_enrollmentid_seq OWNED BY public.enrollment.enrollmentid;


--
-- TOC entry 220 (class 1259 OID 16672)
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
-- TOC entry 219 (class 1259 OID 16671)
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
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- TOC entry 4884 (class 2604 OID 16732)
-- Name: attendancerecord attendanceid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord ALTER COLUMN attendanceid SET DEFAULT nextval('public.attendancerecord_attendanceid_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 16690)
-- Name: classes classid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN classid SET DEFAULT nextval('public.classes_classid_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 16709)
-- Name: enrollment enrollmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment ALTER COLUMN enrollmentid SET DEFAULT nextval('public.enrollment_enrollmentid_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16675)
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- TOC entry 5057 (class 0 OID 16729)
-- Dependencies: 226
-- Data for Name: attendancerecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendancerecord (attendanceid, userid, classid, meetdate, attendance, recorder) FROM stdin;
\.


--
-- TOC entry 5053 (class 0 OID 16687)
-- Dependencies: 222
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (classid, classname, classdesc, category, creator) FROM stdin;
\.


--
-- TOC entry 5055 (class 0 OID 16706)
-- Dependencies: 224
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (enrollmentid, userid, classid, enrolledat) FROM stdin;
\.


--
-- TOC entry 5051 (class 0 OID 16672)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, username, firstname, lastname, password, usertype) FROM stdin;
1	yrodri47	Yazmin	Rodriguez	password	student
\.


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 225
-- Name: attendancerecord_attendanceid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendancerecord_attendanceid_seq', 1, false);


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 221
-- Name: classes_classid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_classid_seq', 1, false);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 223
-- Name: enrollment_enrollmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_enrollmentid_seq', 1, false);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 1, true);


--
-- TOC entry 4896 (class 2606 OID 16740)
-- Name: attendancerecord attendancerecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_pkey PRIMARY KEY (attendanceid);


--
-- TOC entry 4890 (class 2606 OID 16699)
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (classid);


--
-- TOC entry 4892 (class 2606 OID 16715)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (enrollmentid);


--
-- TOC entry 4894 (class 2606 OID 16717)
-- Name: enrollment enrollment_userid_classid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_userid_classid_key UNIQUE (userid, classid);


--
-- TOC entry 4886 (class 2606 OID 16683)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 4888 (class 2606 OID 16685)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4900 (class 2606 OID 16746)
-- Name: attendancerecord attendancerecord_classid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_classid_fkey FOREIGN KEY (classid) REFERENCES public.classes(classid) ON DELETE CASCADE;


--
-- TOC entry 4901 (class 2606 OID 16751)
-- Name: attendancerecord attendancerecord_recorder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_recorder_fkey FOREIGN KEY (recorder) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 4902 (class 2606 OID 16741)
-- Name: attendancerecord attendancerecord_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendancerecord
    ADD CONSTRAINT attendancerecord_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 4897 (class 2606 OID 16700)
-- Name: classes classes_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_creator_fkey FOREIGN KEY (creator) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 4898 (class 2606 OID 16723)
-- Name: enrollment enrollment_classid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_classid_fkey FOREIGN KEY (classid) REFERENCES public.classes(classid) ON DELETE CASCADE;


--
-- TOC entry 4899 (class 2606 OID 16718)
-- Name: enrollment enrollment_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


-- Completed on 2026-03-27 14:43:11

--
-- PostgreSQL database dump complete
--

\unrestrict ijRO0CyzNMR3F5uQLIkInLGe4qOHXhDD0Y8LnoSHh4TZNOanaRYm0JGJhnlx09C

