drop database if exists db_ebbim;
create database db_ebbim
	default charset utf8mb4
	default collate utf8mb4_general_ci;
use db_ebbim;

create table aa_pessoas (
	cd_pessoa int(11) not null,
	nm_pessoa varchar(30),
    nm_apelido varchar(30),
    nm_razao_social varchar(30),
    dt_nascimento date,
    -- estrangeiro registra se é ou não estrangeiro, enquanto a nacionalidade registra qual o gentílico do país onde a pessoa nasceu
    ic_estrangeiro boolean,
    nm_nacionalidade varchar(22) default 'brasileiro',
    -- gênero inicialmente é masculino ou feminino
    ic_genero varchar(10),
    ic_pf boolean,
    cd_cpf_cnpj varchar(14) unique,
    cd_rg varchar(11) unique,
    cd_inscricao_estadual int(9) unique,
    cd_inscricao_municipal int(11) unique,
    -- fornecedor é se a pessoa fornece algo, como por exemplo alimentos, remédios, produtos de limpeza, e etc
    nm_fornecedor varchar(30),
    nm_area_atuacao varchar(30),
    nm_empresa varchar(30),
    nm_funcao varchar(30),
    ds_comentario varchar(140),
	primary key (cd_pessoa)
) default charset utf8mb4;

create table ab_emails (
	cd_email int(11) not null,
    nm_email varchar(50),
    ic_principal boolean,
    cd_pessoa int(11),
	primary key (cd_email),
    constraint fk_email_pessoa
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;

create table ac_telefones (
	cd_telefone int(11) not null,
    nm_ddi int(3) default 51,
    nm_ddd int(3),
    nm_numero int(11),
    -- o tipo seria celular, comercial, residencial, outros ...
    ic_tipo varchar(11),
    cd_pessoa int(11),
	primary key (cd_telefone),
    constraint fk_telefone_pessoa
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;

create table ad_colaboradores(
	cd_colaborador int(11) not null,
    cd_pessoa int(11),
    primary key (cd_colaborador),
    constraint fk_colaborador_pessoa
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;