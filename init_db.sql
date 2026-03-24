DROP DATABASE IF EXISTS transport_company;

CREATE DATABASE transport_company;
\c transport_company

CREATE TABLE clients (
    c_id SERIAL PRIMARY KEY,
    c_sname VARCHAR(30) NOT NULL,
    c_fname VARCHAR(30) NOT NULL,
    c_pname VARCHAR(30) NOT NULL,
    c_phone VARCHAR(15) NOT NULL
);

CREATE TABLE branches (
    br_id SERIAL PRIMARY KEY,
    br_city VARCHAR(30) NOT NULL,
    br_street VARCHAR(30) NOT NULL,
    br_bld VARCHAR(30) NOT NULL,
    br_phone VARCHAR(15) NOT NULL
);

CREATE TABLE employees (
    e_id SERIAL PRIMARY KEY,
    br_id INTEGER NOT NULL REFERENCES branches(br_id),
    e_sname VARCHAR(30) NOT NULL,
    e_fname VARCHAR(30) NOT NULL,
    e_pname VARCHAR(30) NOT NULL,
    e_post VARCHAR(50) NOT NULL,
    e_phone VARCHAR(15) NOT NULL
);

CREATE TABLE services (
    s_id SERIAL PRIMARY KEY,
    s_name VARCHAR(50) NOT NULL,
    s_desc VARCHAR(200)
);

CREATE TABLE orders (
    o_id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL REFERENCES clients(c_id),
    rec_id INTEGER NOT NULL REFERENCES clients(c_id),
    org_br_id INTEGER NOT NULL REFERENCES branches(br_id),
    dest_br_id INTEGER NOT NULL REFERENCES branches(br_id),
    o_status VARCHAR(20) NOT NULL DEFAULT 'Принят',
    o_city VARCHAR(30),
    o_street VARCHAR(50),
    o_bld VARCHAR(10)
);

CREATE TABLE order_services (
    o_id INTEGER NOT NULL REFERENCES orders(o_id) ON DELETE CASCADE,
    s_id INTEGER NOT NULL REFERENCES services(s_id),
    PRIMARY KEY (o_id, s_id)
);

CREATE TABLE processing_history (
    o_id INTEGER NOT NULL REFERENCES orders(o_id) ON DELETE CASCADE,
    e_id INTEGER NOT NULL REFERENCES employees(e_id),
    op_date TIMESTAMP NOT NULL DEFAULT NOW(),
    op_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (o_id, e_id, op_date)
);

INSERT INTO branches (br_city, br_street, br_bld, br_phone) VALUES 
('Калуга', 'ул. Кирова', '5', '8-800-111'),
('Москва', 'ул. Ленина', '10/1', '8-800-222');

INSERT INTO services (s_name, s_desc) VALUES 
('Страховка', 'Страхование груза от повреждений'),
('Доставка до двери', 'Курьер довезет посылку до квартиры');