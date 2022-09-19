create database db_ebbim
	default charset utf8mb4
	default collate utf8mb4_general_ci;
use db_ebbim;

create table aa_pessoas(
	cd_pessoa varchar(10) not null,
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