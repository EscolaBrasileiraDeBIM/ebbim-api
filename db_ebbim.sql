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
    cd_pessoa int(11) not null,
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
    cd_pessoa int(11) not null,
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
    nm_login varchar(50) unique,
    nm_seguro_estagio varchar(60),
    cd_pessoa int(11) not null,
    primary key (cd_colaborador),
    constraint fk_pessoa_colaborador
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa)
) default charset utf8mb4;

create table ag_formularios_colaboradores (
	cd_formulario int(11) not null,
    -- Tipos 0, 1 e 2: 0 - colaborador (não incluí instrutores); 1 - instrutor que está na escola mesmo sem aula, plantão de dúvidas ou atendimento marcado; 2 - instrutor que vem para a escola só quando tema aula, plantão de dúvidas ou atendimento marcado
    qt_tipo_horario tinyint,
    dt_validade_inicio date,
    dt_validade_fim date,
    cd_colaborador int(11) not null,
    primary key (cd_formulario),
    constraint fk_colaborador_formulario
		foreign key (cd_colaborador)
		references ad_colaboradores(cd_colaborador)
) default charset utf8mb4;

create table ah_horarios_colaboradores (
	cd_horario int(11) not null,
    qt_tipo_horario tinyint,
    qt_dia_semana tinyint,
    hr_expediente_inicio time,
    hr_intervalo_inicio time,
    hr_intervalo_fim time,
    hr_expediente_fim time,
    cd_formulario int(11) not null,
    primary key (cd_horario),
    constraint fk_formulario_horario
		foreign key (cd_formulario)
		references ag_formularios_colaboradores(cd_formulario)
) default charset utf8mb4;

create table am_historico_colaboracao (
	cd_colaboracao int(11) not null,
    dt_utilizacao_inicio date,
    dt_utilizacao_fim date,
    cd_colaborador int(11) not null,
    primary key (cd_colaboracao),
    constraint fk_colaborador_colaboracao
		foreign key (cd_colaborador)
		references ad_colaboradores(cd_colaborador)
);

create table an_enderecos (
	cd_endereco int(11) not null,
    cd_cep int(8) not null unique,
    -- tipo é rua, avenida, alameda, rodovia, etc
    nm_tipo varchar(15) not null,
    nm_logradouro varchar(50) not null,
    qt_numero int(5),
    nm_complemento varchar(30),
    nm_bairro varchar(50),
    nm_cidade varchar(30) not null,
    sg_uf varchar(2) not null,
    nm_pais varchar(20) not null,
    qt_area decimal(8,2),
    cd_hendereco int(11) not null,
    primary key (cd_endereco)
);

create table anh_historico_enderecos (
	cd_hendereco int(11) not null,
    dt_entrada date,
    dt_saida date,
    cd_pessoa int(11) not null,
    cd_endereco int(11) not null,
    primary key (cd_hendereco),
    constraint fk_pessoa_hendereco
		foreign key (cd_pessoa)
		references aa_pessoas(cd_pessoa),
	constraint fk_endereco_hendereco
		foreign key (cd_endereco)
		references an_enderecos(cd_endereco)
);