--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 15.12 (Homebrew)

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

ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_project_id_fkey;
ALTER TABLE IF EXISTS ONLY public.task_logs DROP CONSTRAINT IF EXISTS task_logs_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.task_logs DROP CONSTRAINT IF EXISTS task_logs_task_id_fkey;
ALTER TABLE IF EXISTS ONLY public.task_logs DROP CONSTRAINT IF EXISTS task_logs_product_id_fkey;
ALTER TABLE IF EXISTS ONLY public."UserTokens" DROP CONSTRAINT IF EXISTS "UserTokens_user_id_fkey";
ALTER TABLE IF EXISTS ONLY public."UserSkills" DROP CONSTRAINT IF EXISTS "UserSkills_user_id_fkey";
ALTER TABLE IF EXISTS ONLY public."UserSkills" DROP CONSTRAINT IF EXISTS "UserSkills_skill_id_fkey";
ALTER TABLE IF EXISTS ONLY public."TaskLogStatusHistory" DROP CONSTRAINT IF EXISTS "TaskLogStatusHistory_user_id_fkey";
ALTER TABLE IF EXISTS ONLY public."TaskLogStatusHistory" DROP CONSTRAINT IF EXISTS "TaskLogStatusHistory_task_log_id_fkey";
ALTER TABLE IF EXISTS ONLY public."Projects" DROP CONSTRAINT IF EXISTS "Projects_client_id_fkey";
ALTER TABLE IF EXISTS ONLY public."ProjectUsers" DROP CONSTRAINT IF EXISTS "ProjectUsers_user_id_fkey";
ALTER TABLE IF EXISTS ONLY public."ProjectUsers" DROP CONSTRAINT IF EXISTS "ProjectUsers_project_id_fkey";
ALTER TABLE IF EXISTS ONLY public."Products" DROP CONSTRAINT IF EXISTS "Products_project_id_fkey";
ALTER TABLE IF EXISTS ONLY public."ClientContacts" DROP CONSTRAINT IF EXISTS "ClientContacts_client_id_fkey";
DROP INDEX IF EXISTS public."Users_email_key";
DROP INDEX IF EXISTS public."Skills_name_key";
DROP INDEX IF EXISTS public."Products_code_project_id_key";
ALTER TABLE IF EXISTS ONLY public.tasks DROP CONSTRAINT IF EXISTS tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.task_logs DROP CONSTRAINT IF EXISTS task_logs_pkey;
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public."Users" DROP CONSTRAINT IF EXISTS "Users_pkey";
ALTER TABLE IF EXISTS ONLY public."UserTokens" DROP CONSTRAINT IF EXISTS "UserTokens_pkey";
ALTER TABLE IF EXISTS ONLY public."UserSkills" DROP CONSTRAINT IF EXISTS "UserSkills_pkey";
ALTER TABLE IF EXISTS ONLY public."TaskLogStatusHistory" DROP CONSTRAINT IF EXISTS "TaskLogStatusHistory_pkey";
ALTER TABLE IF EXISTS ONLY public."Skills" DROP CONSTRAINT IF EXISTS "Skills_pkey";
ALTER TABLE IF EXISTS ONLY public."Projects" DROP CONSTRAINT IF EXISTS "Projects_pkey";
ALTER TABLE IF EXISTS ONLY public."ProjectUsers" DROP CONSTRAINT IF EXISTS "ProjectUsers_pkey";
ALTER TABLE IF EXISTS ONLY public."Products" DROP CONSTRAINT IF EXISTS "Products_pkey";
ALTER TABLE IF EXISTS ONLY public."Clients" DROP CONSTRAINT IF EXISTS "Clients_pkey";
ALTER TABLE IF EXISTS ONLY public."ClientContacts" DROP CONSTRAINT IF EXISTS "ClientContacts_pkey";
DROP TABLE IF EXISTS public.tasks;
DROP TABLE IF EXISTS public.task_logs;
DROP TABLE IF EXISTS public._prisma_migrations;
DROP TABLE IF EXISTS public."Users";
DROP TABLE IF EXISTS public."UserTokens";
DROP TABLE IF EXISTS public."UserSkills";
DROP TABLE IF EXISTS public."TaskLogStatusHistory";
DROP TABLE IF EXISTS public."Skills";
DROP TABLE IF EXISTS public."Projects";
DROP TABLE IF EXISTS public."ProjectUsers";
DROP TABLE IF EXISTS public."Products";
DROP TABLE IF EXISTS public."Clients";
DROP TABLE IF EXISTS public."ClientContacts";
DROP TYPE IF EXISTS public."UserRole";
DROP TYPE IF EXISTS public."TaskType";
DROP TYPE IF EXISTS public."TaskStatus";
DROP TYPE IF EXISTS public."TaskLogStatus";
DROP TYPE IF EXISTS public."TaskLogApprovalStatus";
DROP TYPE IF EXISTS public."ProjectUserRole";
DROP TYPE IF EXISTS public."ProjectStatus";
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: maestro
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO maestro;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: maestro
--

COMMENT ON SCHEMA public IS '';


--
-- Name: ProjectStatus; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."ProjectStatus" AS ENUM (
    'PLANNED',
    'NEW',
    'IN_PROGRESS',
    'ON_HOLD',
    'COMPLETED',
    'SHIPPED',
    'REJECTED',
    'FINISHED'
);


ALTER TYPE public."ProjectStatus" OWNER TO maestro;

--
-- Name: ProjectUserRole; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."ProjectUserRole" AS ENUM (
    'MANAGER',
    'QA',
    'ENGINEER',
    'PADAWAN'
);


ALTER TYPE public."ProjectUserRole" OWNER TO maestro;

--
-- Name: TaskLogApprovalStatus; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."TaskLogApprovalStatus" AS ENUM (
    'APPROVED',
    'NEEDS_FIXES',
    'ON_HOLD'
);


ALTER TYPE public."TaskLogApprovalStatus" OWNER TO maestro;

--
-- Name: TaskLogStatus; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."TaskLogStatus" AS ENUM (
    'NEW',
    'IN_PROGRESS',
    'COMPLETED',
    'ON_HOLD'
);


ALTER TYPE public."TaskLogStatus" OWNER TO maestro;

--
-- Name: TaskStatus; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."TaskStatus" AS ENUM (
    'NEW',
    'IN_PROGRESS',
    'COMPLETED',
    'ON_HOLD'
);


ALTER TYPE public."TaskStatus" OWNER TO maestro;

--
-- Name: TaskType; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."TaskType" AS ENUM (
    'PRODUCT',
    'GENERAL',
    'INTERMEDIATE'
);


ALTER TYPE public."TaskType" OWNER TO maestro;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: maestro
--

CREATE TYPE public."UserRole" AS ENUM (
    'ADMIN',
    'PROJECT_MANAGER',
    'WORKER',
    'GUEST'
);


ALTER TYPE public."UserRole" OWNER TO maestro;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ClientContacts; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."ClientContacts" (
    id text NOT NULL,
    client_id text NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    telegram text,
    whatsapp text,
    signal text,
    messenger text,
    instagram text,
    facebook text
);


ALTER TABLE public."ClientContacts" OWNER TO maestro;

--
-- Name: Clients; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."Clients" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    address text,
    contact_info text
);


ALTER TABLE public."Clients" OWNER TO maestro;

--
-- Name: Products; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."Products" (
    id text NOT NULL,
    code text NOT NULL,
    project_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Products" OWNER TO maestro;

--
-- Name: ProjectUsers; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."ProjectUsers" (
    user_id text NOT NULL,
    project_id text NOT NULL,
    role public."ProjectUserRole" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL
);


ALTER TABLE public."ProjectUsers" OWNER TO maestro;

--
-- Name: Projects; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."Projects" (
    id text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    start_date timestamp(3) without time zone NOT NULL,
    deadline timestamp(3) without time zone NOT NULL,
    actual_end_date timestamp(3) without time zone,
    status public."ProjectStatus" DEFAULT 'NEW'::public."ProjectStatus" NOT NULL,
    quantity integer,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Projects" OWNER TO maestro;

--
-- Name: Skills; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."Skills" (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Skills" OWNER TO maestro;

--
-- Name: TaskLogStatusHistory; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."TaskLogStatusHistory" (
    id text NOT NULL,
    task_log_id text NOT NULL,
    status public."TaskLogApprovalStatus" NOT NULL,
    user_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."TaskLogStatusHistory" OWNER TO maestro;

--
-- Name: UserSkills; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."UserSkills" (
    user_id text NOT NULL,
    skill_id text NOT NULL
);


ALTER TABLE public."UserSkills" OWNER TO maestro;

--
-- Name: UserTokens; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."UserTokens" (
    id text NOT NULL,
    user_id text NOT NULL,
    jwt_token text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."UserTokens" OWNER TO maestro;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public."Users" (
    id text NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    password_hash text,
    role public."UserRole" DEFAULT 'WORKER'::public."UserRole" NOT NULL,
    "callSign" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastName" text,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Users" OWNER TO maestro;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO maestro;

--
-- Name: task_logs; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public.task_logs (
    id text NOT NULL,
    user_id text NOT NULL,
    task_id text NOT NULL,
    product_id text,
    completed_at timestamp(3) without time zone,
    registered_at timestamp(3) without time zone NOT NULL,
    time_spent numeric(65,30),
    quantity integer
);


ALTER TABLE public.task_logs OWNER TO maestro;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: maestro
--

CREATE TABLE public.tasks (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    type public."TaskType" DEFAULT 'GENERAL'::public."TaskType" NOT NULL,
    status public."TaskStatus" DEFAULT 'NEW'::public."TaskStatus" NOT NULL,
    complexity integer,
    tags text,
    estimated_time numeric(65,30),
    project_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO maestro;

--
-- Data for Name: ClientContacts; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."ClientContacts" (id, client_id, name, email, phone, telegram, whatsapp, signal, messenger, instagram, facebook) FROM stdin;
\.


--
-- Data for Name: Clients; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."Clients" (id, name, description, address, contact_info) FROM stdin;
44090811-4903-469d-8a14-40c07c817c1c	Генерал Черешня			
\.


--
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."Products" (id, code, project_id, created_at) FROM stdin;
542f9cbd-3754-459a-8f89-53dddfb068db	00001	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-12 22:57:13.167
7456c229-7da8-42a9-b3bc-97014383302d	00169	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 17:37:26.959
3ec95bbe-0b3b-4af7-ba25-f78e1edacecd	00170	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 17:53:38.303
19fdeb63-b801-4314-a4ce-c704059948d1	00046	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.342
a3df2442-c261-4de7-bde3-fb42f86e8f11	00047	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.394
d3981126-c996-457f-9b9a-2421e3f2aa9e	00307	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.394
65231940-0759-434a-96b7-3dc15a03336e	00048	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.394
fed79343-1c21-433f-9d45-390cd4003d69	00049	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.394
f6c1869a-ef18-41aa-a7c1-7d5f3153790e	00050	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:32:22.394
479e767b-b238-45ae-8451-d722372e30bc	00232	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.857
18b1be25-b82f-4016-be4a-24ad1211dbcc	00230	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.841
9d4cee0f-b79b-4ce2-9e80-ea96dbf7763b	00248	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.891
8eb6c572-5b1a-47b4-9ea6-b1e31f84815f	00288	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.892
ce5e7b34-5efe-4ba9-b460-c135588b088f	00237	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.892
bad7a9f0-4b12-4a69-a931-d08380e575e8	00214	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:56:41.892
412bc072-99ba-4811-a2d9-9e1bd1f49705	00223	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:57:56.115
751c6384-02dc-45b1-9df0-81fb810e2301	00224	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:57:56.129
93975bc5-c8f0-4c51-86d7-29926d2f24b9	00225	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 18:57:56.131
7d9981a3-b99b-4036-85ec-2ddc6517bf42	00289	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:13:50.924
e5fc2cb3-7620-4112-be4b-a1abddde0365	00497	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:13:50.942
33b56818-edf7-42bd-93d3-fa92f66274fa	00494	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:13:50.969
4dac4fab-0b3f-47f4-8039-5eb68885b867	00493	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:13:50.97
74a33cba-fc25-46a5-a998-f04326faa001	00498	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:13:50.97
98525d40-eee6-4aeb-bd86-2cdeecf6f444	00295	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.938
e2d7e9d4-dcb8-47bd-b745-b9dc380cc1a3	00294	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.954
a1be233c-73f5-441a-8406-af1669469c73	00220	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.959
1614bb2d-bc03-4b20-9f62-9457f3f56e34	00021	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.964
f8e2af02-0e7b-49a6-8905-e3b873f0469f	00219	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.967
44a24f03-8bbf-4002-b4ce-a7ac6ad21926	00218	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.967
364282fa-7253-4420-b2bc-4e12e51985f9	00216	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.98
e24613b2-3592-4332-a332-361d72a6e948	00229	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.991
8985e007-5aea-41ae-83d9-104ff755fca3	00212	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:15:35.993
f69dd59d-a3af-4519-a7c5-a9cd7d7aef8e	00090	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:16:46.014
86d850c9-aab5-40f8-8b92-c78a8d676861	00129	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:16:46.037
f66035ca-88b2-4751-ae44-4bfc3df3ddd9	00089	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:16:46.041
c7b9094d-7b2b-4e6c-bfd0-9ff0b27e50cb	00221	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:16:46.043
b8a5def4-3743-4bcb-85d6-0dfaef34861a	00222	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 19:16:46.044
ebd7c4b8-1263-4177-a75d-a7cd0f722b87	00210	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.645
e0ab9d68-aecb-4f5f-bc23-d5ac6c400fad	00209	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.621
1d357105-a6c6-499a-af09-f9160e2d478b	00296	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.646
3be028d9-01a3-4ab9-a1f5-9c05aff3e2d7	00226	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.685
76c316e9-683e-411b-8435-3db00497136a	00207	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.685
2a3c987a-729e-4b40-b887-0d1a49f55670	00208	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.685
d24ca3d6-4562-4d12-9daf-cdbc11df1ff3	00217	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.735
69bfe62d-1e43-4caf-8ca7-66b59cf0945f	00211	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.741
797368ee-d7fa-438b-b06e-b60c67479032	00215	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.742
7ddba26c-08f2-4181-8ec6-982f51a57743	00228	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:07:12.744
fae0fe25-a965-4f09-8c33-e88baca7a64b	00247	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.726
ac41d8ea-e738-419e-a693-56f2f8a423d9	00241	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.736
640e79ba-ceb6-4639-9c63-5d7ae0bad4a6	00278	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.745
61bce086-4d3a-430b-bfa8-87e4f1d29a08	00280	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.747
9dd3c831-e3fc-435a-92f2-d7376b3bae0b	00281	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.75
bcefc7c3-f6af-417e-865a-6eeff78f928c	00279	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.747
c46da7e2-d9b7-4402-ae77-ed1bacf11bf2	00282	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.799
a3068a89-90a9-4327-8e3d-2c5ca0b30e4b	00246	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.801
97c72fb4-f254-4cda-901b-23216aff55b7	00245	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.802
fd52e3a7-a30b-4647-822b-57206fd5388f	00283	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.807
cb526458-ae1f-4a84-a7a9-e7031f612074	00284	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.81
fe5858af-d539-4e9e-bb94-e99f834bc71b	00285	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.81
94d4fe13-aaed-4a41-b1b3-e2f4a6c7bc23	00287	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.84
828b3c79-f2e8-4b43-b544-8c32d7048d9c	00240	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.849
07874060-cff6-40ec-9b52-ec7121ef8051	00244	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.85
06d5e6ac-8a7c-40f8-8069-65b26a142a6b	00286	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:10:51.848
8a7d8753-a54a-4b10-8a72-1e11ca415b5b	00005	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:24:04.178
9867c7ff-d3bd-4efc-b2b7-ea425350757b	00291	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:09.954
41482a61-e322-42ef-a5fc-6d525c2542a6	00290	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:09.939
3ce8216a-1065-4346-a89b-e72df6d96ce5	00227	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.006
5f00191a-e560-43ec-8ec1-793ccf929ef8	00249	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.007
d332d327-ef27-4775-9683-c23d324abbf4	00213	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.006
a733b4f4-38c9-4720-8388-4dc47d1343de	00231	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.008
fa95754b-4c40-4267-9432-53731574a5d3	00017	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.06
f323147f-dc1c-4116-b9f9-08994fbc61ce	00011	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.775
26352e3f-39b3-4861-bd56-46280b0e7ca0	00022	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.075
a51c1b7f-9f48-4ff0-ba6d-e9ddd3c0eab6	00233	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.078
a3ab5bd5-e345-4cd7-8c46-998665bb3e05	00018	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.082
aa501665-626a-408b-90f6-5bd87b7f54f1	00019	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.764
fca2efaf-aaa7-4f57-a79b-b2d97c45722a	00016	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.08
dd902aca-2a6b-47d7-9a55-83ebd5e6af79	00023	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.082
7c236248-e0e2-4282-b9f9-29e938492539	00235	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:33:10.118
a1c53153-0c6a-44d9-a114-f890828648bf	00020	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.764
6dac48c7-4f4e-4e3b-b4e0-0007a2531cf6	00025	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.775
3726f467-8872-4e1f-9ba2-374a59cc176a	00261	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.775
6383b850-30a2-4fc8-942d-7639fe4bc4c0	00266	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.988
96431ba6-25c7-4474-9832-586672953cd6	00271	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.995
86feb425-d462-4b9c-9eb7-f4d2ff0c8696	00242	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:39:32.674
69519a0e-1a44-442f-ba33-0c0a78f270f5	00262	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 10:08:48.572
516443c7-5d0e-48f2-9d60-41c3a25b1e35	00303	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.889
af0b583f-2864-436e-a71a-1cc742eebcf0	00298	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.896
fb3514d3-4b69-4ac7-9ba8-2c0c7ad09ee9	00029	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.297
4a5aa9ad-3a59-4594-8ad8-da7796878eb8	00037	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.403
1bd6ad93-a944-4fad-b979-40be6f237849	00028	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.297
f5839b70-98fe-4102-95f8-a3015970f6a7	00036	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.369
1ce1f86e-598f-4d6d-99d4-c21e625a6929	00035	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.411
fb0a7aae-0c93-4022-a939-6d25bfd50f1f	00030	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.299
e212dbd6-6c7a-4b60-a2ad-c7280868a9de	00032	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.301
0a03a698-e5f6-45c3-babf-2f6bdac9cc49	00031	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.303
0a4c6115-9f88-4fb0-8086-f6f1ac57ce25	00038	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.411
a25147a7-50cc-42ed-bc93-b0f1ddb70a6e	00034	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.352
a081caa0-5184-4cab-96dc-f6c6601a67d8	00274	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.744
f4c13db0-4d2a-4efc-af90-63d667521d86	00275	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.756
21d970f0-e925-4a19-b17f-dd81ce6d9daf	00277	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.764
07e23ad7-52e6-41c2-bd42-694582dabdf2	00033	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:53:29.352
fc532c16-f1af-4acd-98aa-b1f8c4a857e1	00267	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.711
ae36cc75-9261-4233-8a40-b7bab4768a39	00269	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.734
afe243bd-2e38-40fe-b9d1-dde7a5c177ae	00270	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.736
bb6461e0-752b-43cb-9d11-5531e6d496d2	00276	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.762
eb54f7f4-a917-4957-bd25-d6b948b32052	00264	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.698
fdbd466d-50a6-41dc-8a7f-a159b7afdef6	00263	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.698
c6a7b73f-0e96-4e06-8d65-38948045c58c	00265	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.703
c48ff7d9-df4a-432f-90a7-c819ce939054	00268	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.71
d3118a3a-2929-40fb-8ba9-3cc1d3f5144a	00272	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.741
bcbdbccf-5f80-44c3-abc2-52dca2530751	00273	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:54:49.743
32d8f0c8-2812-4774-a2db-dec48765fbc3	00239	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:16:29.324
6953b2c8-01a6-4e7f-a809-d3aeac589ec0	00238	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:16:29.348
b58192d8-e35b-4f9c-aaa6-24140e8272fc	00495	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:16:29.387
deeadf52-62d8-4aed-992f-2c634c544bde	00496	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:16:29.389
ae0397c6-4b2c-4e6f-9c2a-732ec396c598	00415	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:24.815
88652b5c-bebe-49c5-8b10-bf9298d40195	00423	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:24.921
d39f621b-b7a2-42f4-b9a1-6c75e8ac101c	00417	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:24.936
2a8a107c-523a-4d99-aeaa-9925b85bc8c2	00418	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.005
b1bbd045-abd9-40da-a78b-5f60db643670	00419	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.11
818c6968-9ecd-4db5-a900-5afab0406640	00422	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.112
a76cc3d5-e677-47f3-9f02-ebb0c79503ff	00414	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:24.928
79198527-71fe-43d3-93ec-fe3d6c64d20c	00416	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.004
390c631b-e6a4-4eb4-b372-9a991d5c2de1	00420	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.11
fa0df1ef-18bb-4511-abfd-fc8869f68a2c	00421	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:24:25.129
774c26fe-4d31-4326-a372-b57fe7ecdf27	00408	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.589
a7f4f78d-f4b6-48c5-85e5-32aedeca5266	00407	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.646
3a0b5de5-a2a5-4aa8-adac-46711fff9760	00405	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.65
ca2b58c3-1725-4f12-9142-6b8e5e4bb211	00411	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:44.052
8613cc8e-6c0c-4fbb-9b08-e050ab303f59	00409	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:44.066
e7b7eb6b-baf2-49a4-88c0-55af78cd5ba3	00406	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.648
51d56b56-6de6-4a70-acac-941904743202	00413	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.822
23667994-9046-417f-a79a-f939987a902a	00404	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:43.976
87f66827-72ea-4601-8074-90df4112bf9e	00412	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:44.051
182c2e51-4702-4273-ab5a-7c64200c0746	00410	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:38:44.066
24d815a4-7649-44c1-8b67-a93752b0bf8d	00306	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.826
dab18118-e41b-435f-bece-0073eec25748	00305	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.827
8a77644e-8d6d-4f59-b04e-b8f7f80d46b4	00304	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.839
84b66909-d79c-4906-9c86-7f3d24139942	00301	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.844
3998df44-aa1d-42cc-9fd2-cdf5ef055b3a	00330	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.848
52851dc1-9bc7-4b9f-9156-074d3a005be3	00331	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.851
a10cf89d-c57f-4a62-9fb1-119edefe636f	00302	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.893
47bdea20-40d4-4418-a120-39c54be0b69c	00300	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.895
e21e46cf-2383-46a6-b841-5cd8585310a0	00297	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.897
17026669-dc68-4a75-ad81-958098618536	00308	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.911
8df3c997-06e6-4d60-b941-8a19a6cbf8de	00309	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 14:50:31.916
bbafa0b4-6b4a-45c4-8357-f455f20ae06d	00024	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:35:25.764
f008fc7d-cf2f-486f-852b-a2e88e86113f	00243	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-14 20:39:32.654
\.


--
-- Data for Name: ProjectUsers; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."ProjectUsers" (user_id, project_id, role, "isActive") FROM stdin;
38e25bbe-008e-48d7-bdea-d8b04e7ffbb6	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	MANAGER	t
5d759a32-b650-4801-9bdd-f5565943dc01	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
1554f0d4-f870-4c35-805e-90cd37b2e47f	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
54b4ceec-7c75-4aff-8b08-6333b1849cf8	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
d5c43a0c-6249-49e4-8d04-22024aa8193a	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
4ac2b819-a667-4371-9396-d42cb622a0ea	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
f5eeadc7-c8f8-4ff1-b205-945afd554a96	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
76269788-c718-4340-bd29-6634790ddddc	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	ENGINEER	t
fd20320c-4120-4bd4-bd82-379fe35b122c	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	PADAWAN	t
\.


--
-- Data for Name: Projects; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."Projects" (id, name, client_id, start_date, deadline, actual_end_date, status, quantity, updated_at) FROM stdin;
f26cc409-bfb4-453f-82fe-9e7fe5fc4847	524 каміки з тепловізійною камерою	44090811-4903-469d-8a14-40c07c817c1c	2025-03-07 00:00:00	2025-04-07 00:00:00	\N	IN_PROGRESS	524	2025-03-15 11:50:08.822
\.


--
-- Data for Name: Skills; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."Skills" (id, name) FROM stdin;
\.


--
-- Data for Name: TaskLogStatusHistory; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."TaskLogStatusHistory" (id, task_log_id, status, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: UserSkills; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."UserSkills" (user_id, skill_id) FROM stdin;
\.


--
-- Data for Name: UserTokens; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."UserTokens" (id, user_id, jwt_token, expires_at) FROM stdin;
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public."Users" (id, name, email, phone, password_hash, role, "callSign", "createdAt", "lastName", "updatedAt") FROM stdin;
5d759a32-b650-4801-9bdd-f5565943dc01	Саня	sasha.kozlov2010@gmail.com	+380939923942	$2b$10$.U.uGd/Y8SNLwxVTXPYTE.Y806KPAs7dL0GA3QsZ/1F3TEve0rJVW	WORKER	\N	2025-03-11 20:35:02.865	\N	2025-03-11 20:35:02.865
d5c43a0c-6249-49e4-8d04-22024aa8193a	Максим	guardiamax660@gmail.com	+380972461180	$2b$10$Xtg86ymOytfnR9sBL3xHwO.hFzEq8euTAGEUoC20i1d59iocTtGVC	WORKER	\N	2025-03-12 17:30:42.285	\N	2025-03-12 17:30:42.285
1554f0d4-f870-4c35-805e-90cd37b2e47f	Олексій	alex59.kovalenko@gmail.com	+380671053855	$2b$10$PuerEQ4q8smo.9sv8HRGAeW2Cr7bMn7dFoYro68A24xX3CqCLuE/W	WORKER	\N	2025-03-12 17:43:36.474	\N	2025-03-12 17:43:36.474
54b4ceec-7c75-4aff-8b08-6333b1849cf8	Артем	artemsaliychuk88@gmail.com	+380930334823	$2b$10$F9u80sXxUfm/XSuooA.Isef5qK8AHwu5v7ZXUyREYziormsxfOf6K	WORKER	\N	2025-03-12 17:47:36.911	\N	2025-03-12 17:47:36.911
4ac2b819-a667-4371-9396-d42cb622a0ea	Богдан	Garrik2000@ukr.net	+380677803740	$2b$10$GUzCLCVXpHhVSfedrokYrOvJtG2J6l6TWnYerURD86tcAYBfo3rsW	WORKER	\N	2025-03-12 18:29:31.83	\N	2025-03-12 18:29:31.83
38e25bbe-008e-48d7-bdea-d8b04e7ffbb6	Сергій	cray@sscgroup.net	\N	$2b$10$X7H2FrU5viqsA72NKAAB.OYjkTJAkC2ZUz2aCn2D9j1yA9xk5rskq	ADMIN	\N	2025-03-11 22:29:13.458	\N	2025-03-14 15:04:45.567
f5eeadc7-c8f8-4ff1-b205-945afd554a96	Ігор	wellman3033@gmail.com	+380934927212	$2b$10$t7ydu2tHpRV2cUuSPoycROq/mzRTVq5jYfDpnXZ.J8zM1oBoUII9.	WORKER	\N	2025-03-14 15:56:56.798	\N	2025-03-14 15:56:56.798
76269788-c718-4340-bd29-6634790ddddc	Олена	none1@none.com	+380678160270	$2b$10$kXl7cnvhk0hZAYnnWH3Lxu6QG6nxCs1/bPVdNE9KX4ZRXJBUbMyp6	WORKER	\N	2025-03-14 16:56:18	\N	2025-03-14 16:56:18
fd20320c-4120-4bd4-bd82-379fe35b122c	Ангелина	\N	\N	\N	GUEST	\N	2025-03-15 11:23:56.326	\N	2025-03-15 11:23:56.326
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
05356402-7e3f-41bc-9a97-912a6ffc7a07	ccd84632c4bd60e464f4954517c6f91a4645b5f868bc36247b2514e54b048fbc	2025-03-14 18:27:15.738047+02	20250313101033_init	\N	\N	2025-03-14 18:27:15.70119+02	1
7fa24f8b-5034-4cde-ad70-f5babcd3e6b9	94da2df308c6c11884c1771e674f3258c85d4f0a57b1697dfdb48dbf10fe31bc	2025-03-14 18:27:15.740117+02	20250314162524_add_quantity_to_task_logs	\N	\N	2025-03-14 18:27:15.738524+02	1
60844c14-2f1f-474b-9a72-f3ea095ce143	47b3253152c6104e3fe75c35cc8c217f29a1747b777f80a3e2ade965a436d9d7	2025-03-15 12:39:44.247215+02	20250315103944_make_email_and_password_optional	\N	\N	2025-03-15 12:39:44.245177+02	1
\.


--
-- Data for Name: task_logs; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public.task_logs (id, user_id, task_id, product_id, completed_at, registered_at, time_spent, quantity) FROM stdin;
00ff1a08-a318-47ef-8d53-bfa133c84206	d5c43a0c-6249-49e4-8d04-22024aa8193a	3e3e8139-1872-429e-a284-014f912d309c	\N	\N	2025-03-11 15:37:00	\N	21
28144bbc-7509-4e44-9ad5-102edbeacda5	f5eeadc7-c8f8-4ff1-b205-945afd554a96	2bd3b08c-5ef4-4da0-b178-1676cd40db25	\N	\N	2025-03-11 15:58:00	\N	80
6359f91c-8dae-4df1-86ff-d57c186ed23d	f5eeadc7-c8f8-4ff1-b205-945afd554a96	3e3e8139-1872-429e-a284-014f912d309c	\N	\N	2025-03-11 16:00:00	\N	3
9a954dc4-71af-4a8c-90a6-0f92b4b3ec15	d5c43a0c-6249-49e4-8d04-22024aa8193a	3e3e8139-1872-429e-a284-014f912d309c	\N	\N	2025-03-12 15:38:00	\N	32
9eca3365-6b2c-486f-b9dc-b3c5d8123284	f5eeadc7-c8f8-4ff1-b205-945afd554a96	2bd3b08c-5ef4-4da0-b178-1676cd40db25	\N	\N	2025-03-10 15:58:00	\N	60
b7eca10b-1bbe-4b9f-954b-16764c0b25c6	d5c43a0c-6249-49e4-8d04-22024aa8193a	3e3e8139-1872-429e-a284-014f912d309c	\N	\N	2025-03-13 15:38:00	\N	16
bb14e3fa-dbcb-431a-a28f-d4fbf330fd2c	f5eeadc7-c8f8-4ff1-b205-945afd554a96	2bd3b08c-5ef4-4da0-b178-1676cd40db25	\N	\N	2025-03-07 15:58:00	\N	41
26708232-e34c-4723-bea0-2194faa17bdd	76269788-c718-4340-bd29-6634790ddddc	0290a525-b422-4a2d-9a9c-48a0ed38de78	\N	\N	2025-03-07 16:56:00	6.000000000000000000000000000000	\N
0aa9b0fe-6a6b-4f9b-a472-26e829799e42	76269788-c718-4340-bd29-6634790ddddc	cf2f35ed-f1c6-424e-80b8-04fc1a082a60	\N	\N	2025-03-10 16:57:00	7.000000000000000000000000000000	\N
ba701086-daf1-47fe-b893-f59291b668e1	76269788-c718-4340-bd29-6634790ddddc	cf2f35ed-f1c6-424e-80b8-04fc1a082a60	\N	\N	2025-03-11 16:58:00	2.000000000000000000000000000000	\N
d4475a5f-b4c6-4bc5-abd0-5318b9b9284e	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	7456c229-7da8-42a9-b3bc-97014383302d	\N	2025-03-14 17:35:00	\N	\N
1e99b315-d6f8-46c3-a00b-e4c0a4b353e9	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	3ec95bbe-0b3b-4af7-ba25-f78e1edacecd	\N	2025-03-14 17:52:00	\N	\N
6035450f-2817-4c4f-b1c6-c8a2aefbe2b9	d5c43a0c-6249-49e4-8d04-22024aa8193a	3e3e8139-1872-429e-a284-014f912d309c	\N	\N	2025-03-14 17:51:00	\N	35
7fa61f97-6421-48bc-88ee-443c9a53486e	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a3df2442-c261-4de7-bde3-fb42f86e8f11	\N	2025-03-14 18:45:00	\N	\N
c6f1c578-7076-44a1-8337-69196a3d9499	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	19fdeb63-b801-4314-a4ce-c704059948d1	\N	2025-03-14 18:45:00	\N	\N
60d95c0b-1214-401d-a9e8-94d56bab538d	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	65231940-0759-434a-96b7-3dc15a03336e	\N	2025-03-14 18:45:00	\N	\N
5fc150ba-3094-4e5c-b0c2-e1f1e8894aca	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	fed79343-1c21-433f-9d45-390cd4003d69	\N	2025-03-14 18:45:00	\N	\N
9fa8bd45-b901-4d30-b2d8-970a6ca51b91	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	f6c1869a-ef18-41aa-a7c1-7d5f3153790e	\N	2025-03-14 18:45:00	\N	\N
f7d8dafa-0576-4630-8525-ab85c90b6757	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	d3981126-c996-457f-9b9a-2421e3f2aa9e	\N	2025-03-14 18:45:00	\N	\N
37a540bc-95ba-4757-ad33-2f66f721b505	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	479e767b-b238-45ae-8451-d722372e30bc	\N	2025-03-14 18:54:00	\N	\N
eaa7def9-5a08-4a22-9b7b-465d9fb73dd5	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	18b1be25-b82f-4016-be4a-24ad1211dbcc	\N	2025-03-14 18:54:00	\N	\N
8763cc2b-4053-4d7d-8022-5d03c6d7a1ae	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	9d4cee0f-b79b-4ce2-9e80-ea96dbf7763b	\N	2025-03-14 18:54:00	\N	\N
c1c8bdd0-6b94-47ed-980f-bc61f8301331	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	ce5e7b34-5efe-4ba9-b460-c135588b088f	\N	2025-03-14 18:54:00	\N	\N
337ce62b-ac1a-4e47-9331-34ec990d6575	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	bad7a9f0-4b12-4a69-a931-d08380e575e8	\N	2025-03-14 18:54:00	\N	\N
19902d84-96b0-4c37-adea-6213b99993c2	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	8eb6c572-5b1a-47b4-9ea6-b1e31f84815f	\N	2025-03-14 18:54:00	\N	\N
cb6ed60a-46b9-4b09-944b-9abaa6732e26	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	412bc072-99ba-4811-a2d9-9e1bd1f49705	\N	2025-03-14 18:57:00	\N	\N
e440990c-ec44-4667-b74c-65df5da8b1c0	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	751c6384-02dc-45b1-9df0-81fb810e2301	\N	2025-03-14 18:57:00	\N	\N
de94ea60-6ab2-431e-a840-3e2ccab2b30c	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	93975bc5-c8f0-4c51-86d7-29926d2f24b9	\N	2025-03-14 18:57:00	\N	\N
3e936b7a-6620-4963-94a1-c67f9e1f3f82	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	7d9981a3-b99b-4036-85ec-2ddc6517bf42	\N	2025-03-14 19:12:00	\N	\N
bf4be59e-ada6-4cb3-a148-66503684c063	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	e5fc2cb3-7620-4112-be4b-a1abddde0365	\N	2025-03-14 19:12:00	\N	\N
a6639af0-b4c7-42a9-aa85-93551b64c61b	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	33b56818-edf7-42bd-93d3-fa92f66274fa	\N	2025-03-14 19:12:00	\N	\N
ec970ed4-f2b7-4ab4-acbd-a85857a250e8	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	4dac4fab-0b3f-47f4-8039-5eb68885b867	\N	2025-03-14 19:12:00	\N	\N
05e5ded2-e513-41a5-a3d1-46fe366e7604	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	74a33cba-fc25-46a5-a998-f04326faa001	\N	2025-03-14 19:12:00	\N	\N
87c228c4-f96d-4e38-bb0e-97ff872c8aee	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	98525d40-eee6-4aeb-bd86-2cdeecf6f444	\N	2025-03-14 19:13:00	\N	\N
efbaf7e4-2fc8-488c-8368-20ad6d71d2fa	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	e2d7e9d4-dcb8-47bd-b745-b9dc380cc1a3	\N	2025-03-14 19:13:00	\N	\N
a271925e-8154-45e0-835f-6024b72f2f6b	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a1be233c-73f5-441a-8406-af1669469c73	\N	2025-03-14 19:13:00	\N	\N
fae058c3-9bc1-4ebf-bcec-f33ce750f681	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	1614bb2d-bc03-4b20-9f62-9457f3f56e34	\N	2025-03-14 19:13:00	\N	\N
56c7a29f-54db-4594-82fd-0deda15388fc	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	f8e2af02-0e7b-49a6-8905-e3b873f0469f	\N	2025-03-14 19:13:00	\N	\N
c9318670-e30b-458e-9ffd-d579e20e9cbf	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	44a24f03-8bbf-4002-b4ce-a7ac6ad21926	\N	2025-03-14 19:13:00	\N	\N
de8fe67f-07dc-4603-bcec-0ed6639bf4e1	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	364282fa-7253-4420-b2bc-4e12e51985f9	\N	2025-03-14 19:13:00	\N	\N
9f5840eb-3323-452d-b1be-e54de4c66d83	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	e24613b2-3592-4332-a332-361d72a6e948	\N	2025-03-14 19:13:00	\N	\N
e05bfc8e-d16e-49b8-b1b2-659973ffb67e	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	8985e007-5aea-41ae-83d9-104ff755fca3	\N	2025-03-14 19:13:00	\N	\N
a8fb5cea-2940-406a-9b46-e32767cd1c61	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	f69dd59d-a3af-4519-a7c5-a9cd7d7aef8e	\N	2025-03-14 19:15:00	\N	\N
f66df0a4-34e6-4c75-8991-620f20de9ec9	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	86d850c9-aab5-40f8-8b92-c78a8d676861	\N	2025-03-14 19:15:00	\N	\N
a69c2ae7-dba9-4583-ba83-9bd6ea4c0237	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	b8a5def4-3743-4bcb-85d6-0dfaef34861a	\N	2025-03-14 19:15:00	\N	\N
e54aad4c-820f-4302-a436-c789049d9b50	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	c7b9094d-7b2b-4e6c-bfd0-9ff0b27e50cb	\N	2025-03-14 19:15:00	\N	\N
b47eddeb-45a8-4ed7-bbbd-9502b279ef23	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	ebd7c4b8-1263-4177-a75d-a7cd0f722b87	\N	2025-03-14 20:04:00	\N	\N
e1e1a9cc-5851-4c52-8c66-498b6bf9b386	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	e0ab9d68-aecb-4f5f-bc23-d5ac6c400fad	\N	2025-03-14 20:04:00	\N	\N
126dd3f0-7835-4545-856d-de7cc0f3bfb1	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	1d357105-a6c6-499a-af09-f9160e2d478b	\N	2025-03-14 20:04:00	\N	\N
8acc9871-0b31-4f4f-a9f5-e3752a9eea42	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	ac41d8ea-e738-419e-a693-56f2f8a423d9	\N	2025-03-12 20:07:00	\N	\N
56b8e3df-0a89-4e6e-89bb-8404b41bf7f8	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fae0fe25-a965-4f09-8c33-e88baca7a64b	\N	2025-03-12 20:07:00	\N	\N
6a64838f-2c78-4abc-a21d-f147ed8bd8e1	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	61bce086-4d3a-430b-bfa8-87e4f1d29a08	\N	2025-03-12 20:07:00	\N	\N
02e58fb7-bc34-48da-8693-f41899dae208	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a3068a89-90a9-4327-8e3d-2c5ca0b30e4b	\N	2025-03-12 20:07:00	\N	\N
0af1eba3-f562-4301-a661-7b4482b3e5e3	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fd52e3a7-a30b-4647-822b-57206fd5388f	\N	2025-03-12 20:07:00	\N	\N
4bfffc85-e256-44d2-bdd5-533ec262935b	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	828b3c79-f2e8-4b43-b544-8c32d7048d9c	\N	2025-03-12 20:07:00	\N	\N
7c65ae1e-f900-409c-b2f4-9c4b81e7317c	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	06d5e6ac-8a7c-40f8-8069-65b26a142a6b	\N	2025-03-12 20:07:00	\N	\N
cf07010a-e47a-4742-9c29-577e3f299165	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	bbafa0b4-6b4a-45c4-8357-f455f20ae06d	\N	2025-03-13 10:08:00	\N	\N
047b4a94-d207-4967-8fe7-0832a87cfed4	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	3be028d9-01a3-4ab9-a1f5-9c05aff3e2d7	\N	2025-03-14 20:04:00	\N	\N
4f425169-d6ef-46d8-b095-0c3a59d7e6ce	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	d24ca3d6-4562-4d12-9daf-cdbc11df1ff3	\N	2025-03-14 20:04:00	\N	\N
e114a3eb-0a8b-45a2-9c9a-1b4005a6b9fa	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	7ddba26c-08f2-4181-8ec6-982f51a57743	\N	2025-03-14 20:04:00	\N	\N
b8e0e7aa-a067-4c37-887e-19e529186fb2	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	9dd3c831-e3fc-435a-92f2-d7376b3bae0b	\N	2025-03-12 20:07:00	\N	\N
dab9d69b-1726-42ed-beef-6628e27f0d19	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	97c72fb4-f254-4cda-901b-23216aff55b7	\N	2025-03-12 20:07:00	\N	\N
24858ab5-1415-4b70-b81f-7fb0b76e1299	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	cb526458-ae1f-4a84-a7a9-e7031f612074	\N	2025-03-12 20:07:00	\N	\N
6066f305-1e8a-43d6-94c0-d36a3a6c895f	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	07874060-cff6-40ec-9b52-ec7121ef8051	\N	2025-03-12 20:07:00	\N	\N
6fec31a1-8585-4f7f-91ae-4c947a7084c9	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	6383b850-30a2-4fc8-942d-7639fe4bc4c0	\N	2025-03-13 10:08:00	\N	\N
7d2090e5-db05-47e7-82b6-8c2e86680760	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	69519a0e-1a44-442f-ba33-0c0a78f270f5	\N	2025-03-13 10:08:00	\N	\N
f2eddaeb-9166-47f5-991c-f80577a0a65e	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	2a3c987a-729e-4b40-b887-0d1a49f55670	\N	2025-03-14 20:04:00	\N	\N
342962b1-3f03-4529-adf7-a20c675abbfd	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	69bfe62d-1e43-4caf-8ca7-66b59cf0945f	\N	2025-03-14 20:04:00	\N	\N
699387ff-c62f-4290-b9f1-ed23d96b76da	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	bcefc7c3-f6af-417e-865a-6eeff78f928c	\N	2025-03-12 20:07:00	\N	\N
fbf9d56e-aea8-4582-8e77-176eb93d9272	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	c46da7e2-d9b7-4402-ae77-ed1bacf11bf2	\N	2025-03-12 20:07:00	\N	\N
a934a7b2-6a12-4df2-83c4-a464389809bb	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fe5858af-d539-4e9e-bb94-e99f834bc71b	\N	2025-03-12 20:07:00	\N	\N
a7dc7666-8213-4ff8-9815-601cb19fb7f3	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	94d4fe13-aaed-4a41-b1b3-e2f4a6c7bc23	\N	2025-03-12 20:07:00	\N	\N
c258b400-1fb2-480a-b052-e39d2c63750f	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	96431ba6-25c7-4474-9832-586672953cd6	\N	2025-03-13 10:08:00	\N	\N
e80ee3ce-d520-4db0-b7b7-b7310f50e844	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	aa501665-626a-408b-90f6-5bd87b7f54f1	\N	2025-03-13 10:08:00	\N	\N
64a9ef55-9466-4b5f-b1a1-4031f48f2a3d	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	76c316e9-683e-411b-8435-3db00497136a	\N	2025-03-14 20:04:00	\N	\N
2c7a5973-9a60-480d-9682-b3326e0af5b6	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	797368ee-d7fa-438b-b06e-b60c67479032	\N	2025-03-14 20:04:00	\N	\N
f0089f65-778d-4a29-8de5-4602066abafd	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	640e79ba-ceb6-4639-9c63-5d7ae0bad4a6	\N	2025-03-12 20:07:00	\N	\N
c25498bf-da0c-4546-81ad-c803364f25f1	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	f323147f-dc1c-4116-b9f9-08994fbc61ce	\N	2025-03-13 10:08:00	\N	\N
093dfa36-8c89-40f5-9557-044b53a0354c	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	8a7d8753-a54a-4b10-8a72-1e11ca415b5b	\N	2025-03-14 20:23:00	\N	\N
fcfba719-44af-4046-bb15-1eef3b55e09c	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	3726f467-8872-4e1f-9ba2-374a59cc176a	\N	2025-03-13 10:08:00	\N	\N
c860dfcc-d4ce-40ff-b3fa-4fbcb126f19e	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	6dac48c7-4f4e-4e3b-b4e0-0007a2531cf6	\N	2025-03-13 10:08:00	\N	\N
163f1192-63f5-4870-97ba-c7a3714023b8	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	41482a61-e322-42ef-a5fc-6d525c2542a6	\N	2025-03-11 20:30:00	\N	\N
1e28ffe3-9f8b-4ce7-b7cf-c466a7fffcf7	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a733b4f4-38c9-4720-8388-4dc47d1343de	\N	2025-03-11 20:30:00	\N	\N
ee448009-e33c-4ef7-a853-cd874ec50df3	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a51c1b7f-9f48-4ff0-ba6d-e9ddd3c0eab6	\N	2025-03-11 20:30:00	\N	\N
ba1b80f8-289e-48b6-8545-684abc0bc3ec	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a3ab5bd5-e345-4cd7-8c46-998665bb3e05	\N	2025-03-11 20:30:00	\N	\N
a3ba331b-2a1a-4de4-a142-ed12e3d7c1c9	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	bbafa0b4-6b4a-45c4-8357-f455f20ae06d	\N	2025-03-10 20:33:00	\N	\N
aa923495-d071-4dff-8196-f243b76ad153	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	86feb425-d462-4b9c-9eb7-f4d2ff0c8696	\N	2025-03-12 20:38:00	\N	\N
0964cf3f-9b35-4f99-9c44-f9aa0f2b4e67	76269788-c718-4340-bd29-6634790ddddc	f1afec29-3685-4132-8230-b7d39ce4d9a3	a1c53153-0c6a-44d9-a114-f890828648bf	\N	2025-03-13 10:08:00	\N	\N
f0d68c20-96e3-484f-b960-8b375b65212f	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	9867c7ff-d3bd-4efc-b2b7-ea425350757b	\N	2025-03-11 20:30:00	\N	\N
c600125a-8983-4c2c-aa73-cee66fd5fa95	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	3ce8216a-1065-4346-a89b-e72df6d96ce5	\N	2025-03-11 20:30:00	\N	\N
2389726f-be5b-4896-bb25-a27c0a4e656b	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	dd902aca-2a6b-47d7-9a55-83ebd5e6af79	\N	2025-03-11 20:30:00	\N	\N
05721d6a-5582-446d-9c73-9d8eaf5f394e	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	7c236248-e0e2-4282-b9f9-29e938492539	\N	2025-03-11 20:30:00	\N	\N
a8670c57-6234-44f5-861c-1dcea1f74a87	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	6dac48c7-4f4e-4e3b-b4e0-0007a2531cf6	\N	2025-03-10 20:33:00	\N	\N
6778fd14-4467-4900-b46e-b9002c513dd8	fd20320c-4120-4bd4-bd82-379fe35b122c	f3588791-91aa-430c-9d12-d8c43892c4cd	\N	\N	2025-03-08 11:50:00	8.000000000000000000000000000000	\N
4e7ec870-1ae3-4ba7-85dd-f39e50d8e64e	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fb0a7aae-0c93-4022-a939-6d25bfd50f1f	\N	2025-03-11 11:51:00	\N	\N
6fe8b4bf-c4c3-4e0e-b87b-24c34ac2e560	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	d332d327-ef27-4775-9683-c23d324abbf4	\N	2025-03-11 20:30:00	\N	\N
2e4d58e2-1adf-4b3a-9f31-1ae7e47af099	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	aa501665-626a-408b-90f6-5bd87b7f54f1	\N	2025-03-10 20:33:00	\N	\N
ab812985-88e4-4669-8e8c-1b20f6277033	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	0a03a698-e5f6-45c3-babf-2f6bdac9cc49	\N	2025-03-11 11:51:00	\N	\N
f1518db2-a504-445c-a631-0bf8de5e78a7	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	1ce1f86e-598f-4d6d-99d4-c21e625a6929	\N	2025-03-11 11:51:00	\N	\N
c0b9fca2-9945-4661-9df9-4f283fcf7db0	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	5f00191a-e560-43ec-8ec1-793ccf929ef8	\N	2025-03-11 20:30:00	\N	\N
750f0b39-2288-4bfe-9601-88cbd41bcb12	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	fa95754b-4c40-4267-9432-53731574a5d3	\N	2025-03-11 20:30:00	\N	\N
373fbc41-fb6e-4671-809c-e84e09a5f9be	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	26352e3f-39b3-4861-bd56-46280b0e7ca0	\N	2025-03-11 20:30:00	\N	\N
34903443-9b11-4823-bd61-697fd6d76c6b	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	fca2efaf-aaa7-4f57-a79b-b2d97c45722a	\N	2025-03-11 20:30:00	\N	\N
1b514a5a-797e-4982-b8da-31eef1831aba	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	f323147f-dc1c-4116-b9f9-08994fbc61ce	\N	2025-03-10 20:33:00	\N	\N
bb39c9ac-0b48-4e21-8ee1-dbb7cd0aa6d0	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	1bd6ad93-a944-4fad-b979-40be6f237849	\N	2025-03-11 11:51:00	\N	\N
75e3c116-e50b-4945-9bdd-8ee7407f5c47	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	4a5aa9ad-3a59-4594-8ad8-da7796878eb8	\N	2025-03-11 11:51:00	\N	\N
025d9b3c-6210-4544-99c6-3eb6df190d71	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	a1c53153-0c6a-44d9-a114-f890828648bf	\N	2025-03-10 20:33:00	\N	\N
21beb001-29f9-442a-89ee-25f0efc221e6	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fb3514d3-4b69-4ac7-9ba8-2c0c7ad09ee9	\N	2025-03-11 11:51:00	\N	\N
79638fb5-5a22-46d6-8cf3-f55a7c12c33e	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a25147a7-50cc-42ed-bc93-b0f1ddb70a6e	\N	2025-03-11 11:51:00	\N	\N
cc77b90e-944a-43e9-a2c4-2fdaa6cfa584	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	f5839b70-98fe-4102-95f8-a3015970f6a7	\N	2025-03-11 11:51:00	\N	\N
a0f8bc0f-d175-4d70-b9ca-0ebb9dd2cfb8	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fc532c16-f1af-4acd-98aa-b1f8c4a857e1	\N	2025-03-12 11:53:00	\N	\N
f1d5c4d0-99ad-4b92-80e9-3374eb581777	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	96431ba6-25c7-4474-9832-586672953cd6	\N	2025-03-12 11:53:00	\N	\N
8f00aa48-03bd-49db-81f1-167a8c4195f1	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	bcbdbccf-5f80-44c3-abc2-52dca2530751	\N	2025-03-12 11:53:00	\N	\N
baf62adf-4b3f-48a9-a88e-120eb743e482	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	bb6461e0-752b-43cb-9d11-5531e6d496d2	\N	2025-03-12 11:53:00	\N	\N
897d25d7-ea8f-4d5f-9065-f681072fd7ff	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	3726f467-8872-4e1f-9ba2-374a59cc176a	\N	2025-03-10 20:33:00	\N	\N
00dac22f-317d-44c3-a098-154338744b87	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	6383b850-30a2-4fc8-942d-7639fe4bc4c0	\N	2025-03-10 20:33:00	\N	\N
872071e0-0592-4246-a97a-7315edfbdcab	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	96431ba6-25c7-4474-9832-586672953cd6	\N	2025-03-10 20:33:00	\N	\N
b7cfbd00-3303-4cba-921e-12d491735991	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	f008fc7d-cf2f-486f-852b-a2e88e86113f	\N	2025-03-12 20:38:00	\N	\N
b89c18e3-2224-476f-9228-fbfab83032c1	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e212dbd6-6c7a-4b60-a2ad-c7280868a9de	\N	2025-03-11 11:51:00	\N	\N
32c36cae-50b3-4a40-a01f-43a23204fa81	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	0a4c6115-9f88-4fb0-8086-f6f1ac57ce25	\N	2025-03-11 11:51:00	\N	\N
7042113e-d093-4aa9-b687-c41f9dcbf7fb	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	07e23ad7-52e6-41c2-bd42-694582dabdf2	\N	2025-03-11 11:51:00	\N	\N
b6d5adda-3aa7-433b-9cef-bc68ca11110c	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	6383b850-30a2-4fc8-942d-7639fe4bc4c0	\N	2025-03-12 11:53:00	\N	\N
a70f171b-b718-418d-b794-fe764cca0526	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	afe243bd-2e38-40fe-b9d1-dde7a5c177ae	\N	2025-03-12 11:53:00	\N	\N
1cc6c0b4-1310-458e-8040-63b68d39078b	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a081caa0-5184-4cab-96dc-f6c6601a67d8	\N	2025-03-12 11:53:00	\N	\N
a66f6caf-6805-407e-a42b-671e1d1d99a5	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	f4c13db0-4d2a-4efc-af90-63d667521d86	\N	2025-03-12 11:53:00	\N	\N
65d07c03-7da6-4dfe-ade0-5331ae590ee1	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	21d970f0-e925-4a19-b17f-dd81ce6d9daf	\N	2025-03-12 11:53:00	\N	\N
44c3d8a0-c504-47e1-92e7-285b71090fa6	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fdbd466d-50a6-41dc-8a7f-a159b7afdef6	\N	2025-03-12 11:53:00	\N	\N
fc5fe8a9-a78a-426e-93bd-f8a2624079f0	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	eb54f7f4-a917-4957-bd25-d6b948b32052	\N	2025-03-12 11:53:00	\N	\N
bd4be5fa-4113-4fe7-9fba-ce913ce07fd9	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	c48ff7d9-df4a-432f-90a7-c819ce939054	\N	2025-03-12 11:53:00	\N	\N
02867c8d-1fd7-4d76-bd76-396b7c87adcd	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	ae36cc75-9261-4233-8a40-b7bab4768a39	\N	2025-03-12 11:53:00	\N	\N
3af26df2-3103-4c28-b63d-34adc34d23ef	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	d3118a3a-2929-40fb-8ba9-3cc1d3f5144a	\N	2025-03-12 11:53:00	\N	\N
2cceadf7-893c-427a-a42c-59937be626bf	76269788-c718-4340-bd29-6634790ddddc	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	c6a7b73f-0e96-4e06-8d65-38948045c58c	\N	2025-03-12 11:53:00	\N	\N
b5cf5cd9-c542-4725-b204-88feb42de632	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	797368ee-d7fa-438b-b06e-b60c67479032	\N	2025-03-15 13:58:00	\N	\N
370d3472-0b0a-4aeb-b7bb-9133179c7ad5	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	d24ca3d6-4562-4d12-9daf-cdbc11df1ff3	\N	2025-03-15 13:58:00	\N	\N
87907259-7944-451e-9b4f-f8ba3d141254	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	479e767b-b238-45ae-8451-d722372e30bc	\N	2025-03-15 13:58:00	\N	\N
c3fab6ce-2eda-4a5e-918c-afe72b95fdae	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	ce5e7b34-5efe-4ba9-b460-c135588b088f	\N	2025-03-15 13:58:00	\N	\N
436d0b39-6b6e-473d-86ab-f425fa7536de	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	69bfe62d-1e43-4caf-8ca7-66b59cf0945f	\N	2025-03-15 13:58:00	\N	\N
1a128e86-b4c1-434e-b7e7-f7e51c3671af	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	7ddba26c-08f2-4181-8ec6-982f51a57743	\N	2025-03-15 13:58:00	\N	\N
146c3a0d-53f6-40c8-911c-34b8f4c6972e	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	8eb6c572-5b1a-47b4-9ea6-b1e31f84815f	\N	2025-03-15 13:58:00	\N	\N
0b5a4c2f-a2d7-4604-8b33-4b60ffdd7723	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	bad7a9f0-4b12-4a69-a931-d08380e575e8	\N	2025-03-15 13:58:00	\N	\N
620199fe-354e-4781-97c3-ee066f902360	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	9867c7ff-d3bd-4efc-b2b7-ea425350757b	\N	2025-03-12 14:13:00	\N	\N
72b00254-357c-4ae1-9399-41479a983906	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	8eb6c572-5b1a-47b4-9ea6-b1e31f84815f	\N	2025-03-12 14:13:00	\N	\N
96be6f78-c262-4aca-8883-56082ef756f3	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	deeadf52-62d8-4aed-992f-2c634c544bde	\N	2025-03-12 14:13:00	\N	\N
e625c113-26f0-4897-a982-9e827bce1f22	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	32d8f0c8-2812-4774-a2db-dec48765fbc3	\N	2025-03-12 14:13:00	\N	\N
7566b6db-cd0c-4b92-9a8d-6d44f17be601	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	41482a61-e322-42ef-a5fc-6d525c2542a6	\N	2025-03-12 14:13:00	\N	\N
1eab56f9-e9f1-4157-8ef2-d2db1b763ab6	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	4dac4fab-0b3f-47f4-8039-5eb68885b867	\N	2025-03-12 14:13:00	\N	\N
48a27785-2f4d-47b4-8054-fa1097a6b0f7	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	33b56818-edf7-42bd-93d3-fa92f66274fa	\N	2025-03-12 14:13:00	\N	\N
105545c5-4c51-41c0-88a1-c1f4dba828a9	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	74a33cba-fc25-46a5-a998-f04326faa001	\N	2025-03-12 14:13:00	\N	\N
19809b16-1221-48cc-ad2c-489f2fde0058	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	18b1be25-b82f-4016-be4a-24ad1211dbcc	\N	2025-03-15 14:19:00	\N	\N
32318f92-baf3-4f2d-bdbf-7aabc9ba8970	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	7d9981a3-b99b-4036-85ec-2ddc6517bf42	\N	2025-03-12 14:13:00	\N	\N
a6ae3323-6e95-45a5-a5a1-457c5fa2867e	4ac2b819-a667-4371-9396-d42cb622a0ea	f1afec29-3685-4132-8230-b7d39ce4d9a3	9d4cee0f-b79b-4ce2-9e80-ea96dbf7763b	\N	2025-03-15 14:19:00	\N	\N
46a100ae-46da-46fa-8101-0294bf6593c3	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	6953b2c8-01a6-4e7f-a809-d3aeac589ec0	\N	2025-03-12 14:13:00	\N	\N
3af0180a-7c25-4d4f-b84a-b56c7dfade87	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	b58192d8-e35b-4f9c-aaa6-24140e8272fc	\N	2025-03-12 14:13:00	\N	\N
4c390303-c8c1-47c2-ae84-8575c5bf8dc3	4ac2b819-a667-4371-9396-d42cb622a0ea	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e5fc2cb3-7620-4112-be4b-a1abddde0365	\N	2025-03-12 14:13:00	\N	\N
817815b6-5cda-4efe-98f0-6d40ec6066b4	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	ae0397c6-4b2c-4e6f-9c2a-732ec396c598	\N	2025-03-15 14:22:00	\N	\N
31d5de84-e8f4-4f19-b702-07e5436b25fc	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	88652b5c-bebe-49c5-8b10-bf9298d40195	\N	2025-03-15 14:22:00	\N	\N
2124a684-5138-4601-ba79-9d2bed26f8f9	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	d39f621b-b7a2-42f4-b9a1-6c75e8ac101c	\N	2025-03-15 14:22:00	\N	\N
1a2ed4f3-eef5-4637-85fb-ff267297624f	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	2a8a107c-523a-4d99-aeaa-9925b85bc8c2	\N	2025-03-15 14:22:00	\N	\N
09852bdd-614d-48de-acaa-6628a841644f	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	818c6968-9ecd-4db5-a900-5afab0406640	\N	2025-03-15 14:22:00	\N	\N
6f8732de-ce5a-4399-bae8-bae4ab0c1715	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a76cc3d5-e677-47f3-9f02-ebb0c79503ff	\N	2025-03-15 14:22:00	\N	\N
cac12706-874a-4465-9d65-6ac6597a2d47	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	79198527-71fe-43d3-93ec-fe3d6c64d20c	\N	2025-03-15 14:22:00	\N	\N
c066ee85-3bef-40c7-8c8e-f0841d6bc6a3	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	390c631b-e6a4-4eb4-b372-9a991d5c2de1	\N	2025-03-15 14:22:00	\N	\N
4d0e1c6d-e804-434b-8db6-9977e485844a	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	b1bbd045-abd9-40da-a78b-5f60db643670	\N	2025-03-15 14:22:00	\N	\N
228c573f-c771-4e9b-b1c1-31ad190633bf	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	fa0df1ef-18bb-4511-abfd-fc8869f68a2c	\N	2025-03-15 14:22:00	\N	\N
8af2bda4-b533-4f65-b15d-6ef610100174	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	774c26fe-4d31-4326-a372-b57fe7ecdf27	\N	2025-03-15 14:35:00	\N	\N
2c2d79d5-3650-4d39-b8ab-99a1a76610d0	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a7f4f78d-f4b6-48c5-85e5-32aedeca5266	\N	2025-03-15 14:35:00	\N	\N
2b6daff8-f8f3-4416-9a21-b05b472164ca	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	3a0b5de5-a2a5-4aa8-adac-46711fff9760	\N	2025-03-15 14:35:00	\N	\N
88a4eda1-747c-49e3-83c7-e811c08f2477	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	87f66827-72ea-4601-8074-90df4112bf9e	\N	2025-03-15 14:35:00	\N	\N
cf902a86-396e-401f-849a-7f7c4f257ade	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	8613cc8e-6c0c-4fbb-9b08-e050ab303f59	\N	2025-03-15 14:35:00	\N	\N
da28e6f4-7b37-4cc2-9f14-486acfb65741	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e7b7eb6b-baf2-49a4-88c0-55af78cd5ba3	\N	2025-03-15 14:35:00	\N	\N
c36b5ef3-6a6d-4f44-a24c-bce066a86b2f	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	51d56b56-6de6-4a70-acac-941904743202	\N	2025-03-15 14:35:00	\N	\N
19039aac-9cdc-4103-b8c4-848028798d8c	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	23667994-9046-417f-a79a-f939987a902a	\N	2025-03-15 14:35:00	\N	\N
988df919-7049-4a47-8ad1-2a9d90e7abaa	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	ca2b58c3-1725-4f12-9142-6b8e5e4bb211	\N	2025-03-15 14:35:00	\N	\N
bfc5e4bc-2cfa-40b9-8b86-6a2a1cef55eb	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	182c2e51-4702-4273-ab5a-7c64200c0746	\N	2025-03-15 14:35:00	\N	\N
b046b525-f12d-48de-a2ad-df5d90b4e8cd	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e2d7e9d4-dcb8-47bd-b745-b9dc380cc1a3	\N	2025-03-14 14:47:00	\N	\N
48767786-dc63-404b-86a8-f4e24314bcd1	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	3be028d9-01a3-4ab9-a1f5-9c05aff3e2d7	\N	2025-03-14 14:47:00	\N	\N
73aa97c1-78a3-4928-aa2e-df955c45294a	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	47bdea20-40d4-4418-a120-39c54be0b69c	\N	2025-03-14 14:47:00	\N	\N
b263ec18-caf3-43f1-9224-a31fb9d52a55	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	412bc072-99ba-4811-a2d9-9e1bd1f49705	\N	2025-03-14 14:47:00	\N	\N
14ae98e4-5d2c-40ca-87db-0605790b9fd1	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	751c6384-02dc-45b1-9df0-81fb810e2301	\N	2025-03-14 14:47:00	\N	\N
d561be33-3199-4456-9301-26142bbd5f66	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	3ce8216a-1065-4346-a89b-e72df6d96ce5	\N	2025-03-14 14:47:00	\N	\N
2d5533a1-1e48-4dfc-9965-631ff7c1eff1	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a1be233c-73f5-441a-8406-af1669469c73	\N	2025-03-14 14:47:00	\N	\N
58a60b12-7695-4712-a8bb-3523b5b39450	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	c7b9094d-7b2b-4e6c-bfd0-9ff0b27e50cb	\N	2025-03-14 14:47:00	\N	\N
14d43619-7e5a-4895-922d-15753feb3c51	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	b8a5def4-3743-4bcb-85d6-0dfaef34861a	\N	2025-03-14 14:47:00	\N	\N
e85c8395-944e-47d8-a44b-db971883cf02	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	dab18118-e41b-435f-bece-0073eec25748	\N	2025-03-14 14:47:00	\N	\N
7d4f92e7-08b6-4499-b69c-7f79898ea2a9	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e24613b2-3592-4332-a332-361d72a6e948	\N	2025-03-14 14:47:00	\N	\N
2145657c-ead2-4b20-9d35-4e407d4df199	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	52851dc1-9bc7-4b9f-9156-074d3a005be3	\N	2025-03-14 14:47:00	\N	\N
591cba9a-a608-4e9a-a3d2-de7452fa28f7	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	7ddba26c-08f2-4181-8ec6-982f51a57743	\N	2025-03-14 14:47:00	\N	\N
307758a2-919d-4896-a952-afa2fdbbebff	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	d24ca3d6-4562-4d12-9daf-cdbc11df1ff3	\N	2025-03-14 14:47:00	\N	\N
8c1e78c9-dd5a-428e-b395-8375e943f9a9	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	797368ee-d7fa-438b-b06e-b60c67479032	\N	2025-03-14 14:47:00	\N	\N
1e8f1b3f-54f5-4fba-9bd3-fecb15125140	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	44a24f03-8bbf-4002-b4ce-a7ac6ad21926	\N	2025-03-14 14:47:00	\N	\N
f2adb000-4988-4232-819d-38fc9355b716	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	f8e2af02-0e7b-49a6-8905-e3b873f0469f	\N	2025-03-14 14:47:00	\N	\N
11a752dc-9398-40fe-b593-dc8f92358653	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	364282fa-7253-4420-b2bc-4e12e51985f9	\N	2025-03-14 14:47:00	\N	\N
8e11b641-af1b-4f8f-9a3e-11b73bde1744	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	516443c7-5d0e-48f2-9d60-41c3a25b1e35	\N	2025-03-14 14:47:00	\N	\N
86c90650-fc63-491f-919e-e43e053f2ad8	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	a10cf89d-c57f-4a62-9fb1-119edefe636f	\N	2025-03-14 14:47:00	\N	\N
af4a863e-b135-46ed-a100-eebd3357a202	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	e21e46cf-2383-46a6-b841-5cd8585310a0	\N	2025-03-14 14:47:00	\N	\N
4ef48695-043e-4bc0-ac5a-4db1a9c99b09	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	d3981126-c996-457f-9b9a-2421e3f2aa9e	\N	2025-03-14 14:47:00	\N	\N
7bcceb67-6033-43a1-bfeb-53d99b75a921	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	93975bc5-c8f0-4c51-86d7-29926d2f24b9	\N	2025-03-14 14:47:00	\N	\N
ae3d5834-7a79-4a4c-ac2c-7a552b6bd425	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	98525d40-eee6-4aeb-bd86-2cdeecf6f444	\N	2025-03-14 14:47:00	\N	\N
92915ef9-89cf-4c34-a9d0-8574514ca752	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	24d815a4-7649-44c1-8b67-a93752b0bf8d	\N	2025-03-14 14:47:00	\N	\N
2606363e-ceb9-446c-93e8-c33171df6b11	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	8a77644e-8d6d-4f59-b04e-b8f7f80d46b4	\N	2025-03-14 14:47:00	\N	\N
5aec602c-26eb-4888-b775-6716f48354b6	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	84b66909-d79c-4906-9c86-7f3d24139942	\N	2025-03-14 14:47:00	\N	\N
1cb07ab0-89af-4452-b656-311360743c4c	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	3998df44-aa1d-42cc-9fd2-cdf5ef055b3a	\N	2025-03-14 14:47:00	\N	\N
1a95625b-d582-4de1-a932-de96e7714403	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	8985e007-5aea-41ae-83d9-104ff755fca3	\N	2025-03-14 14:47:00	\N	\N
aa624f6b-395d-46e9-b05d-d466d1d2db05	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	69bfe62d-1e43-4caf-8ca7-66b59cf0945f	\N	2025-03-14 14:47:00	\N	\N
674fe20e-9949-451a-b7ca-1eae56d4dcc1	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	18b1be25-b82f-4016-be4a-24ad1211dbcc	\N	2025-03-14 14:47:00	\N	\N
4a65acba-e790-40df-83a4-10e48000ca88	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	af0b583f-2864-436e-a71a-1cc742eebcf0	\N	2025-03-14 14:47:00	\N	\N
b849f856-fca5-47dd-9fd4-be45e99c03bb	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	17026669-dc68-4a75-ad81-958098618536	\N	2025-03-14 14:47:00	\N	\N
bea73c67-4d4a-4487-856c-803050c0ced6	54b4ceec-7c75-4aff-8b08-6333b1849cf8	b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	8df3c997-06e6-4d60-b941-8a19a6cbf8de	\N	2025-03-14 14:47:00	\N	\N
2cba56f3-d04c-493a-a498-153ca41af3a1	f5eeadc7-c8f8-4ff1-b205-945afd554a96	ccc27a15-e2e3-4629-bb95-cef43e631311	f66035ca-88b2-4751-ae44-4bfc3df3ddd9	\N	2025-03-14 19:15:00	\N	\N
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: maestro
--

COPY public.tasks (id, name, description, type, status, complexity, tags, estimated_time, project_id, created_at, updated_at) FROM stdin;
b42a1f15-1e3a-4153-80c0-15a5c9fbbdfb	Збірка рами	Результат: \nЗібрана рама, з променями, стійками, болтами на стек, моторами і неусадженою термозбіжкою на промінях	PRODUCT	NEW	\N	\N	12.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
ccc27a15-e2e3-4629-bb95-cef43e631311	Пайка моторів	Напаяні мотори, гребінкою, промиті і пролаковані контакти	PRODUCT	NEW	5	\N	12.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
f1afec29-3685-4132-8230-b7d39ce4d9a3	Фінальна збірка	Установка втх\nустановка ПК\nУстановка камери\nУстановка РХ\nКришка і стяжки	PRODUCT	NEW	7	\N	23.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
1b33a79e-9790-49bc-8bb3-c7efc8d20832	Налаштування		PRODUCT	NEW	\N	\N	15.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
7cf25d99-7da4-4437-86dc-3bb79b7db073	Обліт		PRODUCT	NEW	\N	\N	10.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
b984449d-3e0c-43fb-9209-e3a5fd7f3733	Усадка термозбіжок		PRODUCT	NEW	\N	\N	3.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
0290a525-b422-4a2d-9a9c-48a0ed38de78	Розпаковка рам		GENERAL	NEW	5	\N	0.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
cf2f35ed-f1c6-424e-80b8-04fc1a082a60	Сортування болтів		GENERAL	NEW	\N	\N	0.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
f1ef797a-b1ed-46fa-9341-6b661cd4848a	Порізка термозбіжки		GENERAL	NEW	\N	\N	0.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
406f31ba-96a2-4328-aca2-2ead65149553	Натягання термозбіжок на проміні		GENERAL	NEW	\N	\N	0.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
3e3e8139-1872-429e-a284-014f912d309c	Тонка пайка	ELRS припаяний до ПК. Припаяний дріт ПІ	INTERMEDIATE	NEW	4	\N	15.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
2bd3b08c-5ef4-4da0-b178-1676cd40db25	Пайка силових дротів	ESC з силовими дротами і конденсатором. Промитий. Пролакований	INTERMEDIATE	NEW	4	\N	10.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-13 00:33:45.533	2025-03-13 00:33:45.533
f3588791-91aa-430c-9d12-d8c43892c4cd	Нарізка моторів		GENERAL	NEW	\N	\N	0.000000000000000000000000000000	f26cc409-bfb4-453f-82fe-9e7fe5fc4847	2025-03-15 11:36:18.926	2025-03-15 11:36:18.926
\.


--
-- Name: ClientContacts ClientContacts_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."ClientContacts"
    ADD CONSTRAINT "ClientContacts_pkey" PRIMARY KEY (id);


--
-- Name: Clients Clients_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Clients"
    ADD CONSTRAINT "Clients_pkey" PRIMARY KEY (id);


--
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY (id);


--
-- Name: ProjectUsers ProjectUsers_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."ProjectUsers"
    ADD CONSTRAINT "ProjectUsers_pkey" PRIMARY KEY (user_id, project_id);


--
-- Name: Projects Projects_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Projects"
    ADD CONSTRAINT "Projects_pkey" PRIMARY KEY (id);


--
-- Name: Skills Skills_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Skills"
    ADD CONSTRAINT "Skills_pkey" PRIMARY KEY (id);


--
-- Name: TaskLogStatusHistory TaskLogStatusHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."TaskLogStatusHistory"
    ADD CONSTRAINT "TaskLogStatusHistory_pkey" PRIMARY KEY (id);


--
-- Name: UserSkills UserSkills_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."UserSkills"
    ADD CONSTRAINT "UserSkills_pkey" PRIMARY KEY (user_id, skill_id);


--
-- Name: UserTokens UserTokens_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "UserTokens_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: task_logs task_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: Products_code_project_id_key; Type: INDEX; Schema: public; Owner: maestro
--

CREATE UNIQUE INDEX "Products_code_project_id_key" ON public."Products" USING btree (code, project_id);


--
-- Name: Skills_name_key; Type: INDEX; Schema: public; Owner: maestro
--

CREATE UNIQUE INDEX "Skills_name_key" ON public."Skills" USING btree (name);


--
-- Name: Users_email_key; Type: INDEX; Schema: public; Owner: maestro
--

CREATE UNIQUE INDEX "Users_email_key" ON public."Users" USING btree (email);


--
-- Name: ClientContacts ClientContacts_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."ClientContacts"
    ADD CONSTRAINT "ClientContacts_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Clients"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Products Products_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_project_id_fkey" FOREIGN KEY (project_id) REFERENCES public."Projects"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProjectUsers ProjectUsers_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."ProjectUsers"
    ADD CONSTRAINT "ProjectUsers_project_id_fkey" FOREIGN KEY (project_id) REFERENCES public."Projects"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProjectUsers ProjectUsers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."ProjectUsers"
    ADD CONSTRAINT "ProjectUsers_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Projects Projects_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."Projects"
    ADD CONSTRAINT "Projects_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Clients"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TaskLogStatusHistory TaskLogStatusHistory_task_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."TaskLogStatusHistory"
    ADD CONSTRAINT "TaskLogStatusHistory_task_log_id_fkey" FOREIGN KEY (task_log_id) REFERENCES public.task_logs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TaskLogStatusHistory TaskLogStatusHistory_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."TaskLogStatusHistory"
    ADD CONSTRAINT "TaskLogStatusHistory_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSkills UserSkills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."UserSkills"
    ADD CONSTRAINT "UserSkills_skill_id_fkey" FOREIGN KEY (skill_id) REFERENCES public."Skills"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSkills UserSkills_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."UserSkills"
    ADD CONSTRAINT "UserSkills_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserTokens UserTokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public."UserTokens"
    ADD CONSTRAINT "UserTokens_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_logs task_logs_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_product_id_fkey FOREIGN KEY (product_id) REFERENCES public."Products"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: task_logs task_logs_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_logs task_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maestro
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public."Projects"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: maestro
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

