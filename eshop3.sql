CREATE DATABASE eshop;
USE eshop;

CREATE TABLE users(
	pk_userId 	INT NOT NULL UNIQUE AUTO_INCREMENT,
    name 		varchar(40) NOT NULL UNIQUE,
    phoneNumber	varchar(12),
    
    PRIMARY KEY (pk_userId)
);

CREATE TABLE buyer(
	pk_userId INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY (pk_userId),
    foreign key (pk_userId) references users(pk_userId)
);

CREATE TABLE seller(
	pk_userId INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY (pk_userId),
    foreign key(pk_userId) references users(pk_userId)
);

CREATE TABLE bankCard(
	pk_cardNumber 	char(19) NOT NULL,
    expiryDate 		date NOT NULL,
    bank 			varchar(20),
    
    PRIMARY KEY (pk_cardNumber)
);

CREATE TABLE creditCard(
	pk_cardNumber 	char(19) NOT NULL,
    fk_userId 		INT NOT NULL,
    organization 	varchar(50),
    
    PRIMARY KEY (pk_cardNumber),
    foreign key (pk_cardNumber) references bankCard(pk_cardNumber),
    foreign key(fk_userId) references users(pk_userId)
);

CREATE TABLE debitCard(
	pk_cardNumber 		char(19) NOT NULL,
    fk_userId 		INT NOT NULL,	
    PRIMARY KEY (pk_cardNumber),
    
    foreign key(pk_cardNumber) references bankCard(pk_cardNumber),
    foreign key(fk_userId) references users(pk_userId)
);

CREATE TABLE store(
	pk_sid 			INT NOT NULL,
    name 			varchar(50) NOT NULL,
	province 		varchar(35) NOT NULL,
	city 			varchar(40) NOT NULL,
    streetAdr 		varchar(30) NOT NULL,
    customerGrade  	INT,
    startTime		date NOT NULL,
    
    PRIMARY KEY (pk_sid)
);

CREATE TABLE brand(
	pk_brandName varchar(50) NOT NULL,
    
    PRIMARY KEY (pk_brandName)
);

CREATE TABLE product(
	pk_pid 			INT NOT NULL,
    fk_sid 			INT NOT NULL,
    name 			varchar(120) NOT NULL,
    fk_brandName 	varchar(30) NOT NULL,
    type 			varchar(50),
	amount 			INT DEFAULT NULL,
    price 			DECIMAL(6,2),
    color 			varchar(20),
    modelNumber 	varchar(50),
    
    PRIMARY KEY (pk_pid),
    foreign key(fk_sid) references store(pk_sid),
    foreign key(fk_brandName) references brand(pk_brandName)
);

CREATE TABLE orderItem(
	pk_itemId 		INT NOT NULL AUTO_INCREMENT,
    fk_pid 			INT NOT NULL,
    price 			DECIMAL(6,2),
    creationTime 	date NOT NULL,
    
    PRIMARY KEY (pk_itemId),
    foreign key(fk_pid) references product(pk_pid)
);

CREATE TABLE orders(
	pk_orderNumber 	INT NOT NULL,
	paymentStatus 	ENUM('Paid', 'Unpaid'),
    creationTime    date NOT NULL,
    totalAmount 	DECIMAL(10,2),
    
    PRIMARY KEY(pk_orderNumber)
);


CREATE TABLE address(
	pk_addrId 			INT NOT NULL,
    fk_userId 			INT NOT NULL,
    name 				varchar(50),
    contactPhoneNumber 	varchar(20), 
    province 			varchar(100),
	city 				varchar(100),
    streetAddr 			varchar(100),
    postalCode 			varchar(12),
    
    PRIMARY KEY (pk_addrId),
    foreign key(fk_userId) references users(pk_userId)
);

CREATE TABLE comments(
	creationTime 	date NOT NULL,
    fk_userId 		INT NOT NULL,
    fk_pid 			INT NOT NULL, 
    grade 			FLOAT,
    content 		varchar(500),
    
    PRIMARY KEY(creationTime, fk_userId, fk_pid),
    foreign key(fk_userId) references users(pk_userId),
    foreign key(fk_pid) references product(pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid 	INT NOT NULL,
    streetAdr 	varchar(100) NOT NULL,
    city 		varchar(50), 
    province 	varchar(50),
    startTime 	varchar(20),
    endTime 	varchar(20),
    
    PRIMARY KEY(pk_spid)
);

CREATE TABLE save_to_shopping_cart(
	fk_userId 	INT NOT NULL,
    fk_pid 		INT NOT NULL,
    addTime 	date NOT NULL,
    quantity 	INT,
    
    PRIMARY KEY(fk_userId, fk_pid),
    foreign key(fk_userId) references users(pk_userId),
    foreign key(fk_pid) references product(pk_pid)
);

CREATE TABLE contain(
	fk_orderNumber 	INT NOT NULL,
    fk_itemId 		INT NOT NULL,
    quantity 		INT,
    
    PRIMARY KEY (fk_orderNumber),
    foreign key(fk_orderNumber) references orders(pk_orderNumber),
    foreign key(fk_itemId) references orderItem(pk_itemId)
);

CREATE TABLE payment(
	fk_orderNumber 		INT NOT NULL,
    fk_creditCardNumber varchar(25),
    payTime 			date,
    
    PRIMARY KEY (fk_orderNumber, fk_creditCardNumber),
    foreign key (fk_creditCardNumber) references bankCard(pk_cardNumber),
	foreign key(fk_orderNumber) references orders(pk_orderNumber)
);

CREATE TABLE deliver_to(
	fk_addrId 		INT NOT NULL,
    fk_orderNumber 	INT NOT NULL,
	timeDelivered 	date,
    
    PRIMARY KEY(fk_addrId, fk_orderNumber),
    foreign key(fk_addrId) references address(pk_addrId),
    foreign key(fk_orderNumber) references orders(pk_orderNumber)
);

CREATE TABLE manage(
	fk_userId 	INT NOT NULL,
    fk_sid 		INT NOT NULL,
    setUpTime 	date,
    
    PRIMARY KEY(fk_userId, fk_sid),
    foreign key(fk_userId) references users(pk_userId),
    foreign key(fk_sid) references store(pk_sid)
);

CREATE TABLE after_sales_service_at(
	fk_brandName 	varchar(20) NOT NULL,
    fk_spid 	INT NOT NULL,
    
    PRIMARY KEY (fk_brandName, fk_spid),
    foreign key(fk_brandName) references brand(pk_brandName),
    foreign key(fk_spid) references servicePoint(pk_spid)
);
