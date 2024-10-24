create database if not exists Loja;

use Loja;

create table Estado (
	ID int primary key auto_increment,
    Nome varchar(50) not null,
    UF varchar(2) not null
);

create table Municipio (
	ID int primary key auto_increment,
	FK_EstadoID int not null,
    Nome varchar(80) not null,
    codIBGE int not null,
    foreign key (FK_EstadoID) references Estado(ID)
);

create table Cliente (
	ID int primary key auto_increment,
    Nome varchar(80) not null,
    CPF varchar(11) not null,
    Celular varchar(11) not null,
    EndLogradouro varchar(100) not null,
    EndNumero varchar(10) not null,
    EndMunicipio int not null,
    EndCEP char(8) not null,
    FK_Municipio_ID int not null,
    foreign key (FK_Municipio_ID) references Municipio(ID)
);

create table ContaReceber(
	ID int primary key auto_increment,
    FK_Cliente_ID int not null,
    FaturaVendaID int not null,
    DataConta date not null,
    DataVencimento date not null,
    Valor decimal (18,2) not null,
    Situacao enum ('1','2','3') not null,
    foreign key (FK_Cliente_ID) references Cliente(ID)
);

insert into Estado (Nome, UF) values
('Rio de Janeiro', 'RJ'),
('Pernambuco', 'PE'),
('Espírito Santo', 'ES');

select * from Estado;

insert into Municipio(Fk_EstadoID, Nome, CodIBGE) values
(1, 'São Gonçalo', 3304904), 
(2, 'Recife', 2611606),
(3, 'Vitória', 3205309);

select * from Municipio;

insert into Cliente (Nome, CPF, Celular, EndLogradouro, EndNumero, EndMunicipio, Fk_Municipio_ID, EndCEP) values
('Felipe Brito', '16294214750', '21982076692', 'Rua Cisco Guedes', '305', 1, 1, '24415060'),
('Beatriz Silva', '19875846089', '21979645981', 'Av. Lucio Feteira', '204', 2, 2, '35584965'),
('João Pedro', '08787455501', '21988745667', 'Rua Ubatuba', '299', 3, 3, '21044891');

select * from Cliente;

insert into ContaReceber (Fk_Cliente_ID, FaturaVendaID, DataConta, DataVencimento, Valor, Situacao) values
(1, 101, '2024-10-28', '2025-09-27', 400.00, '1'),
(2, 103, '2024-10-30', '2025-09-29', 550.00, '2'),
(3, 100, '2024-09-05', '2025-08-03', 860.00, '3');

select * from ContaReceber;

create view  ContasNaoPagas as
select CR.ID as 'ID - Conta a Receber',
	   C.Nome as 'Nome - Cliente',
       C.CPF as 'CPF - Cliente',
       CR.DataVencimento as 'Data de Vencimento',
       CR.Valor as 'Valor - Conta'
from ContaReceber CR
join Cliente C on CR.FK_Cliente_ID = C.ID
where CR.Situacao = '1';

select * from ContasNaoPagas;