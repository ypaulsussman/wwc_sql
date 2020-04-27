--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: findings; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.findings (
    id integer NOT NULL,
    study_review_id integer,
    intervention_id integer,
    comparison text,
    outcomemeasureid integer,
    outcome_measure text,
    period text,
    sample_description text,
    is_subgroup boolean,
    outcome_sample_size integer,
    outcome_measure_intervention_sample_size double precision,
    outcome_measure_comparison_sample_size double precision,
    intervention_clusters_sample_size integer,
    comparison_clusters_sample_size integer,
    intervention_mean double precision,
    comparison_mean double precision,
    intervention_standard_deviation double precision,
    comparison_standard_deviation double precision,
    effect_size_study double precision,
    effect_size_wwc double precision,
    improvement_index double precision,
    p_value_study double precision,
    p_value_wwc double precision,
    icc double precision,
    clusters_total double precision,
    is_statistically_significant boolean,
    finding_rating text,
    essa_rating text,
    l1_unit_of_analysis text,
    outcome_domain_id integer
);


ALTER TABLE public.findings OWNER TO ypaulsussman;

--
-- Name: intervention_reports; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.intervention_reports (
    intervention_id integer,
    numstudiesmeetingstandards integer,
    numstudieseligible integer,
    intervention_page_url text,
    sample_size_intervention integer,
    effectiveness_rating text,
    id integer NOT NULL,
    protocol_id integer,
    outcome_domain_id integer
);


ALTER TABLE public.intervention_reports OWNER TO ypaulsussman;

--
-- Name: intervention_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.intervention_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intervention_reports_id_seq OWNER TO ypaulsussman;

--
-- Name: intervention_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.intervention_reports_id_seq OWNED BY public.intervention_reports.id;


--
-- Name: interventions; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.interventions (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.interventions OWNER TO ypaulsussman;

--
-- Name: outcome_domains; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.outcome_domains (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.outcome_domains OWNER TO ypaulsussman;

--
-- Name: outcome_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.outcome_domains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.outcome_domains_id_seq OWNER TO ypaulsussman;

--
-- Name: outcome_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.outcome_domains_id_seq OWNED BY public.outcome_domains.id;


--
-- Name: protocols; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.protocols (
    id integer NOT NULL,
    name text NOT NULL,
    version numeric(5,2) NOT NULL
);


ALTER TABLE public.protocols OWNER TO ypaulsussman;

--
-- Name: protocols_id_seq; Type: SEQUENCE; Schema: public; Owner: ypaulsussman
--

CREATE SEQUENCE public.protocols_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protocols_id_seq OWNER TO ypaulsussman;

--
-- Name: protocols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ypaulsussman
--

ALTER SEQUENCE public.protocols_id_seq OWNED BY public.protocols.id;


--
-- Name: study_reviews; Type: TABLE; Schema: public; Owner: ypaulsussman
--

CREATE TABLE public.study_reviews (
    id integer NOT NULL,
    standards_version text,
    citation text,
    study_design text,
    study_rating text,
    class_type_general boolean,
    class_type_inclusion boolean,
    delivery_method_individual boolean,
    delivery_method_school boolean,
    delivery_method_small_group boolean,
    delivery_method_whole_class boolean,
    demographics_of_study_sample_english_language_learners numeric(5,2),
    demographics_of_study_sample_free_or_reduced_price_lunch numeric(5,2),
    demographics_of_study_sample_international numeric(5,2),
    demographics_of_study_sample_students_with_disabilities numeric(5,2),
    ethnicity_hispanic numeric(5,2),
    ethnicity_not_hispanic numeric(5,2),
    gender_female numeric(5,2),
    gender_male numeric(5,2),
    grade_1 boolean,
    grade_10 boolean,
    grade_11 boolean,
    grade_12 boolean,
    grade_2 boolean,
    grade_3 boolean,
    grade_4 boolean,
    grade_5 boolean,
    grade_6 boolean,
    grade_7 boolean,
    grade_8 boolean,
    grade_9 boolean,
    grade_k boolean,
    grade_pk boolean,
    grade_ps boolean,
    program_type_curriculum boolean,
    program_type_policy boolean,
    program_type_practice boolean,
    program_type_school_level boolean,
    program_type_supplement boolean,
    program_type_teacher_level boolean,
    race_asian numeric(5,2),
    race_black numeric(5,2),
    race_native_american numeric(5,2),
    race_other numeric(5,2),
    race_pacific_islander numeric(5,2),
    race_white numeric(5,2),
    region_state_alabama boolean,
    region_state_alaska boolean,
    region_state_arizona boolean,
    region_state_arkansas boolean,
    region_state_california boolean,
    region_state_colorado boolean,
    region_state_connecticut boolean,
    region_state_delaware boolean,
    region_state_district_of_columbia boolean,
    region_state_florida boolean,
    region_state_georgia boolean,
    region_state_hawaii boolean,
    region_state_idaho boolean,
    region_state_illinois boolean,
    region_state_indiana boolean,
    region_state_iowa boolean,
    region_state_kansas boolean,
    region_state_kentucky boolean,
    region_state_louisiana boolean,
    region_state_maine boolean,
    region_state_maryland boolean,
    region_state_massachusetts boolean,
    region_state_michigan boolean,
    region_state_midwest boolean,
    region_state_minnesota boolean,
    region_state_mississippi boolean,
    region_state_missouri boolean,
    region_state_montana boolean,
    region_state_nebraska boolean,
    region_state_nevada boolean,
    region_state_new_hampshire boolean,
    region_state_new_jersey boolean,
    region_state_new_mexico boolean,
    region_state_new_york boolean,
    region_state_north_carolina boolean,
    region_state_north_dakota boolean,
    region_state_northeast boolean,
    region_state_ohio boolean,
    region_state_oklahoma boolean,
    region_state_oregon boolean,
    region_state_pennsylvania boolean,
    region_state_rhode_island boolean,
    region_state_south boolean,
    region_state_south_carolina boolean,
    region_state_south_dakota boolean,
    region_state_tennessee boolean,
    region_state_texas boolean,
    region_state_utah boolean,
    region_state_vermont boolean,
    region_state_virginia boolean,
    region_state_washington boolean,
    region_state_west boolean,
    region_state_west_virginia boolean,
    region_state_wisconsin boolean,
    region_state_wyoming boolean,
    school_type_charter boolean,
    school_type_parochial boolean,
    school_type_private boolean,
    school_type_public boolean,
    urbanicity_rural boolean,
    urbanicity_suburban boolean,
    urbanicity_urban boolean,
    studyid integer,
    publication text,
    publication_date text,
    productid integer,
    product_name text,
    purpose_of_review text,
    study_page_url text,
    rating_reason text,
    ineligibility_reason text,
    intervention_id integer,
    ericid text,
    us_region_u_s__region text,
    disability_autism_spectrum_disorder numeric(5,2),
    school_setting_student_count integer,
    disability_individualized_education_plan__iep_ numeric(5,2),
    demographics_of_study_sample_minority numeric(5,2),
    demographics_of_study_sample_non_minority numeric(5,2),
    revieweddate timestamp without time zone,
    multisite text,
    topic_literacy boolean,
    topic_mathematics boolean,
    topic_science boolean,
    topic_behavior boolean,
    topic_swd boolean,
    topic_ell boolean,
    topic_teacher_excellence boolean,
    topic_charter_schools boolean,
    topic_early_childhood boolean,
    topic_k_to_12th_grade boolean,
    topic_path_to_graduation boolean,
    topic_postsecondary boolean,
    posting_date date,
    protocol_id integer
);


ALTER TABLE public.study_reviews OWNER TO ypaulsussman;

--
-- Name: intervention_reports id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports ALTER COLUMN id SET DEFAULT nextval('public.intervention_reports_id_seq'::regclass);


--
-- Name: outcome_domains id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.outcome_domains ALTER COLUMN id SET DEFAULT nextval('public.outcome_domains_id_seq'::regclass);


--
-- Name: protocols id; Type: DEFAULT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.protocols ALTER COLUMN id SET DEFAULT nextval('public.protocols_id_seq'::regclass);


--
-- Name: findings findings_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_pkey PRIMARY KEY (id);


--
-- Name: intervention_reports intervention_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports
    ADD CONSTRAINT intervention_reports_pkey PRIMARY KEY (id);


--
-- Name: interventions interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_pkey PRIMARY KEY (id);


--
-- Name: outcome_domains outcome_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.outcome_domains
    ADD CONSTRAINT outcome_domains_pkey PRIMARY KEY (id);


--
-- Name: protocols protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.protocols
    ADD CONSTRAINT protocols_pkey PRIMARY KEY (id);


--
-- Name: study_reviews studies_pkey; Type: CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.study_reviews
    ADD CONSTRAINT studies_pkey PRIMARY KEY (id);


--
-- Name: study_reviews constraint_fk_interventions; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.study_reviews
    ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: findings constraint_fk_interventions; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: intervention_reports constraint_fk_interventions; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports
    ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: findings constraint_fk_outcome_domains; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT constraint_fk_outcome_domains FOREIGN KEY (outcome_domain_id) REFERENCES public.outcome_domains(id);


--
-- Name: intervention_reports constraint_fk_outcome_domains; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports
    ADD CONSTRAINT constraint_fk_outcome_domains FOREIGN KEY (outcome_domain_id) REFERENCES public.outcome_domains(id);


--
-- Name: study_reviews constraint_fk_protocols; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.study_reviews
    ADD CONSTRAINT constraint_fk_protocols FOREIGN KEY (protocol_id) REFERENCES public.protocols(id);


--
-- Name: intervention_reports constraint_fk_protocols; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.intervention_reports
    ADD CONSTRAINT constraint_fk_protocols FOREIGN KEY (protocol_id) REFERENCES public.protocols(id);


--
-- Name: findings constraint_fk_studies; Type: FK CONSTRAINT; Schema: public; Owner: ypaulsussman
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT constraint_fk_studies FOREIGN KEY (study_review_id) REFERENCES public.study_reviews(id);


--
-- PostgreSQL database dump complete
--

