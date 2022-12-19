CREATE DATABASE chatterio;
\c  chatterio;

-- CREATE TABLE users (
--     user_id SERIAL NOT NULL,
--     username varchar(255) NOT NULL,
--     password varchar(255) NOT NULL,
--     email varchar(255) NOT NULL,
--     PRIMARY KEY (user_id)
-- );


-- -- chatrooms 1:M users
-- CREATE TABLE chatrooms (
--     chatroom_id SERIAL NOT NULL,
--     user_id int NOT NULL,
--     name varchar(255) NOT NULL,
--     private boolean NOT NULL,
--     passcode varchar(255),
--     PRIMARY KEY (chatroom_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id)
-- );

-- -- message M:1 users
-- -- message M:1 chatrooms
-- CREATE TABLE messages (
--     message_id SERIAL NOT NULL,
--     message_text TEXT NOT NULL,
--     user_id int NOT NULL,
--     chatroom_id int NOT NULL,
--     PRIMARY KEY (message_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id),
--     FOREIGN KEY (chatroom_id) REFERENCES chatrooms(chatroom_id)
-- );

-- CREATE TABLE users_chats (
--     row_id SERIAL NOT NULL,
--     user_id int NOT NULL,
--     chat_id int NOT NULL,
--     PRIMARY KEY (row_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id),
--     FOREIGN KEY (chat_id) REFERENCES chatrooms(chatroom_id)
-- );

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

SET default_table_access_method = heap;

--
-- Name: chatrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chatrooms (
    chatroom_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    private boolean NOT NULL,
    passcode character varying(255)
);


ALTER TABLE public.chatrooms OWNER TO postgres;

--
-- Name: chatrooms_chatroom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chatrooms_chatroom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chatrooms_chatroom_id_seq OWNER TO postgres;

--
-- Name: chatrooms_chatroom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chatrooms_chatroom_id_seq OWNED BY public.chatrooms.chatroom_id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    message_id integer NOT NULL,
    message_text text NOT NULL,
    user_id integer NOT NULL,
    chatroom_id integer NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_message_id_seq OWNER TO postgres;

--
-- Name: messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_message_id_seq OWNED BY public.messages.message_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_chats (
    row_id integer NOT NULL,
    user_id integer NOT NULL,
    chat_id integer NOT NULL
);


ALTER TABLE public.users_chats OWNER TO postgres;

--
-- Name: users_chats_row_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_chats_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_chats_row_id_seq OWNER TO postgres;

--
-- Name: users_chats_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_chats_row_id_seq OWNED BY public.users_chats.row_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: chatrooms chatroom_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatrooms ALTER COLUMN chatroom_id SET DEFAULT nextval('public.chatrooms_chatroom_id_seq'::regclass);


--
-- Name: messages message_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN message_id SET DEFAULT nextval('public.messages_message_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users_chats row_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_chats ALTER COLUMN row_id SET DEFAULT nextval('public.users_chats_row_id_seq'::regclass);


--
-- Data for Name: chatrooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.chatrooms (chatroom_id, user_id, name, private) VALUES(1, 1, 'Testowy czat', 't');
INSERT INTO public.chatrooms (chatroom_id, user_id, name, private) VALUES(2, 2, 'soviet2chat', 't');       


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messages (message_id, message_text, user_id, chatroom_id) VALUES(3,'very secure chat',1,2);
INSERT INTO public.messages (message_id, message_text, user_id, chatroom_id) VALUES(4,'much wow',1,2);
INSERT INTO public.messages (message_id, message_text, user_id, chatroom_id) VALUES(5,'so this is my secret key',1,2);
INSERT INTO public.messages (message_id, message_text, user_id, chatroom_id) VALUES(6,'FLAG{IDOR_INSECURE_DIRECT_OBJECT_REFERENCE}',1,2);



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (user_id, username, password, email) VALUES(1,       'soviet',  '$2b$12$275RP1nf0F8yX7ySwwf3OuPx9q2AoGaHK8FyABQLESrupsqU4z1cm',    'user@example.com');
INSERT INTO public.users (user_id, username, password, email) VALUES(2,       'soviet2', '$2b$12$1.ThA31Ir7EPI1zAqjnyhe0hYDC.yXrgUYuPymSUZm283EM6szg7.',    'userdd@example.com');
INSERT INTO public.users (user_id, username, password, email) VALUES(3,       'admin',   '$2b$12$uV36ZWGgjo0CKxAd.Qg7ueJ/RbNo/2gnMn0n9zPuYmFZotLZELlF2',    'admin@admin.com');


--
-- Data for Name: users_chats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users_chats (row_id, user_id, chat_id) VALUES(2,       2,       2);
INSERT INTO public.users_chats (row_id, user_id, chat_id) VALUES(1,       1,       1);



--
-- Name: chatrooms_chatroom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chatrooms_chatroom_id_seq', 2, true);


--
-- Name: messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_message_id_seq', 6, true);


--
-- Name: users_chats_row_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_chats_row_id_seq', 2, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 3, true);


--
-- Name: chatrooms chatrooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatrooms
    ADD CONSTRAINT chatrooms_pkey PRIMARY KEY (chatroom_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);


--
-- Name: users_chats users_chats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_chats
    ADD CONSTRAINT users_chats_pkey PRIMARY KEY (row_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: chatrooms chatrooms_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatrooms
    ADD CONSTRAINT chatrooms_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: messages messages_chatroom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_chatroom_id_fkey FOREIGN KEY (chatroom_id) REFERENCES public.chatrooms(chatroom_id);


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: users_chats users_chats_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_chats
    ADD CONSTRAINT users_chats_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chatrooms(chatroom_id);


--
-- Name: users_chats users_chats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_chats
    ADD CONSTRAINT users_chats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--