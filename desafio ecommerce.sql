-- criação do banco de dados ecommerce
create database ecommerce;
use ecommerce;

-- criar tabela clientes

CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit VARCHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    CONSTRAINT unique_cpf_client UNIQUE (CPF),
    Address VARCHAR(30)
);

-- criar tabela produto
-- size equivale a dimensão do produto

CREATE TABLE product(
    IdProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10),
    Classification_Kids BOOL DEFAULT FALSE,
    Category ENUM('Eletrônico', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    Avaliation FLOAT DEFAULT 0,
    Size VARCHAR(10)
);

-- para ser continuado no desafio, termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no doagrama do esquema relacional
-- criar constraints relacioandas ao pagamento
CREATE TABLE payments(
    IdClient INT PRIMARY KEY,
    IdPayment INT,
    TypePayment ENUM('Card', 'Pix', 'Boleto', 'Dois cartões', 'Transferência'),
    limitAvailiable FLOAT
);

-- criar tabela pedido
-- sendvalue é o frete
CREATE TABLE orders(
    IdOrder INT AUTO_INCREMENT PRIMARY KEY,
    IdOrderClient INT,
    OrderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    OrdersDescription VARCHAR(255),
    SendValue FLOAT DEFAULT 10,
    PaymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (IdorderClient) REFERENCES clients (IdClient)
);

-- criar tabela estoque

CREATE TABLE storagelocation(
	IdLproduct int,
    IdLstorage int,
    Location varchar (255) not null,
    primary key (IdLproduct,IdLstorage),
    constraint fk_product_location foreign key (IdLproduct) references product(IdProduct),
    constraint fk_product_location_storage foreign key (IdLstorage) references productOrder(IdPOorder)
);

-- criar tabela fornecedor

CREATE TABLE supplier(
    IdSupllier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Contact CHAR(11) DEFAULT 0,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- criar tabela vendedor

CREATE TABLE seller(
    IdSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialNameSeller VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(15) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Location varchar(255),
    Contact CHAR(11) DEFAULT 0,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- criar tabela produtos vendedor

create table productSeller(
	IdPseller int,
	IdProduct int,
	ProductQuantity int default 1,
	primary key (IdPseller, IdProduct),
	constraint fk_product_seller foreign key (IdPSeller) references seller(IdSeller),
	constraint fk_product_product foreign key (IdProduct) references product(IdProduct)
);

create table productOrder(
	IdPOproduct int,
	IdPOorder int,
	PoQuantity int default 1,
    PoStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
	primary key (IdPOproduct, IdPOorder),
	constraint fk_product_order foreign key (IdPOproduct) references product(IdProduct),
	constraint fk_product_productOrder foreign key (IdPOorder) references orders(IdOrder)
);

show tables;
drop table cliente;
show databases;
use information_schema;
show tables;
desc table_constraints;

