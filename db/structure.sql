SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timers_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.timers_status AS ENUM (
    'pending',
    'in_progress',
    'paused',
    'expired',
    'canceled'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    team_id bigint,
    tournament_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups (
    id bigint NOT NULL,
    name character varying NOT NULL,
    tournament_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    id bigint NOT NULL,
    team_one_id integer NOT NULL,
    team_two_id integer NOT NULL,
    team_one_score integer DEFAULT 0 NOT NULL,
    team_two_score integer DEFAULT 0 NOT NULL,
    tournament_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    duration integer DEFAULT 720 NOT NULL
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: playing_spaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playing_spaces (
    id bigint NOT NULL,
    name character varying NOT NULL,
    tournament_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: playing_spaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.playing_spaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playing_spaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.playing_spaces_id_seq OWNED BY public.playing_spaces.id;


--
-- Name: registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registrations (
    id bigint NOT NULL,
    team_id bigint,
    user_id bigint,
    enrollment_id bigint,
    status integer DEFAULT 2,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registrations_id_seq OWNED BY public.registrations.id;


--
-- Name: rosters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rosters (
    id bigint NOT NULL,
    player_id bigint,
    team_id bigint,
    role integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rosters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rosters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rosters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rosters_id_seq OWNED BY public.rosters.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    logo character varying,
    player_count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: timers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.timers (
    id bigint NOT NULL,
    jid character varying,
    expires_at timestamp without time zone,
    match_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status public.timers_status DEFAULT 'pending'::public.timers_status,
    paused_with double precision
);


--
-- Name: timers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.timers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: timers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.timers_id_seq OWNED BY public.timers.id;


--
-- Name: tournament_staffs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tournament_staffs (
    id bigint NOT NULL,
    user_id bigint,
    tournament_id bigint,
    role integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tournament_staffs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tournament_staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tournament_staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tournament_staffs_id_seq OWNED BY public.tournament_staffs.id;


--
-- Name: tournaments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tournaments (
    id bigint NOT NULL,
    name character varying,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    registration_start_date timestamp without time zone,
    registration_end_date timestamp without time zone,
    description text,
    team_cap integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying DEFAULT 'USD'::character varying NOT NULL
);


--
-- Name: tournaments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tournaments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tournaments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tournaments_id_seq OWNED BY public.tournaments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first character varying,
    last character varying,
    nickname character varying,
    dob character varying,
    phone character varying,
    gender character varying,
    email character varying,
    bio text,
    avatar character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_digest character varying,
    stripe_customer_id character varying(51)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: playing_spaces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playing_spaces ALTER COLUMN id SET DEFAULT nextval('public.playing_spaces_id_seq'::regclass);


--
-- Name: registrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations ALTER COLUMN id SET DEFAULT nextval('public.registrations_id_seq'::regclass);


--
-- Name: rosters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rosters ALTER COLUMN id SET DEFAULT nextval('public.rosters_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: timers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.timers ALTER COLUMN id SET DEFAULT nextval('public.timers_id_seq'::regclass);


--
-- Name: tournament_staffs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournament_staffs ALTER COLUMN id SET DEFAULT nextval('public.tournament_staffs_id_seq'::regclass);


--
-- Name: tournaments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournaments ALTER COLUMN id SET DEFAULT nextval('public.tournaments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: playing_spaces playing_spaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playing_spaces
    ADD CONSTRAINT playing_spaces_pkey PRIMARY KEY (id);


--
-- Name: registrations registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: rosters rosters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rosters
    ADD CONSTRAINT rosters_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: timers timers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.timers
    ADD CONSTRAINT timers_pkey PRIMARY KEY (id);


--
-- Name: tournament_staffs tournament_staffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournament_staffs
    ADD CONSTRAINT tournament_staffs_pkey PRIMARY KEY (id);


--
-- Name: tournaments tournaments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_enrollments_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_team_id ON public.enrollments USING btree (team_id);


--
-- Name: index_enrollments_on_tournament_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_tournament_id ON public.enrollments USING btree (tournament_id);


--
-- Name: index_groups_on_tournament_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_groups_on_tournament_id ON public.groups USING btree (tournament_id);


--
-- Name: index_matches_on_team_one_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_matches_on_team_one_id ON public.matches USING btree (team_one_id);


--
-- Name: index_matches_on_team_two_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_matches_on_team_two_id ON public.matches USING btree (team_two_id);


--
-- Name: index_matches_on_tournament_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_matches_on_tournament_id ON public.matches USING btree (tournament_id);


--
-- Name: index_playing_spaces_on_tournament_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_playing_spaces_on_tournament_id ON public.playing_spaces USING btree (tournament_id);


--
-- Name: index_registrations_on_enrollment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_enrollment_id ON public.registrations USING btree (enrollment_id);


--
-- Name: index_registrations_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_team_id ON public.registrations USING btree (team_id);


--
-- Name: index_registrations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_user_id ON public.registrations USING btree (user_id);


--
-- Name: index_rosters_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rosters_on_player_id ON public.rosters USING btree (player_id);


--
-- Name: index_rosters_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rosters_on_team_id ON public.rosters USING btree (team_id);


--
-- Name: index_timers_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_timers_on_match_id ON public.timers USING btree (match_id);


--
-- Name: index_timers_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_timers_on_status ON public.timers USING btree (status);


--
-- Name: index_tournament_staffs_on_tournament_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tournament_staffs_on_tournament_id ON public.tournament_staffs USING btree (tournament_id);


--
-- Name: index_tournament_staffs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tournament_staffs_on_user_id ON public.tournament_staffs USING btree (user_id);


--
-- Name: enrollments fk_rails_1113cafab7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_rails_1113cafab7 FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);


--
-- Name: groups fk_rails_1a66c2460d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_rails_1a66c2460d FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);


--
-- Name: playing_spaces fk_rails_1f40cfa305; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playing_spaces
    ADD CONSTRAINT fk_rails_1f40cfa305 FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);


--
-- Name: registrations fk_rails_2e0658f554; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT fk_rails_2e0658f554 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tournament_staffs fk_rails_446bd3b1b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournament_staffs
    ADD CONSTRAINT fk_rails_446bd3b1b4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: rosters fk_rails_51ff61356a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rosters
    ADD CONSTRAINT fk_rails_51ff61356a FOREIGN KEY (player_id) REFERENCES public.users(id);


--
-- Name: matches fk_rails_700eaa2935; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_700eaa2935 FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);


--
-- Name: registrations fk_rails_8cb8121b74; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT fk_rails_8cb8121b74 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: registrations fk_rails_a02ebd55aa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT fk_rails_a02ebd55aa FOREIGN KEY (enrollment_id) REFERENCES public.enrollments(id);


--
-- Name: tournament_staffs fk_rails_bcd01678fd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tournament_staffs
    ADD CONSTRAINT fk_rails_bcd01678fd FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id);


--
-- Name: enrollments fk_rails_e6c7302600; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_rails_e6c7302600 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: timers fk_rails_f795a19d26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.timers
    ADD CONSTRAINT fk_rails_f795a19d26 FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: rosters fk_rails_f86e1a5aa2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rosters
    ADD CONSTRAINT fk_rails_f86e1a5aa2 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO myapp,sharedapp,public;

INSERT INTO "schema_migrations" (version) VALUES
('20180610223406'),
('20180610223522'),
('20180610223621'),
('20180610223938'),
('20180610224000'),
('20180610224028'),
('20180610224052'),
('20180610234735'),
('20180626013909'),
('20180629050451'),
('20180630030838'),
('20180703024006'),
('20180704045646'),
('20180717185249'),
('20180720203523'),
('20180720211051'),
('20180807051643'),
('20180807051922'),
('20180807153114'),
('20181213183915'),
('20181213193750');


