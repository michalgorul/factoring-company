create table company
(
    id           bigserial
        constraint company_pkey
            primary key,
    company_name varchar(50) not null,
    country      varchar(50) not null,
    city         varchar(50) not null,
    street       varchar(50) not null,
    postal_code  varchar(15),
    nip          varchar(10) not null,
    regon        varchar(14) not null
);

INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (2, 'Roombo', 'China', 'Longfeng', 'Jackson', '366041', '1096810192', '693610026');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (3, 'Reallinks', 'Japan', 'Matsutō', 'John Wall', '929-0203', '5347068072', '693610026');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (4, 'Skyba', 'Vietnam', 'Thị Trấn Nho Quan', 'Carey', '366041', '1169915609', '076434653');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (5, 'Geba', 'Argentina', 'San Antonio', 'Northview', '4503', '1159006420', '711991718');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (6, 'Quinu', 'Portugal', 'Campinho', 'Dryden', '7200-505', '5354118374', '714974063');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (8, 'Dynava', 'Poland', 'Lipie', 'Sloan', '42-165', '1096810192', '693610026');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (10, 'Camimbo', 'Russia', 'Prokhladnyy', 'Elmside', '366041', '1169915609', '714974063');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (11, 'Wordpedia', 'Mexico', 'La Esperanza', 'Mandrake', '87076', '1159006420', '693610026');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (12, 'Dabshots', 'Russia', 'Novoshakhtinsk', 'Saint Paul', '346930', '5347068072', '852690730');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (13, 'Yadel', 'Portugal', 'Praia de Mira', 'Old Gate', '3070-725', '1159006420', '714974063');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (14, 'Jayo', 'China', 'Mamu', 'Becker', '445564', '5292669645', '291819869');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (16, 'Mynte', 'South Korea', 'Fuyo', 'Loomis', '445564', '5354118374', '374700130');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (18, 'Youtags', 'Brazil', 'Igarapava', 'Pine View', '14540-000', '1169915609', '076434653');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (19, 'Photobean', 'Indonesia', 'Babakankiray', 'Hazelcrest', '445564', '5347068072', '291819869');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (20, 'Gigazoom', 'United States', 'Amarillo', 'Fuller', '79171', '1159006420', '711991718');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (15, 'Voonte', 'France', 'Saint-Quentin-en-Yvelines', 'Cambridge', '78067', '1096810192', '714974063');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (7, 'Obaa', 'China', 'Shuibian', 'Cottonwood', '366041', '5354118371', '076434652');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (23, 'Asd', 'Albania', 'Asd', 'Asd', '132', '123', '1323');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (24, 'Asd', 'Albania', 'Asd', 'Asd', '123', '1233123', '1234535');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (1, 'Google', 'Poland', 'Cisaat', 'North Pass', '40893', '1389431167', '168046322128');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (9, 'Eazzy', 'Argentina', 'San José de Feliciano', 'Northfield', '3187', '6340137913', '711991718');
INSERT INTO company (id, company_name, country, city, street, postal_code, nip, regon)
VALUES (17, 'Oozz', 'Russia', 'Severomorsk', 'Acker', '445564', '6340137913', '291819869');


create table bank_account
(
    id                  bigserial
        constraint bank_account_pkey
            primary key,
    bank_swift          varchar(8)  not null,
    bank_account_number varchar(28) not null,
    bank_name           varchar(50) not null,
    company_id          integer
        constraint bank_account_company_fk
            references company
);

INSERT INTO bank_account (id, bank_swift, bank_account_number, bank_name, company_id)
VALUES (2, 'INGF', 'PL56109024023852652826413581', 'Bank', 23);
INSERT INTO bank_account (id, bank_swift, bank_account_number, bank_name, company_id)
VALUES (3, 'INGBPLPW', 'PL26109024023581471617763254', 'ING Bank Śląski', 17);
INSERT INTO bank_account (id, bank_swift, bank_account_number, bank_name, company_id)
VALUES (1, 'INGBPLPW', 'PL29109024026315757975737284', 'ING Bank Śląski', 3);
INSERT INTO bank_account (id, bank_swift, bank_account_number, bank_name, company_id)
VALUES (4, 'INGPL', 'PL61109024026675336446175781', 'INGG', 1);
INSERT INTO bank_account (id, bank_swift, bank_account_number, bank_name, company_id)
VALUES (5, 'INGPL', 'PL52109024029543952276618365', 'INGG', 11);

create table currency
(
    id   bigserial
        constraint currency_pkey
            primary key,
    name varchar(15) not null,
    code varchar(5)  not null
);


INSERT INTO currency (id, name, code)
VALUES (3, 'Yuan Renminbi', 'CNY');
INSERT INTO currency (id, name, code)
VALUES (7, 'Rupiah', 'IDR');
INSERT INTO currency (id, name, code)
VALUES (9, 'Baht', 'THB');
INSERT INTO currency (id, name, code)
VALUES (12, 'Balboa', 'PAB');
INSERT INTO currency (id, name, code)
VALUES (15, 'Krona', 'SEK');
INSERT INTO currency (id, name, code)
VALUES (17, 'Leone', 'SLL');
INSERT INTO currency (id, name, code)
VALUES (18, 'Zloty', 'PLN');
INSERT INTO currency (id, name, code)
VALUES (20, 'Birr', 'ETB');
INSERT INTO currency (id, name, code)
VALUES (23, 'Euro', 'EUR');
INSERT INTO currency (id, name, code)
VALUES (24, 'Real', 'BRL');
INSERT INTO currency (id, name, code)
VALUES (25, 'Ruble', 'RUB');
INSERT INTO currency (id, name, code)
VALUES (26, 'Dirham', 'MAD');
INSERT INTO currency (id, name, code)
VALUES (28, 'Koruna', 'CZK');
INSERT INTO currency (id, name, code)
VALUES (29, 'Franc', 'XOF');
INSERT INTO currency (id, name, code)
VALUES (32, 'Lempira', 'HNL');
INSERT INTO currency (id, name, code)
VALUES (34, 'Dollar', 'USD');
INSERT INTO currency (id, name, code)
VALUES (35, 'Hryvnia', 'UAH');
INSERT INTO currency (id, name, code)
VALUES (37, 'Rupee', 'PKR');
INSERT INTO currency (id, name, code)
VALUES (38, 'Lev', 'BGN');
INSERT INTO currency (id, name, code)
VALUES (40, 'Cordoba', 'NIO');
INSERT INTO currency (id, name, code)
VALUES (43, 'Pound', 'EGP');
INSERT INTO currency (id, name, code)
VALUES (45, 'Quetzal', 'GTQ');
INSERT INTO currency (id, name, code)
VALUES (46, 'Peso', 'UYU');
INSERT INTO currency (id, name, code)
VALUES (6, 'Dram', 'AMD');

create table payment_type
(
    id                bigserial
        constraint payment_type_pkey
            primary key,
    payment_type_name varchar(24) not null
);

INSERT INTO payment_type (id, payment_type_name)
VALUES (1, 'Cash');
INSERT INTO payment_type (id, payment_type_name)
VALUES (3, 'Debit card');
INSERT INTO payment_type (id, payment_type_name)
VALUES (4, 'Credit cards');
INSERT INTO payment_type (id, payment_type_name)
VALUES (5, 'Mobile payment');
INSERT INTO payment_type (id, payment_type_name)
VALUES (6, 'Electronic bank transfer');
INSERT INTO payment_type (id, payment_type_name)
VALUES (2, 'Check');


create table "user"
(
    id          bigserial
        constraint user_pkey
            primary key,
    username    varchar(50)           not null,
    password    varchar(150)          not null,
    email       varchar(50)           not null,
    first_name  varchar(50)           not null,
    last_name   varchar(50)           not null,
    country     varchar(50)           not null,
    city        varchar(50)           not null,
    street      varchar(50)           not null,
    postal_code varchar(50),
    phone       varchar(50)           not null,
    company_id  integer
        constraint user_company_fk
            references company,
    locked      boolean default false not null,
    enabled     boolean default false not null
);


create unique index user_email_uindex
    on "user" (email);

INSERT INTO "user" (id, username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id, locked, enabled)
VALUES (20, 'asdsad', '$2a$12$FPbp/1x1ewcRiWP8xi.t9etZy.Dzfrtke0mQC65YmcpoaJdripkpK', 'michal1gorul@gmail.com',
        'michalgorul@gmail.co', '+48692195554', 'Polska', 'Katowice', 'Paderewskiego 9', '40-281', '+4812122112', null,
        false, true);
INSERT INTO "user" (id, username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id, locked, enabled)
VALUES (19, 'asdasd', '$2a$12$3CdscNo1zpjNhYrNyRct7Og7Kg0Sqv1ey1ZxOOcrr5OmvYBWnbqYi', 'michalgorul@gmail.com',
        'michalgorul@gmail.com', '+48692195554', 'Polska', 'Katowice', 'Paderewskiego 9', '40-281', '+48692195554', 23,
        false, true);
INSERT INTO "user" (id, username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id, locked, enabled)
VALUES (1, 'admin', '$2a$10$ocYCca1ClRCppPb41t9dj.1FfRVUzFVxiUVDTV0hwtJALvWm8VAie', 'test@test.com', 'John', 'Wick',
        'United States', 'New York', 'Waywood Circle', '93144', '+48888888888', 1, false, true);

create table confirmation_token
(
    id           bigserial
        constraint confirmation_token_pkey
            primary key,
    token        varchar(150) not null,
    created_at   timestamp    not null,
    expires_at   timestamp    not null,
    confirmed_at timestamp,
    user_id      integer
        constraint confirmation_token_user_fk
            references "user"
);


INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (15, 'f831bb93-c77d-42c0-b5f2-1ba6e7609a63', '2021-10-24 02:46:47.125126', '2021-10-24 03:01:47.125126',
        '2021-10-24 02:51:17.496401', 19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (16, '1a267c3a-8e30-4af7-82dd-3831d902ce99', '2021-10-24 12:58:01.621866', '2021-10-24 13:13:01.621866', null,
        20);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (17, 'bb5269d9-785c-4e8e-ac9d-05f0c4bc6d5f', '2021-10-27 21:31:02.642914', '2021-10-27 22:01:02.643914',
        '2021-10-27 21:32:47.656515', 19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (18, 'fe0f1d74-b014-4b7e-ac93-9e0d44c00de8', '2021-10-27 21:38:08.355978', '2021-10-27 22:08:08.356978', null,
        19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (19, 'd651e3ae-da35-47e1-9a40-397257095f12', '2021-10-27 22:47:21.704944', '2021-10-27 23:17:21.704944', null,
        19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (20, 'de144598-b02e-42bb-a167-4d1647b24322', '2021-10-27 22:47:58.116170', '2021-10-27 23:17:58.117170', null,
        19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (21, 'cd6fa8d1-5465-470a-9cee-282601236251', '2021-10-27 22:53:07.455447', '2021-10-27 23:23:07.455447',
        '2021-10-27 22:53:53.293070', 19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (22, '61baac62-6a4f-4878-a6c6-ddd6f811e8a7', '2021-10-27 23:14:18.713123', '2021-10-27 23:44:18.713123',
        '2021-10-27 23:14:58.242147', 19);
INSERT INTO confirmation_token (id, token, created_at, expires_at, confirmed_at, user_id)
VALUES (23, 'f5597607-e0ef-4a18-80af-b4204adae2a6', '2021-10-27 23:21:46.385478', '2021-10-27 23:51:46.385478', null,
        19);


create table credit
(
    id                    bigserial
        constraint credit_pkey
            primary key,
    credit_number         varchar(15)   not null,
    amount                numeric(8, 2) not null,
    next_payment          numeric(8, 2) not null,
    installments          integer       not null,
    balance               numeric(8, 2) not null,
    rate_of_interest      numeric(4, 2) not null,
    next_payment_date     date          not null,
    creation_date         date          not null,
    last_installment_date date          not null,
    user_id               integer       not null
        constraint invoice_user_fk
            references "user",
    status                varchar(50),
    commission            varchar(20),
    payment_day           integer,
    insurance             varchar(20),
    one_time_commission   numeric(8, 2)
);


INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (10, '8/11/2021', 28063.31, 1477.02, 19, 0.00, 7.77, '2021-12-01', '2021-11-16', '2023-06-01', 1, 'processing',
        'credited', 1, 'noProtection', 0.00);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (11, '11/11/2021', 47140.00, 47140.00, 1, 0.00, 0.00, '2021-12-01', '2021-11-16', '2021-12-01', 1, 'processing',
        'automatic', 1, 'noProtection', 3662.78);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (15, '15/11/2021', 1.00, 1.00, 1, 0.00, 0.00, '2021-12-01', '2021-11-16', '2021-12-01', 1, 'processing',
        'noProtection', 1, 'credited', 0.08);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (16, '16/11/2021', 1.00, 1.00, 1, 0.00, 0.00, '2021-12-01', '2021-11-16', '2021-12-01', 1, 'processing',
        'noProtection', 1, 'credited', 0.08);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (3, '#89bbad', 7173.01, 16609.79, 55, 74154.42, 6.55, '2021-03-26', '2021-08-05', '2020-12-03', 1, 'funded',
        'automatic', 1, 'noProtection', 0.00);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (12, '12/11/2021', 100000.00, 0.00, 0, 0.00, 0.00, '2022-05-01', '2021-11-16', '2021-12-01', 1, 'funded',
        'noProtection', 1, 'credited', 113.44);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (7, '1/11/2021', 100000.00, 2000.00, 4, 8000.00, 7.77, '2023-05-28', '2021-11-15', '2026-01-15', 1, 'active',
        'automatic', 29, 'noProtection', 7770.00);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (1, '#d0e034', 49241.46, 74842.96, 86, 9320.62, 1.37, '2021-08-24', '2020-12-16', '2020-09-16', 1, 'funded',
        'automatic', 1, 'noProtection', 0.00);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (13, '13/11/2021', 1670.00, 1670.00, 1, 0.00, 0.00, '2021-12-01', '2021-11-16', '2021-12-01', 1, 'processing',
        'noProtection', 1, 'credited', 129.76);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (14, '14/11/2021', 1.00, 1.00, 1, 0.00, 0.00, '2021-12-01', '2021-11-16', '2021-12-01', 1, 'processing',
        'noProtection', 1, 'credited', 0.08);
INSERT INTO credit (id, credit_number, amount, next_payment, installments, balance, rate_of_interest, next_payment_date,
                    creation_date, last_installment_date, user_id, status, commission, payment_day, insurance,
                    one_time_commission)
VALUES (17, '17/11/2021', 10000.00, 1000.00, 10, 10000.00, 0.00, '2021-12-01', '2021-11-19', '2022-09-01', 1, 'active',
        'automatic', 1, 'noProtection', 777.00);


create table customer
(
    id           bigserial
        constraint customer_pkey
            primary key,
    first_name   varchar(50)  not null,
    last_name    varchar(50)  not null,
    company_name varchar(50)  not null,
    country      varchar(50)  not null,
    city         varchar(50)  not null,
    street       varchar(50)  not null,
    postal_code  varchar(15),
    phone        varchar(15)  not null,
    blacklisted  boolean      not null,
    user_id      integer
        constraint customer_user_fk
            references "user",
    email        varchar(100) not null,
    company_id   integer
        constraint customer_company_fk
            references company
);

create unique index customer_email_uindex
    on customer (email);

INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (30, 'Michalgorul', 'Asdf', 'Adf', 'Algeria', 'Adfs', 'Adf', '16515', '+48692195554', false, 19,
        'michalgorul@gmail.com', 24);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (15, 'Susanne', 'Haverty', 'Wordware', 'Kazakhstan', 'Borovskoy', 'Bluestem Pass', '88815', '+48694586215',
        false, 1, 'test101@test.com', null);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (7, 'Ingemar', 'Verrall', 'Quatz', 'Angola', 'Luanda', '2240 Crownhardt Street', '88815', '656-929-7181', false,
        1, 'test2@test.com', 11);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (19, 'Nettle', 'Haine', 'Oyoloo', 'Belarus', 'Horad Krychaw', '4 Maple Parkway', '6506', '496-477-1000', false,
        1, 'test14@test.com', 15);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (8, 'Loleta', 'Hartles', 'Quire', 'Ethiopia', 'Debre Sīna', '86 Homewood Pass', '88815', '682-786-4649', false,
        1, 'test3@test.com', 7);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (16, 'Evelyn', 'Dowty', 'Oodoo', 'Ukraine', 'Hubynykha', '948 Brickson Park Plaza', '6506', '912-426-1663',
        false, 1, 'test11@test.com', 1);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (6, 'Gaby', 'Hughlin', 'Kwideo', 'Indonesia', 'Pandean', '82074 Iowa Junction', '88815', '117-480-2591', true, 1,
        'test1@test.com', 5);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (27, 'Koo', 'Follows', 'Tanoodle', 'Poland', 'Chodzież', '5 Tennyson Junction', '64-800', '734-486-7799', true,
        1, 'test22@test.com', 6);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (20, 'Audrye', 'Aslie', 'Dynabox', 'Indonesia', 'Tenggun Dajah', '7595 Burrows Avenue', '6506', '303-716-3562',
        false, 1, 'test15@test.com', 2);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (28, 'Kattie', 'Davio', 'Vinder', 'Malaysia', 'Kuantan', '5 Carioca Plaza', '25200', '394-826-8061', false, 1,
        'test23@test.com', 19);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (21, 'Ellene', 'Yeatman', 'Brainverse', 'Norway', 'Kristiansund N', '710 Londonderry Plaza', '6506',
        '563-131-1292', true, 1, 'test16@test.com', 13);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (22, 'Sarette', 'Littlepage', 'Brainverse', 'Malaysia', 'Sandakan', '896 Main Plaza', '90736', '537-122-2464',
        false, 1, 'test17@test.com', 14);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (18, 'Hal', 'Stickells', 'Kwinu', 'Mongolia', 'Huurch', '26639 Hovde Crossing', '6506', '381-381-2281', true, 1,
        'test13@test.com', 20);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (24, 'Shannan', 'Wanek', 'Latz', 'China', 'Yangzhuang', '444 Karstens Court', '6506', '189-749-7687', true, 1,
        'test19@test.com', 4);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (5, 'Leann', 'Vann', 'Zoovu', 'Saudi Arabia', 'Ţubarjal', '4 Susan Place', '88815', '671-735-9741', true, 1,
        'test@test.com', 8);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (23, 'Ezra', 'Lyst', 'Kwinu', 'Philippines', 'Panikihan', '28 Pine View Court', '4307', '623-872-9678', false, 1,
        'test18@test.com', 12);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (10, 'Fredek', 'Attkins', 'Plajo', 'Costa Rica', 'San Juan de Dios', '40708 Lerdahl Alley', '10303',
        '342-689-3793', false, 1, 'test5@test.com', 1);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (11, 'Ulla', 'Caiger', 'BlogXS', 'Ukraine', 'Serednye', '53 Holmberg Lane', '88815', '911-430-7125', false, 1,
        'test6@test.com', 2);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (12, 'Clarey', 'Brimacombe', 'Realbuzz', 'Philippines', 'Banag', '4802 Crest Line Lane', '4234', '821-447-1886',
        false, 1, 'test7@test.com', 5);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (26, 'Rodney', 'Clausewitz', 'Bluezoom', 'China', 'Nanzamu', '24354 Artisan Place', '6506', '418-868-3763',
        false, 1, 'test21@test.com', 18);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (25, 'Urson', 'Topes', 'Zoonoodle', 'Poland', 'Wleń', '8 Meadow Valley Drive', '59-610', '658-756-8147', false,
        1, 'test20@test.com', 10);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (17, 'Ilyse', 'Crim', 'Vinte', 'Vietnam', 'Bến Tre', '39 Carberry Alley', '6506', '467-673-1220', false, 1,
        'test12@test.com', 16);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (14, 'Vale', 'Priter', 'Eamia', 'Jordan', 'Al Azraq ash Shamālī', '7 Sullivan Plaza', '88815', '659-935-4256',
        false, 1, 'test9@test.com', 9);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (9, 'Raleigh', 'Hannon', 'Gabtype', 'Mexico', 'Buenavista', '16 Longview Trail', '88815', '442-792-5781', true,
        1, 'test4@test.com', 17);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (29, 'Kenon', 'Purshouse', 'Bluezoom', 'China', 'Wukang', '523 Becker Hill', '6506', '859-783-0407', false, 1,
        'test24@test.com', 3);
INSERT INTO customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id, email, company_id)
VALUES (13, 'Adrien', 'Nel', 'Oodoo', 'Norway', 'Rennebu', 'Di Loreto Terrace', '7398', '+4812313212', false, 1,
        'test8@test.com', 4);


create table file
(
    id           uuid         not null
        constraint file_pk
            primary key,
    name         varchar(255) not null,
    size         bigint       not null,
    content_type varchar(255) not null,
    data         oid          not null,
    user_id      integer      not null
        constraint "file_user_FK"
            references "user",
    catalog      varchar(50)  not null
);


create table product
(
    id           bigserial
        constraint product_pkey
            primary key,
    name         varchar(50) not null,
    pkwiu        varchar(10) not null,
    measure_unit varchar(8)  not null
);

INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (1, 'sofa', '123.123.1', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (51, 'Monitor', '12.12.11.9', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (2, 'Whmis - Spray Bottle Trigger', '10.11.99.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (3, 'Fib N9 - Prague Powder', '13.95.10.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (4, 'Pepper - Sorrano', '26.30.40.0', 'meters');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (5, 'Chicken - Breast, 5 - 7 Oz', '01.16.19.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (6, 'Beer - Rickards Red', '19.20.23.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (7, 'Bread Fig And Almond', '14.13.35.0', 'seconds');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (8, 'Foam Espresso Cup Plain White', '10.89.16.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (9, 'Spice - Pepper Portions', '26.30.40.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (10, 'Stock - Fish', '26.30.40.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (11, 'Sloe Gin - Mcguinness', '01.26.12.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (12, 'Pepper - Cayenne', '10.39.17.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (13, 'Loquat', '02.10.11.0', 'kilowatt');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (14, 'Carrots - Jumbo', '17.12.34.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (15, 'Ginger - Ground', '19.20.23.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (16, 'Squash - Butternut', '25.94.99.0', 'meters');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (17, 'Pasta - Penne Primavera, Single', '03.00.42.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (18, 'Assorted Desserts', '03.00.42.0', 'kilowatt');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (19, 'Cheese - Mozzarella', '25.94.99.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (20, 'Sobe - Lizard Fuel', '13.95.10.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (21, 'Soup - Campbellschix Stew', '10.61.12.0', 'seconds');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (22, 'Salmon - Fillets', '16.10.13.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (23, 'Tray - 16in Rnd Blk', '19.20.23.0', 'meters');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (24, 'Bacardi Breezer - Tropical', '25.29.99.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (25, 'Sour Puss Sour Apple', '14.13.35.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (26, 'Star Fruit', '14.13.35.0', 'seconds');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (27, 'Tea - Decaf 1 Cup', '26.30.40.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (28, 'Syrup - Monin - Passion Fruit', '01.45.30.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (29, 'Hickory Smoke, Liquid', '01.26.12.0', 'grams');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (30, 'Gherkin', '01.26.12.0', 'galons');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (31, 'Grapefruit - White', '01.26.12.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (32, 'Yogurt - Peach, 175 Gr', '01.26.12.0', 'kilowatt');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (33, 'Salmon Atl.whole 8 - 10 Lb', '01.45.30.0', 'litres');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (34, 'Syrup - Monin - Blue Curacao', '01.45.30.0', 'kilowatt');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (35, 'Eggs - Extra Large', '10.61.12.0', 'number');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (36, 'Water - Spring 1.5lit', '10.61.12.0', 'seconds');
INSERT INTO product (id, name, pkwiu, measure_unit)
VALUES (37, 'Wine - Trimbach Pinot Blanc', '16.10.13.0', 'galons');


create table invoice
(
    id               bigserial
        constraint invoice_pkey
            primary key,
    invoice_number   varchar(50)   not null,
    creation_date    date          not null,
    sale_date        date          not null,
    payment_deadline date          not null,
    to_pay           numeric(8, 2) not null,
    to_pay_in_words  text          not null,
    paid_by_user     numeric(7, 2) not null,
    to_pay_by_user   numeric(7, 2) not null,
    remarks          text,
    customer_id      integer       not null,
    payment_type_id  integer       not null
        constraint invoice_payment_type_fk
            references payment_type,
    currency_id      integer       not null
        constraint invoice_currency_fk
            references currency,
    status           varchar(50)   not null,
    user_id          integer
        constraint invoice_user_fk
            references "user"
);


INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (1, '#3e456a', '2020-12-20', '2021-06-24', '2021-08-28', 302.58, 'suspendisse potenti nullam porttitor', 5790.36,
        5047.72, 'ut volutpat sapien arcu sed augue aliquam erat volutpat', 26, 1, 25, 'funded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (98, '98/10/2021', '2021-10-31', '2021-10-31', '2022-10-31', 3075.00, 'three thousand seventy-five £ 00/100',
        0.00, 3075.00, 'asdsdasd', 7, 3, 18, 'active', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (16, '#5f1af4', '2021-08-04', '2020-10-03', '2021-08-20', 6847.38, 'id ornare', 724.50, 6524.53, null, 5, 4, 23,
        'funded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (64, '#17a2fc', '2021-05-12', '2021-05-17', '2021-03-30', 4769.20, 'nibh in', 6527.01, 4655.06,
        'sit amet eleifend', 14, 5, 9, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (33, '#5611a9', '2021-08-24', '2021-02-02', '2021-01-19', 7210.01, 'interdum eu tincidunt in', 5104.83, 5766.43,
        'nisi venenatis tristique fusce congue diam id ornare', 15, 2, 34, 'funded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (106, '103/10/2021', '2021-10-31', '2021-10-31', '2021-11-23', 329.99, 'three hundred twenty-nine £ 99/100',
        329.99, 0.00, 'tesrt', 19, 1, 15, 'funded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (109, '109/11/2021', '2021-11-21', '2021-11-21', '2021-12-21', 110.00, 'one hundred ten 00/100', 0.00, 111.10,
        '', 7, 4, 9, 'active', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (108, '1/11/2021', '2021-11-08', '2021-11-08', '2021-12-08', 2913.75,
        'two thousand nine hundred thirteen 75/100', 0.00, 2913.75, '', 8, 5, 15, 'active', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (23, '#eb2205', '2020-11-19', '2021-05-29', '2021-04-02', 4545.00,
        'four thousand five hundred forty-five £ 00/100', 5213.49, -668.49, 'eu magna vulputate luctus cum sociis', 22,
        3, 7, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (110, '110/11/2021', '2021-11-21', '2021-11-21', '2021-12-21', 220.00, 'two hundred twenty 00/100', 0.00, 222.20,
        '', 8, 4, 12, 'active', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (25, '#f6e1c4', '2020-10-17', '2020-09-28', '2020-10-22', 7503.70, 'justo morbi', 7851.22, 6176.43, null, 13, 2,
        7, 'funded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (26, '#f48cb9', '2021-07-25', '2021-03-17', '2021-05-12', 9161.47, 'cras pellentesque volutpat', 333.82, 180.70,
        null, 16, 4, 23, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (27, '#05d34c', '2021-08-03', '2020-10-09', '2021-01-11', 2650.40, 'massa tempor convallis', 7220.61, 4258.18,
        'morbi vestibulum velit id pretium iaculis diam erat fermentum', 13, 2, 45, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (31, '#1ddfee', '2020-11-25', '2021-03-17', '2021-04-09', 8308.44, 'egestas metus', 1230.15, 2561.98, null, 12,
        5, 20, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (102, '102/10/2021', '2021-10-31', '2021-10-31', '2021-11-16', 110.00, 'one hundred ten £ 00/100', 0.00, 110.00,
        '', 7, 3, 34, 'unfunded', 1);
INSERT INTO invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words,
                     paid_by_user, to_pay_by_user, remarks, customer_id, payment_type_id, currency_id, status, user_id)
VALUES (86, '#5ebd8e', '2021-07-10', '2021-08-04', '2021-04-28', 5391.39, 'velit vivamus vel', 4727.04, 7833.91, null,
        15, 5, 18, 'unfunded', 1);

create table invoice_item
(
    id          bigserial
        constraint invoice_item_pkey
            primary key,
    quantity    integer       not null,
    net_price   numeric(8, 2) not null,
    net_value   numeric(8, 2) not null,
    vat_rate    numeric(8, 2) not null,
    vat_value   numeric(8, 2) not null,
    gross_value numeric(8, 2) not null,
    product_id  integer       not null
        constraint invoice_item_product_fk
            references product,
    invoice_id  integer       not null
        constraint invoice_item_invoice_fk
            references invoice
            on delete cascade
);



INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (1, 2, 123.00, 246.00, 23.00, 56.58, 302.58, 1, 1);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (74, 2, 100.00, 200.00, 0.10, 20.00, 220.00, 2, 110);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (28, 93, 3769.75, 350586.75, 0.15, 52588.01, 403174.76, 48, 33);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (33, 54, 7347.14, 396745.56, 0.21, 83316.57, 480062.13, 6, 16);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (51, 9, 9196.01, 82764.09, 0.22, 18208.10, 100972.19, 15, 23);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (59, 79, 4655.54, 367787.66, 0.21, 77235.41, 445023.07, 16, 25);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (60, 59, 7049.07, 415895.13, 0.13, 54066.37, 469961.50, 2, 26);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (18, 43, 7849.34, 337521.62, 0.13, 43877.81, 381399.43, 38, 27);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (43, 1, 5486.61, 5486.61, 0.01, 54.87, 5541.48, 15, 31);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (64, 2, 123.00, 246.00, 0.23, 28.29, 274.29, 1, 98);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (66, 1, 100.00, 100.00, 0.10, 10.00, 110.00, 1, 102);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (70, 3, 100.00, 300.00, 0.10, 30.00, 330.00, 2, 106);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (72, 5, 555.00, 2775.00, 0.05, 138.75, 2913.75, 4, 108);
INSERT INTO invoice_item (id, quantity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
VALUES (73, 1, 100.00, 100.00, 0.10, 10.00, 110.00, 5, 109);


create table transaction
(
    id               bigserial
        constraint transaction_pkey
            primary key,
    transaction_date date          not null,
    value            numeric(8, 2) not null,
    user_id          integer       not null,
    invoice_id       integer
        constraint transaction_invoice_fk
            references invoice,
    currency_id      integer
        constraint transaction_currency_fk
            references currency,
    credit_id        integer
        constraint transaction_credit_fk
            references credit,
    name             varchar(50),
    benefit          boolean       not null
);

INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (5, '2021-11-19', 2000.00, 1, null, 34, 12, 'Loan payment', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (7, '2021-11-19', 3000.00, 1, null, 34, 12, 'Loan overpay', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (4, '2021-11-19', 2000.00, 1, null, 34, 12, 'Loan monthly payment', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (11, '2021-11-19', 1950.00, 1, null, 34, 12, 'Loan overpay', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (8, '2021-11-28', 1000.00, 1, null, 34, 12, 'Loan monthly payment', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (6, '2021-11-18', 16609.79, 1, null, 34, 3, 'Loan monthly payment', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (12, '2021-11-07', 50.00, 1, 1, 34, null, 'Loan overpay', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (14, '2021-11-21', 220.00, 1, null, 34, 12, 'Receiving money for an invoice', true);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (16, '2021-10-13', 10000.00, 1, null, 34, 17, 'Loan receive', true);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (10, '2021-09-15', 7173.01, 1, null, 34, 12, 'Loan receive', true);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (13, '2021-07-14', 2000.00, 1, null, 34, 7, 'Loan monthly payment', false);
INSERT INTO transaction (id, transaction_date, value, user_id, invoice_id, currency_id, credit_id, name, benefit)
VALUES (15, '2021-08-13', 329.99, 1, 106, 34, null, 'Invoice payment', true);





























