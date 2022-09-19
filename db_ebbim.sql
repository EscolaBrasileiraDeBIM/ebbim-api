create database db_ebbim;
use db_ebbim;

create table aa_pessoas(
	cd_pessoa varchar(10) not null,
	nm_pessoa varchar(50) not null,
    nm_apelido varchar(50),
    nm_razao_social varchar(50),
    ic_estrangeiro boolean,
    ic_genero varchar(20) not null,
    ic_pf boolean,
    cd_cpf_cnpj varchar(13),
    cd_inscricao_estadual int(10),
    cd_inscricao_municipal int(10),
    nm_fornecedor varchar(50),
    nm_empresa varchar(50),
    ds_comentario varchar(120),
    cd_rg int(10),
    dt_nascimento date,
    primary key (cd_pessoa)
);

create table ac_telefone(
	cd_telefone varchar(10),
    nm_tipo varchar(20),
    cd_ddi int(2),
    cd_ddd int(2),
    cd_numero int(15),
    cd_ramal int(5),
    cd_pessoa varchar(10),
    primary key (cd_telefone),
    constraint fk_pessoas_telefone foreign key (cd_pessoa) references aa_pessoas(cd_pessoa)
);

create table ab_email(
	cd_email varchar(10),
    nm_email varchar(50),
    ic_principal boolean,
    cd_pessoa varchar(10),
    primary key (cd_email),
    constraint fk_pessoas_email foreign key (cd_pessoa) references aa_pessoas(cd_pessoa)
);