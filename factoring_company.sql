create table customer (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	postal_code VARCHAR(15),
	phone VARCHAR(15) NOT NULL,
	blacklisted BOOLEAN NOT NULL
);

create table company (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	company_name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	postal_code VARCHAR(15),
	nip VARCHAR(10) NOT NULL,
	regon VARCHAR(14) NOT NULL
);

create table currency (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(15) NOT NULL,
	code VARCHAR(5) NOT NULL
);

create table status (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(24) NOT NULL
);

create table payment_type (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(24) NOT NULL
);


create table seller (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	postal_code VARCHAR(15),
	nip VARCHAR(10) NOT NULL,
	regon VARCHAR(14) NOT NULL
);


create table product (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	pkwiu VARCHAR(10) NOT NULL,
	measure_unit VARCHAR(8) NOT NULL
);

create table bank_account (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	bank_swift VARCHAR(8) NOT NULL,
	bank_account_number VARCHAR(28) NOT NULL,
	bank_name VARCHAR(16) NOT NULL,
	seller_id INT,
	company_id INT,
	CONSTRAINT bank_account_seller_FK FOREIGN KEY ( seller_id ) REFERENCES seller ( id ),
    CONSTRAINT bank_account_company_FK FOREIGN KEY ( company_id ) REFERENCES company ( id )
);

create table "user" (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	postal_code VARCHAR(50),
	phone VARCHAR(50) NOT NULL,
	company_id INT NOT NULL,
	CONSTRAINT user_company_FK FOREIGN KEY ( company_id ) REFERENCES company ( id )
);

create table invoice (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	invoice_number VARCHAR(50) NOT NULL,
	creation_date DATE NOT NULL,
	sale_date DATE NOT NULL,
	payment_deadline DATE NOT NULL,
	to_pay DECIMAL(8,2) NOT NULL,
	to_pay_in_words TEXT NOT NULL,
	paid DECIMAL(7,2) NOT NULL,
	left_to_pay DECIMAL(7,2) NOT NULL,
	remarks TEXT,
	seller_id INT NOT NULL,
	customer_id INT NOT NULL,
	payment_type_id INT NOT NULL,
	currency_id INT NOT NULL,
	CONSTRAINT invoice_seller_FK FOREIGN KEY ( seller_id ) REFERENCES seller ( id ),
	CONSTRAINT invoice_customer_FK FOREIGN KEY ( customer_id ) REFERENCES customer ( id ),
	CONSTRAINT invoice_payment_type_FK FOREIGN KEY ( payment_type_id ) REFERENCES payment_type ( id ),
	CONSTRAINT invoice_currency_FK FOREIGN KEY ( currency_id ) REFERENCES currency ( id )
);

create table invoice_item (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	quentity INT NOT NULL,
	net_price DECIMAL(8,2) NOT NULL,
	net_value DECIMAL(8,2) NOT NULL,
	vat_rate DECIMAL(8,2) NOT NULL,
	vat_value DECIMAL(8,2) NOT NULL,
	gross_value DECIMAL(8,2) NOT NULL,
	product_id INT NOT NULL,
	invoice_id INT NOT NULL
);

create table transaction (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	transaction_date DATE NOT NULL,
	value DECIMAL(8,2) NOT NULL,
	status_id INT NOT NULL,
	customer_id INT NOT NULL,
	invoice_id INT NOT NULL,
	currency_id INT NOT NULL,
	CONSTRAINT transaction_status_FK FOREIGN KEY ( status_id ) REFERENCES status ( id ),
	CONSTRAINT transaction_customer_FK FOREIGN KEY ( customer_id ) REFERENCES customer ( id ),
	CONSTRAINT transaction_invoice_FK FOREIGN KEY ( invoice_id ) REFERENCES invoice ( id ),
	CONSTRAINT transaction_currency_FK FOREIGN KEY ( currency_id ) REFERENCES currency ( id )
);

create table "order" (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	order_number VARCHAR(50) NOT NULL,
	order_type TEXT NOT NULL,
	order_date DATE NOT NULL,
	first_pay_ammount DECIMAL(8,2) NOT NULL,
	second_pay_ammount DECIMAL(7,2) NOT NULL,
	commission_rate DECIMAL(6,2) NOT NULL,
	commission_value DECIMAL(6,2) NOT NULL,
	invoice_id INT NOT NULL,
	user_id INT NOT NULL,
	status_id INT NOT NULL,
	CONSTRAINT order_invoice_FK FOREIGN KEY ( invoice_id ) REFERENCES invoice ( id ),
	CONSTRAINT order_user_FK FOREIGN KEY ( user_id ) REFERENCES "user" ( id ),
	CONSTRAINT order_status_FK FOREIGN KEY ( status_id ) REFERENCES status ( id )
);

insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Elsie', 'Newcomb', 'Wordware', 'Nigeria', 'Sauri', '8627 Brentwood Park', null, '929-885-1154', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Barry', 'Comins', 'Leexo', 'Sierra Leone', 'Lago', '98432 Southridge Alley', null, '479-764-6085', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Deirdre', 'Grinley', 'Yadel', 'Papua New Guinea', 'Kavieng', '17162 Valley Edge Crossing', null, '426-776-1338', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Hadrian', 'Brambell', 'Jayo', 'East Timor', 'Venilale', '1 Sunbrook Point', null, '801-574-1560', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Jere', 'Moxson', 'Rhyzio', 'Russia', 'Ozherel’ye', '1 Di Loreto Road', '142920', '572-231-6312', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Gard', 'Tosspell', 'Voomm', 'Portugal', 'Sobreira', '29 Packers Park', '4960-180', '242-320-7532', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Cyb', 'Chrismas', 'Dynabox', 'Poland', 'Leki Szlacheckie', '9546 Comanche Center', '97-352', '229-667-3439', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Tome', 'Rexworthy', 'Ntag', 'Ivory Coast', 'Abidjan', '55156 Blaine Center', null, '705-999-6096', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Dennie', 'Goodere', 'Dabshots', 'Brazil', 'Teresópolis', '62 Ryan Drive', '25950-000', '490-946-4991', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Maggy', 'Lagde', 'Wordify', 'United States', 'Fort Wayne', '35 Briar Crest Court', '46896', '260-391-5822', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Beltran', 'Naish', 'Wikido', 'Czech Republic', 'Vodnany', '7 Golf View Plaza', '389 01', '753-906-1205', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Cherry', 'Cheetham', 'Devshare', 'Poland', 'Wolin', '714 Northfield Avenue', '72-510', '899-347-3092', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Cathee', 'Pyford', 'Yakitri', 'Indonesia', 'Krajan Curahcotok', '414 Emmet Center', null, '866-795-2242', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Bernie', 'Mulles', 'Innojam', 'Colombia', 'Cértegui', '784 American Ash Way', '272027', '827-233-5941', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Corrine', 'Schaumaker', 'Trudeo', 'Haiti', 'Thomazeau', '5 Ronald Regan Avenue', null, '605-242-5706', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Rick', 'Grills', 'Linkbuzz', 'Thailand', 'Bang Sao Thong', '62077 Holmberg Pass', '10560', '309-296-1671', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Joni', 'Adamczyk', 'Devshare', 'Brazil', 'Descalvado', '65 Upham Parkway', '13690-000', '524-363-6509', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Shanie', 'Pennino', 'Pixonyx', 'Russia', 'Peremyshl’', '6667 Bay Point', '249144', '404-472-6390', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Salomi', 'Locarno', 'Gabtune', 'China', 'Gaoqiao', '170 Laurel Hill', null, '499-763-6547', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Nata', 'O''Skehan', 'Tekfly', 'Peru', 'Iberia', '001 Chive Lane', null, '869-628-2393', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Linus', 'Caley', 'Aimbo', 'Russia', 'Tsotsin-Yurt', '6533 Hollow Ridge Street', '368033', '297-674-6740', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Wash', 'Zapater', 'Tazz', 'Philippines', 'Makiwalo', '3324 Buhler Trail', '1743', '752-903-5593', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Horatia', 'Fearnsides', 'Cogibox', 'Portugal', 'Santa Cruz', '436 Blue Bill Park Point', '4820-560', '135-916-5336', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Oneida', 'Henze', 'Tagchat', 'Malaysia', 'Putrajaya', '21329 Hovde Circle', '62606', '203-703-7182', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Amalee', 'Squibbs', 'Jabberstorm', 'China', 'Zangbawa', '3 Lunder Parkway', null, '391-779-2152', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Olin', 'Matcham', 'Realcube', 'China', 'Dahe', '22 Birchwood Hill', null, '887-634-7525', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Janela', 'Asken', 'Eidel', 'United States', 'Washington', '4 Victoria Pass', '20210', '202-725-7642', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Boyce', 'Gerish', 'Eidel', 'China', 'Wangchang', '41401 Morning Street', null, '106-789-8161', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Lesli', 'Gwinn', 'Photobug', 'Philippines', 'Baloc', '24378 Jenna Circle', '3114', '394-300-5300', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Janeta', 'Reuven', 'Topicware', 'Portugal', 'Lamoso', '919 Arrowood Center', '4590-416', '928-372-5392', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Shermie', 'Keizman', 'Photojam', 'Indonesia', 'Kadujangkung', '731 Independence Place', null, '339-357-9635', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Maxie', 'Mallett', 'Wikibox', 'Indonesia', 'Klapagading', '6 Vidon Lane', null, '426-862-3747', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Ced', 'Foden', 'Zoomzone', 'Poland', 'Syców', '18217 Continental Street', '56-500', '586-547-7739', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Roselin', 'Fairlamb', 'Oba', 'China', 'Qitao', '710 Blue Bill Park Terrace', null, '370-119-6388', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Frederique', 'Lapthorn', 'Kwimbee', 'China', 'Mentougou', '6931 Ilene Point', null, '387-156-7796', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Hillary', 'Gueny', 'Voolith', 'Philippines', 'Simimbaan', '4 Alpine Court', '4200', '583-674-2419', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Barnabe', 'Raison', 'Pixope', 'Sweden', 'Torslanda', '7234 Vernon Hill', '423 55', '783-946-0916', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Alyosha', 'Dawidman', 'Miboo', 'Croatia', 'Sigetec', '432 Ruskin Point', '48321', '344-770-0273', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Luis', 'Kierans', 'Jabbersphere', 'China', 'Xiaoshiqiao', '7635 Fulton Point', null, '885-352-5787', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Vale', 'Peteri', 'Voolith', 'Canada', 'Thessalon', '680 Browning Park', 'P0T', '134-869-5796', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Cariotta', 'Dewane', 'Lazzy', 'Indonesia', 'Bokat', '08 Helena Road', null, '231-646-8301', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Traci', 'Giacovetti', 'Fivechat', 'China', 'Geji', '75 Oneill Junction', null, '842-806-1068', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Clerissa', 'Dunridge', 'Meejo', 'Indonesia', 'Nuasepu', '70269 Lotheville Trail', null, '656-834-2317', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Marcille', 'MacQueen', 'Skidoo', 'Mexico', 'Tamaulipas', '4727 Fallview Street', '89060', '415-561-5773', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Maribelle', 'Garmons', 'Jabbercube', 'Bolivia', 'Camargo', '864 Oak Center', null, '386-831-4007', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Chery', 'Reeson', 'Tagfeed', 'China', 'Zhongdong', '9 Petterle Court', null, '395-316-7004', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Heriberto', 'Tansly', 'Avamm', 'Spain', 'Almeria', '837 Steensland Street', '04070', '595-906-1634', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Murielle', 'Cubberley', 'Fivebridge', 'Armenia', 'Kasakh', '329 Mallard Center', null, '231-489-9629', false);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Jabez', 'Helis', 'Yombu', 'Poland', 'Subkowy', '6926 Fuller Terrace', '83-120', '213-139-8658', true);
insert into customer (first_name, last_name, company_name, country, city, street, postal_code, phone, blacklisted) values ('Heath', 'Durtnell', 'Quinu', 'Russia', 'Onguday', '004 Heath Lane', '649446', '391-289-9124', true);


insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Twiyo', 'Indonesia', 'Cisaat', '8439 North Pass', null, '1389431167', '16804632212896');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Meejo', 'United States', 'Des Moines', '87 Goodland Junction', '50981', '6090238606', '20435640895460');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Feedmix', 'Ethiopia', 'Gelemso', '57695 Farwell Drive', null, '9357583317', '26851515600372');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Topicblab', 'Russia', 'Tsotsin-Yurt', '0 Springview Court', '368033', '5583795490', '20226354205424');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Linktype', 'Indonesia', 'Girang', '15 Stephen Park', null, '4489694726', '22580372785755');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Twitterwire', 'Poland', 'Dobra', '9 Killdeer Street', '72-210', '6735889442', '32336928702750');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Eazzy', 'Indonesia', 'Parawan', '8484 Roxbury Parkway', null, '8899500793', '20244568047724');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Zooveo', 'France', 'Rodez', '23085 Surrey Junction', '12020 CEDEX 9', '6711895313', '12062588547638');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Jaxspan', 'Czech Republic', 'Holýšov', '529 Melody Hill', '345 62', '4559440653', '10100991658076');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Mycat', 'Russia', 'Pushkino', '34314 Sycamore Plaza', '142139', '2693830027', '16341090698379');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Innojam', 'Indonesia', 'Banjar Geriana Kangin', '8 Cambridge Pass', null, '5262597384', '22020610081170');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('InnoZ', 'China', 'Wujiabao', '6465 Monica Road', null, '3832448327', '26045418830871');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Dynazzy', 'United States', 'Philadelphia', '98 Warner Street', '19178', '5420938431', '18880571709671');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Vinder', 'France', 'Rennes', '95969 Crest Line Crossing', '35059 CEDEX', '8615261848', '08882227479078');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Lajo', 'Czech Republic', 'Vlkoš', '8 Commercial Avenue', '751 19', '7376189112', '22536823757810');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Wordtune', 'France', 'Paris 01', '0 Ruskin Terrace', '75032 CEDEX 01', '9698491680', '30498770309111');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Eire', 'Greece', 'Fotolívos', '6 Talisman Park', null, '7799319562', '06816864307198');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Wikizz', 'China', 'Xinjian', '28724 Paget Center', null, '2492812040', '20919712748658');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Gigaclub', 'North Korea', 'Yŏnan-ŭp', '21 Ridgeway Pass', null, '2576489282', '14654158283428');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Kimia', 'Indonesia', 'Jetis', '5554 Crowley Court', null, '8649493023', '04758681690865');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Npath', 'United Kingdom', 'Normanton', '99 Crest Line Road', 'LE15', '2664252214', '02250827672259');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Demivee', 'Germany', 'Frankfurt am Main', '9 Ilene Lane', '60435', '8180069640', '14487228675642');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Demizz', 'China', 'Jianping', '1 Express Place', null, '2094008120', '20257119577845');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Myworks', 'Myanmar', 'Chauk', '33 Goodland Park', null, '2026534267', '16812579026751');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Yamia', 'China', 'Zhenqiao', '99681 Rowland Crossing', null, '6876969893', '18909061161981');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('DabZ', 'Sweden', 'Solna', '3 Aberg Plaza', '171 49', '3795421959', '06722947267593');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Jabbersphere', 'Philippines', 'Villaviciosa', '61 Corscot Way', '2811', '3850221456', '30328912155445');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Plambee', 'China', 'Yanchi', '372 Steensland Center', null, '5746312042', '18786992297813');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Voonder', 'Argentina', 'Achiras', '06015 Forster Place', '3246', '2261189894', '28002054096811');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Voolith', 'Philippines', 'Aborlan', '8 Amoth Point', '5302', '2744227164', '20335833904997');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('BlogXS', 'Kenya', 'Eldama Ravine', '1 Warner Street', null, '8956902538', '04682251664570');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Skaboo', 'Australia', 'Eastern Suburbs Mc', '0 Marquette Avenue', '1391', '2589288077', '04382270530122');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Zoozzy', 'China', 'Shuigou’ao', '1900 Service Terrace', null, '2420831602', '14548096766626');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Thoughtbridge', 'Democratic Republic of the Congo', 'Butembo', '49442 Weeping Birch Court', null, '3015274857', '30282302104000');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Quimm', 'Malaysia', 'Bintulu', '61 Ludington Road', '97010', '1042111874', '30356797933714');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Thoughtstorm', 'France', 'Eaubonne', '779 Glacier Hill Avenue', '95604 CEDEX', '6282866617', '12289454313521');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Tagtune', 'South Africa', 'Oudtshoorn', '5 Chinook Drive', '6651', '3561264821', '12941006354932');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Linkbuzz', 'Japan', 'Shingū', '803 Anzinger Center', '649-5313', '8388685461', '02629124765470');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Trilith', 'Indonesia', 'Bendosari', '69475 Debra Center', null, '1956733718', '22799856395974');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Youspan', 'Poland', 'Dzięgielów', '69600 Wayridge Crossing', '43-445', '5853856156', '14420686216108');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Babblestorm', 'Canada', 'Kirkland Lake', '5055 Del Mar Hill', 'P2N', '5061033404', '14990878703940');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Demimbu', 'Poland', 'Przyborów', '977 Hansons Terrace', '60-116', '8351653619', '26751193795102');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Avavee', 'Ivory Coast', 'Sakassou', '0703 Gulseth Street', null, '2976302672', '12420561951607');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Shuffledrive', 'Poland', 'Lubień Kujawski', '345 Goodland Place', '87-840', '3258099354', '02460477124051');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Zoombox', 'Cape Verde', 'Cova Figueira', '57 7th Road', null, '9957870350', '04063436350190');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Flipstorm', 'Serbia', 'Gložan', '7703 Jenna Parkway', null, '6450549628', '26381941454285');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Zazio', 'Philippines', 'Sagay', '441 Saint Paul Plaza', '9103', '6675886025', '28853704784090');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Topicshots', 'Thailand', 'Watthana Nakhon', '842 Talisman Street', '34230', '6673528474', '32815825363241');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Devify', 'Morocco', 'Bouabout', '203 Fulton Crossing', null, '3783361068', '12209251347552');
insert into company (company_name, country, city, street, postal_code, nip, regon) values ('Youspan', 'Japan', 'Numazu', '56242 Buena Vista Hill', '419-0125', '6525599666', '06860486056493');

insert into currency (name, code) values ('Ruble', 'RUB');
insert into currency (name, code) values ('Dirham', 'MAD');
insert into currency (name, code) values ('Yuan Renminbi', 'CNY');
insert into currency (name, code) values ('Koruna', 'CZK');
insert into currency (name, code) values ('Franc', 'XOF');
insert into currency (name, code) values ('Dram', 'AMD');
insert into currency (name, code) values ('Rupiah', 'IDR');
insert into currency (name, code) values ('Lempira', 'HNL');
insert into currency (name, code) values ('Baht', 'THB');
insert into currency (name, code) values ('Dollar', 'USD');
insert into currency (name, code) values ('Hryvnia', 'UAH');
insert into currency (name, code) values ('Balboa', 'PAB');
insert into currency (name, code) values ('Rupee', 'PKR');
insert into currency (name, code) values ('Lev', 'BGN');
insert into currency (name, code) values ('Krona', 'SEK');
insert into currency (name, code) values ('Cordoba', 'NIO');
insert into currency (name, code) values ('Leone', 'SLL');
insert into currency (name, code) values ('Zloty', 'PLN');
insert into currency (name, code) values ('Pound', 'EGP');
insert into currency (name, code) values ('Birr', 'ETB');
insert into currency (name, code) values ('Quetzal', 'GTQ');
insert into currency (name, code) values ('Peso', 'UYU');
insert into currency (name, code) values ('Euro', 'EUR');
insert into currency (name, code) values ('Real', 'BRL');


insert into status (name) values ('Invalid or incomplete');
insert into status (name) values ('Cancelled by com.polsl.factoringcompany.customer');
insert into status (name) values ('Authorisation declined');
insert into status (name) values ('Authorised');
insert into status (name) values ('Authorised and cancelled');
insert into status (name) values ('Payment deleted');
insert into status (name) values ('Refund');
insert into status (name) values ('Payment requested');


insert into payment_type (name) values ('Cash');
insert into payment_type (name) values ('Check');
insert into payment_type (name) values ('Debit card');
insert into payment_type (name) values ('Credit cards');
insert into payment_type (name) values ('Mobile payment');
insert into payment_type (name) values ('Electronic bank transfer');

insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Malinda', 'Hebbes', 'Jabbertype', 'Indonesia', 'Kota Ternate', '8353 Valley Edge Avenue', null, '2462795182', '12784200290184');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Lesya', 'Errington', 'Linklinks', 'Indonesia', 'Pasirbitung', '217 Cordelia Place', null, '3517198313', '24214552118290');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Bailey', 'Dunthorne', 'Yakidoo', 'Portugal', 'Vila Moreira', '7140 Orin Parkway', '2380-638', '2372800459', '26765293944844');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Arabella', 'Biaggetti', 'Yotz', 'Iran', 'Khalilabad', '95702 Moose Trail', null, '5577637473', '06134635054053');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Consuelo', 'Boich', 'Trilia', 'France', 'Bordeaux', '94861 Elka Park', '33026 CEDEX', '1760631965', '16168426178354');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Karly', 'Simkins', 'Wordware', 'Indonesia', 'Rancamaya', '1 Petterle Parkway', null, '4832225384', '12538661745018');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Elle', 'Leband', 'Gabspot', 'Philippines', 'Palayan City', '80 Delaware Junction', '3132', '5031843021', '20539353533850');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Valentine', 'Goodall', 'Skipfire', 'China', 'Weihe', '0471 International Drive', null, '4492005493', '16211783116687');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Rufus', 'Wetherick', 'Yotz', 'Liberia', 'Buutuo', '9 Mosinee Plaza', null, '5929732993', '28021572381886');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Katy', 'Gavin', 'Wikivu', 'Vietnam', 'Hưng Nguyên', '5 Anniversary Court', null, '9447150384', '20170335812435');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Felicdad', 'Van Arsdalen', 'Katz', 'Russia', 'Gremyachinsk', '0 Center Alley', '300971', '2440731513', '20773616963198');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Sosanna', 'Heams', 'Browsecat', 'China', 'Haocun', '43790 Dovetail Park', null, '8122538242', '02477958885228');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Cal', 'Dew', 'Eabox', 'China', 'Diaoling', '658 Darwin Trail', null, '1894498183', '18926394569394');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Candace', 'Poone', 'Oodoo', 'Philippines', 'San Rafael', '259 Veith Circle', '5039', '3787261487', '14596267276970');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Fonz', 'Kelsow', 'Janyx', 'France', 'Orléans', '77233 Monument Park', '45032 CEDEX 1', '8794718766', '14242217188578');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Patty', 'Caustic', 'Twitternation', 'Nigeria', 'Kaura Namoda', '3602 Bluejay Terrace', null, '1578762161', '22508756773390');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Gaston', 'Willshire', 'Oyoyo', 'Serbia', 'Tomaševac', '81644 Vernon Plaza', null, '4175780535', '16705606313991');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Harriott', 'Glasper', 'Lajo', 'Indonesia', 'Ciela Lebak', '5 Northfield Terrace', null, '9630622127', '10939254702145');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Coraline', 'Blanpein', 'Linkbuzz', 'Peru', 'Tocota', '0 Commercial Hill', null, '6727323039', '02434682036207');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Allyce', 'Horbart', 'Riffpedia', 'Philippines', 'Pudoc North', '99 Vernon Center', '2727', '7552494280', '32076873323189');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Torrin', 'Lovatt', 'Oba', 'China', 'Zhong’an', '65123 Mifflin Lane', null, '8258201660', '22423322288116');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Hilarius', 'Pavkovic', 'Twitterworks', 'China', 'Wenfu', '31795 Pierstorff Junction', null, '6939642447', '12140121929195');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Suki', 'Cassy', 'Riffpedia', 'Sweden', 'Kumla', '331 Messerschmidt Circle', '692 24', '4622274206', '16115780564835');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Nikolas', 'Bullene', 'Voomm', 'Venezuela', 'Barbacoas', '84 Troy Place', null, '7431658245', '14227083835771');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Alfons', 'Crosgrove', 'Flashpoint', 'Indonesia', 'Lebao', '49696 Cordelia Park', null, '3952326294', '22511772027351');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Olly', 'Faussett', 'Skyba', 'Indonesia', 'Lundo', '80 Annamark Street', null, '7015665028', '06375316075009');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Daile', 'Scown', 'Yoveo', 'China', 'Shiyun', '97 Hallows Avenue', null, '6620299640', '18739375096140');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Niki', 'Currum', 'Skinix', 'Indonesia', 'Tenjolaya', '4 Esch Terrace', null, '1051879652', '16230863727949');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Darleen', 'Labone', 'Leenti', 'Macedonia', 'Sredno Konjare', '73 Kings Place', '1060', '8621959252', '18247340902379');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Joyann', 'Walhedd', 'Zoonder', 'Niger', 'Dogondoutchi', '4 Farwell Circle', null, '2487088050', '12714782256116');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Emerson', 'Zannini', 'Dabshots', 'Sri Lanka', 'Negombo', '5306 Anderson Crossing', '11500', '5334677372', '06053153556013');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Kipp', 'Lind', 'Kaymbo', 'Philippines', 'Capas', '9772 Anzinger Court', '2333', '6886318482', '08584795416376');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Roseanna', 'Grinishin', 'Kayveo', 'Philippines', 'Kajatian', '83 Roxbury Terrace', '7407', '3558492713', '04459134338790');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Nanete', 'Mangham', 'Trudeo', 'East Timor', 'Lospalos', '9 Bartelt Plaza', null, '5850516388', '24900541587469');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Abbott', 'Shawell', 'Skibox', 'Philippines', 'Pandan Niog', '78 Glendale Street', '3313', '7620486992', '08102551179698');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Jamie', 'Du Plantier', 'Skimia', 'Botswana', 'Tonota', '71 Morrow Pass', null, '7516092862', '24612100327203');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Kalli', 'Giacoppoli', 'Jaxbean', 'Syria', 'Mahīn', '31196 Petterle Street', null, '7969262193', '24803762080449');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Hyacinthie', 'Sapshed', 'InnoZ', 'Argentina', 'Salta', '174 Forster Crossing', '4400', '7291320025', '14557541014827');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Carmella', 'Jacomb', 'Agimba', 'Taiwan', 'Hualian', '359 Ridge Oak Plaza', null, '2397313141', '30124159319136');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Ashley', 'Seys', 'Zoomdog', 'Canada', 'Salaberry-de-Valleyfield', '1562 Ramsey Avenue', 'J3Y', '7358923412', '20993766091263');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Bartram', 'Beccles', 'Thoughtsphere', 'China', 'Dagou', '85838 Village Green Place', null, '3528482851', '20304213947098');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Cris', 'Viveash', 'Topiczoom', 'China', 'Heshang', '9 Scott Pass', null, '7453861686', '24418687285711');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Thurston', 'Gandar', 'Zooveo', 'China', 'Xinshan', '97 Debra Court', null, '8911979079', '30160244793306');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Adorne', 'O''Hogertie', 'Voonyx', 'Mongolia', 'Erdenet', '85 Meadow Valley Street', null, '3174124194', '10896827031651');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Haily', 'Fearenside', 'Babblestorm', 'Grenada', 'Saint George''s', '9265 Park Meadow Center', null, '3966165027', '16973731862375');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Jeffrey', 'Venus', 'Photojam', 'Russia', 'Tayzhina', '412 International Court', '143814', '4739428553', '20171052012202');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Jasper', 'Hamal', 'Snaptags', 'Czech Republic', 'Poniklá', '8522 Anniversary Park', '512 42', '7254756656', '20294915607324');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Tremayne', 'Larciere', 'Jabberbean', 'Russia', 'Bugul’ma', '66 Ramsey Pass', '358006', '6181177750', '14587703817754');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Shaughn', 'Sprules', 'Realbuzz', 'Indonesia', 'Rancabelut', '1014 Scoville Hill', null, '8378721126', '18309600972058');
insert into seller (first_name, last_name, company_name, country, city, street, postal_code, nip, regon) values ('Nat', 'Burgoine', 'Pixope', 'Indonesia', 'Tembilahan', '9344 American Ash Trail', null, '3394523683', '04149653241281');


insert into product (name, pkwiu, measure_unit) values ('Plate Foam Laminated 9in Blk', '26.30.40.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Whmis - Spray Bottle Trigger', '10.11.99.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Fib N9 - Prague Powder', '13.95.10.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Pepper - Sorrano', '26.30.40.0', 'meters');
insert into product (name, pkwiu, measure_unit) values ('Chicken - Breast, 5 - 7 Oz', '01.16.19.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Beer - Rickards Red', '19.20.23.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Bread Fig And Almond', '14.13.35.0', 'seconds');
insert into product (name, pkwiu, measure_unit) values ('Foam Espresso Cup Plain White', '10.89.16.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Spice - Pepper Portions', '26.30.40.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Stock - Fish', '26.30.40.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Sloe Gin - Mcguinness', '01.26.12.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Pepper - Cayenne', '10.39.17.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Loquat', '02.10.11.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Carrots - Jumbo', '17.12.34.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Ginger - Ground', '19.20.23.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Squash - Butternut', '25.94.99.0', 'meters');
insert into product (name, pkwiu, measure_unit) values ('Pasta - Penne Primavera, Single', '03.00.42.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Assorted Desserts', '03.00.42.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Cheese - Mozzarella', '25.94.99.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Sobe - Lizard Fuel', '13.95.10.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Soup - Campbellschix Stew', '10.61.12.0', 'seconds');
insert into product (name, pkwiu, measure_unit) values ('Salmon - Fillets', '16.10.13.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Tray - 16in Rnd Blk', '19.20.23.0', 'meters');
insert into product (name, pkwiu, measure_unit) values ('Bacardi Breezer - Tropical', '25.29.99.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Sour Puss Sour Apple', '14.13.35.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Star Fruit', '14.13.35.0', 'seconds');
insert into product (name, pkwiu, measure_unit) values ('Tea - Decaf 1 Cup', '26.30.40.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Syrup - Monin - Passion Fruit', '01.45.30.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Hickory Smoke, Liquid', '01.26.12.0', 'grams');
insert into product (name, pkwiu, measure_unit) values ('Gherkin', '01.26.12.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Grapefruit - White', '01.26.12.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Yogurt - Peach, 175 Gr', '01.26.12.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Salmon Atl.whole 8 - 10 Lb', '01.45.30.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Syrup - Monin - Blue Curacao', '01.45.30.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Eggs - Extra Large', '10.61.12.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Water - Spring 1.5lit', '10.61.12.0', 'seconds');
insert into product (name, pkwiu, measure_unit) values ('Wine - Trimbach Pinot Blanc', '16.10.13.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Oranges - Navel, 72', '13.95.10.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Pork Casing', '14.13.35.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Ice Cream - Turtles Stick Bar', '01.45.30.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Garam Marsala', '01.45.30.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Fib N9 - Prague Powder', '26.30.40.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Wine - White, Pelee Island', '17.12.34.0', 'galons');
insert into product (name, pkwiu, measure_unit) values ('Bacardi Breezer - Tropical', '01.26.12.0', 'meters');
insert into product (name, pkwiu, measure_unit) values ('Butter - Salted, Micro', '01.16.19.0', 'kilowatt');
insert into product (name, pkwiu, measure_unit) values ('Nut - Hazelnut, Ground, Natural', '01.28.19.0', 'litres');
insert into product (name, pkwiu, measure_unit) values ('Broom And Brush Rack Black', '08.11.12.0', 'number');
insert into product (name, pkwiu, measure_unit) values ('Bread - White, Sliced', '01.28.19.0', 'seconds');
insert into product (name, pkwiu, measure_unit) values ('Shrimp - 16 - 20 Cooked, Peeled', '01.16.19.0', 'meters');
insert into product (name, pkwiu, measure_unit) values ('Mushroom - Oyster, Fresh', '01.45.30.0', 'grams');


insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL55106001226993953859941195', 'Bank Pekao', null, 28);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL70249010280936227140059340', 'Citi Handlowy', null, 34);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('CITIPLPX', 'PL85156010943556537615452339', 'Morgan Stanley', null, 49);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('CITIPLPX', 'PL35103000062415176170519183', 'Alior Bank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL83249010289013239235444482', 'Getin Noble Bank', null, 5);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL43188010221244859866799600', 'ING Bank Slaski', null, 42);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL42116022449387848568965989', 'Citi Handlowy', null, 36);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL89109011284551717899255837', 'BZ WBK', null, 17);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL96105001032128930997002666', 'Bank Millennium', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL50114010944071851911235317', 'mBank', null, 5);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL50103010583948407743064848', 'ING Bank Slaski', null, 14);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL75156011955973237386716501', 'BZ WBK', null, 31);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL37116000060603939868588546', 'Citi Handlowy', null, 4);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL80114011118159407971938788', 'Bank Pekao', null, 20);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL90124010112641838028330845', 'Alior Bank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL03188000098674488219455167', 'mBank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL79106000500000614054366189', 'Bank of America', null, 26);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL81249000053732787414735046', 'BZ WBK', null, 13);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL68249010448715277737185115', 'Bank of America', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL77116022159504869868628804', 'Getin Noble Bank', null, 34);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL56154000047046676516687176', 'Alior Bank', null, 49);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL11105001292056617970094379', 'Bank of America', null, 9);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL07249000054850948099499597', 'ING Bank Slaski', null, 9);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL83109010699644438685464962', 'BZ WBK', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL93156011114110710453144707', 'Bank of America', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL77156010944831253134836042', 'Getin Noble Bank', null, 46);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL96105000860222750022898541', 'BGZ BNP Paribas', null, 13);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL69116022282290946337740892', 'Morgan Stanley', null, 35);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL77249010579442609311228036', 'Morgan Stanley', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL65156011665086240833815066', 'Morgan Stanley', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL25188010195063905985162742', 'BGZ BNP Paribas', null, 45);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL20154010272913045304853376', 'Bank Pekao', null, 12);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL45156010239991304114625961', 'mBank', null, 18);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL49249010577537673221583519', 'Citi Handlowy', null, 26);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL09106002651881227262946805', 'Bank Millennium', null, 7);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('CITIPLPX', 'PL66103011337013212160497936', 'Alior Bank', null, 50);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL28188000096862461249965629', 'BZ WBK', null, 39);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL44156011956570758668252735', 'Citi Handlowy', null, 14);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL54109000467929105299508073', 'Citi Handlowy', null, 47);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL69124010536530638040096801', 'Morgan Stanley', null, 23);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL46116022448090077132476665', 'ING Bank Slaski', null, 24);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL09156010238087713446938238', 'BGZ BNP Paribas', null, 12);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL46188010191178335059721969', 'BGZ BNP Paribas', null, 15);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL56124011127319924683954550', 'PKO BP', null, 37);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL98114010819823234848686877', 'Bank Millennium', null, 16);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL89249010156327098634471845', 'BGZ BNP Paribas', null, 38);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL12114010788619011460882105', 'Citi Handlowy', null, 38);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL47156010817478805452667402', 'Bank Pekao', null, 32);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL74124000693411542486360084', 'Bank Millennium', null, 7);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL07156011085751655867287204', 'Citi Handlowy', null, 50);

insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL59109010562142613040287158', 'Bank Millennium', 16, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL60249010152554199120360091', 'BZ WBK', 43, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL07106001937471710345370581', 'BZ WBK', 37, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL83156011110243280641860426', 'Bank Millennium', 30, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL57188010193463455235191677', 'Alior Bank', 36, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL67103011332572218484361913', 'Citi Handlowy', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL67103011332572218484361913', 'Citi Handlowy', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL39103011884078753222319442', 'Getin Noble Bank', 33, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL73188000090489110985837479', 'Alior Bank', 49, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('CITIPLPX', 'PL85249010570842049162414593', 'Morgan Stanley', 33, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL63109010562774982370196297', 'Alior Bank', 18, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL51249010449509267152250902', 'Bank Pekao', 40, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL06154010720138564287655890', 'ING Bank Slaski', 2, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL83114010785432767740152149', 'Bank of America', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL43106000896284921917008332', 'Getin Noble Bank', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL75105001613603954224961149', 'Bank Millennium', 17, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL22154011448296841071791970', 'PKO BP', 39, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('DEUTPLPK', 'PL05154000042198123813489548', 'Getin Noble Bank', 23, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('CITIPLPX', 'PL15154010560097346863427627', 'mBank', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL46105001162611056384148164', 'ING Bank Slaski', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL31154011153827655965016826', 'ING Bank Slaski', 44, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL85124000433755302821613752', 'Getin Noble Bank', 42, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL43103011916845775243089600', 'Morgan Stanley', 26, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL70114010652264380915894553', 'PKO BP', 19, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL53249010312912238726209080', 'Citi Handlowy', 32, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL19106001512816517263379755', 'mBank', 31, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL78156011665193825328916717', 'mBank', 39, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL89249010445683958489979673', 'mBank', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('INGBPLPW', 'PL63154011155619584662153943', 'Morgan Stanley', 46, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL69124010378943631055526093', 'ING Bank Slaski', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL46109011318264290267383172', 'Bank Millennium', 47, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL68103010326855729153064866', 'Getin Noble Bank', 10, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL86124010375289098289833393', 'Getin Noble Bank', 35, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('RCBWPLPW', 'PL73105000606040788753296959', 'BZ WBK', 14, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL89105001160689405390399660', 'Bank of America', 24, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL47124010378016190647542652', 'BZ WBK', 43, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL53116022319177253065999850', 'Citi Handlowy', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL95156010819491893435088249', 'Bank Pekao', 9, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL18154010563906864648112505', 'PKO BP', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('LUBWPLPR', 'PL91105000730563530433889343', 'Morgan Stanley', 24, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL53124011254406805310692779', 'Morgan Stanley', 37, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALLBPLPW', 'PL67188010226939231662580563', 'Bank Millennium', 15, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL38109011283137506358628790', 'mBank', 14, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('ALBPPLPW', 'PL29249010282568972641801854', 'Bank Millennium', 40, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL38114011409328487801294219', 'Bank Millennium', 50, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('BPKOPLPW', 'PL11109011028992162124691190', 'Bank Millennium', 25, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PKOPPLPW', 'PL27154010144480555303987410', 'Alior Bank', 5, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('HYVEPLP2', 'PL83109011443695951368249329', 'Bank Millennium', 19, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('PPABPLPK', 'PL18116022285436484744206176', 'Alior Bank', 20, null);
insert into bank_account (bank_swift, bank_account_number, bank_name, seller_id, company_id) values ('VOWAPLP', 'PL40105000023196174503851700', 'Bank Pekao', 33, null);


insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mdooland0', 'DRc6VD', 'mdooland0@symantec.com', 'Maxim', 'Dooland', 'Mexico', 'Lindavista', '36 Center Crossing', '37800', '574-269-1116', 5);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mmorecombe1', 'w8WobE', 'mmorecombe1@bravesites.com', 'Malissa', 'Morecombe', 'Mauritius', 'Cap Malheureux', '422 Lawn Circle', null, '876-723-2757', 21);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('ascorthorne2', 'HQWLGpDv', 'ascorthorne2@chicagotribune.com', 'Aloysia', 'Scorthorne', 'Philippines', 'Catayauan', '8681 Elgar Circle', '3509', '965-888-9900', 29);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('despinay3', 'U4B8WLxsgsE', 'despinay3@domainmarket.com', 'Darryl', 'Espinay', 'Puerto Rico', 'Ponce', '24660 Iowa Parkway', '00731', '347-611-1766', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('flindhe4', 'At2ZFFys2i', 'flindhe4@state.gov', 'Fiona', 'Lindhe', 'Indonesia', 'Inanwatan', '5227 Butterfield Center', null, '796-156-8271', 37);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('zswyre5', '3QJ2nOk', 'zswyre5@ucoz.ru', 'Zena', 'Swyre', 'Colombia', 'Chitagá', '57910 Pond Alley', '544038', '393-964-2997', 21);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('liglesiaz6', '4sPPxV8CxlY', 'liglesiaz6@mediafire.com', 'Larry', 'Iglesiaz', 'Ukraine', 'Svalyava', '758 Glendale Plaza', null, '672-954-4471', 26);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('iunworth7', 'hjtxKHsGHwjC', 'iunworth7@51.la', 'Irwinn', 'Unworth', 'Greece', 'Mýrina', '75875 Blue Bill Park Lane', null, '524-407-1814', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('sgerling8', 'koQ5iZUPX', 'sgerling8@go.com', 'Schuyler', 'Gerling', 'Philippines', 'Naagas', '9 Spohn Trail', '1413', '345-660-8693', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('kgouinlock9', 'hI7lZRVRvoBd', 'kgouinlock9@reuters.com', 'Keary', 'Gouinlock', 'Peru', 'Yanas', '1918 Lindbergh Alley', null, '840-542-6604', 6);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bsybea', 'Pyzb8P', 'bsybea@fc2.com', 'Bellina', 'Sybe', 'Palau', 'Ngchesar Hamlet', '6536 Forest Run Circle', null, '260-248-5566', 23);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('agrigolib', 'zpaQE1gJK6', 'agrigolib@webs.com', 'Adrianna', 'Grigoli', 'Russia', 'Slobodskoy', '874 Hayes Hill', '613155', '506-535-0445', 44);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('proggeroc', 'nbZU43BPb', 'proggeroc@oracle.com', 'Peggy', 'Roggero', 'Brazil', 'Tucumã', '6103 Sutherland Pass', '68385-000', '398-638-6085', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('siddisond', 'OXIj7rhhmwpi', 'siddisond@prweb.com', 'Sheena', 'Iddison', 'Argentina', 'Colonias Unidas', '61317 Browning Alley', '3515', '729-155-7026', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('wcliffe', 'JzCcXvUj', 'wcliffe@washington.edu', 'Wesley', 'Cliff', 'Greece', 'Fteliá', '05199 Veith Lane', null, '289-361-1323', 50);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('kcancelierf', '3QEh1MyMv8', 'kcancelierf@a8.net', 'Kilian', 'Cancelier', 'China', 'Baixiang', '1 Carioca Trail', null, '790-130-4269', 43);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('gbartalig', 'tt5m8JX', 'gbartalig@amazon.co.jp', 'Giacopo', 'Bartali', 'Fiji', 'Levuka', '9926 Northwestern Center', null, '128-901-6450', 13);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('tklimah', '6T5TJG', 'tklimah@squarespace.com', 'Tomkin', 'Klima', 'Russia', 'Burayevo', '808 Welch Hill', '452960', '411-720-0348', 2);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('dkeddyi', 'P2zuOQruE3', 'dkeddyi@craigslist.org', 'Dalia', 'Keddy', 'Belarus', 'Urechcha', '74796 Eastlawn Hill', null, '431-318-2589', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('dwallworthj', 'hxB2MyFhQa', 'dwallworthj@amazon.de', 'Dominick', 'Wallworth', 'Canada', 'Saint-Rémi', '3 Eagan Crossing', 'K1G', '743-587-1741', 3);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('cmougeotk', 'sUReR6', 'cmougeotk@twitpic.com', 'Clement', 'Mougeot', 'Czech Republic', 'Frýdlant', '53235 Corben Place', '464 01', '914-842-0738', 22);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mvardonl', 'cZhgYJtU', 'mvardonl@elegantthemes.com', 'Myranda', 'Vardon', 'Slovenia', 'Bistrica pri Tržiču', '3 Mitchell Plaza', '4290', '531-904-4965', 12);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mjickellsm', '3T9VTw8', 'mjickellsm@ted.com', 'Mauricio', 'Jickells', 'China', 'Xiatuanpu', '4896 West Hill', null, '414-784-1107', 37);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('tcisnerosn', 'tEpUHp', 'tcisnerosn@gravatar.com', 'Trudy', 'Cisneros', 'China', 'Maopingchang', '3 Esch Junction', null, '838-987-8786', 49);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mbridgemano', 'nT2Dm0o56EPI', 'mbridgemano@over-blog.com', 'Marlin', 'Bridgeman', 'Brazil', 'Ilhéus', '15545 Lien Junction', '45650-000', '840-421-7969', 42);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('cgellyp', 'a9brM0D', 'cgellyp@sohu.com', 'Charlene', 'Gelly', 'Costa Rica', 'Juntas', '66 Elka Avenue', '11803', '878-999-8902', 12);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mvakhrushevq', 'SHxbmB8RHO6y', 'mvakhrushevq@cbsnews.com', 'Mac', 'Vakhrushev', 'China', 'Tangzi', '9832 Rowland Circle', null, '910-798-2668', 29);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bcrouchr', 'rZjWl2ts', 'bcrouchr@google.ca', 'Betsy', 'Crouch', 'Colombia', 'Cáceres', '012 Grayhawk Court', '052458', '140-740-1426', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('itreess', 'OCzev4', 'itreess@netvibes.com', 'Idalina', 'Trees', 'Indonesia', 'Waiholo', '4 Farwell Drive', null, '542-481-5303', 7);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('xkahent', 'pT7YPL8', 'xkahent@kickstarter.com', 'Xena', 'Kahen', 'Canada', 'Nelson', '67 Eastlawn Crossing', 'V1L', '526-258-7878', 46);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('ryoxenu', 'JIL7bQ9l', 'ryoxenu@myspace.com', 'Ronald', 'Yoxen', 'Philippines', 'Patao', '98795 Jay Avenue', '6052', '649-729-5941', 35);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bhackletonv', 'BaD2qbyx', 'bhackletonv@redcross.org', 'Bertha', 'Hackleton', 'China', 'Renhe', '94 Havey Point', null, '729-994-3463', 41);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('hkollaschekw', '0r2szM', 'hkollaschekw@bloglines.com', 'Honor', 'Kollaschek', 'Philippines', 'Naili', '2741 Old Shore Place', '5613', '728-439-9322', 8);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('mreignardx', 'hPcVnofEzUHY', 'mreignardx@state.tx.us', 'Melvyn', 'Reignard', 'Albania', 'Kushovë', '99129 Bellgrove Court', null, '512-617-3872', 11);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('tmattocky', 'Vb4Otg', 'tmattocky@wordpress.com', 'Terrence', 'Mattock', 'China', 'Keyinhe', '82041 Park Meadow Court', null, '442-529-7374', 4);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bmclernonz', 'W5gzCB', 'bmclernonz@fastcompany.com', 'Betti', 'McLernon', 'Azerbaijan', 'Dondar Quşçu', '71090 Clemons Circle', null, '838-636-3623', 10);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('amcgrath10', 'n4LzTyNJTB', 'amcgrath10@printfriendly.com', 'Alie', 'Mc Grath', 'Bangladesh', 'Madaripur', '7914 Shoshone Trail', '7904', '564-453-8948', 50);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('spriden11', 'qQT9E3nE5Jxz', 'spriden11@independent.co.uk', 'Shay', 'Priden', 'Indonesia', 'Batugede Kulon', '54 Gale Way', null, '968-612-0352', 34);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bodooley12', '1n0AYF', 'bodooley12@miibeian.gov.cn', 'Bernardina', 'O'' Dooley', 'Philippines', 'Sibucao', '3 Mallard Place', '6130', '535-883-7444', 8);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('ssmither13', 'TYDL48Cpj6', 'ssmither13@biblegateway.com', 'Shannah', 'Smither', 'Mexico', 'Independencia', '1261 Summit Lane', '26830', '196-138-3219', 15);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('fpate14', 'IGMl9YJ', 'fpate14@miibeian.gov.cn', 'Frederich', 'Pate', 'Mongolia', 'Sangiyn Dalay', '9973 Sycamore Plaza', null, '236-716-5746', 9);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('eobrallaghan15', '7YbH9Y4', 'eobrallaghan15@so-net.ne.jp', 'Enrica', 'O''Brallaghan', 'China', 'Lucun', '94 Namekagon Hill', null, '154-316-5511', 27);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('btambling16', 'VNhk6ThrPtqE', 'btambling16@imgur.com', 'Briano', 'Tambling', 'France', 'Bondy', '7 Katie Way', '93144 CEDEX', '907-149-3360', 28);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('htwaits17', '9QE4zlphVh', 'htwaits17@gizmodo.com', 'Harland', 'Twaits', 'Azerbaijan', 'Ramana', '899 4th Drive', null, '943-689-1281', 43);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('hthresher18', '6pBCHkmtKIq', 'hthresher18@so-net.ne.jp', 'Hebert', 'Thresher', 'Portugal', 'Vale da Bajouca', '497 Stuart Terrace', '2425-207', '113-195-3768', 3);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('bhussy19', 'cnvTVXePK6R', 'bhussy19@netscape.com', 'Blair', 'Hussy', 'Indonesia', 'Cibeureum', '3 Golf Plaza', null, '311-235-7086', 38);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('sgellion1a', 'kmooISMeWH', 'sgellion1a@topsy.com', 'Sioux', 'Gellion', 'Portugal', 'Couço', '2 Ridgeway Parkway', '2100-309', '680-597-2583', 9);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('sleaming1b', 'u2jwkgw', 'sleaming1b@about.com', 'Say', 'Leaming', 'China', 'Waina', '3 Portage Junction', null, '191-555-8261', 13);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('aomond1c', 'SVKZEp0IxBbd', 'aomond1c@ebay.com', 'Afton', 'Omond', 'Ukraine', 'Kovel’', '5 Sheridan Parkway', null, '865-441-5762', 47);
insert into "user" (username, password, email, first_name, last_name, country, city, street, postal_code, phone, company_id) values ('hsantarelli1d', 'ngkXCoXmkyY', 'hsantarelli1d@omniture.com', 'Hortensia', 'Santarelli', 'China', 'Jishan', '13 Waywood Circle', null, '855-414-6048', 21);


insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('876690745-4', '2018-10-23 00:27:50', '2019-12-11 00:01:05', '2021-05-15 08:51:59', 44022.71, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', 35218.17, 8804.54, null, 18, 22, 2, 2);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('106893298-8', '2017-08-04 01:06:14', '2019-04-08 12:45:46', '2021-02-20 16:42:21', 64966.88, 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 51973.5, 12993.38, 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', 21, 40, 4, 10);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('653544344-2', '2018-08-14 23:17:07', '2018-11-22 02:30:10', '2021-02-03 21:10:33', 55150.39, 'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', 44120.31, 11030.08, null, 7, 20, 2, 4);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('952205928-5', '2019-04-03 21:37:10', '2019-11-07 22:53:10', '2021-04-16 17:22:07', 36334.68, 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 29067.74, 7266.94, 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', 38, 7, 5, 13);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('076951094-9', '2018-12-12 12:55:59', '2019-10-03 19:57:55', '2020-12-15 01:21:14', 1969.21, 'Etiam faucibus cursus urna. Ut tellus.', 1575.37, 393.84, null, 13, 41, 6, 2);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('548632159-7', '2017-10-01 20:48:48', '2020-01-07 07:41:26', '2021-05-21 01:40:45', 22503.97, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', 18003.18, 4500.79, null, 33, 10, 6, 15);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('983499992-5', '2018-07-24 11:26:54', '2020-07-30 04:02:00', '2020-11-20 10:56:40', 63489.24, 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.', 50791.39, 12697.85, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 31, 4, 6, 11);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('805419880-9', '2018-05-24 06:13:56', '2020-04-16 19:41:35', '2021-02-09 03:59:49', 41972.42, 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 33577.94, 8394.48, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.', 10, 10, 6, 11);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('409808947-5', '2018-02-21 14:18:59', '2020-04-28 13:16:49', '2021-01-24 11:35:58', 22423.49, 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 17938.79, 4484.7, null, 22, 3, 4, 1);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('497756369-7', '2019-04-19 15:28:38', '2019-11-17 07:00:43', '2020-11-25 15:21:56', 55742.54, 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 44594.03, 11148.51, null, 49, 45, 5, 1);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('062322241-8', '2019-05-28 08:54:13', '2019-09-18 06:45:32', '2021-03-06 03:33:10', 33565.49, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 26852.39, 6713.1, null, 47, 3, 6, 17);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('658311659-6', '2018-01-14 16:01:17', '2019-02-13 18:10:27', '2020-12-29 11:41:07', 14306.14, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', 11444.91, 2861.23, null, 45, 18, 4, 8);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('659712848-6', '2018-01-27 23:44:55', '2020-03-07 09:24:36', '2021-02-11 04:06:47', 89618.22, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 71694.58, 17923.64, 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 8, 44, 4, 6);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('372330037-5', '2018-06-25 14:39:01', '2020-06-28 16:06:47', '2021-04-16 00:30:48', 99755.43, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 79804.34, 19951.09, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', 15, 15, 3, 8);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('250595539-5', '2018-10-10 02:13:49', '2020-08-11 11:19:28', '2020-12-05 10:19:09', 99089.43, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 79271.54, 19817.89, 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 33, 8, 5, 11);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('423543691-0', '2018-07-17 03:50:00', '2019-10-05 00:02:35', '2021-02-17 04:27:39', 62891.72, 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 50313.38, 12578.34, null, 16, 32, 4, 2);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('753409139-X', '2018-04-22 10:33:11', '2019-04-09 04:09:17', '2021-01-03 11:22:00', 5892.85, 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 4714.28, 1178.57, null, 1, 7, 4, 4);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('922862956-8', '2019-01-18 21:25:21', '2019-02-19 00:58:22', '2021-01-22 07:49:12', 89134.61, 'Praesent lectus.', 71307.69, 17826.92, 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 48, 11, 3, 18);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('961690234-2', '2019-05-04 01:36:04', '2018-11-21 23:06:13', '2021-02-01 17:37:47', 17803.35, 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 14242.68, 3560.67, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', 4, 42, 4, 13);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('330553212-2', '2019-04-22 11:21:54', '2019-09-16 20:38:38', '2021-04-01 17:44:12', 54239.92, 'Vivamus vel nulla eget eros elementum pellentesque.', 43391.94, 10847.98, 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 38, 21, 5, 24);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('306068941-5', '2018-03-04 08:41:36', '2019-05-24 23:24:25', '2021-02-14 20:26:12', 60753.68, 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 48602.94, 12150.74, null, 41, 5, 1, 18);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('444974399-7', '2017-12-20 09:44:45', '2019-09-26 13:42:00', '2021-05-01 02:20:10', 33744.33, 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 26995.46, 6748.87, null, 48, 10, 5, 24);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('555389463-8', '2018-10-04 22:54:03', '2020-03-03 21:54:32', '2021-04-07 02:31:36', 72289.15, 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 57831.32, 14457.83, null, 45, 34, 4, 6);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('585705191-6', '2018-03-02 18:50:59', '2019-02-12 16:41:38', '2020-11-26 10:56:28', 82976.88, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', 66381.5, 16595.38, 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 27, 28, 1, 23);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('322208852-7', '2018-12-13 03:12:57', '2019-10-24 07:26:05', '2021-02-02 15:37:50', 91148.03, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', 72918.42, 18229.61, null, 35, 49, 3, 11);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('741503178-4', '2018-11-03 11:52:24', '2020-07-09 15:18:35', '2021-03-13 16:46:21', 95898.85, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 76719.08, 19179.77, 'Mauris ullamcorper purus sit amet nulla.', 31, 13, 3, 6);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('886324292-5', '2018-03-21 18:06:23', '2019-02-17 20:24:17', '2020-10-19 04:09:01', 51898.64, 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 41518.91, 10379.73, null, 27, 39, 1, 20);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('845858645-2', '2018-10-20 03:53:51', '2019-06-19 06:59:23', '2021-03-28 14:10:16', 52168.46, 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', 41734.77, 10433.69, 'Nam dui.', 42, 38, 1, 20);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('012084581-4', '2017-09-09 22:00:22', '2018-11-16 07:05:18', '2021-04-20 20:36:28', 64267.79, 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 51414.23, 12853.56, 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 25, 36, 4, 24);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('391287152-3', '2019-05-12 17:14:53', '2019-06-25 20:40:10', '2020-12-05 21:55:20', 63927.88, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 51142.3, 12785.58, null, 12, 50, 4, 19);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('209363658-1', '2017-10-23 10:54:16', '2019-12-04 03:01:35', '2021-04-24 14:50:03', 88178.49, 'Sed vel enim sit amet nunc viverra dapibus.', 70542.79, 17635.7, null, 29, 36, 2, 16);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('177510673-X', '2018-11-03 10:59:21', '2020-06-26 03:12:12', '2021-03-29 08:40:11', 20139.04, 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 16111.23, 4027.81, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 13, 23, 4, 22);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('697180247-0', '2019-02-07 19:54:09', '2019-01-02 04:49:38', '2020-10-16 03:59:36', 87048.21, 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 69638.57, 17409.64, null, 46, 31, 3, 13);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('309367218-X', '2018-04-05 16:13:31', '2020-08-07 07:53:35', '2021-02-22 16:17:19', 28186.44, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 22549.15, 5637.29, null, 18, 44, 1, 16);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('489408772-3', '2018-09-12 23:09:57', '2019-03-27 05:25:24', '2021-05-03 07:59:28', 13564.73, 'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 10851.78, 2712.95, null, 8, 41, 3, 13);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('390205425-5', '2017-09-25 16:47:43', '2019-10-01 11:08:35', '2020-12-13 15:30:24', 75509.67, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 60407.74, 15101.93, null, 44, 33, 5, 4);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('219204723-1', '2017-12-25 19:23:59', '2020-08-18 08:45:03', '2021-02-07 20:54:17', 30538.56, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 24430.85, 6107.71, null, 13, 21, 5, 5);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('574329781-9', '2018-09-01 09:03:33', '2020-04-05 13:12:45', '2021-04-09 16:13:29', 93389.93, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 74711.94, 18677.99, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 3, 33, 6, 21);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('515684318-2', '2017-10-10 10:07:37', '2019-12-26 22:09:39', '2020-11-24 20:55:51', 36273.22, 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', 29018.58, 7254.64, null, 8, 19, 3, 9);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('368110379-8', '2019-01-01 00:50:41', '2019-10-16 20:09:58', '2020-11-06 00:07:31', 80977.67, 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 64782.14, 16195.53, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 17, 44, 2, 1);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('394727821-7', '2019-03-12 11:42:34', '2019-11-15 15:15:35', '2021-04-08 02:03:56', 82793.31, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', 66234.65, 16558.66, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 34, 35, 1, 4);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('809195358-5', '2019-01-06 15:17:36', '2019-02-11 17:19:39', '2021-02-27 07:28:33', 36604.25, 'Curabitur in libero ut massa volutpat convallis.', 29283.4, 7320.85, null, 10, 12, 5, 16);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('333662855-5', '2017-10-12 00:26:54', '2019-12-20 05:02:51', '2021-03-27 11:21:39', 62639.91, 'Morbi vel lectus in quam fringilla rhoncus.', 50111.93, 12527.98, null, 49, 25, 3, 22);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('142304045-7', '2018-12-02 10:17:14', '2019-05-10 14:19:06', '2021-03-11 06:02:57', 83523.79, 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 66819.03, 16704.76, 'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 22, 35, 2, 1);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('667133570-2', '2018-11-05 19:45:41', '2019-01-20 05:08:12', '2021-03-18 16:40:17', 40120.02, 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', 32096.02, 8024.0, null, 19, 26, 5, 20);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('794064711-3', '2019-06-03 08:02:02', '2019-10-20 09:36:20', '2021-01-01 15:34:11', 25940.26, 'Maecenas ut massa quis augue luctus tincidunt.', 20752.21, 5188.05, null, 47, 5, 4, 3);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('568035016-5', '2017-10-05 15:19:00', '2019-01-16 22:35:40', '2020-11-16 11:13:37', 56580.99, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', 45264.79, 11316.2, null, 12, 12, 4, 22);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('733495733-4', '2019-05-06 08:27:58', '2019-01-06 17:30:56', '2021-03-16 14:08:15', 21419.37, 'Vestibulum sed magna at nunc commodo placerat.', 17135.5, 4283.87, null, 37, 7, 5, 15);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('863045527-6', '2019-02-19 13:30:11', '2020-03-07 03:28:32', '2021-05-18 08:49:43', 40641.05, 'In sagittis dui vel nisl.', 32512.84, 8128.21, null, 24, 20, 4, 8);
insert into invoice (invoice_number, creation_date, sale_date, payment_deadline, to_pay, to_pay_in_words, paid, left_to_pay, remarks, seller_id, customer_id, payment_type_id, currency_id) values ('557290642-5', '2018-09-13 18:59:18', '2020-03-05 06:20:17', '2021-02-17 11:54:12', 1706.47, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', 1365.18, 341.29, null, 2, 24, 3, 13);


insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (79, 5587.48, 441410.92, 0.23, 101524.51, 542935.43, 50, 0);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (55, 223.57, 12296.35, 0.1, 1229.64, 13525.99, 40, 7);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (56, 5561.03, 311417.68, 0.18, 56055.18, 367472.86, 36, 4);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (12, 5468.3, 65619.6, 0.16, 10499.14, 76118.74, 21, 0);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (55, 2888.02, 158841.1, 0.1, 15884.11, 174725.21, 42, 2);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (75, 3410.05, 255753.75, 0.01, 2557.54, 258311.29, 45, 47);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (86, 6609.58, 568423.88, 0.05, 28421.19, 596845.07, 9, 16);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (67, 7122.54, 477210.18, 0.17, 81125.73, 558335.91, 5, 37);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (69, 7228.47, 498764.43, 0.04, 19950.58, 518715.01, 50, 47);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (46, 6072.58, 279338.68, 0.12, 33520.64, 312859.32, 29, 38);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (46, 6953.6, 319865.6, 0.06, 19191.94, 339057.54, 10, 33);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (15, 568.69, 8530.35, 0.06, 511.82, 9042.17, 12, 6);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (43, 7849.34, 337521.62, 0.13, 43877.81, 381399.43, 38, 32);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (36, 6219.51, 223902.36, 0.18, 40302.42, 264204.78, 23, 32);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (24, 2599.07, 62377.68, 0.05, 3118.88, 65496.56, 29, 2);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (86, 4526.89, 389312.54, 0.18, 70076.26, 459388.8, 26, 15);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (85, 7966.29, 677134.65, 0.08, 54170.77, 731305.42, 46, 0);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (40, 1432.4, 57296.0, 0.11, 6302.56, 63598.56, 26, 38);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (61, 9410.97, 574069.17, 0.15, 86110.38, 660179.55, 14, 2);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (93, 3769.75, 350586.75, 0.15, 52588.01, 403174.76, 48, 33);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (28, 5243.67, 146822.76, 0.06, 8809.37, 155632.13, 40, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (77, 3707.38, 285468.26, 0.05, 14273.41, 299741.67, 1, 5);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (5, 1675.09, 8375.45, 0.17, 1423.83, 9799.28, 43, 3);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (54, 7347.14, 396745.56, 0.21, 83316.57, 480062.13, 6, 16);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (57, 6026.53, 343512.21, 0.14, 48091.71, 391603.92, 8, 35);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (7, 9924.17, 69469.19, 0.21, 14588.53, 84057.72, 1, 14);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (2, 4307.02, 8614.04, 0.11, 947.54, 9561.58, 46, 39);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (37, 4501.45, 166553.65, 0.14, 23317.51, 189871.16, 13, 42);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (2, 8595.79, 17191.58, 0.01, 171.92, 17363.5, 23, 1);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (97, 164.12, 15919.64, 0.19, 3024.73, 18944.37, 39, 34);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (2, 6893.37, 13786.74, 0.03, 413.6, 14200.34, 0, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (1, 5486.61, 5486.61, 0.01, 54.87, 5541.48, 15, 35);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (77, 1507.54, 116080.58, 0.21, 24376.92, 140457.5, 20, 36);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (14, 849.42, 11891.88, 0.21, 2497.29, 14389.17, 16, 24);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (17, 4293.37, 72987.29, 0.17, 12407.84, 85395.13, 46, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (26, 1455.86, 37852.36, 0.12, 4542.28, 42394.64, 47, 36);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (26, 2991.9, 77789.4, 0.19, 14779.99, 92569.39, 32, 49);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (94, 1231.8, 115789.2, 0.14, 16210.49, 131999.69, 33, 28);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (58, 4742.23, 275049.34, 0.04, 11001.97, 286051.31, 32, 50);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (9, 9196.01, 82764.09, 0.22, 18208.1, 100972.19, 15, 23);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (34, 918.07, 31214.38, 0.2, 6242.88, 37457.26, 47, 12);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (75, 2487.6, 186570.0, 0.09, 16791.3, 203361.3, 35, 46);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (28, 9524.23, 266678.44, 0.04, 10667.14, 277345.58, 30, 18);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (42, 1518.06, 63758.52, 0.17, 10838.95, 74597.47, 37, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (23, 9898.78, 227671.94, 0.08, 18213.76, 245885.7, 4, 41);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (85, 4177.34, 355073.9, 0.18, 63913.3, 418987.2, 2, 18);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (83, 2717.73, 225571.59, 0.06, 13534.3, 239105.89, 35, 28);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (79, 4655.54, 367787.66, 0.21, 77235.41, 445023.07, 16, 25);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (59, 7049.07, 415895.13, 0.13, 54066.37, 469961.5, 2, 26);
insert into invoice_item (quentity, net_price, net_value, vat_rate, vat_value, gross_value, product_id, invoice_id) values (23, 8147.15, 187384.45, 0.04, 7495.38, 194879.83, 10, 43);



insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-12-26 03:17:06', 22164.36, 3, 5, 34, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-09-12 05:59:01', 22082.69, 5, 28, 24, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-12-05 03:39:11', 86029.62, 4, 48, 15, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-11-07 04:30:13', 97122.93, 1, 43, 41, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-06-03 04:37:35', 36985.52, 5, 39, 39, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2021-01-12 21:24:12', 17815.16, 3, 5, 46, 23);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-10-05 17:00:24', 29945.72, 4, 10, 38, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-05-24 11:34:53', 23587.59, 2, 15, 18, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-11-06 05:16:48', 97712.52, 3, 1, 46, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-03-03 06:49:06', 75442.42, 8, 20, 26, 18);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-07-09 19:47:17', 55156.98, 1, 20, 43, 24);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-11-17 07:25:57', 92654.68, 5, 27, 29, 8);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-11-18 22:50:02', 72513.3, 8, 25, 27, 24);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-11-20 04:56:05', 2538.94, 2, 27, 40, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-12-09 12:17:51', 57620.07, 2, 50, 32, 13);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-09-16 02:18:24', 745.49, 5, 32, 19, 23);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-12-09 21:00:25', 11557.89, 5, 44, 2, 10);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-10-19 22:09:25', 50945.65, 4, 12, 1, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-07-31 00:13:47', 43617.68, 4, 12, 17, 12);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-11-10 01:03:24', 56995.3, 5, 1, 50, 1);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-09-07 05:29:44', 15083.01, 3, 12, 28, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-12-14 15:54:11', 30375.08, 4, 34, 7, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-03-15 13:46:07', 33862.72, 6, 4, 14, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-06-04 00:07:55', 35271.77, 3, 9, 33, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-11-20 19:42:19', 70052.79, 2, 23, 15, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-01-06 03:09:56', 38058.23, 4, 8, 39, 3);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2021-03-21 04:12:44', 98892.12, 3, 8, 38, 5);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-10-15 10:17:50', 37049.42, 7, 45, 43, 10);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-10-26 20:20:58', 90190.43, 1, 48, 14, 22);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-12-09 20:46:28', 57548.92, 5, 24, 35, 21);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-11-28 09:49:34', 83282.64, 2, 19, 36, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-08-22 17:05:11', 94994.78, 2, 37, 24, 1);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-09-10 07:50:02', 23144.53, 1, 42, 44, 22);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-09-11 10:18:51', 49072.25, 5, 17, 33, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-12-23 00:11:35', 90197.58, 6, 46, 16, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-03-07 15:34:23', 57216.97, 3, 46, 8, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-07-12 05:29:42', 76332.12, 6, 12, 23, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-04-18 10:56:23', 14746.91, 2, 45, 38, 9);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-05-28 20:50:48', 87061.86, 3, 47, 6, 2);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2021-04-15 09:37:24', 27091.06, 6, 27, 33, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-07-08 05:48:06', 79190.1, 5, 28, 49, 14);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-03-14 02:25:48', 94670.87, 8, 1, 7, 4);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2021-09-02 03:51:51', 39607.5, 5, 30, 3, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-10-14 09:03:33', 87270.59, 3, 36, 14, 19);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2019-01-25 16:48:41', 84731.67, 6, 35, 10, 6);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-11-16 01:32:30', 70535.7, 1, 22, 22, 15);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-10-14 09:00:14', 654.52, 6, 48, 2, 21);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2017-08-17 15:45:01', 96322.37, 7, 46, 6, 17);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2020-08-08 07:05:15', 6499.0, 6, 11, 26, 7);
insert into transaction (transaction_date, value, status_id, customer_id, invoice_id, currency_id) values ('2018-03-02 18:10:31', 98870.03, 4, 15, 2, 13);


insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1482177900', 'nunc', '2020-06-18 03:02:45', 33404.86, 7179.15, 0.01, 405.84, 24, 18, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1186822503', 'dolor sit amet', '2020-04-26 11:08:02', 93294.2, 720.65, 0.0, 0.0, 38, 34, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2003330453', 'dolor', '2017-09-13 16:33:06', 54832.97, 11236.81, 0.01, 660.7, 34, 19, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('4512022287', 'lobortis vel', '2021-03-26 02:14:25', 76209.11, 1155.95, 0.01, 773.65, 44, 28, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('3591912913', 'sociis natoque', '2019-02-12 15:49:14', 28772.94, 14890.81, 0.02, 873.28, 38, 4, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1812382057', 'euismod scelerisque quam', '2019-05-05 14:01:07', 55932.2, 18036.69, 0.01, 739.69, 16, 20, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2674111763', 'amet sem fusce', '2020-11-12 21:06:42', 19047.75, 8281.78, 0.0, 0.0, 18, 15, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1976330076', 'mauris lacinia', '2019-12-17 08:19:15', 26846.56, 7021.82, 0.01, 338.68, 41, 31, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1981033408', 'id', '2019-02-17 13:14:16', 76700.73, 6210.31, 0.01, 829.11, 37, 40, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('3184553434', 'quis', '2018-02-26 14:44:37', 45274.98, 7509.84, 0.01, 527.85, 34, 41, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2395578231', 'nulla nisl', '2018-10-16 18:02:27', 50274.58, 10874.03, 0.01, 611.49, 30, 46, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('5438616566', 'cras', '2019-06-30 00:11:49', 57387.26, 7111.55, 0.01, 644.99, 1, 10, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('0632470038', 'vel', '2019-12-24 13:52:12', 5348.58, 7398.78, 0.01, 127.47, 32, 13, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9383820993', 'dis parturient montes', '2021-01-23 03:30:49', 57899.67, 16553.7, 0.0, 0.0, 35, 47, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('5579946309', 'ut nulla sed', '2019-09-08 05:20:57', 6675.4, 2736.65, 0.02, 188.24, 2, 8, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('6397279669', 'faucibus cursus urna', '2018-11-12 17:33:57', 30377.04, 3743.71, 0.02, 682.42, 26, 27, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1414346387', 'nisi at nibh', '2019-04-17 12:19:27', 63403.67, 11944.81, 0.01, 753.48, 6, 42, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9679606368', 'dui', '2021-04-10 04:33:25', 53254.28, 3260.29, 0.0, 0.0, 38, 6, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('4723290354', 'donec', '2019-04-03 13:16:22', 69888.82, 6238.25, 0.01, 761.27, 35, 32, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('3157395319', 'tortor', '2018-12-22 01:12:06', 8444.38, 3539.45, 0.02, 239.68, 25, 15, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1472695461', 'nascetur ridiculus', '2020-12-30 19:10:43', 71712.1, 17492.87, 0.0, 0.0, 12, 22, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9081357034', 'lectus', '2020-10-28 00:15:07', 51948.89, 17647.13, 0.0, 0.0, 50, 41, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('4257652527', 'leo odio porttitor', '2017-09-25 01:54:58', 76289.71, 16288.51, 0.0, 0.0, 17, 44, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1843905914', 'odio in hac', '2019-12-30 09:28:12', 42027.6, 14619.66, 0.02, 1132.95, 6, 34, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9905593314', 'libero', '2020-11-30 15:40:03', 92284.3, 10713.82, 0.01, 1029.98, 27, 30, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1782717870', 'aenean fermentum donec', '2020-05-24 22:00:47', 84674.3, 19906.02, 0.0, 0.0, 4, 15, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9541578020', 'sed', '2018-03-19 06:25:28', 70333.51, 12652.29, 0.01, 829.86, 32, 8, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('5464369554', 'mus etiam', '2019-09-24 08:39:00', 25469.17, 3661.61, 0.01, 291.31, 8, 8, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1166627322', 'congue', '2020-05-21 04:30:26', 69861.16, 156.68, 0.01, 700.18, 30, 34, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('7942581802', 'etiam justo', '2020-04-01 15:34:07', 88828.8, 3798.96, 0.01, 926.28, 22, 39, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('7911595151', 'sed', '2017-10-03 09:25:46', 30270.99, 8836.93, 0.0, 0.0, 39, 24, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2766550690', 'tincidunt in', '2020-01-13 22:50:45', 69855.45, 6594.6, 0.01, 764.5, 28, 39, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('7795125743', 'quis libero nullam', '2018-03-02 21:56:08', 82003.75, 19608.66, 0.02, 2032.25, 21, 38, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('0376401826', 'donec vitae nisi', '2019-05-03 13:38:44', 61940.17, 18844.24, 0.01, 807.84, 15, 34, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2843359643', 'ante ipsum primis', '2021-03-20 14:07:44', 883.21, 11485.76, 0.0, 0.0, 32, 2, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2922180824', 'sit amet', '2021-01-23 15:04:29', 58076.25, 10059.35, 0.02, 1362.71, 40, 12, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('3048132856', 'elit', '2017-11-29 01:09:25', 72239.8, 15918.8, 0.01, 881.59, 48, 12, 5);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('2891242661', 'donec diam', '2020-03-04 11:21:34', 80802.79, 18518.04, 0.01, 993.21, 42, 37, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('5675066128', 'morbi odio odio', '2019-11-28 02:43:38', 66451.44, 102.61, 0.02, 1331.08, 4, 43, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('3722620260', 'sem', '2020-04-25 10:43:03', 75919.93, 9999.34, 0.01, 859.19, 5, 29, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('4121958012', 'sem sed', '2021-09-12 13:17:59', 12397.54, 15718.1, 0.01, 281.16, 24, 50, 2);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9389112133', 'vestibulum vestibulum', '2020-11-15 16:03:27', 62584.23, 4859.34, 0.01, 674.44, 16, 6, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('4077605709', 'rutrum rutrum neque', '2019-08-26 09:10:39', 8132.61, 17115.97, 0.01, 252.49, 33, 18, 1);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('9212351638', 'gravida nisi at', '2018-05-01 06:06:50', 10187.15, 16192.35, 0.0, 0.0, 23, 49, 8);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('6428932784', 'ultrices mattis', '2019-11-16 04:42:47', 48785.89, 1479.43, 0.01, 502.65, 18, 7, 7);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('0746847491', 'suspendisse accumsan', '2021-06-29 02:37:03', 53767.65, 922.69, 0.01, 546.9, 13, 9, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('1797003569', 'posuere nonummy integer', '2017-09-27 09:53:22', 73089.46, 19889.26, 0.01, 929.79, 48, 21, 3);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('5616390607', 'gravida sem praesent', '2020-06-21 00:39:19', 71135.02, 6835.59, 0.01, 779.71, 39, 33, 6);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('7381435217', 'diam erat', '2017-12-17 19:04:34', 19077.94, 6556.52, 0.02, 512.69, 42, 34, 4);
insert into "order" (order_number, order_type, order_date, first_pay_ammount, second_pay_ammount, commission_rate, commission_value, invoice_id, user_id, status_id) values ('0458799653', 'nibh', '2020-06-25 08:41:41', 9716.0, 2612.59, 0.0, 0.0, 1, 3, 1);
