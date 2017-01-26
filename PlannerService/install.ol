CREATE SEQUENCE public.plan_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.plan_sequence
    OWNER TO postgres;

CREATE SEQUENCE public.plan_step_sequence
        INCREMENT 1
        START 2
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE public.plan_step_sequence
        OWNER TO postgres;

CREATE TABLE public.plan_header
        (
            mrn integer,
            doctor character varying COLLATE "default".pg_catalog,
            plan_id integer NOT NULL DEFAULT nextval('plan_sequence'::regclass),
            date date,
            CONSTRAINT plan_header_pkey PRIMARY KEY (plan_id)
        )
        WITH (
            OIDS = FALSE
        )
        TABLESPACE pg_default;

        CREATE TABLE public.plan_step
(
    plan_id integer,
    step_id integer NOT NULL DEFAULT nextval('plan_step_sequence'::regclass),
    function character varying COLLATE "default".pg_catalog,
    data xml,
    completed boolean DEFAULT false,
    execution boolean
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


CREATE TABLE public.plan_step_pre
(
    plan_id integer,
    step_id integer,
    prereq integer
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
