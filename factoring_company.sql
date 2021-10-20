create table customer
(
    id           BIGSERIAL   NOT NULL PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    country      VARCHAR(50) NOT NULL,
    city         VARCHAR(50) NOT NULL,
    street       VARCHAR(50) NOT NULL,
    postal_code  VARCHAR(15),
    phone        VARCHAR(15) NOT NULL,
    blacklisted  BOOLEAN     NOT NULL,
    user_id      INT,
    CONSTRAINT customer_user_FK FOREIGN KEY (user_id) REFERENCES "user" (id)

);

create table company
(
    id           BIGSERIAL   NOT NULL PRIMARY KEY,
    company_name VARCHAR(50) NOT NULL,
    country      VARCHAR(50) NOT NULL,
    city         VARCHAR(50) NOT NULL,
    street       VARCHAR(50) NOT NULL,
    postal_code  VARCHAR(15),
    nip          VARCHAR(10) NOT NULL,
    regon        VARCHAR(14) NOT NULL
);

create table currency
(
    id   BIGSERIAL   NOT NULL PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    code VARCHAR(5)  NOT NULL
);

create table status
(
    id   BIGSERIAL   NOT NULL PRIMARY KEY,
    name VARCHAR(24) NOT NULL
);

create table payment_type
(
    id   BIGSERIAL   NOT NULL PRIMARY KEY,
    name VARCHAR(24) NOT NULL
);


create table seller
(
    id           BIGSERIAL   NOT NULL PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    country      VARCHAR(50) NOT NULL,
    city         VARCHAR(50) NOT NULL,
    street       VARCHAR(50) NOT NULL,
    postal_code  VARCHAR(15),
    nip          VARCHAR(10) NOT NULL,
    regon        VARCHAR(14) NOT NULL
);


create table product
(
    id           BIGSERIAL   NOT NULL PRIMARY KEY,
    name         VARCHAR(50) NOT NULL,
    pkwiu        VARCHAR(10) NOT NULL,
    measure_unit VARCHAR(8)  NOT NULL
);

create table bank_account
(
    id                  BIGSERIAL   NOT NULL PRIMARY KEY,
    bank_swift          VARCHAR(8)  NOT NULL,
    bank_account_number VARCHAR(28) NOT NULL,
    bank_name           VARCHAR(16) NOT NULL,
    seller_id           INT,
    company_id          INT,
    CONSTRAINT bank_account_seller_FK FOREIGN KEY (seller_id) REFERENCES seller (id),
    CONSTRAINT bank_account_company_FK FOREIGN KEY (company_id) REFERENCES company (id)
);

create table "user"
(
    id          BIGSERIAL   NOT NULL PRIMARY KEY,
    username    VARCHAR(50) NOT NULL,
    password    VARCHAR(50) NOT NULL,
    email       VARCHAR(50) NOT NULL,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    country     VARCHAR(50) NOT NULL,
    city        VARCHAR(50) NOT NULL,
    street      VARCHAR(50) NOT NULL,
    postal_code VARCHAR(50),
    phone       VARCHAR(50) NOT NULL,
    company_id  INT         NOT NULL,
    CONSTRAINT user_company_FK FOREIGN KEY (company_id) REFERENCES company (id)
);

create table invoice
(
    id               BIGSERIAL     NOT NULL PRIMARY KEY,
    invoice_number   VARCHAR(50)   NOT NULL,
    creation_date    DATE          NOT NULL,
    sale_date        DATE          NOT NULL,
    payment_deadline DATE          NOT NULL,
    to_pay           DECIMAL(8, 2) NOT NULL,
    to_pay_in_words  TEXT          NOT NULL,
    paid             DECIMAL(7, 2) NOT NULL,
    left_to_pay      DECIMAL(7, 2) NOT NULL,
    remarks          TEXT,
    seller_id        INT           NOT NULL,
    customer_id      INT           NOT NULL,
    payment_type_id  INT           NOT NULL,
    currency_id      INT           NOT NULL,
    CONSTRAINT invoice_seller_FK FOREIGN KEY (seller_id) REFERENCES seller (id),
    CONSTRAINT invoice_customer_FK FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT invoice_payment_type_FK FOREIGN KEY (payment_type_id) REFERENCES payment_type (id),
    CONSTRAINT invoice_currency_FK FOREIGN KEY (currency_id) REFERENCES currency (id)
);

create table invoice_item
(
    id          BIGSERIAL     NOT NULL PRIMARY KEY,
    quentity    INT           NOT NULL,
    net_price   DECIMAL(8, 2) NOT NULL,
    net_value   DECIMAL(8, 2) NOT NULL,
    vat_rate    DECIMAL(8, 2) NOT NULL,
    vat_value   DECIMAL(8, 2) NOT NULL,
    gross_value DECIMAL(8, 2) NOT NULL,
    product_id  INT           NOT NULL,
    invoice_id  INT           NOT NULL,
    CONSTRAINT invoice_item_product_FK FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT invoice_item_invoice_FK FOREIGN KEY (invoice_id) REFERENCES invoice (id)
);

create table transaction
(
    id               BIGSERIAL     NOT NULL PRIMARY KEY,
    transaction_date DATE          NOT NULL,
    value            DECIMAL(8, 2) NOT NULL,
    status_id        INT           NOT NULL,
    customer_id      INT           NOT NULL,
    invoice_id       INT           NOT NULL,
    currency_id      INT           NOT NULL,
    CONSTRAINT transaction_status_FK FOREIGN KEY (status_id) REFERENCES status (id),
    CONSTRAINT transaction_customer_FK FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT transaction_invoice_FK FOREIGN KEY (invoice_id) REFERENCES invoice (id),
    CONSTRAINT transaction_currency_FK FOREIGN KEY (currency_id) REFERENCES currency (id)
);

create table "order"
(
    id                 BIGSERIAL     NOT NULL PRIMARY KEY,
    order_number       VARCHAR(50)   NOT NULL,
    order_type         TEXT          NOT NULL,
    order_date         DATE          NOT NULL,
    first_pay_ammount  DECIMAL(8, 2) NOT NULL,
    second_pay_ammount DECIMAL(7, 2) NOT NULL,
    commission_rate    DECIMAL(6, 2) NOT NULL,
    commission_value   DECIMAL(6, 2) NOT NULL,
    invoice_id         INT           NOT NULL,
    user_id            INT           NOT NULL,
    status_id          INT           NOT NULL,
    CONSTRAINT order_invoice_FK FOREIGN KEY (invoice_id) REFERENCES invoice (id),
    CONSTRAINT order_user_FK FOREIGN KEY (user_id) REFERENCES "user" (id),
    CONSTRAINT order_status_FK FOREIGN KEY (status_id) REFERENCES status (id)
);

create table credit
(
    id                    BIGSERIAL     NOT NULL PRIMARY KEY,
    credit_number         VARCHAR(15)   NOT NULL,
    left_to_pay           DECIMAL(8, 2) NOT NULL,
    amount                DECIMAL(8, 2) NOT NULL,
    next_payment          DECIMAL(8, 2) NOT NULL,
    installments          INT           NOT NULL,
    balance               DECIMAL(8, 2) NOT NULL,
    rate_of_interest      DECIMAL(4, 2) NOT NULL,
    next_payment_date     DATE          NOT NULL,
    creation_date         DATE          NOT NULL,
    last_installment_date DATE          NOT NULL,
    user_id               INT           NOT NULL,
    CONSTRAINT invoice_user_FK FOREIGN KEY (user_id) REFERENCES "user" (id)
);

insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (1, 'Arlette', 'Schinetti', 'Buzzdog', 'China', 'Yangping', '6 Elgar Point', '88815', '625-493-4073', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (2, 'Sheila', 'Chamley', 'Gabtype', 'Indonesia', 'Pondohan', '599 Orin Junction', '88815', '355-951-6648', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (3, 'Noelle', 'Capron', 'Snaptags', 'China', 'Ni’ao', '262 Service Drive', '88815', '960-608-6596', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (4, 'Vanessa', 'Goutcher', 'Oyope', 'Azerbaijan', 'Heydərabad', '4 Oxford Road', '88815', '982-321-4319', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (5, 'Leann', 'Vann', 'Zoovu', 'Saudi Arabia', 'Ţubarjal', '4 Susan Place', '88815', '671-735-9741', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (6, 'Gaby', 'Hughlin', 'Kwideo', 'Indonesia', 'Pandean', '82074 Iowa Junction', '88815', '117-480-2591', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (7, 'Ingemar', 'Verrall', 'Quatz', 'Angola', 'Luanda', '2240 Crownhardt Street', '88815', '656-929-7181', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (8, 'Loleta', 'Hartles', 'Quire', 'Ethiopia', 'Debre Sīna', '86 Homewood Pass', '88815', '682-786-4649', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (9, 'Raleigh', 'Hannon', 'Gabtype', 'Mexico', 'Buenavista', '16 Longview Trail', '88815', '442-792-5781', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (10, 'Fredek', 'Attkins', 'Plajo', 'Costa Rica', 'San Juan de Dios', '40708 Lerdahl Alley', '10303',
        '342-689-3793', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (11, 'Ulla', 'Caiger', 'BlogXS', 'Ukraine', 'Serednye', '53 Holmberg Lane', '88815', '911-430-7125', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (12, 'Clarey', 'Brimacombe', 'Realbuzz', 'Philippines', 'Banag', '4802 Crest Line Lane', '4234', '821-447-1886',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (13, 'Adrien', 'Nel', 'Oodoo', 'Norway', 'Rennebu', '7816 Di Loreto Terrace', '7398', '856-812-8363', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (14, 'Vale', 'Priter', 'Eamia', 'Jordan', 'Al Azraq ash Shamālī', '7 Sullivan Plaza', '88815', '659-935-4256',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (15, 'Susanne', 'Haverty', 'Wordware', 'Kazakhstan', 'Borovskoy', '2120 Bluestem Pass', '88815', '294-314-2973',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (16, 'Evelyn', 'Dowty', 'Oodoo', 'Ukraine', 'Hubynykha', '948 Brickson Park Plaza', '6506', '912-426-1663',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (17, 'Ilyse', 'Crim', 'Vinte', 'Vietnam', 'Bến Tre', '39 Carberry Alley', '6506', '467-673-1220', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (18, 'Hal', 'Stickells', 'Kwinu', 'Mongolia', 'Huurch', '26639 Hovde Crossing', '6506', '381-381-2281', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (19, 'Nettle', 'Haine', 'Oyoloo', 'Belarus', 'Horad Krychaw', '4 Maple Parkway', '6506', '496-477-1000', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (20, 'Audrye', 'Aslie', 'Dynabox', 'Indonesia', 'Tenggun Dajah', '7595 Burrows Avenue', '6506', '303-716-3562',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (21, 'Ellene', 'Yeatman', 'Brainverse', 'Norway', 'Kristiansund N', '710 Londonderry Plaza', '6506',
        '563-131-1292', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (22, 'Sarette', 'Littlepage', 'Brainverse', 'Malaysia', 'Sandakan', '896 Main Plaza', '90736', '537-122-2464',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (23, 'Ezra', 'Lyst', 'Kwinu', 'Philippines', 'Panikihan', '28 Pine View Court', '4307', '623-872-9678', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (24, 'Shannan', 'Wanek', 'Latz', 'China', 'Yangzhuang', '444 Karstens Court', '6506', '189-749-7687', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (25, 'Urson', 'Topes', 'Zoonoodle', 'Poland', 'Wleń', '8 Meadow Valley Drive', '59-610', '658-756-8147', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (26, 'Rodney', 'Clausewitz', 'Bluezoom', 'China', 'Nanzamu', '24354 Artisan Place', '6506', '418-868-3763',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (27, 'Koo', 'Follows', 'Tanoodle', 'Poland', 'Chodzież', '5 Tennyson Junction', '64-800', '734-486-7799', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (28, 'Kattie', 'Davio', 'Vinder', 'Malaysia', 'Kuantan', '5 Carioca Plaza', '25200', '394-826-8061', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (29, 'Kenon', 'Purshouse', 'Bluezoom', 'China', 'Wukang', '523 Becker Hill', '6506', '859-783-0407', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (30, 'Matt', 'O''Hickey', 'Agivu', 'Brazil', 'Nova Venécia', '9071 Corscot Alley', '29830-000', '339-642-5339',
        true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (31, 'Tommy', 'Blais', 'Mydo', 'Thailand', 'Kathu', '10 Schmedeman Pass', '83120', '363-761-4683', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (32, 'Desiree', 'Halliberton', 'Rhyzio', 'Indonesia', 'Mojo', '73487 Delladonna Way', '25200', '498-729-4324',
        true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (33, 'Marcelo', 'Bestiman', 'Voomm', 'Philippines', 'Cawayan', '9 Mockingbird Terrace', '5409', '424-308-2150',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (34, 'Sylas', 'Bridge', 'Twitterbeat', 'South Korea', 'Heung-hai', '24795 Hagan Junction', '25200',
        '456-459-3313', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (35, 'Tamas', 'Oman', 'Quimba', 'Armenia', 'Armash', '2 Kedzie Park', '25200', '859-262-2625', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (36, 'Celie', 'Wooland', 'Livefish', 'Sweden', 'Burträsk', '1400 Bayside Lane', '937 91', '965-170-9809', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (37, 'Brian', 'Eisikowitz', 'Mydeo', 'Ethiopia', 'Hawassa', '89302 7th Crossing', '25200', '959-730-1268', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (38, 'Cazzie', 'Chaimson', 'Oodoo', 'Indonesia', 'Tawun', '71 Loftsgordon Drive', '949-0544', '572-245-4861',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (39, 'Bear', 'Asker', 'Abata', 'Finland', 'Karis', '29849 Hoepker Junction', '39290', '547-427-1163', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (40, 'Lydon', 'Lead', 'Linktype', 'China', 'Nanping', '78736 Oak Valley Hill', '949-0544', '671-262-2353', true,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (41, 'Cornell', 'Claughton', 'Browsedrive', 'New Zealand', 'Napier', '2 Becker Alley', '4147', '492-420-3700',
        true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (42, 'Frank', 'Ashwin', 'Camido', 'Poland', 'Wysoka Strzyżowska', '487 Rockefeller Junction', '38-123',
        '236-363-0809', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (43, 'Daryle', 'Pentelow', 'Topiczoom', 'Pakistan', 'Mīrpur Māthelo', '95 Hoepker Park', '63211', '282-700-2539',
        true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (44, 'Durand', 'Boschmann', 'Browsecat', 'Indonesia', 'Karangpeton', '4198 Welch Circle', '949-0544',
        '910-174-6209', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (45, 'Gerrard', 'Darlow', 'Meevee', 'Japan', 'Itoigawa', '2 Northview Pass', '949-0544', '404-394-9457', false,
        1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (46, 'Fenelia', 'Ornillos', 'Cogilith', 'Indonesia', 'Siwalan', '9 Muir Avenue', '949-0544', '203-190-6933',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (47, 'Cecilio', 'Gogerty', 'Blogtag', 'Indonesia', 'Sempu', '49218 Eagle Crest Circle', '949-0544',
        '300-500-8070', false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (48, 'Idell', 'Cockran', 'DabZ', 'Poland', 'Ceranów', '93 Algoma Center', '08-322', '395-856-5031', true, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (49, 'Lyndsey', 'Sanbrooke', 'Rooxo', 'Portugal', 'Ferraria', '3 Warrior Alley', '2445-079', '382-110-9883',
        false, 1);
insert into customer (id, first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted,
                      user_id)
values (50, 'Spenser', 'Sinkins', 'Babbleset', 'Portugal', 'Abade de Vermoim', '2 Summer Ridge Circle', '4770-014',
        '211-600-3034', true, 1);

insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Twiyo', 'Indonesia', 'Cisaat', '8439 North Pass', null, '1389431167', '16804632212896');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Meejo', 'United States', 'Des Moines', '87 Goodland Junction', '50981', '6090238606', '20435640895460');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Feedmix', 'Ethiopia', 'Gelemso', '57695 Farwell Drive', null, '9357583317', '26851515600372');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Topicblab', 'Russia', 'Tsotsin-Yurt', '0 Springview Court', '368033', '5583795490', '20226354205424');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Linktype', 'Indonesia', 'Girang', '15 Stephen Park', null, '4489694726', '22580372785755');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Twitterwire', 'Poland', 'Dobra', '9 Killdeer Street', '72-210', '6735889442', '32336928702750');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Eazzy', 'Indonesia', 'Parawan', '8484 Roxbury Parkway', null, '8899500793', '20244568047724');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Zooveo', 'France', 'Rodez', '23085 Surrey Junction', '12020 CEDEX 9', '6711895313', '12062588547638');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Jaxspan', 'Czech Republic', 'Holýšov', '529 Melody Hill', '345 62', '4559440653', '10100991658076');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Mycat', 'Russia', 'Pushkino', '34314 Sycamore Plaza', '142139', '2693830027', '16341090698379');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Innojam', 'Indonesia', 'Banjar Geriana Kangin', '8 Cambridge Pass', null, '5262597384', '22020610081170');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('InnoZ', 'China', 'Wujiabao', '6465 Monica Road', null, '3832448327', '26045418830871');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Dynazzy', 'United States', 'Philadelphia', '98 Warner Street', '19178', '5420938431', '18880571709671');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Vinder', 'France', 'Rennes', '95969 Crest Line Crossing', '35059 CEDEX', '8615261848', '08882227479078');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Lajo', 'Czech Republic', 'Vlkoš', '8 Commercial Avenue', '751 19', '7376189112', '22536823757810');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Wordtune', 'France', 'Paris 01', '0 Ruskin Terrace', '75032 CEDEX 01', '9698491680', '30498770309111');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Eire', 'Greece', 'Fotolívos', '6 Talisman Park', null, '7799319562', '06816864307198');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Wikizz', 'China', 'Xinjian', '28724 Paget Center', null, '2492812040', '20919712748658');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Gigaclub', 'North Korea', 'Yŏnan-ŭp', '21 Ridgeway Pass', null, '2576489282', '14654158283428');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Kimia', 'Indonesia', 'Jetis', '5554 Crowley Court', null, '8649493023', '04758681690865');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Npath', 'United Kingdom', 'Normanton', '99 Crest Line Road', 'LE15', '2664252214', '02250827672259');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Demivee', 'Germany', 'Frankfurt am Main', '9 Ilene Lane', '60435', '8180069640', '14487228675642');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Demizz', 'China', 'Jianping', '1 Express Place', null, '2094008120', '20257119577845');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Myworks', 'Myanmar', 'Chauk', '33 Goodland Park', null, '2026534267', '16812579026751');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Yamia', 'China', 'Zhenqiao', '99681 Rowland Crossing', null, '6876969893', '18909061161981');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('DabZ', 'Sweden', 'Solna', '3 Aberg Plaza', '171 49', '3795421959', '06722947267593');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Jabbersphere', 'Philippines', 'Villaviciosa', '61 Corscot Way', '2811', '3850221456', '30328912155445');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Plambee', 'China', 'Yanchi', '372 Steensland Center', null, '5746312042', '18786992297813');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Voonder', 'Argentina', 'Achiras', '06015 Forster Place', '3246', '2261189894', '28002054096811');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Voolith', 'Philippines', 'Aborlan', '8 Amoth Point', '5302', '2744227164', '20335833904997');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('BlogXS', 'Kenya', 'Eldama Ravine', '1 Warner Street', null, '8956902538', '04682251664570');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Skaboo', 'Australia', 'Eastern Suburbs Mc', '0 Marquette Avenue', '1391', '2589288077', '04382270530122');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Zoozzy', 'China', 'Shuigou’ao', '1900 Service Terrace', null, '2420831602', '14548096766626');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Thoughtbridge', 'Democratic Republic of the Congo', 'Butembo', '49442 Weeping Birch Court', null, '3015274857',
        '30282302104000');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Quimm', 'Malaysia', 'Bintulu', '61 Ludington Road', '97010', '1042111874', '30356797933714');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Thoughtstorm', 'France', 'Eaubonne', '779 Glacier Hill Avenue', '95604 CEDEX', '6282866617', '12289454313521');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Tagtune', 'South Africa', 'Oudtshoorn', '5 Chinook Drive', '6651', '3561264821', '12941006354932');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Linkbuzz', 'Japan', 'Shingū', '803 Anzinger Center', '649-5313', '8388685461', '02629124765470');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Trilith', 'Indonesia', 'Bendosari', '69475 Debra Center', null, '1956733718', '22799856395974');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Youspan', 'Poland', 'Dzięgielów', '69600 Wayridge Crossing', '43-445', '5853856156', '14420686216108');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Babblestorm', 'Canada', 'Kirkland Lake', '5055 Del Mar Hill', 'P2N', '5061033404', '14990878703940');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Demimbu', 'Poland', 'Przyborów', '977 Hansons Terrace', '60-116', '8351653619', '26751193795102');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Avavee', 'Ivory Coast', 'Sakassou', '0703 Gulseth Street', null, '2976302672', '12420561951607');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Shuffledrive', 'Poland', 'Lubień Kujawski', '345 Goodland Place', '87-840', '3258099354', '02460477124051');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Zoombox', 'Cape Verde', 'Cova Figueira', '57 7th Road', null, '9957870350', '04063436350190');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Flipstorm', 'Serbia', 'Gložan', '7703 Jenna Parkway', null, '6450549628', '26381941454285');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Zazio', 'Philippines', 'Sagay', '441 Saint Paul Plaza', '9103', '6675886025', '28853704784090');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Topicshots', 'Thailand', 'Watthana Nakhon', '842 Talisman Street', '34230', '6673528474', '32815825363241');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Devify', 'Morocco', 'Bouabout', '203 Fulton Crossing', null, '3783361068', '12209251347552');
insert into company (company_name, country, city, street, postal_code, nip, regon)
values ('Youspan', 'Japan', 'Numazu', '56242 Buena Vista Hill', '419-0125', '6525599666', '06860486056493');

insert into currency (name, code)
values ('Ruble', 'RUB');
insert into currency (name, code)
values ('Dirham', 'MAD');
insert into currency (name, code)
values ('Yuan Renminbi', 'CNY');
insert into currency (name, code)
values ('Koruna', 'CZK');
insert into currency (name, code)
values ('Franc', 'XOF');
insert into currency (name, code)
values ('Dram', 'AMD');
insert into currency (name, code)
values ('Rupiah', 'IDR');
insert into currency (name, code)
values ('Lempira', 'HNL');
insert into currency (name, code)
values ('Baht', 'THB');
insert into currency (name, code)
values ('Dollar', 'USD');
insert into currency (name, code)
values ('Hryvnia', 'UAH');
insert into currency (name, code)
values ('Balboa', 'PAB');
insert into currency (name, code)
values ('Rupee', 'PKR');
insert into currency (name, code)
values ('Lev', 'BGN');
insert into currency (name, code)
values ('Krona', 'SEK');
insert into currency (name, code)
values ('Cordoba', 'NIO');
insert into currency (name, code)
values ('Leone', 'SLL');
insert into currency (name, code)
values ('Zloty', 'PLN');
insert into currency (name, code)
values ('Pound', 'EGP');
insert into currency (name, code)
values ('Birr', 'ETB');
insert into currency (name, code)
values ('Quetzal', 'GTQ');
insert into currency (name, code)
values ('Peso', 'UYU');
insert into currency (name, code)
values ('Euro', 'EUR');
insert into currency (name, code)
values ('Real', 'BRL');


insert into status (name)
values ('Invalid or incomplete');
insert into status (name)
values ('Cancelled by com.polsl.factoringcompany.customer');
insert into status (name)
values ('Authorisation declined');
insert into status (name)
values ('Authorised');
insert into status (name)
values ('Authorised and cancelled');
insert into status (name)
values ('Payment deleted');
insert into status (name)
values ('Refund');
insert into status (name)
values ('Payment requested');


insert into payment_type (name)
values ('Cash');
insert into payment_type (name)
values ('Check');
insert into payment_type (name)
values ('Debit card');
insert into payment_type (name)
values ('Credit cards');
insert into payment_type (name)
values ('Mobile payment');
insert into payment_type (name)
values ('Electronic bank transfer');

insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Malinda', 'Hebbes', 'Jabbertype', 'Indonesia', 'Kota Ternate', '8353 Valley Edge Avenue', null, '2462795182',
        '12784200290184');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Lesya', 'Errington', 'Linklinks', 'Indonesia', 'Pasirbitung', '217 Cordelia Place', null, '3517198313',
        '24214552118290');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Bailey', 'Dunthorne', 'Yakidoo', 'Portugal', 'Vila Moreira', '7140 Orin Parkway', '2380-638', '2372800459',
        '26765293944844');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Arabella', 'Biaggetti', 'Yotz', 'Iran', 'Khalilabad', '95702 Moose Trail', null, '5577637473',
        '06134635054053');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Consuelo', 'Boich', 'Trilia', 'France', 'Bordeaux', '94861 Elka Park', '33026 CEDEX', '1760631965',
        '16168426178354');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Karly', 'Simkins', 'Wordware', 'Indonesia', 'Rancamaya', '1 Petterle Parkway', null, '4832225384',
        '12538661745018');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Elle', 'Leband', 'Gabspot', 'Philippines', 'Palayan City', '80 Delaware Junction', '3132', '5031843021',
        '20539353533850');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Valentine', 'Goodall', 'Skipfire', 'China', 'Weihe', '0471 International Drive', null, '4492005493',
        '16211783116687');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Rufus', 'Wetherick', 'Yotz', 'Liberia', 'Buutuo', '9 Mosinee Plaza', null, '5929732993', '28021572381886');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Katy', 'Gavin', 'Wikivu', 'Vietnam', 'Hưng Nguyên', '5 Anniversary Court', null, '9447150384',
        '20170335812435');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Felicdad', 'Van Arsdalen', 'Katz', 'Russia', 'Gremyachinsk', '0 Center Alley', '300971', '2440731513',
        '20773616963198');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Sosanna', 'Heams', 'Browsecat', 'China', 'Haocun', '43790 Dovetail Park', null, '8122538242',
        '02477958885228');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Cal', 'Dew', 'Eabox', 'China', 'Diaoling', '658 Darwin Trail', null, '1894498183', '18926394569394');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Candace', 'Poone', 'Oodoo', 'Philippines', 'San Rafael', '259 Veith Circle', '5039', '3787261487',
        '14596267276970');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Fonz', 'Kelsow', 'Janyx', 'France', 'Orléans', '77233 Monument Park', '45032 CEDEX 1', '8794718766',
        '14242217188578');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Patty', 'Caustic', 'Twitternation', 'Nigeria', 'Kaura Namoda', '3602 Bluejay Terrace', null, '1578762161',
        '22508756773390');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Gaston', 'Willshire', 'Oyoyo', 'Serbia', 'Tomaševac', '81644 Vernon Plaza', null, '4175780535',
        '16705606313991');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Harriott', 'Glasper', 'Lajo', 'Indonesia', 'Ciela Lebak', '5 Northfield Terrace', null, '9630622127',
        '10939254702145');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Coraline', 'Blanpein', 'Linkbuzz', 'Peru', 'Tocota', '0 Commercial Hill', null, '6727323039',
        '02434682036207');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Allyce', 'Horbart', 'Riffpedia', 'Philippines', 'Pudoc North', '99 Vernon Center', '2727', '7552494280',
        '32076873323189');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Torrin', 'Lovatt', 'Oba', 'China', 'Zhong’an', '65123 Mifflin Lane', null, '8258201660', '22423322288116');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Hilarius', 'Pavkovic', 'Twitterworks', 'China', 'Wenfu', '31795 Pierstorff Junction', null, '6939642447',
        '12140121929195');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Suki', 'Cassy', 'Riffpedia', 'Sweden', 'Kumla', '331 Messerschmidt Circle', '692 24', '4622274206',
        '16115780564835');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Nikolas', 'Bullene', 'Voomm', 'Venezuela', 'Barbacoas', '84 Troy Place', null, '7431658245', '14227083835771');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Alfons', 'Crosgrove', 'Flashpoint', 'Indonesia', 'Lebao', '49696 Cordelia Park', null, '3952326294',
        '22511772027351');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Olly', 'Faussett', 'Skyba', 'Indonesia', 'Lundo', '80 Annamark Street', null, '7015665028', '06375316075009');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Daile', 'Scown', 'Yoveo', 'China', 'Shiyun', '97 Hallows Avenue', null, '6620299640', '18739375096140');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Niki', 'Currum', 'Skinix', 'Indonesia', 'Tenjolaya', '4 Esch Terrace', null, '1051879652', '16230863727949');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Darleen', 'Labone', 'Leenti', 'Macedonia', 'Sredno Konjare', '73 Kings Place', '1060', '8621959252',
        '18247340902379');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Joyann', 'Walhedd', 'Zoonder', 'Niger', 'Dogondoutchi', '4 Farwell Circle', null, '2487088050',
        '12714782256116');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Emerson', 'Zannini', 'Dabshots', 'Sri Lanka', 'Negombo', '5306 Anderson Crossing', '11500', '5334677372',
        '06053153556013');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Kipp', 'Lind', 'Kaymbo', 'Philippines', 'Capas', '9772 Anzinger Court', '2333', '6886318482',
        '08584795416376');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Roseanna', 'Grinishin', 'Kayveo', 'Philippines', 'Kajatian', '83 Roxbury Terrace', '7407', '3558492713',
        '04459134338790');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Nanete', 'Mangham', 'Trudeo', 'East Timor', 'Lospalos', '9 Bartelt Plaza', null, '5850516388',
        '24900541587469');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Abbott', 'Shawell', 'Skibox', 'Philippines', 'Pandan Niog', '78 Glendale Street', '3313', '7620486992',
        '08102551179698');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Jamie', 'Du Plantier', 'Skimia', 'Botswana', 'Tonota', '71 Morrow Pass', null, '7516092862', '24612100327203');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Kalli', 'Giacoppoli', 'Jaxbean', 'Syria', 'Mahīn', '31196 Petterle Street', null, '7969262193',
        '24803762080449');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Hyacinthie', 'Sapshed', 'InnoZ', 'Argentina', 'Salta', '174 Forster Crossing', '4400', '7291320025',
        '14557541014827');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Carmella', 'Jacomb', 'Agimba', 'Taiwan', 'Hualian', '359 Ridge Oak Plaza', null, '2397313141',
        '30124159319136');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Ashley', 'Seys', 'Zoomdog', 'Canada', 'Salaberry-de-Valleyfield', '1562 Ramsey Avenue', 'J3Y', '7358923412',
        '20993766091263');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Bartram', 'Beccles', 'Thoughtsphere', 'China', 'Dagou', '85838 Village Green Place', null, '3528482851',
        '20304213947098');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Cris', 'Viveash', 'Topiczoom', 'China', 'Heshang', '9 Scott Pass', null, '7453861686', '24418687285711');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Thurston', 'Gandar', 'Zooveo', 'China', 'Xinshan', '97 Debra Court', null, '8911979079', '30160244793306');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Adorne', 'O''Hogertie', 'Voonyx', 'Mongolia', 'Erdenet', '85 Meadow Valley Street', null, '3174124194',
        '10896827031651');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Haily', 'Fearenside', 'Babblestorm', 'Grenada', 'Saint George''s', '9265 Park Meadow Center', null,
        '3966165027', '16973731862375');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Jeffrey', 'Venus', 'Photojam', 'Russia', 'Tayzhina', '412 International Court', '143814', '4739428553',
        '20171052012202');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Jasper', 'Hamal', 'Snaptags', 'Czech Republic', 'Poniklá', '8522 Anniversary Park', '512 42', '7254756656',
        '20294915607324');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Tremayne', 'Larciere', 'Jabberbean', 'Russia', 'Bugul’ma', '66 Ramsey Pass', '358006', '6181177750',
        '14587703817754');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Shaughn', 'Sprules', 'Realbuzz', 'Indonesia', 'Rancabelut', '1014 Scoville Hill', null, '8378721126',
        '18309600972058');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon)
values ('Nat', 'Burgoine', 'Pixope', 'Indonesia', 'Tembilahan', '9344 American Ash Trail', null, '3394523683',
        '04149653241281');


insert into product (name, pkwiu, measure_unit)
values ('Plate Foam Laminated 9in Blk', '26.30.40.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Whmis - Spray Bottle Trigger', '10.11.99.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Fib N9 - Prague Powder', '13.95.10.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Pepper - Sorrano', '26.30.40.0', 'meters');
insert into product (name, pkwiu, measure_unit)
values ('Chicken - Breast, 5 - 7 Oz', '01.16.19.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Beer - Rickards Red', '19.20.23.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Bread Fig And Almond', '14.13.35.0', 'seconds');
insert into product (name, pkwiu, measure_unit)
values ('Foam Espresso Cup Plain White', '10.89.16.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Spice - Pepper Portions', '26.30.40.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Stock - Fish', '26.30.40.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Sloe Gin - Mcguinness', '01.26.12.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Pepper - Cayenne', '10.39.17.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Loquat', '02.10.11.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Carrots - Jumbo', '17.12.34.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Ginger - Ground', '19.20.23.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Squash - Butternut', '25.94.99.0', 'meters');
insert into product (name, pkwiu, measure_unit)
values ('Pasta - Penne Primavera, Single', '03.00.42.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Assorted Desserts', '03.00.42.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Cheese - Mozzarella', '25.94.99.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Sobe - Lizard Fuel', '13.95.10.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Soup - Campbellschix Stew', '10.61.12.0', 'seconds');
insert into product (name, pkwiu, measure_unit)
values ('Salmon - Fillets', '16.10.13.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Tray - 16in Rnd Blk', '19.20.23.0', 'meters');
insert into product (name, pkwiu, measure_unit)
values ('Bacardi Breezer - Tropical', '25.29.99.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Sour Puss Sour Apple', '14.13.35.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Star Fruit', '14.13.35.0', 'seconds');
insert into product (name, pkwiu, measure_unit)
values ('Tea - Decaf 1 Cup', '26.30.40.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Syrup - Monin - Passion Fruit', '01.45.30.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Hickory Smoke, Liquid', '01.26.12.0', 'grams');
insert into product (name, pkwiu, measure_unit)
values ('Gherkin', '01.26.12.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Grapefruit - White', '01.26.12.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Yogurt - Peach, 175 Gr', '01.26.12.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Salmon Atl.whole 8 - 10 Lb', '01.45.30.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Syrup - Monin - Blue Curacao', '01.45.30.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Eggs - Extra Large', '10.61.12.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Water - Spring 1.5lit', '10.61.12.0', 'seconds');
insert into product (name, pkwiu, measure_unit)
values ('Wine - Trimbach Pinot Blanc', '16.10.13.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Oranges - Navel, 72', '13.95.10.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Pork Casing', '14.13.35.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Ice Cream - Turtles Stick Bar', '01.45.30.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Garam Marsala', '01.45.30.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Fib N9 - Prague Powder', '26.30.40.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Wine - White, Pelee Island', '17.12.34.0', 'galons');
insert into product (name, pkwiu, measure_unit)
values ('Bacardi Breezer - Tropical', '01.26.12.0', 'meters');
insert into product (name, pkwiu, measure_unit)
values ('Butter - Salted, Micro', '01.16.19.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit)
values ('Nut - Hazelnut, Ground, Natural', '01.28.19.0', 'litres');
insert into product (name, pkwiu, measure_unit)
values ('Broom And Brush Rack Black', '08.11.12.0', 'number');
insert into product (name, pkwiu, measure_unit)
values ('Bread - White, Sliced', '01.28.19.0', 'seconds');
insert into product (name, pkwiu, measure_unit)
values ('Shrimp - 16 - 20 Cooked, Peeled', '01.16.19.0', 'meters');
insert into product (name, pkwiu, measure_unit)
values ('Mushroom - Oyster, Fresh', '01.45.30.0', 'grams');


insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL55106001226993953859941195', 'Bank Pekao', null, 28);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL70249010280936227140059340', 'Citi Handlowy', null, 34);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('CITIPLPX', 'PL85156010943556537615452339', 'Morgan Stanley', null, 49);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('CITIPLPX', 'PL35103000062415176170519183', 'Alior Bank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL83249010289013239235444482', 'Getin Noble Bank', null, 5);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL43188010221244859866799600', 'ING Bank Slaski', null, 42);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL42116022449387848568965989', 'Citi Handlowy', null, 36);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL89109011284551717899255837', 'BZ WBK', null, 17);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL96105001032128930997002666', 'Bank Millennium', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL50114010944071851911235317', 'mBank', null, 5);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL50103010583948407743064848', 'ING Bank Slaski', null, 14);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL75156011955973237386716501', 'BZ WBK', null, 31);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL37116000060603939868588546', 'Citi Handlowy', null, 4);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL80114011118159407971938788', 'Bank Pekao', null, 20);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL90124010112641838028330845', 'Alior Bank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL03188000098674488219455167', 'mBank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL79106000500000614054366189', 'Bank of America', null, 26);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL81249000053732787414735046', 'BZ WBK', null, 13);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL68249010448715277737185115', 'Bank of America', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL77116022159504869868628804', 'Getin Noble Bank', null, 34);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL56154000047046676516687176', 'Alior Bank', null, 49);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL11105001292056617970094379', 'Bank of America', null, 9);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL07249000054850948099499597', 'ING Bank Slaski', null, 9);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL83109010699644438685464962', 'BZ WBK', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL93156011114110710453144707', 'Bank of America', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL77156010944831253134836042', 'Getin Noble Bank', null, 46);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL96105000860222750022898541', 'BGZ BNP Paribas', null, 13);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL69116022282290946337740892', 'Morgan Stanley', null, 35);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL77249010579442609311228036', 'Morgan Stanley', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL65156011665086240833815066', 'Morgan Stanley', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL25188010195063905985162742', 'BGZ BNP Paribas', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL20154010272913045304853376', 'Bank Pekao', null, 12);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL45156010239991304114625961', 'mBank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL49249010577537673221583519', 'Citi Handlowy', null, 26);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL09106002651881227262946805', 'Bank Millennium', null, 7);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('CITIPLPX', 'PL66103011337013212160497936', 'Alior Bank', null, 50);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL28188000096862461249965629', 'BZ WBK', null, 39);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL44156011956570758668252735', 'Citi Handlowy', null, 14);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL54109000467929105299508073', 'Citi Handlowy', null, 47);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL69124010536530638040096801', 'Morgan Stanley', null, 23);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL46116022448090077132476665', 'ING Bank Slaski', null, 24);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL09156010238087713446938238', 'BGZ BNP Paribas', null, 12);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL46188010191178335059721969', 'BGZ BNP Paribas', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL56124011127319924683954550', 'PKO BP', null, 37);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL98114010819823234848686877', 'Bank Millennium', null, 16);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL89249010156327098634471845', 'BGZ BNP Paribas', null, 38);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL12114010788619011460882105', 'Citi Handlowy', null, 38);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL47156010817478805452667402', 'Bank Pekao', null, 32);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL74124000693411542486360084', 'Bank Millennium', null, 7);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL07156011085751655867287204', 'Citi Handlowy', null, 50);

insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL59109010562142613040287158', 'Bank Millennium', 16, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL60249010152554199120360091', 'BZ WBK', 43, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL07106001937471710345370581', 'BZ WBK', 37, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL83156011110243280641860426', 'Bank Millennium', 30, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL57188010193463455235191677', 'Alior Bank', 36, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL67103011332572218484361913', 'Citi Handlowy', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL67103011332572218484361913', 'Citi Handlowy', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL39103011884078753222319442', 'Getin Noble Bank', 33, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL73188000090489110985837479', 'Alior Bank', 49, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('CITIPLPX', 'PL85249010570842049162414593', 'Morgan Stanley', 33, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL63109010562774982370196297', 'Alior Bank', 18, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL51249010449509267152250902', 'Bank Pekao', 40, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL06154010720138564287655890', 'ING Bank Slaski', 2, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL83114010785432767740152149', 'Bank of America', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL43106000896284921917008332', 'Getin Noble Bank', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL75105001613603954224961149', 'Bank Millennium', 17, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL22154011448296841071791970', 'PKO BP', 39, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('DEUTPLPK', 'PL05154000042198123813489548', 'Getin Noble Bank', 23, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('CITIPLPX', 'PL15154010560097346863427627', 'mBank', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL46105001162611056384148164', 'ING Bank Slaski', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL31154011153827655965016826', 'ING Bank Slaski', 44, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL85124000433755302821613752', 'Getin Noble Bank', 42, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL43103011916845775243089600', 'Morgan Stanley', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL70114010652264380915894553', 'PKO BP', 19, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL53249010312912238726209080', 'Citi Handlowy', 32, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL19106001512816517263379755', 'mBank', 31, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL78156011665193825328916717', 'mBank', 39, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL89249010445683958489979673', 'mBank', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('INGBPLPW', 'PL63154011155619584662153943', 'Morgan Stanley', 46, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL69124010378943631055526093', 'ING Bank Slaski', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL46109011318264290267383172', 'Bank Millennium', 47, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL68103010326855729153064866', 'Getin Noble Bank', 10, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL86124010375289098289833393', 'Getin Noble Bank', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('RCBWPLPW', 'PL73105000606040788753296959', 'BZ WBK', 14, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL89105001160689405390399660', 'Bank of America', 24, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL47124010378016190647542652', 'BZ WBK', 43, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL53116022319177253065999850', 'Citi Handlowy', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL95156010819491893435088249', 'Bank Pekao', 9, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL18154010563906864648112505', 'PKO BP', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('LUBWPLPR', 'PL91105000730563530433889343', 'Morgan Stanley', 24, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL53124011254406805310692779', 'Morgan Stanley', 37, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALLBPLPW', 'PL67188010226939231662580563', 'Bank Millennium', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL38109011283137506358628790', 'mBank', 14, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('ALBPPLPW', 'PL29249010282568972641801854', 'Bank Millennium', 40, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL38114011409328487801294219', 'Bank Millennium', 50, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('BPKOPLPW', 'PL11109011028992162124691190', 'Bank Millennium', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PKOPPLPW', 'PL27154010144480555303987410', 'Alior Bank', 5, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('HYVEPLP2', 'PL83109011443695951368249329', 'Bank Millennium', 19, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('PPABPLPK', 'PL18116022285436484744206176', 'Alior Bank', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id)
values ('VOWAPLP', 'PL40105000023196174503851700', 'Bank Pekao', 33, null);


insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mdooland0', 'DRc6VD', 'mdooland0@symantec.com', 'Maxim', 'Dooland', 'Mexico', 'Lindavista',
        '36 Center Crossing', '37800', '574-269-1116', 5);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mmorecombe1', 'w8WobE', 'mmorecombe1@bravesites.com', 'Malissa', 'Morecombe', 'Mauritius', 'Cap Malheureux',
        '422 Lawn Circle', null, '876-723-2757', 21);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('ascorthorne2', 'HQWLGpDv', 'ascorthorne2@chicagotribune.com', 'Aloysia', 'Scorthorne', 'Philippines',
        'Catayauan', '8681 Elgar Circle', '3509', '965-888-9900', 29);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('despinay3', 'U4B8WLxsgsE', 'despinay3@domainmarket.com', 'Darryl', 'Espinay', 'Puerto Rico', 'Ponce',
        '24660 Iowa Parkway', '00731', '347-611-1766', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('flindhe4', 'At2ZFFys2i', 'flindhe4@state.gov', 'Fiona', 'Lindhe', 'Indonesia', 'Inanwatan',
        '5227 Butterfield Center', null, '796-156-8271', 37);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('zswyre5', '3QJ2nOk', 'zswyre5@ucoz.ru', 'Zena', 'Swyre', 'Colombia', 'Chitagá', '57910 Pond Alley', '544038',
        '393-964-2997', 21);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('liglesiaz6', '4sPPxV8CxlY', 'liglesiaz6@mediafire.com', 'Larry', 'Iglesiaz', 'Ukraine', 'Svalyava',
        '758 Glendale Plaza', null, '672-954-4471', 26);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('iunworth7', 'hjtxKHsGHwjC', 'iunworth7@51.la', 'Irwinn', 'Unworth', 'Greece', 'Mýrina',
        '75875 Blue Bill Park Lane', null, '524-407-1814', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('sgerling8', 'koQ5iZUPX', 'sgerling8@go.com', 'Schuyler', 'Gerling', 'Philippines', 'Naagas', '9 Spohn Trail',
        '1413', '345-660-8693', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('kgouinlock9', 'hI7lZRVRvoBd', 'kgouinlock9@reuters.com', 'Keary', 'Gouinlock', 'Peru', 'Yanas',
        '1918 Lindbergh Alley', null, '840-542-6604', 6);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bsybea', 'Pyzb8P', 'bsybea@fc2.com', 'Bellina', 'Sybe', 'Palau', 'Ngchesar Hamlet', '6536 Forest Run Circle',
        null, '260-248-5566', 23);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('agrigolib', 'zpaQE1gJK6', 'agrigolib@webs.com', 'Adrianna', 'Grigoli', 'Russia', 'Slobodskoy',
        '874 Hayes Hill', '613155', '506-535-0445', 44);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('proggeroc', 'nbZU43BPb', 'proggeroc@oracle.com', 'Peggy', 'Roggero', 'Brazil', 'Tucumã',
        '6103 Sutherland Pass', '68385-000', '398-638-6085', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('siddisond', 'OXIj7rhhmwpi', 'siddisond@prweb.com', 'Sheena', 'Iddison', 'Argentina', 'Colonias Unidas',
        '61317 Browning Alley', '3515', '729-155-7026', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('wcliffe', 'JzCcXvUj', 'wcliffe@washington.edu', 'Wesley', 'Cliff', 'Greece', 'Fteliá', '05199 Veith Lane',
        null, '289-361-1323', 50);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('kcancelierf', '3QEh1MyMv8', 'kcancelierf@a8.net', 'Kilian', 'Cancelier', 'China', 'Baixiang',
        '1 Carioca Trail', null, '790-130-4269', 43);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('gbartalig', 'tt5m8JX', 'gbartalig@amazon.co.jp', 'Giacopo', 'Bartali', 'Fiji', 'Levuka',
        '9926 Northwestern Center', null, '128-901-6450', 13);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('tklimah', '6T5TJG', 'tklimah@squarespace.com', 'Tomkin', 'Klima', 'Russia', 'Burayevo', '808 Welch Hill',
        '452960', '411-720-0348', 2);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('dkeddyi', 'P2zuOQruE3', 'dkeddyi@craigslist.org', 'Dalia', 'Keddy', 'Belarus', 'Urechcha',
        '74796 Eastlawn Hill', null, '431-318-2589', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('dwallworthj', 'hxB2MyFhQa', 'dwallworthj@amazon.de', 'Dominick', 'Wallworth', 'Canada', 'Saint-Rémi',
        '3 Eagan Crossing', 'K1G', '743-587-1741', 3);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('cmougeotk', 'sUReR6', 'cmougeotk@twitpic.com', 'Clement', 'Mougeot', 'Czech Republic', 'Frýdlant',
        '53235 Corben Place', '464 01', '914-842-0738', 22);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mvardonl', 'cZhgYJtU', 'mvardonl@elegantthemes.com', 'Myranda', 'Vardon', 'Slovenia', 'Bistrica pri Tržiču',
        '3 Mitchell Plaza', '4290', '531-904-4965', 12);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mjickellsm', '3T9VTw8', 'mjickellsm@ted.com', 'Mauricio', 'Jickells', 'China', 'Xiatuanpu', '4896 West Hill',
        null, '414-784-1107', 37);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('tcisnerosn', 'tEpUHp', 'tcisnerosn@gravatar.com', 'Trudy', 'Cisneros', 'China', 'Maopingchang',
        '3 Esch Junction', null, '838-987-8786', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mbridgemano', 'nT2Dm0o56EPI', 'mbridgemano@over-blog.com', 'Marlin', 'Bridgeman', 'Brazil', 'Ilhéus',
        '15545 Lien Junction', '45650-000', '840-421-7969', 42);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('cgellyp', 'a9brM0D', 'cgellyp@sohu.com', 'Charlene', 'Gelly', 'Costa Rica', 'Juntas', '66 Elka Avenue',
        '11803', '878-999-8902', 12);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mvakhrushevq', 'SHxbmB8RHO6y', 'mvakhrushevq@cbsnews.com', 'Mac', 'Vakhrushev', 'China', 'Tangzi',
        '9832 Rowland Circle', null, '910-798-2668', 29);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bcrouchr', 'rZjWl2ts', 'bcrouchr@google.ca', 'Betsy', 'Crouch', 'Colombia', 'Cáceres', '012 Grayhawk Court',
        '052458', '140-740-1426', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('itreess', 'OCzev4', 'itreess@netvibes.com', 'Idalina', 'Trees', 'Indonesia', 'Waiholo', '4 Farwell Drive',
        null, '542-481-5303', 7);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('xkahent', 'pT7YPL8', 'xkahent@kickstarter.com', 'Xena', 'Kahen', 'Canada', 'Nelson', '67 Eastlawn Crossing',
        'V1L', '526-258-7878', 46);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('ryoxenu', 'JIL7bQ9l', 'ryoxenu@myspace.com', 'Ronald', 'Yoxen', 'Philippines', 'Patao', '98795 Jay Avenue',
        '6052', '649-729-5941', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bhackletonv', 'BaD2qbyx', 'bhackletonv@redcross.org', 'Bertha', 'Hackleton', 'China', 'Renhe',
        '94 Havey Point', null, '729-994-3463', 41);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('hkollaschekw', '0r2szM', 'hkollaschekw@bloglines.com', 'Honor', 'Kollaschek', 'Philippines', 'Naili',
        '2741 Old Shore Place', '5613', '728-439-9322', 8);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('mreignardx', 'hPcVnofEzUHY', 'mreignardx@state.tx.us', 'Melvyn', 'Reignard', 'Albania', 'Kushovë',
        '99129 Bellgrove Court', null, '512-617-3872', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('tmattocky', 'Vb4Otg', 'tmattocky@wordpress.com', 'Terrence', 'Mattock', 'China', 'Keyinhe',
        '82041 Park Meadow Court', null, '442-529-7374', 4);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bmclernonz', 'W5gzCB', 'bmclernonz@fastcompany.com', 'Betti', 'McLernon', 'Azerbaijan', 'Dondar Quşçu',
        '71090 Clemons Circle', null, '838-636-3623', 10);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('amcgrath10', 'n4LzTyNJTB', 'amcgrath10@printfriendly.com', 'Alie', 'Mc Grath', 'Bangladesh', 'Madaripur',
        '7914 Shoshone Trail', '7904', '564-453-8948', 50);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('spriden11', 'qQT9E3nE5Jxz', 'spriden11@independent.co.uk', 'Shay', 'Priden', 'Indonesia', 'Batugede Kulon',
        '54 Gale Way', null, '968-612-0352', 34);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bodooley12', '1n0AYF', 'bodooley12@miibeian.gov.cn', 'Bernardina', 'O'' Dooley', 'Philippines', 'Sibucao',
        '3 Mallard Place', '6130', '535-883-7444', 8);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('ssmither13', 'TYDL48Cpj6', 'ssmither13@biblegateway.com', 'Shannah', 'Smither', 'Mexico', 'Independencia',
        '1261 Summit Lane', '26830', '196-138-3219', 15);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('fpate14', 'IGMl9YJ', 'fpate14@miibeian.gov.cn', 'Frederich', 'Pate', 'Mongolia', 'Sangiyn Dalay',
        '9973 Sycamore Plaza', null, '236-716-5746', 9);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('eobrallaghan15', '7YbH9Y4', 'eobrallaghan15@so-net.ne.jp', 'Enrica', 'O''Brallaghan', 'China', 'Lucun',
        '94 Namekagon Hill', null, '154-316-5511', 27);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('btambling16', 'VNhk6ThrPtqE', 'btambling16@imgur.com', 'Briano', 'Tambling', 'France', 'Bondy', '7 Katie Way',
        '93144 CEDEX', '907-149-3360', 28);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('htwaits17', '9QE4zlphVh', 'htwaits17@gizmodo.com', 'Harland', 'Twaits', 'Azerbaijan', 'Ramana',
        '899 4th Drive', null, '943-689-1281', 43);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('hthresher18', '6pBCHkmtKIq', 'hthresher18@so-net.ne.jp', 'Hebert', 'Thresher', 'Portugal', 'Vale da Bajouca',
        '497 Stuart Terrace', '2425-207', '113-195-3768', 3);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('bhussy19', 'cnvTVXePK6R', 'bhussy19@netscape.com', 'Blair', 'Hussy', 'Indonesia', 'Cibeureum', '3 Golf Plaza',
        null, '311-235-7086', 38);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('sgellion1a', 'kmooISMeWH', 'sgellion1a@topsy.com', 'Sioux', 'Gellion', 'Portugal', 'Couço',
        '2 Ridgeway Parkway', '2100-309', '680-597-2583', 9);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('sleaming1b', 'u2jwkgw', 'sleaming1b@about.com', 'Say', 'Leaming', 'China', 'Waina', '3 Portage Junction', null,
        '191-555-8261', 13);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('aomond1c', 'SVKZEp0IxBbd', 'aomond1c@ebay.com', 'Afton', 'Omond', 'Ukraine', 'Kovel’', '5 Sheridan Parkway',
        null, '865-441-5762', 47);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone,
                    company_id)
values ('hsantarelli1d', 'ngkXCoXmkyY', 'hsantarelli1d@omniture.com', 'Hortensia', 'Santarelli', 'China', 'Jishan',
        '13 Waywood Circle', null, '855-414-6048', 21);


insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (1, '#3e456a', '2020-12-20 14:17:29', '2021-06-24 06:05:26', '2021-08-28 08:36:54', 9500.87,
        'suspendisse potenti nullam porttitor', 5790.36, 5047.72,
        'ut volutpat sapien arcu sed augue aliquam erat volutpat', 'funded', 1, 26, 1, 25);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (2, '#b1004f', '2021-01-21 23:28:06', '2020-11-29 01:13:41', '2021-02-15 05:49:25', 5796.83,
        'felis sed interdum', 2788.61, 4438.93, null, 'active', 1, 1, 2, 35);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (3, '#dcb8d6', '2020-10-18 21:40:39', '2021-07-19 14:03:47', '2021-08-25 15:06:53', 7708.19, 'at velit', 8798.55,
        2630.9, 'eros viverra eget congue eget semper', 'active', 1, 8, 4, 28);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (4, '#0ade4f', '2021-05-11 20:29:07', '2021-08-22 17:48:37', '2021-06-04 16:43:59', 5619.76, 'eu mi', 1211.09,
        3606.43, 'sit amet diam in', 'unfunded', 1, 4, 2, 6);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (5, '#fe77ff', '2021-04-03 15:42:45', '2021-04-16 14:36:09', '2020-11-29 18:42:39', 1947.17, 'diam vitae quam',
        929.28, 1664.08, 'ultricies eu nibh quisque id justo sit amet', 'active', 1, 4, 3, 45);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (6, '#b0eeb9', '2021-07-27 06:09:27', '2021-08-31 01:30:07', '2020-12-09 23:54:14', 4469.02, 'est risus', 395.41,
        3946.78, 'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', 'unfunded', 1, 9, 4, 26);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (7, '#bb1630', '2021-04-21 10:33:01', '2020-11-10 15:39:30', '2020-11-20 03:15:52', 4817.3,
        'rhoncus aliquet pulvinar', 6330.47, 8923.37, null, 'active', 1, 6, 5, 15);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (8, '#9d10f1', '2021-03-30 04:11:45', '2021-09-02 01:05:44', '2020-10-10 16:29:43', 3429.8, 'augue a suscipit',
        240.84, 4060.37, null, 'unfunded', 1, 17, 2, 17);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (9, '#fd7da9', '2020-09-11 06:14:39', '2021-08-11 22:11:38', '2021-01-13 22:35:51', 2148.04,
        'fusce posuere felis', 6997.16, 7237.6, 'fermentum donec ut mauris eget massa', 'funded', 1, 17, 5, 7);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (10, '#ecda47', '2020-12-06 21:14:33', '2021-01-28 23:32:01', '2021-06-06 04:12:12', 6646.48,
        'mi integer ac neque', 7353.86, 8926.9, 'iaculis justo in', 'active', 1, 4, 5, 19);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (11, '#0e330b', '2020-11-19 21:01:07', '2021-07-02 11:39:57', '2021-01-10 12:44:30', 7978.67, 'at nibh', 1178.75,
        8647.25, 'in hac habitasse', 'unfunded', 1, 27, 5, 28);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (12, '#e3063b', '2021-07-26 13:32:22', '2020-10-27 12:51:24', '2021-02-09 23:22:40', 9610.78,
        'morbi non quam nec', 9988.36, 3429.63, 'ante ipsum primis in faucibus orci luctus et', 'active', 1, 25, 2, 7);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (13, '#2f97cf', '2021-02-20 04:50:26', '2021-07-30 22:27:24', '2021-07-02 08:00:58', 3358.74, 'dolor sit amet',
        2333.55, 7137.46, 'in hac habitasse platea dictumst morbi vestibulum velit id', 'funded', 1, 22, 5, 6);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (14, '#c06e06', '2021-03-06 08:42:32', '2021-08-10 22:01:35', '2020-11-17 08:08:33', 3574.56,
        'quisque ut erat curabitur', 8707.12, 7696.89, 'amet nulla', 'unfunded', 1, 22, 1, 31);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (15, '#754cb7', '2021-04-04 13:23:08', '2021-01-07 17:43:19', '2021-08-17 12:59:36', 1656.14, 'nisl duis',
        2238.01, 8558.44, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis', 'funded', 1, 9, 1, 18);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (16, '#5f1af4', '2021-08-04 07:42:51', '2020-10-03 18:13:04', '2021-08-20 08:07:36', 6847.38, 'id ornare', 724.5,
        6524.53, null, 'funded', 1, 5, 4, 47);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (17, '#e15824', '2021-06-01 13:47:25', '2021-04-04 10:37:48', '2021-02-08 10:59:50', 7777.01,
        'etiam vel augue vestibulum', 1706.72, 8977.12, 'pretium quis lectus', 'funded', 1, 28, 3, 42);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (18, '#83ada5', '2021-03-08 08:14:12', '2021-02-17 22:59:08', '2021-08-22 22:47:12', 4092.63, 'pharetra magna',
        7554.83, 8565.14, 'odio condimentum id luctus nec molestie sed justo pellentesque', 'active', 1, 28, 3, 29);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (19, '#6ffc91', '2021-02-23 11:07:33', '2020-10-21 01:57:36', '2020-11-23 08:37:23', 9038.22, 'tellus nulla',
        6458.62, 4868.4, 'lectus pellentesque', 'funded', 1, 25, 3, 37);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (20, '#da4294', '2021-05-24 05:10:17', '2020-12-20 01:42:05', '2021-09-05 17:19:44', 764.91, 'lacinia sapien',
        6966.12, 4397.81, 'curabitur gravida nisi at nibh in hac habitasse', 'active', 1, 9, 1, 46);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (21, '#65cb3c', '2020-11-03 03:57:57', '2020-11-29 02:39:11', '2021-08-10 06:15:44', 1495.37,
        'ut tellus nulla ut', 4924.65, 7633.56, 'ut volutpat sapien arcu', 'funded', 1, 23, 4, 3);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (22, '#7712c7', '2020-10-16 03:15:52', '2020-09-07 19:05:42', '2021-09-01 12:12:18', 144.42,
        'lectus pellentesque eget', 763.6, 1639.48, 'ac lobortis', 'active', 1, 10, 2, 30);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (23, '#eb2205', '2020-11-19 07:10:29', '2021-05-29 09:19:31', '2021-04-02 17:32:52', 4901.47, 'nulla eget',
        5213.49, 8930.57, 'eu magna vulputate luctus cum sociis', 'active', 1, 22, 3, 32);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (24, '#4ddec5', '2021-03-05 12:05:20', '2021-01-14 09:04:23', '2021-01-26 18:36:27', 2799.13,
        'erat vestibulum sed', 3588.67, 2214.32, 'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur',
        'unfunded', 1, 22, 5, 23);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (25, '#f6e1c4', '2020-10-17 22:22:08', '2020-09-28 22:06:06', '2020-10-22 02:24:38', 7503.7, 'justo morbi',
        7851.22, 6176.43, null, 'funded', 1, 13, 2, 7);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (26, '#f48cb9', '2021-07-25 00:13:43', '2021-03-17 04:41:01', '2021-05-12 13:24:14', 9161.47,
        'cras pellentesque volutpat', 333.82, 180.7, null, 'unfunded', 1, 16, 4, 23);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (27, '#05d34c', '2021-08-03 02:06:35', '2020-10-09 17:52:47', '2021-01-11 22:14:44', 2650.4,
        'massa tempor convallis', 7220.61, 4258.18, 'morbi vestibulum velit id pretium iaculis diam erat fermentum',
        'unfunded', 1, 13, 2, 45);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (28, '#d5142a', '2020-09-13 08:13:58', '2021-04-14 03:45:36', '2020-09-07 05:32:24', 646.0, 'suspendisse ornare',
        190.65, 4750.22, null, 'unfunded', 1, 13, 2, 8);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (29, '#b34148', '2021-01-24 01:03:23', '2021-07-10 04:26:58', '2020-12-19 14:48:51', 4218.1,
        'velit id pretium iaculis', 1361.88, 5725.43, null, 'funded', 1, 7, 3, 1);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (30, '#849f61', '2020-11-20 15:52:13', '2021-03-28 13:42:20', '2021-04-02 18:47:44', 7464.9,
        'integer pede justo', 9754.44, 7491.36, 'aliquam augue quam sollicitudin vitae consectetuer eget', 'active', 1,
        16, 3, 14);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (31, '#1ddfee', '2020-11-25 10:28:37', '2021-03-17 07:22:18', '2021-04-09 22:44:45', 8308.44, 'egestas metus',
        1230.15, 2561.98, null, 'unfunded', 1, 12, 5, 20);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (32, '#83d3f6', '2020-09-18 07:00:51', '2021-03-18 07:56:48', '2020-12-31 06:27:07', 4553.06, 'orci eget',
        448.92, 5150.91, 'risus semper porta volutpat', 'funded', 1, 1, 2, 33);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (33, '#5611a9', '2021-08-24 07:18:00', '2021-02-02 11:55:29', '2021-01-19 13:43:45', 7210.01,
        'interdum eu tincidunt in', 5104.83, 5766.43, 'nisi venenatis tristique fusce congue diam id ornare', 'funded',
        1, 15, 2, 10);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (34, '#17df44', '2021-07-29 23:42:44', '2021-06-16 08:33:31', '2021-01-24 06:07:19', 3964.27,
        'volutpat convallis morbi odio', 5618.48, 5856.95,
        'nulla ultrices aliquet maecenas leo odio condimentum id luctus', 'active', 1, 12, 1, 33);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (35, '#919877', '2021-04-23 01:47:34', '2020-09-09 06:40:03', '2020-10-04 14:05:08', 808.8, 'odio in hac',
        8204.66, 9111.34, 'porttitor lacus at turpis', 'unfunded', 1, 25, 4, 17);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (36, '#c8909e', '2020-11-19 05:46:59', '2021-04-25 19:37:40', '2021-05-27 16:52:20', 3960.2, 'enim leo', 6973.85,
        9688.3, null, 'unfunded', 1, 3, 5, 47);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (37, '#3f44f9', '2020-10-01 18:47:39', '2021-01-26 05:38:08', '2021-05-23 10:34:42', 4640.58, 'nulla elit ac',
        2506.16, 3632.51, 'vel nisl duis ac nibh fusce lacus purus aliquet', 'funded', 1, 15, 1, 17);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (38, '#faaa94', '2021-05-05 21:19:38', '2020-12-26 06:17:22', '2020-12-14 17:46:22', 4448.41,
        'risus dapibus augue', 4105.5, 2776.3, 'sit amet sapien dignissim vestibulum vestibulum ante', 'unfunded', 1,
        13, 1, 1);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (39, '#c4e2fd', '2020-11-17 04:36:24', '2021-08-24 21:46:48', '2021-03-21 11:57:15', 1416.05, 'quis odio',
        8406.49, 3580.9, null, 'unfunded', 1, 5, 1, 38);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (40, '#0faea4', '2021-04-04 01:23:18', '2020-11-03 16:28:38', '2021-07-02 22:11:22', 5258.42, 'in consequat ut',
        9007.69, 6197.08, 'adipiscing elit proin', 'active', 1, 8, 4, 15);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (41, '#adc697', '2021-07-22 02:39:26', '2021-02-25 22:53:22', '2021-02-14 17:40:32', 1731.18, 'nulla dapibus',
        5363.01, 9682.82, null, 'funded', 1, 19, 1, 12);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (42, '#f6763e', '2021-01-10 01:57:50', '2021-08-28 08:12:36', '2020-12-03 03:02:21', 6247.51,
        'sodales sed tincidunt', 4587.68, 8236.03, 'ultrices mattis odio donec vitae', 'active', 1, 15, 2, 9);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (43, '#dc2cb2', '2021-06-12 08:20:53', '2020-09-28 02:33:43', '2021-08-17 13:19:00', 9478.7,
        'convallis morbi odio odio', 2091.79, 4311.68, 'ligula vehicula consequat morbi a ipsum integer a nibh',
        'unfunded', 1, 16, 4, 37);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (44, '#e6325b', '2021-04-02 08:23:45', '2021-01-11 15:15:28', '2020-10-02 16:48:51', 8538.23, 'turpis integer',
        5601.81, 6503.55, 'eros elementum pellentesque quisque porta volutpat erat', 'funded', 1, 9, 1, 38);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (45, '#e9d437', '2021-07-06 13:15:17', '2020-11-03 08:13:34', '2021-05-21 14:53:30', 3525.83,
        'posuere felis sed', 5032.09, 9346.34, 'donec posuere metus vitae ipsum aliquam non', 'active', 1, 22, 1, 8);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (46, '#5cc602', '2021-03-02 18:44:21', '2020-11-21 13:46:48', '2021-03-10 10:18:33', 1313.64,
        'convallis morbi odio odio', 3832.76, 7168.91, 'vitae ipsum aliquam non', 'active', 1, 14, 1, 29);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (47, '#c09f13', '2021-05-05 02:19:09', '2021-03-17 04:24:19', '2020-11-27 17:22:22', 5322.15, 'vel ipsum',
        8362.2, 838.77, null, 'funded', 1, 12, 3, 32);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (48, '#4f8255', '2021-03-19 12:01:19', '2020-09-10 03:47:37', '2020-10-14 19:48:24', 490.41,
        'etiam pretium iaculis', 8228.39, 942.58, 'ut erat curabitur gravida', 'unfunded', 1, 8, 1, 26);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (49, '#37326a', '2021-03-28 19:11:52', '2021-07-13 07:30:01', '2020-12-31 01:05:13', 1634.69, 'nisl duis ac',
        9712.33, 8072.76, 'est risus auctor sed tristique in tempus sit amet', 'active', 1, 10, 2, 42);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (50, '#37d2ca', '2021-03-05 20:48:15', '2021-07-21 11:10:03', '2021-05-08 19:17:41', 1412.23,
        'diam nam tristique', 1741.94, 9879.74, null, 'unfunded', 1, 20, 4, 46);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (51, '#cb73b1', '2021-02-07 19:40:55', '2020-09-19 10:12:55', '2020-09-16 06:32:10', 2780.05, 'ipsum primis',
        2964.6, 4618.31, 'sapien placerat ante', 'unfunded', 1, 2, 3, 45);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (52, '#78f43d', '2021-02-15 00:41:54', '2020-12-08 20:26:19', '2021-07-28 15:38:36', 2437.26,
        'praesent id massa id', 9164.25, 5414.17, 'ut tellus nulla', 'unfunded', 1, 11, 2, 32);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (53, '#a60194', '2021-01-16 12:07:45', '2021-05-25 21:40:15', '2020-12-03 01:41:31', 1717.66,
        'velit nec nisi vulputate', 3623.36, 427.26, 'sed tristique', 'unfunded', 1, 10, 2, 1);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (54, '#8f9f5e', '2021-06-01 01:08:42', '2021-06-07 12:35:51', '2021-04-26 03:38:52', 1669.88,
        'aliquam convallis nunc proin', 596.25, 4698.82, null, 'unfunded', 1, 28, 5, 34);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (55, '#e401e5', '2021-04-20 13:38:26', '2021-07-14 21:30:06', '2021-03-13 20:24:23', 7156.23,
        'ante ipsum primis', 1492.73, 2416.55, 'nulla nunc purus phasellus in felis donec semper sapien', 'funded', 1,
        8, 1, 3);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (56, '#48568d', '2021-03-11 10:59:58', '2021-02-23 02:31:44', '2021-02-21 03:36:04', 6370.7, 'et tempus semper',
        5176.32, 5872.85, null, 'funded', 1, 14, 3, 8);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (57, '#e34edb', '2020-10-25 22:00:09', '2020-11-28 00:04:26', '2020-12-27 05:21:33', 3609.26,
        'pede venenatis non', 4129.58, 6736.75, null, 'active', 1, 12, 1, 31);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (58, '#67d502', '2020-12-10 20:15:33', '2021-05-31 02:32:23', '2021-03-24 09:48:49', 6525.59,
        'morbi vestibulum velit', 4912.84, 651.21, 'tortor quis turpis sed', 'active', 1, 8, 5, 12);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (59, '#7bb2a8', '2021-07-10 10:58:40', '2021-05-05 17:01:00', '2021-02-15 20:52:10', 6186.49,
        'nulla mollis molestie', 8741.5, 5900.19, 'morbi vestibulum velit id pretium iaculis', 'funded', 1, 20, 1, 19);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (60, '#128523', '2020-10-06 12:05:24', '2021-06-14 20:23:23', '2021-07-06 10:11:03', 9504.22, 'neque sapien',
        4779.45, 548.18, 'vestibulum sed', 'funded', 1, 26, 5, 16);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (61, '#02ce49', '2020-09-15 14:25:29', '2020-11-02 04:25:58', '2020-11-25 21:29:45', 5205.31, 'vel dapibus at',
        2539.13, 4224.48, null, 'unfunded', 1, 22, 4, 46);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (62, '#9008fb', '2021-01-13 08:57:37', '2020-09-26 22:23:47', '2021-09-02 16:17:16', 6993.04, 'a pede', 9603.87,
        8617.97, 'dis parturient montes nascetur ridiculus mus', 'active', 1, 20, 5, 38);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (63, '#3fd634', '2021-05-09 18:26:12', '2020-10-10 07:29:01', '2020-11-29 15:04:06', 9059.89,
        'tincidunt lacus at velit', 8439.32, 6224.48, 'volutpat erat quisque erat', 'funded', 1, 20, 2, 4);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (64, '#17a2fc', '2021-05-12 09:22:40', '2021-05-17 09:44:55', '2021-03-30 04:19:14', 4769.2, 'nibh in', 6527.01,
        4655.06, 'sit amet eleifend', 'unfunded', 1, 14, 5, 44);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (65, '#38f1c8', '2021-07-12 08:50:18', '2020-11-16 12:32:52', '2020-12-06 18:37:14', 5288.59,
        'vitae mattis nibh', 5708.32, 7603.44, 'in eleifend quam a odio in', 'unfunded', 1, 9, 3, 25);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (66, '#b0f724', '2021-04-15 14:15:54', '2021-07-10 17:58:22', '2021-07-11 03:24:01', 3019.67, 'in tempus sit',
        295.79, 4646.37, null, 'active', 1, 15, 2, 15);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (67, '#7e6850', '2021-02-12 22:43:07', '2020-09-22 22:30:14', '2021-01-03 09:57:58', 410.16,
        'consectetuer adipiscing elit', 8575.39, 1323.35, 'curae nulla dapibus dolor vel est donec odio justo',
        'funded', 1, 16, 4, 11);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (68, '#d3a626', '2021-02-28 20:40:18', '2021-05-03 21:50:08', '2021-05-16 03:42:19', 7946.33,
        'vel enim sit amet', 3808.63, 202.72, 'nec condimentum', 'unfunded', 1, 30, 4, 43);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (69, '#dbc301', '2021-02-20 01:52:55', '2021-07-28 11:57:48', '2021-06-21 09:28:30', 6524.67,
        'aliquam non mauris', 6397.65, 5915.35, null, 'funded', 1, 14, 4, 3);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (70, '#a686f0', '2021-08-01 12:12:17', '2021-05-25 22:18:07', '2021-02-03 12:18:47', 4475.24,
        'quam turpis adipiscing lorem', 154.56, 5147.65, null, 'active', 1, 7, 5, 25);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (71, '#4cdfe2', '2021-07-02 06:16:20', '2021-03-19 20:23:26', '2021-05-05 15:45:27', 7098.24, 'ut blandit',
        5596.35, 5406.7, 'justo in blandit ultrices enim', 'active', 1, 28, 2, 9);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (72, '#3addd8', '2020-11-05 17:17:00', '2021-02-02 10:35:18', '2021-07-02 02:51:26', 7192.08,
        'in porttitor pede justo', 6671.28, 1479.36, 'parturient montes nascetur ridiculus', 'active', 1, 1, 2, 22);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (73, '#4f8e0b', '2020-11-20 02:33:56', '2020-11-30 17:28:45', '2021-02-14 07:39:55', 4537.29,
        'mauris eget massa', 6285.6, 6795.46, null, 'unfunded', 1, 12, 1, 5);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (74, '#2cd17e', '2021-05-24 15:51:10', '2021-07-19 23:38:53', '2021-01-06 12:56:31', 8971.71,
        'id ornare imperdiet sapien', 4090.19, 11.26, null, 'active', 1, 10, 4, 7);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (75, '#4702c2', '2020-10-05 17:39:07', '2021-08-31 14:51:39', '2020-12-23 22:00:13', 7041.51,
        'quis tortor id nulla', 4543.03, 3803.15, 'ut ultrices vel', 'unfunded', 1, 13, 1, 29);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (76, '#32358c', '2021-01-27 14:41:44', '2020-11-30 11:58:59', '2020-10-02 22:47:41', 823.44,
        'orci vehicula condimentum curabitur', 7508.18, 4033.49,
        'fermentum justo nec condimentum neque sapien placerat ante', 'unfunded', 1, 15, 3, 44);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (77, '#3d67d9', '2020-11-29 20:39:37', '2020-10-29 12:23:09', '2020-10-19 09:23:20', 7273.08, 'orci mauris',
        5774.4, 7007.35, null, 'unfunded', 1, 1, 3, 11);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (78, '#10233e', '2021-07-28 23:56:31', '2020-11-04 01:33:52', '2021-07-06 21:27:20', 6235.58,
        'consequat nulla nisl nunc', 8937.15, 6626.53, 'sapien iaculis congue vivamus metus arcu adipiscing',
        'unfunded', 1, 2, 4, 9);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (79, '#337b81', '2021-05-29 14:14:30', '2020-11-26 16:49:45', '2021-07-04 05:38:59', 76.47, 'posuere cubilia',
        6784.41, 9031.78, 'felis fusce posuere', 'active', 1, 28, 4, 37);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (80, '#458aa2', '2021-03-14 02:19:15', '2020-12-19 18:40:43', '2021-04-25 04:59:27', 1164.23,
        'sagittis dui vel nisl', 3926.69, 6564.48, null, 'unfunded', 1, 15, 3, 1);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (81, '#f67db8', '2021-04-29 23:56:12', '2021-07-19 20:25:39', '2021-08-14 04:24:58', 9595.75,
        'non mauris morbi non', 8059.79, 2423.65, 'posuere metus vitae ipsum aliquam', 'active', 1, 25, 3, 31);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (82, '#324985', '2020-09-15 13:48:22', '2021-07-22 03:59:49', '2020-10-03 17:11:06', 6143.35, 'eu felis fusce',
        3959.26, 7438.71, 'pellentesque volutpat dui maecenas', 'unfunded', 1, 19, 1, 22);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (83, '#6ff498', '2020-09-10 00:42:13', '2021-03-10 15:23:13', '2020-10-27 18:19:06', 7365.34, 'nibh in', 4123.35,
        326.78, null, 'active', 1, 26, 4, 17);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (84, '#765b7a', '2021-01-08 21:26:46', '2020-11-07 19:15:56', '2021-02-09 21:45:17', 7017.31,
        'suspendisse potenti cras', 2461.69, 2628.28, 'congue diam id ornare', 'funded', 1, 18, 3, 1);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (85, '#19a2ca', '2021-03-04 16:26:06', '2021-05-28 18:31:42', '2021-08-11 08:46:07', 2993.8, 'quisque porta',
        5977.4, 4756.47, 'consequat dui nec nisi volutpat eleifend donec ut dolor', 'funded', 1, 8, 1, 43);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (86, '#5ebd8e', '2021-07-10 23:10:25', '2021-08-04 19:15:51', '2021-04-28 20:59:20', 5391.39,
        'velit vivamus vel', 4727.04, 7833.91, null, 'unfunded', 1, 15, 5, 42);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (87, '#c82d18', '2021-03-31 09:06:06', '2020-09-09 13:58:02', '2021-06-03 01:59:43', 4963.03,
        'malesuada in imperdiet et', 3104.0, 1029.44, 'facilisi cras non velit nec nisi vulputate nonummy', 'active', 1,
        23, 5, 15);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (88, '#372c58', '2020-10-22 15:02:20', '2021-01-12 12:50:47', '2021-01-24 00:22:23', 8100.34,
        'imperdiet nullam orci', 2382.66, 9356.17, 'dui vel nisl duis ac nibh fusce lacus purus', 'active', 1, 23, 1,
        38);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (89, '#7c2386', '2021-09-01 15:36:57', '2021-05-03 05:56:29', '2020-11-26 03:43:17', 5960.42,
        'dolor sit amet consectetuer', 139.13, 356.17, 'id pretium iaculis diam erat fermentum justo', 'active', 1, 13,
        3, 15);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (90, '#cf9989', '2021-03-29 18:53:02', '2021-06-03 12:52:18', '2021-02-14 21:53:53', 1856.37,
        'adipiscing elit proin risus', 9189.23, 9267.25, 'integer ac neque', 'active', 1, 20, 4, 23);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (91, '#e7dabc', '2021-04-22 21:41:51', '2021-03-17 21:25:31', '2021-08-22 12:07:49', 5951.12,
        'ipsum aliquam non', 1235.67, 9556.08, 'mauris eget massa tempor convallis nulla neque libero convallis eget',
        'active', 1, 2, 5, 41);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (92, '#421830', '2021-05-20 23:05:18', '2020-11-17 21:01:40', '2021-01-29 17:44:13', 4602.87,
        'non lectus aliquam', 2931.19, 135.77, 'vivamus vel nulla', 'unfunded', 1, 28, 5, 26);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (93, '#799e25', '2021-07-04 14:06:25', '2020-10-10 18:24:32', '2020-11-15 00:00:09', 9533.41,
        'turpis elementum ligula vehicula', 2533.6, 2679.52, null, 'funded', 1, 29, 3, 18);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (94, '#53b33d', '2021-07-29 14:55:09', '2020-12-11 17:13:11', '2021-04-07 18:58:52', 9611.5, 'cursus urna',
        8668.74, 1103.23, null, 'active', 1, 21, 2, 33);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (95, '#4ca5af', '2021-04-28 00:43:56', '2021-06-30 23:17:35', '2021-01-30 03:43:36', 1655.18,
        'risus semper porta volutpat', 9272.25, 8329.96, 'posuere cubilia curae mauris viverra diam vitae', 'active', 1,
        8, 5, 3);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (96, '#bb5f08', '2021-06-30 06:15:17', '2020-10-01 18:55:09', '2020-11-05 04:33:32', 5414.16,
        'vivamus vestibulum', 5209.75, 4599.92, 'suspendisse potenti', 'active', 1, 11, 3, 38);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (97, '#d393a6', '2021-05-14 15:42:50', '2021-07-27 09:07:28', '2021-05-09 08:35:52', 6054.57,
        'convallis morbi odio', 8190.02, 223.34, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum',
        'funded', 1, 28, 2, 14);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (98, '#f343ac', '2021-02-24 20:19:01', '2021-04-24 05:36:35', '2020-12-19 22:20:24', 1066.02,
        'amet diam in magna', 1111.78, 8011.48, 'nulla nunc purus phasellus in felis donec semper sapien', 'funded', 1,
        23, 2, 46);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (99, '#948691', '2021-07-27 15:38:31', '2021-07-20 17:22:16', '2021-02-20 21:09:52', 199.65, 'pretium iaculis',
        331.05, 3276.35, 'in sagittis dui vel nisl', 'active', 1, 13, 3, 43);
insert into invoice (id, invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid,
                     left_to_pay, remarks, status, seller_id, customer_id, payment_type_id, currency_id)
values (100, '#3d1458', '2021-08-04 01:48:00', '2020-11-29 04:10:06', '2021-03-23 04:29:10', 4698.63, 'auctor sed',
        8527.31, 3106.8, null, 'active', 1, 11, 2, 1);

insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (79, 5587.48, 441410.92, 0.23, 101524.51, 542935.43, 50, 0);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (55, 223.57, 12296.35, 0.1, 1229.64, 13525.99, 40, 7);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (56, 5561.03, 311417.68, 0.18, 56055.18, 367472.86, 36, 4);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (12, 5468.3, 65619.6, 0.16, 10499.14, 76118.74, 21, 8);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (55, 2888.02, 158841.1, 0.1, 15884.11, 174725.21, 42, 9);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (75, 3410.05, 255753.75, 0.01, 2557.54, 258311.29, 45, 47);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (86, 6609.58, 568423.88, 0.05, 28421.19, 596845.07, 9, 16);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (67, 7122.54, 477210.18, 0.17, 81125.73, 558335.91, 5, 37);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (69, 7228.47, 498764.43, 0.04, 19950.58, 518715.01, 50, 47);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (46, 6072.58, 279338.68, 0.12, 33520.64, 312859.32, 29, 38);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (46, 6953.6, 319865.6, 0.06, 19191.94, 339057.54, 10, 33);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (15, 568.69, 8530.35, 0.06, 511.82, 9042.17, 12, 10);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (43, 7849.34, 337521.62, 0.13, 43877.81, 381399.43, 38, 32);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (36, 6219.51, 223902.36, 0.18, 40302.42, 264204.78, 23, 32);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (24, 2599.07, 62377.68, 0.05, 3118.88, 65496.56, 29, 45);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (86, 4526.89, 389312.54, 0.18, 70076.26, 459388.8, 26, 15);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (85, 7966.29, 677134.65, 0.08, 54170.77, 731305.42, 46, 44);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (40, 1432.4, 57296.0, 0.11, 6302.56, 63598.56, 26, 38);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (61, 9410.97, 574069.17, 0.15, 86110.38, 660179.55, 14, 28);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (93, 3769.75, 350586.75, 0.15, 52588.01, 403174.76, 48, 33);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (28, 5243.67, 146822.76, 0.06, 8809.37, 155632.13, 40, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (77, 3707.38, 285468.26, 0.05, 14273.41, 299741.67, 1, 5);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (5, 1675.09, 8375.45, 0.17, 1423.83, 9799.28, 43, 33);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (54, 7347.14, 396745.56, 0.21, 83316.57, 480062.13, 6, 16);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (57, 6026.53, 343512.21, 0.14, 48091.71, 391603.92, 8, 35);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (7, 9924.17, 69469.19, 0.21, 14588.53, 84057.72, 1, 14);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (2, 4307.02, 8614.04, 0.11, 947.54, 9561.58, 46, 39);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (37, 4501.45, 166553.65, 0.14, 23317.51, 189871.16, 13, 42);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (2, 8595.79, 17191.58, 0.01, 171.92, 17363.5, 23, 1);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (97, 164.12, 15919.64, 0.19, 3024.73, 18944.37, 39, 34);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (2, 6893.37, 13786.74, 0.03, 413.6, 14200.34, 5, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (1, 5486.61, 5486.61, 0.01, 54.87, 5541.48, 15, 35);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (77, 1507.54, 116080.58, 0.21, 24376.92, 140457.5, 20, 36);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (14, 849.42, 11891.88, 0.21, 2497.29, 14389.17, 16, 24);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (17, 4293.37, 72987.29, 0.17, 12407.84, 85395.13, 46, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (26, 1455.86, 37852.36, 0.12, 4542.28, 42394.64, 47, 36);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (26, 2991.9, 77789.4, 0.19, 14779.99, 92569.39, 32, 49);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (94, 1231.8, 115789.2, 0.14, 16210.49, 131999.69, 33, 28);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (58, 4742.23, 275049.34, 0.04, 11001.97, 286051.31, 32, 50);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (9, 9196.01, 82764.09, 0.22, 18208.1, 100972.19, 15, 23);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (34, 918.07, 31214.38, 0.2, 6242.88, 37457.26, 47, 12);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (75, 2487.6, 186570.0, 0.09, 16791.3, 203361.3, 35, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (28, 9524.23, 266678.44, 0.04, 10667.14, 277345.58, 30, 18);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (42, 1518.06, 63758.52, 0.17, 10838.95, 74597.47, 37, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (23, 9898.78, 227671.94, 0.08, 18213.76, 245885.7, 4, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (85, 4177.34, 355073.9, 0.18, 63913.3, 418987.2, 2, 18);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (83, 2717.73, 225571.59, 0.06, 13534.3, 239105.89, 35, 28);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (79, 4655.54, 367787.66, 0.21, 77235.41, 445023.07, 16, 25);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (59, 7049.07, 415895.13, 0.13, 54066.37, 469961.5, 2, 26);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id)
values (23, 8147.15, 187384.45, 0.04, 7495.38, 194879.83, 10, 43);



insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-12-26 03:17:06', 22164.36, 3, 5, 34, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-09-12 05:59:01', 22082.69, 5, 28, 24, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-12-05 03:39:11', 86029.62, 4, 48, 15, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-11-07 04:30:13', 97122.93, 1, 43, 41, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-06-03 04:37:35', 36985.52, 5, 39, 39, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2021-01-12 21:24:12', 17815.16, 3, 5, 46, 23);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-10-05 17:00:24', 29945.72, 4, 10, 38, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-05-24 11:34:53', 23587.59, 2, 15, 18, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-11-06 05:16:48', 97712.52, 3, 1, 46, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-03-03 06:49:06', 75442.42, 8, 20, 26, 18);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-07-09 19:47:17', 55156.98, 1, 20, 43, 24);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-11-17 07:25:57', 92654.68, 5, 27, 29, 8);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-11-18 22:50:02', 72513.3, 8, 25, 27, 24);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-11-20 04:56:05', 2538.94, 2, 27, 40, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-12-09 12:17:51', 57620.07, 2, 50, 32, 13);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-09-16 02:18:24', 745.49, 5, 32, 19, 23);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-12-09 21:00:25', 11557.89, 5, 44, 2, 10);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-10-19 22:09:25', 50945.65, 4, 12, 1, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-07-31 00:13:47', 43617.68, 4, 12, 17, 12);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-11-10 01:03:24', 56995.3, 5, 1, 50, 1);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-09-07 05:29:44', 15083.01, 3, 12, 28, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-12-14 15:54:11', 30375.08, 4, 34, 7, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-03-15 13:46:07', 33862.72, 6, 4, 14, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-06-04 00:07:55', 35271.77, 3, 9, 33, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-11-20 19:42:19', 70052.79, 2, 23, 15, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-01-06 03:09:56', 38058.23, 4, 8, 39, 3);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2021-03-21 04:12:44', 98892.12, 3, 8, 38, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-10-15 10:17:50', 37049.42, 7, 45, 43, 10);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-10-26 20:20:58', 90190.43, 1, 48, 14, 22);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-12-09 20:46:28', 57548.92, 5, 24, 35, 21);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-11-28 09:49:34', 83282.64, 2, 19, 36, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-08-22 17:05:11', 94994.78, 2, 37, 24, 1);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-09-10 07:50:02', 23144.53, 1, 42, 44, 22);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-09-11 10:18:51', 49072.25, 5, 17, 33, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-12-23 00:11:35', 90197.58, 6, 46, 16, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-03-07 15:34:23', 57216.97, 3, 46, 8, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-07-12 05:29:42', 76332.12, 6, 12, 23, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-04-18 10:56:23', 14746.91, 2, 45, 38, 9);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-05-28 20:50:48', 87061.86, 3, 47, 6, 2);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2021-04-15 09:37:24', 27091.06, 6, 27, 33, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-07-08 05:48:06', 79190.1, 5, 28, 49, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-03-14 02:25:48', 94670.87, 8, 1, 7, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2021-09-02 03:51:51', 39607.5, 5, 30, 3, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-10-14 09:03:33', 87270.59, 3, 36, 14, 19);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2019-01-25 16:48:41', 84731.67, 6, 35, 10, 6);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-11-16 01:32:30', 70535.7, 1, 22, 22, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-10-14 09:00:14', 654.52, 6, 48, 2, 21);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2017-08-17 15:45:01', 96322.37, 7, 46, 6, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2020-08-08 07:05:15', 6499.0, 6, 11, 26, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id)
values ('2018-03-02 18:10:31', 98870.03, 4, 15, 2, 13);


insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1482177900', 'nunc', '2020-06-18 03:02:45', 33404.86, 7179.15, 0.01, 405.84, 24, 18, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1186822503', 'dolor sit amet', '2020-04-26 11:08:02', 93294.2, 720.65, 0.0, 0.0, 38, 34, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2003330453', 'dolor', '2017-09-13 16:33:06', 54832.97, 11236.81, 0.01, 660.7, 34, 19, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('4512022287', 'lobortis vel', '2021-03-26 02:14:25', 76209.11, 1155.95, 0.01, 773.65, 44, 28, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('3591912913', 'sociis natoque', '2019-02-12 15:49:14', 28772.94, 14890.81, 0.02, 873.28, 38, 4, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1812382057', 'euismod scelerisque quam', '2019-05-05 14:01:07', 55932.2, 18036.69, 0.01, 739.69, 16, 20, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2674111763', 'amet sem fusce', '2020-11-12 21:06:42', 19047.75, 8281.78, 0.0, 0.0, 18, 15, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1976330076', 'mauris lacinia', '2019-12-17 08:19:15', 26846.56, 7021.82, 0.01, 338.68, 41, 31, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1981033408', 'id', '2019-02-17 13:14:16', 76700.73, 6210.31, 0.01, 829.11, 37, 40, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('3184553434', 'quis', '2018-02-26 14:44:37', 45274.98, 7509.84, 0.01, 527.85, 34, 41, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2395578231', 'nulla nisl', '2018-10-16 18:02:27', 50274.58, 10874.03, 0.01, 611.49, 30, 46, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('5438616566', 'cras', '2019-06-30 00:11:49', 57387.26, 7111.55, 0.01, 644.99, 1, 10, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('0632470038', 'vel', '2019-12-24 13:52:12', 5348.58, 7398.78, 0.01, 127.47, 32, 13, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9383820993', 'dis parturient montes', '2021-01-23 03:30:49', 57899.67, 16553.7, 0.0, 0.0, 35, 47, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('5579946309', 'ut nulla sed', '2019-09-08 05:20:57', 6675.4, 2736.65, 0.02, 188.24, 2, 8, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('6397279669', 'faucibus cursus urna', '2018-11-12 17:33:57', 30377.04, 3743.71, 0.02, 682.42, 26, 27, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1414346387', 'nisi at nibh', '2019-04-17 12:19:27', 63403.67, 11944.81, 0.01, 753.48, 6, 42, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9679606368', 'dui', '2021-04-10 04:33:25', 53254.28, 3260.29, 0.0, 0.0, 38, 6, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('4723290354', 'donec', '2019-04-03 13:16:22', 69888.82, 6238.25, 0.01, 761.27, 35, 32, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('3157395319', 'tortor', '2018-12-22 01:12:06', 8444.38, 3539.45, 0.02, 239.68, 25, 15, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1472695461', 'nascetur ridiculus', '2020-12-30 19:10:43', 71712.1, 17492.87, 0.0, 0.0, 12, 22, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9081357034', 'lectus', '2020-10-28 00:15:07', 51948.89, 17647.13, 0.0, 0.0, 50, 41, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('4257652527', 'leo odio porttitor', '2017-09-25 01:54:58', 76289.71, 16288.51, 0.0, 0.0, 17, 44, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1843905914', 'odio in hac', '2019-12-30 09:28:12', 42027.6, 14619.66, 0.02, 1132.95, 6, 34, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9905593314', 'libero', '2020-11-30 15:40:03', 92284.3, 10713.82, 0.01, 1029.98, 27, 30, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1782717870', 'aenean fermentum donec', '2020-05-24 22:00:47', 84674.3, 19906.02, 0.0, 0.0, 4, 15, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9541578020', 'sed', '2018-03-19 06:25:28', 70333.51, 12652.29, 0.01, 829.86, 32, 8, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('5464369554', 'mus etiam', '2019-09-24 08:39:00', 25469.17, 3661.61, 0.01, 291.31, 8, 8, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1166627322', 'congue', '2020-05-21 04:30:26', 69861.16, 156.68, 0.01, 700.18, 30, 34, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('7942581802', 'etiam justo', '2020-04-01 15:34:07', 88828.8, 3798.96, 0.01, 926.28, 22, 39, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('7911595151', 'sed', '2017-10-03 09:25:46', 30270.99, 8836.93, 0.0, 0.0, 39, 24, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2766550690', 'tincidunt in', '2020-01-13 22:50:45', 69855.45, 6594.6, 0.01, 764.5, 28, 39, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('7795125743', 'quis libero nullam', '2018-03-02 21:56:08', 82003.75, 19608.66, 0.02, 2032.25, 21, 38, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('0376401826', 'donec vitae nisi', '2019-05-03 13:38:44', 61940.17, 18844.24, 0.01, 807.84, 15, 34, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2843359643', 'ante ipsum primis', '2021-03-20 14:07:44', 883.21, 11485.76, 0.0, 0.0, 32, 2, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2922180824', 'sit amet', '2021-01-23 15:04:29', 58076.25, 10059.35, 0.02, 1362.71, 40, 12, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('3048132856', 'elit', '2017-11-29 01:09:25', 72239.8, 15918.8, 0.01, 881.59, 48, 12, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('2891242661', 'donec diam', '2020-03-04 11:21:34', 80802.79, 18518.04, 0.01, 993.21, 42, 37, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('5675066128', 'morbi odio odio', '2019-11-28 02:43:38', 66451.44, 102.61, 0.02, 1331.08, 4, 43, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('3722620260', 'sem', '2020-04-25 10:43:03', 75919.93, 9999.34, 0.01, 859.19, 5, 29, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('4121958012', 'sem sed', '2021-09-12 13:17:59', 12397.54, 15718.1, 0.01, 281.16, 24, 50, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9389112133', 'vestibulum vestibulum', '2020-11-15 16:03:27', 62584.23, 4859.34, 0.01, 674.44, 16, 6, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('4077605709', 'rutrum rutrum neque', '2019-08-26 09:10:39', 8132.61, 17115.97, 0.01, 252.49, 33, 18, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('9212351638', 'gravida nisi at', '2018-05-01 06:06:50', 10187.15, 16192.35, 0.0, 0.0, 23, 49, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('6428932784', 'ultrices mattis', '2019-11-16 04:42:47', 48785.89, 1479.43, 0.01, 502.65, 18, 7, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('0746847491', 'suspendisse accumsan', '2021-06-29 02:37:03', 53767.65, 922.69, 0.01, 546.9, 13, 9, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('1797003569', 'posuere nonummy integer', '2017-09-27 09:53:22', 73089.46, 19889.26, 0.01, 929.79, 48, 21, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('5616390607', 'gravida sem praesent', '2020-06-21 00:39:19', 71135.02, 6835.59, 0.01, 779.71, 39, 33, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('7381435217', 'diam erat', '2017-12-17 19:04:34', 19077.94, 6556.52, 0.02, 512.69, 42, 34, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate,
                     commission_value, invoice_id, user_id, status_id)
values ('0458799653', 'nibh', '2020-06-25 08:41:41', 9716.0, 2612.59, 0.0, 0.0, 1, 3, 1);

insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (1, '#d0e034', 26851.83, 49241.46, 74842.96, 86, 93290.62, 1.37, '2021-08-24 23:07:21', '2020-12-16 12:43:53', '2021-09-30 12:02:04', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (2, '#b63574', 25352.35, 46684.74, 56604.12, 37, 99814.35, 1.01, '2021-02-24 11:45:23', '2021-01-19 20:01:44', '2021-08-06 19:09:55', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (3, '#89bbad', 62096.89, 7173.01, 16609.79, 56, 90764.21, 6.55, '2021-02-26 22:38:26', '2021-08-05 08:11:26', '2020-12-03 15:35:14', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (4, '#523d79', 75901.87, 57059.09, 51667.31, 57, 56749.41, 3.82, '2021-09-26 16:15:55', '2020-11-25 01:14:43', '2020-12-23 04:14:42', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (5, '#ae1e73', 69141.02, 11009.27, 41221.79, 83, 21753.64, 6.47, '2021-09-07 08:11:58', '2021-02-04 20:40:48', '2021-06-17 10:18:13', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (6, '#071324', 78708.75, 52069.28, 67521.18, 3, 74889.82, 6.69, '2021-03-09 12:52:42', '2021-09-10 22:10:26', '2020-11-07 00:02:35', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (7, '#6c0920', 47578.25, 78363.73, 46124.7, 56, 87582.92, 5.46, '2021-07-18 20:43:28', '2020-12-29 01:15:31', '2021-04-18 19:52:29', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (8, '#e7ac7d', 65034.79, 63004.39, 10857.23, 21, 71217.1, 6.92, '2021-08-08 19:08:54', '2021-09-25 02:14:15', '2021-08-31 07:04:31', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (9, '#ada834', 2769.48, 8051.41, 2576.28, 15, 90829.54, 3.28, '2021-05-29 12:27:58', '2020-11-16 10:31:22', '2021-07-25 06:07:42', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (10, '#e04cac', 43124.29, 30262.65, 44534.95, 32, 96414.03, 6.74, '2021-09-28 04:06:35', '2021-09-03 13:48:23', '2021-06-12 06:52:03', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (11, '#af9ab3', 25642.58, 39522.33, 16650.81, 77, 34221.31, 3.13, '2020-12-14 16:33:58', '2021-06-02 00:48:01', '2021-01-06 19:00:50', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (12, '#26f0d7', 60507.6, 24223.44, 50602.99, 50, 99093.91, 4.93, '2021-07-14 14:56:01', '2021-04-12 10:14:15', '2021-05-12 15:22:17', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (13, '#1cf611', 1550.28, 80364.22, 63315.54, 11, 70187.22, 1.39, '2021-05-22 21:22:59', '2021-01-24 10:07:14', '2021-09-30 15:54:37', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (14, '#9c6629', 16549.35, 51480.32, 55696.22, 16, 82965.9, 1.68, '2021-03-10 13:32:28', '2021-07-07 16:01:00', '2021-08-14 14:35:28', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (15, '#b8c2f2', 24244.27, 43263.59, 69775.62, 26, 79525.97, 8.46, '2020-11-28 03:35:16', '2020-10-31 06:03:39', '2021-08-24 10:51:08', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (16, '#85af08', 70200.71, 63584.7, 87203.62, 40, 59196.27, 6.08, '2021-07-02 05:08:23', '2021-06-23 23:53:19', '2021-05-25 19:58:34', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (17, '#eab63a', 52100.58, 39128.85, 1016.16, 97, 50755.64, 5.38, '2021-09-28 20:36:01', '2021-03-04 22:04:07', '2020-11-29 13:44:28', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (18, '#27fa82', 2033.33, 54710.2, 58156.3, 47, 34147.84, 4.78, '2021-03-09 19:55:45', '2020-10-14 03:58:06', '2021-03-29 04:24:35', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (19, '#c52053', 79723.05, 11440.99, 23409.57, 5, 12278.97, 3.52, '2020-12-15 15:15:17', '2020-12-01 19:56:59', '2021-07-17 01:40:46', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (20, '#0d2f40', 43370.93, 34794.62, 31602.94, 87, 54602.18, 5.44, '2021-02-26 18:12:37', '2020-10-29 14:22:59', '2020-12-20 04:55:32', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (21, '#9298b3', 27390.42, 3947.0, 84124.15, 62, 25079.89, 6.99, '2020-11-02 00:29:25', '2021-04-24 02:06:00', '2021-09-20 05:12:42', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (22, '#8dbb75', 48047.0, 62765.45, 26941.17, 66, 64561.42, 3.02, '2021-07-14 19:49:40', '2021-05-23 17:15:58', '2020-12-08 23:19:31', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (23, '#2f02a3', 21175.14, 51758.88, 90588.22, 14, 40673.62, 7.08, '2020-10-24 05:16:43', '2020-11-19 18:36:04', '2021-01-20 17:02:06', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (24, '#30a9ae', 34742.69, 26676.78, 38228.49, 34, 20563.97, 1.87, '2020-12-28 11:14:44', '2021-04-07 22:08:05', '2021-02-14 11:08:27', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (25, '#0526f8', 95064.0, 3176.86, 22652.85, 2, 63477.05, 2.84, '2021-04-14 17:11:49', '2020-10-28 01:41:42', '2021-07-24 04:49:01', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (26, '#f38cfd', 81489.08, 74171.53, 19302.93, 52, 44937.44, 1.36, '2021-01-29 19:46:02', '2021-02-25 23:50:06', '2021-01-12 21:17:08', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (27, '#3c803b', 81732.08, 51794.43, 97452.86, 66, 31777.45, 3.9, '2020-10-27 10:17:54', '2021-06-17 09:49:39', '2021-09-10 12:55:09', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (28, '#c89688', 9698.09, 90608.52, 12784.92, 3, 53958.23, 1.43, '2021-07-29 09:48:58', '2021-05-22 12:04:47', '2020-10-18 14:22:42', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (29, '#e92e68', 87530.18, 47536.93, 61398.24, 25, 10167.22, 4.47, '2021-08-07 09:42:10', '2021-09-22 17:32:09', '2020-10-24 04:32:54', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (30, '#633a16', 27649.89, 66896.62, 41113.73, 51, 73335.88, 4.67, '2021-05-09 03:12:55', '2020-11-25 00:30:19', '2021-08-30 09:05:36', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (31, '#8d2960', 52310.03, 19192.93, 39128.58, 57, 20689.27, 8.41, '2021-03-03 19:46:59', '2021-07-15 08:37:08', '2021-08-24 17:27:04', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (32, '#eae08e', 78846.96, 81623.43, 31117.71, 59, 67725.97, 2.38, '2021-06-09 06:49:33', '2021-03-10 10:12:48', '2021-02-14 22:34:47', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (33, '#389684', 10025.55, 55448.98, 99893.29, 28, 53102.97, 5.28, '2021-03-29 21:46:46', '2021-09-04 22:09:20', '2021-04-09 20:13:04', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (34, '#4c145b', 55537.46, 27303.53, 17919.79, 62, 36637.1, 8.86, '2020-12-23 23:25:51', '2021-04-06 21:03:20', '2021-06-06 06:02:59', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (35, '#743e78', 13204.76, 34049.09, 6161.52, 45, 65109.52, 2.71, '2021-08-29 02:39:49', '2021-01-23 04:33:07', '2021-02-23 00:00:34', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (36, '#23de0b', 67675.42, 30364.77, 85958.57, 28, 44543.35, 5.99, '2020-11-22 04:55:43', '2021-09-15 13:44:43', '2020-11-01 18:40:56', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (37, '#bf172e', 14779.43, 51227.27, 70812.89, 62, 82311.88, 8.46, '2021-04-03 09:36:47', '2020-10-21 05:53:37', '2021-04-02 11:23:39', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (38, '#01e5ae', 27777.47, 72744.2, 41932.71, 42, 22408.39, 8.73, '2021-05-06 06:45:12', '2021-09-22 02:33:15', '2021-02-05 16:44:17', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (39, '#c33088', 23072.47, 33442.16, 94075.05, 63, 4085.45, 1.11, '2021-06-03 21:00:33', '2021-04-04 02:14:31', '2021-06-03 14:24:13', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (40, '#0273f9', 41920.1, 1481.92, 11677.14, 83, 59120.71, 3.05, '2021-02-05 09:02:02', '2021-06-11 17:34:19', '2021-06-28 10:44:38', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (41, '#90ac31', 64679.55, 63078.41, 51700.01, 88, 50558.15, 4.03, '2020-11-19 07:37:13', '2020-12-07 05:30:25', '2021-05-01 12:38:47', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (42, '#c54cf8', 96700.39, 80749.88, 64147.2, 65, 9441.66, 3.57, '2020-12-24 06:42:30', '2021-09-14 10:19:36', '2021-07-14 03:09:45', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (43, '#51628d', 99090.32, 83444.62, 43006.63, 51, 55526.67, 1.27, '2021-05-18 06:11:28', '2021-08-16 02:42:59', '2021-02-03 17:41:27', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (44, '#b92add', 44266.77, 19995.35, 8144.08, 53, 94682.05, 2.64, '2021-08-18 14:38:23', '2020-10-29 16:20:35', '2021-06-27 04:23:32', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (45, '#83d8b8', 66113.44, 30771.49, 41344.03, 25, 55467.97, 8.9, '2021-01-31 13:23:27', '2021-06-15 10:26:04', '2021-06-18 14:21:06', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (46, '#7d83b9', 65393.46, 47936.47, 65286.43, 18, 64449.5, 2.42, '2021-04-28 21:49:59', '2021-09-09 16:09:12', '2021-07-15 17:25:28', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (47, '#658f76', 2666.31, 35211.33, 65448.26, 84, 33848.98, 2.47, '2021-09-03 09:45:24', '2021-05-26 22:22:24', '2020-11-10 23:53:55', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (48, '#60284a', 33167.08, 16049.64, 97747.92, 87, 83720.86, 8.46, '2021-07-09 15:51:58', '2021-03-10 23:18:27', '2020-11-09 14:52:33', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (49, '#e3e9a3', 53955.31, 74796.34, 37803.7, 32, 81262.73, 1.75, '2021-03-13 09:50:40', '2021-03-19 07:04:35', '2020-12-08 22:43:32', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (50, '#79a4b4', 86225.38, 89894.81, 57678.61, 78, 78838.82, 4.18, '2021-08-23 18:31:27', '2021-05-10 02:31:53', '2021-03-31 04:52:49', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (51, '#6eef41', 86406.97, 77563.6, 13551.8, 2, 54094.85, 3.91, '2020-10-29 03:02:18', '2021-05-17 16:43:48', '2021-08-23 03:21:38', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (52, '#9dbe10', 58130.61, 33511.54, 63723.33, 42, 13393.0, 1.95, '2020-11-05 13:47:13', '2021-03-25 05:05:24', '2020-11-27 16:26:53', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (53, '#48b41f', 30860.54, 86578.98, 53542.45, 25, 3845.49, 3.78, '2021-03-29 13:55:16', '2021-04-04 12:38:21', '2020-12-19 09:20:04', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (54, '#db4d59', 9939.45, 56173.96, 65697.42, 72, 63778.72, 7.16, '2021-03-21 02:16:46', '2021-08-04 12:49:01', '2021-03-11 04:31:00', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (55, '#8d8bd5', 63048.13, 51793.42, 42576.25, 1, 13998.93, 8.64, '2021-02-23 07:19:36', '2020-12-14 11:17:22', '2021-04-18 09:47:39', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (56, '#df567d', 96903.89, 4819.22, 12742.69, 65, 54324.64, 4.74, '2021-09-12 14:59:06', '2021-05-18 06:28:32', '2021-09-22 00:55:47', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (57, '#09f14e', 10940.38, 98750.15, 47728.78, 97, 2987.67, 5.5, '2020-12-17 10:39:24', '2021-05-28 15:27:46', '2021-09-29 20:09:42', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (58, '#a6bc1f', 72306.03, 91816.95, 49888.13, 66, 91147.04, 3.39, '2020-12-05 21:11:20', '2020-12-13 06:52:42', '2021-05-15 01:44:43', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (59, '#b58f15', 39956.55, 35774.14, 69181.09, 87, 74897.5, 3.7, '2021-10-09 20:16:42', '2021-06-22 16:45:16', '2021-07-31 12:54:23', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (60, '#d8d449', 11821.71, 98035.38, 55843.81, 12, 54364.01, 7.36, '2021-09-28 08:45:41', '2021-06-22 13:35:20', '2021-04-29 01:46:19', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (61, '#8e4cdd', 43475.52, 27184.68, 93304.99, 54, 11909.2, 4.98, '2021-01-28 00:37:46', '2021-07-10 02:11:13', '2021-04-01 08:06:10', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (62, '#ce3a10', 80476.63, 80522.43, 56785.67, 9, 97002.92, 2.36, '2020-11-16 06:24:31', '2021-04-16 19:57:45', '2021-09-20 19:40:04', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (63, '#16886d', 13485.76, 31579.58, 90141.12, 11, 65080.67, 4.97, '2021-03-28 22:47:24', '2021-05-16 16:04:56', '2021-04-28 09:16:33', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (64, '#8fe3fc', 26419.53, 5217.03, 1688.71, 99, 45974.28, 6.85, '2020-12-18 12:10:21', '2021-08-24 04:46:48', '2021-08-17 07:59:26', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (65, '#26b1f0', 59138.6, 89050.61, 11846.45, 13, 68357.48, 7.64, '2021-07-28 12:20:08', '2021-04-12 08:59:00', '2021-07-16 22:07:58', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (66, '#54da4c', 75012.21, 90336.26, 15777.4, 35, 1403.94, 2.82, '2020-12-27 13:32:39', '2021-06-02 01:26:22', '2020-11-24 00:05:08', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (67, '#fca9d1', 67452.53, 79074.99, 49545.21, 60, 54519.46, 7.62, '2021-08-25 07:50:44', '2020-11-21 20:57:57', '2020-11-24 12:18:03', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (68, '#07daae', 64392.59, 15870.25, 26821.2, 20, 81222.71, 2.77, '2021-06-24 05:11:38', '2021-01-11 00:15:02', '2021-02-09 14:30:10', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (69, '#ec6f5a', 81967.61, 59211.19, 82847.84, 15, 8579.25, 8.93, '2021-08-25 03:32:42', '2021-08-22 07:59:39', '2020-10-16 19:18:19', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (70, '#b22f85', 15782.5, 73004.45, 83583.19, 78, 69623.12, 2.77, '2020-11-02 07:30:20', '2021-01-28 21:07:55', '2021-05-03 05:25:40', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (71, '#c12007', 74881.88, 92146.91, 98054.33, 43, 44284.6, 4.76, '2021-08-19 23:40:20', '2021-10-09 19:59:45', '2021-09-26 16:20:08', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (72, '#eaae72', 41354.12, 98628.92, 62564.7, 97, 17291.66, 3.15, '2021-05-18 00:17:58', '2021-03-27 03:02:48', '2021-03-31 07:48:34', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (73, '#c16fb1', 14246.66, 66126.5, 19124.49, 3, 24173.69, 2.7, '2020-11-17 09:04:07', '2020-11-08 09:46:14', '2021-10-03 02:19:34', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (74, '#edea82', 77319.65, 63019.88, 50543.94, 14, 26081.07, 2.89, '2021-02-02 13:59:47', '2021-02-03 03:26:07', '2021-07-24 14:30:25', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (75, '#57492d', 24853.39, 65974.51, 60718.03, 57, 3449.83, 1.29, '2021-07-19 08:05:25', '2021-07-03 15:54:49', '2021-03-25 21:49:05', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (76, '#99b7e1', 76248.98, 92359.8, 97702.57, 28, 47884.17, 2.38, '2021-03-30 04:21:37', '2021-01-28 22:08:31', '2020-12-19 05:27:11', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (77, '#89adea', 74101.42, 47477.0, 22618.6, 35, 22848.76, 7.66, '2021-03-17 01:35:34', '2021-05-13 15:57:35', '2020-10-20 17:40:06', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (78, '#7b27bc', 85099.67, 11532.94, 49564.11, 19, 46202.67, 5.12, '2021-04-08 03:46:25', '2021-09-03 14:56:41', '2021-07-08 08:53:45', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (79, '#4877fa', 86519.44, 28519.69, 35803.77, 8, 57576.32, 2.03, '2020-12-08 07:00:39', '2021-04-21 00:59:07', '2021-07-30 03:23:52', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (80, '#b11218', 51736.71, 32979.52, 91722.79, 18, 25276.15, 2.34, '2021-09-17 04:39:08', '2021-06-18 21:28:08', '2020-11-19 03:16:17', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (81, '#d39998', 45212.59, 56686.78, 50653.61, 63, 3275.92, 6.23, '2021-05-13 16:55:07', '2021-03-28 22:47:41', '2020-11-05 10:59:01', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (82, '#c5d076', 26515.37, 59661.25, 91679.36, 13, 15631.95, 8.8, '2021-09-15 11:51:10', '2021-09-07 04:34:03', '2021-01-17 01:30:21', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (83, '#2b18a9', 90597.12, 13379.24, 71404.5, 50, 144.36, 2.9, '2021-09-29 05:07:03', '2021-09-15 17:14:32', '2021-01-27 20:38:01', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (84, '#7c4b1a', 81976.77, 49446.56, 99798.08, 84, 27754.08, 3.59, '2021-01-09 22:39:20', '2021-04-12 14:48:20', '2020-11-18 20:40:24', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (85, '#07450b', 42813.92, 80798.09, 88607.4, 12, 14775.3, 5.44, '2021-09-01 21:00:15', '2020-11-20 20:33:31', '2020-12-22 02:57:22', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (86, '#7677d3', 9950.9, 40500.85, 93667.24, 46, 13151.15, 7.51, '2021-05-19 22:41:06', '2021-04-23 08:13:55', '2021-03-31 19:08:45', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (87, '#0f3cda', 92714.52, 9574.6, 39828.09, 12, 62351.81, 1.05, '2021-07-21 12:44:39', '2021-08-02 16:16:24', '2021-09-15 06:15:43', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (88, '#d83602', 99410.43, 21096.94, 62730.81, 9, 10219.15, 6.05, '2021-03-31 15:16:22', '2021-10-05 15:19:17', '2021-08-02 15:01:12', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (89, '#20e6d8', 58996.0, 97823.17, 11689.56, 21, 56230.93, 1.15, '2021-08-02 03:54:49', '2021-02-14 22:39:55', '2021-07-28 10:18:50', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (90, '#0854b6', 26933.85, 55790.85, 36923.19, 61, 6142.05, 7.18, '2021-09-25 19:21:44', '2020-11-26 18:43:34', '2021-07-26 02:53:41', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (91, '#b24ead', 33002.51, 20051.16, 17975.73, 91, 15646.97, 6.9, '2021-04-15 12:38:47', '2021-07-06 04:02:51', '2020-11-25 22:28:10', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (92, '#1e1243', 52901.98, 80211.82, 45594.78, 61, 5481.6, 1.43, '2021-02-25 02:34:39', '2020-10-18 12:36:51', '2021-09-06 09:57:58', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (93, '#7480dd', 17333.8, 30385.07, 28308.16, 84, 21932.49, 5.59, '2020-11-21 03:25:59', '2021-07-21 18:33:15', '2021-01-03 20:01:39', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (94, '#186831', 75190.9, 90801.51, 39089.29, 30, 27571.06, 1.09, '2021-07-16 22:41:30', '2021-04-21 21:22:37', '2021-09-16 08:02:52', 1, 'processing');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (95, '#251028', 91215.88, 26405.97, 80573.56, 80, 60115.12, 6.09, '2021-08-18 07:03:42', '2021-09-26 03:19:48', '2021-01-03 16:07:47', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (96, '#40274f', 15948.25, 80618.65, 103.61, 5, 13743.64, 8.8, '2021-02-25 10:00:56', '2021-10-10 21:49:20', '2021-07-30 20:31:01', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (97, '#fc876f', 77168.14, 30621.39, 71688.63, 91, 55334.79, 4.58, '2021-05-17 16:55:38', '2020-12-13 20:57:26', '2021-01-02 03:38:58', 1, 'funded');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (98, '#43c7dd', 12619.21, 10213.58, 72094.43, 19, 94535.83, 2.79, '2020-10-13 00:12:05', '2021-07-27 13:28:18', '2020-11-11 11:28:51', 1, 'active');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (99, '#9ab95e', 46562.55, 45122.54, 69118.84, 78, 21305.34, 7.21, '2021-02-28 00:49:11', '2021-02-28 18:46:47', '2021-03-09 02:02:44', 1, 'review');
insert into credit (id, credit_number, left_to_pay, amount, next_payment, installments, balance, rate_of_interest, next_payment_date, creation_date, last_installment_date, user_id, status) values (100, '#50b874', 64654.75, 54610.28, 49297.53, 85, 94020.48, 3.01, '2021-09-16 21:17:38', '2020-12-03 20:15:12', '2021-08-11 14:44:19', 1, 'processing');

insert into product (id, name, pkwiu, measure_unit) values (1, 'Calypso - Lemonade', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (2, 'Propel Sport Drink', '234.345.6', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (3, 'Melon - Watermelon, Seedless', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (4, 'Bread - White Mini Epi', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (5, 'Edible Flower - Mixed', '345.456.7', 'number');
insert into product (id, name, pkwiu, measure_unit) values (6, 'Ocean Spray - Ruby Red', '234.345.6', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (7, 'Anchovy Fillets', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (8, 'Chicken - Whole Roasting', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (9, 'Cilantro / Coriander - Fresh', '567.678.9', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (10, 'Wine - Marlbourough Sauv Blanc', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (11, 'Pie Filling - Pumpkin', '456.567.8', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (12, 'Soup - Knorr, Ministrone', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (13, 'Cheese - Gouda', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (14, 'Lettuce - Green Leaf', '567.678.9', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (15, 'Sauce - Marinara', '234.345.6', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (16, 'Potatoes - Yukon Gold, 80 Ct', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (17, 'Muffins - Assorted', '234.345.6', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (18, 'Bread - Hot Dog Buns', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (19, 'Wine - White, Pelee Island', '456.567.8', 'number');
insert into product (id, name, pkwiu, measure_unit) values (20, 'Chicken - Diced, Cooked', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (21, 'Wine - Lou Black Shiraz', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (22, 'Kaffir Lime Leaves', '567.678.9', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (23, 'Soap - Hand Soap', '567.678.9', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (24, 'Bagel - 12 Grain Preslice', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (25, 'Oats Large Flake', '456.567.8', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (26, 'Sauce - Hollandaise', '123.234.5', 'number');
insert into product (id, name, pkwiu, measure_unit) values (27, 'Pumpkin', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (28, 'Vinegar - Raspberry', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (29, 'Wine - Pinot Noir Mondavi Coastal', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (30, 'Dried Figs', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (31, 'Iced Tea - Lemon, 460 Ml', '123.234.5', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (32, 'Chervil - Fresh', '123.234.5', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (33, 'Lobster - Tail 6 Oz', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (34, 'Pastry - Chocolate Marble Tea', '456.567.8', 'number');
insert into product (id, name, pkwiu, measure_unit) values (35, 'Isomalt', '345.456.7', 'number');
insert into product (id, name, pkwiu, measure_unit) values (36, 'Apples - Sliced / Wedge', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (37, 'Wine - Coteaux Du Tricastin Ac', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (38, 'Pate - Liver', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (39, 'Bread - Pumpernickel', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (40, 'Danishes - Mini Raspberry', '678.789.0', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (41, 'Hand Towel', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (42, 'Wine - Cava Aria Estate Brut', '567.678.9', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (43, 'Puree - Guava', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (44, 'Chicken Breast Wing On', '345.456.7', 'number');
insert into product (id, name, pkwiu, measure_unit) values (45, 'Schnappes - Peach, Walkers', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (46, 'Pastry - Banana Tea Loaf', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (47, 'Tomatoes - Yellow Hot House', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (48, 'Soup - Boston Clam Chowder', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (49, 'Salt - Seasoned', '234.345.6', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (50, 'Fuji Apples', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (51, 'Mop Head - Cotton, 24 Oz', '234.345.6', 'number');
insert into product (id, name, pkwiu, measure_unit) values (52, 'Yoplait Drink', '234.345.6', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (53, 'Juice - Orange 1.89l', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (54, 'Veal - Inside, Choice', '234.345.6', 'number');
insert into product (id, name, pkwiu, measure_unit) values (55, 'Tomatoes', '678.789.0', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (56, 'Juice - Apple 284ml', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (57, 'Cloves - Ground', '567.678.9', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (58, 'Mushroom - Morel Frozen', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (59, 'Kirsch - Schloss', '678.789.0', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (60, 'Soup - Campbells', '234.345.6', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (61, 'Wine - Two Oceans Cabernet', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (62, 'Danishes - Mini Raspberry', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (63, 'Beer - Blue', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (64, 'Veal - Brisket, Provimi,bnls', '456.567.8', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (65, 'Pepper - Red, Finger Hot', '234.345.6', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (66, 'Syrup - Monin, Swiss Choclate', '567.678.9', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (67, 'Chervil - Fresh', '345.456.7', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (68, 'Chips Potato Swt Chilli Sour', '345.456.7', 'number');
insert into product (id, name, pkwiu, measure_unit) values (69, 'Pepper - Red Chili', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (70, 'Dc - Frozen Momji', '456.567.8', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (71, 'Soup Bowl Clear 8oz92008', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (72, 'Schnappes Peppermint - Walker', '567.678.9', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (73, 'Bread - Frozen Basket Variety', '567.678.9', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (74, 'Crab Brie In Phyllo', '123.234.5', 'number');
insert into product (id, name, pkwiu, measure_unit) values (75, 'Tomato - Plum With Basil', '123.234.5', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (76, 'Gelatine Leaves - Bulk', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (77, 'Wine - Pinot Noir Pond Haddock', '456.567.8', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (78, 'Ice Cream Bar - Hagen Daz', '234.345.6', 'number');
insert into product (id, name, pkwiu, measure_unit) values (79, 'Beer - Blue Light', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (80, 'Truffle - Peelings', '234.345.6', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (81, 'Carbonated Water - Orange', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (82, 'Beef - Tenderloin Tails', '123.234.5', 'number');
insert into product (id, name, pkwiu, measure_unit) values (83, 'Nantucket Pine Orangebanana', '234.345.6', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (84, 'Chinese Foods - Chicken Wing', '456.567.8', 'number');
insert into product (id, name, pkwiu, measure_unit) values (85, 'Lentils - Green, Dry', '123.234.5', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (86, 'Fish - Scallops, Cold Smoked', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (87, 'Chick Peas - Dried', '123.234.5', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (88, 'Artichoke - Fresh', '345.456.7', 'kg');
insert into product (id, name, pkwiu, measure_unit) values (89, 'Wine - Riesling Dr. Pauly', '345.456.7', 'number');
insert into product (id, name, pkwiu, measure_unit) values (90, 'Sprouts - Peppercress', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (91, 'Cup - 6oz, Foam', '567.678.9', 'number');
insert into product (id, name, pkwiu, measure_unit) values (92, 'Garam Masala Powder', '678.789.0', 'number');
insert into product (id, name, pkwiu, measure_unit) values (93, 'Mushroom - Morels, Dry', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (94, 'Cookie Dough - Double', '234.345.6', 'number');
insert into product (id, name, pkwiu, measure_unit) values (95, 'Melon - Watermelon Yellow', '567.678.9', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (96, 'Wine - Red, Antinori Santa', '456.567.8', 'number');
insert into product (id, name, pkwiu, measure_unit) values (97, 'Table Cloth 144x90 White', '678.789.0', 'litres');
insert into product (id, name, pkwiu, measure_unit) values (98, 'Sauce - Rosee', '456.567.8', 'number');
insert into product (id, name, pkwiu, measure_unit) values (99, 'Beef - Top Butt Aaa', '123.234.5', 'number');
insert into product (id, name, pkwiu, measure_unit) values (100, 'Table Cloth 90x90 White', '678.789.0', 'litres');