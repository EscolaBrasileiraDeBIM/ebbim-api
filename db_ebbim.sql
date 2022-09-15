drop database if exists db_ebbim;
create database db_ebbim
	default charset utf8mb4
	default collate utf8mb4_general_ci;
use db_ebbim;

create table aa_pessoas (
	cd_pessoa int(11) not null,
	nm_pessoa varchar(50) not null,
    nm_apelido varchar(50),
    nm_razao_social varchar(50),
    dt_nascimento date,
    -- estrangeiro registra se é ou não estrangeiro, enquanto a nacionalidade registra qual o gentílico do país onde a pessoa nasceu
    ic_estrangeiro boolean,
    nm_nacionalidade varchar(22) default 'brasileiro',
    -- gênero inicialmente é masculino ou feminino
    ic_genero varchar(20),
    ic_pf boolean,
    cd_cpf_cnpj varchar(14) unique,
    cd_rg int(11) unique,
    cd_inscricao_estadual int(9) unique,
    cd_inscricao_municipal int(11) unique,
    -- fornecedor é se a pessoa fornece algo, como por exemplo alimentos, remédios, produtos de limpeza, e etc
    nm_fornecedor varchar(50),
    nm_area_atuacao varchar(50),
    nm_empresa varchar(50),
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
    constraint fk_pessoa_email
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;

create table ac_telefones (
	cd_telefone int(11) not null,
    -- o tipo seria celular, comercial, residencial, outros ...
    nm_tipo varchar(11),
    cd_ddi int(3) default 51,
    cd_ddd int(3),
    cd_numero int(15),
    cd_ramal int(5),
    cd_pessoa int(11),
	primary key (cd_telefone),
    constraint fk_pessoa_telefone
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;

create table ad_colaboradores(
	cd_colaborador int(11) not null,
    ic_ativo boolean,
    ic_instrutor boolean,
    nm_escolaridade varchar(30),
    nm_funcao_principal varchar(30),
    -- cv é o curriculum vitae
    ds_cv varchar(2000),
    nm_funcoes varchar(200),
    nm_login varchar(50),
    cd_seguro_estagio int(20),
    cd_pessoa int(11),
    primary key (cd_colaborador),
    constraint fk_pessoa_colaborador
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;