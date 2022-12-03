drop database db_ebbim;
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

create table ad_colaboradores(
	cd_colaborador varchar(10),
    ic_ativo boolean,
    ic_instrutor_ativo boolean,
    ic_instrutor_tipo boolean,
    cd_pessoa varchar(10),
    primary key (cd_colaborador),
    constraint fk_pessoas_colaboradores foreign key (cd_pessoa) references aa_pessoas(cd_pessoa)
);

create table cd_tipo_de_contrato(
	cd_tipo_de_contrato int(1) unique,
	ds_comercializacao varchar(20),
	ds_conteudo varchar(20),
	ds_descricao varchar(20),
	ds_desenvolvimento varchar(20),
	ds_instrucao varchar(20),
	ds_transmissao varchar(20)
);

create table ce_tipo_de_produto(
	sg_tipo_de_produto varchar(2),
	ds_descricao varchar(20),
    primary key (sg_tipo_de_produto)
);

create table ca_cursos(
	cd_curso varchar(10),
	cd_curso3dig varchar(3) unique,
    nm_oficial varchar(50),
    nm_status varchar(15),
	-- dc_interno é o código completo do curso, criado a partir de outros dados. Exemplos PT-CR-01-4DV-A-08, PT-CR-01-VWR-B-08, PT-CR-02-BLD-A-24, e etc
	dc_interno varchar(20),
	-- nm_interno é o apelido do curso
    nm_interno varchar(50),
    nm_link_site varchar(50),
    sg_idioma varchar(2),
    sg_tipo_de_produto varchar(2),
    cd_tipo_de_contrato int(1),
    sg_produto varchar(3),
    cd_versao varchar(1),
    vl_horas_aula int(2),
    -- cd_data é um cálculo no FM (c_tabelaPrecoAtiva) que pega o ID primário da tabela cb_data_reajuste
	cd_data varchar(10) unique,
    primary key (cd_curso),
    constraint fk_cursos_tipo_de_contrato foreign key (cd_tipo_de_contrato) references cd_tipo_de_contrato(cd_tipo_de_contrato),
    constraint fk_cursos_tipo_de_produto foreign key (sg_tipo_de_produto) references ce_tipo_de_produto(sg_tipo_de_produto)
);

create table cb_data_reajuste(
	cd_data varchar(10),
	dt_inicio date,
	dt_fim date,
	cd_curso3dig varchar(3),
    primary key (cd_data),
    constraint fk_cursos_data foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);

create table cc_preco_base(
	cd_preco varchar(10),
	dt_atual date,
	dt_inicio date,
	dt_fim date,
    -- nm_status é o c_ativo no FM
    nm_status varchar(15),
    -- cd_data é o #ID_CB no FM
    vl_preco_base decimal(7,2),
    vl_preco_indiv decimal(7,2),
    vl_preco_online decimal(7,2),
    vl_preco_promo decimal(7,2),
    vl_preco_sab decimal(7,2),
    vl_preco_sab_indiv decimal(7,2),
    vl_preco_sab_online decimal(7,2),
    vl_preco_sab_promo decimal(7,2),
	cd_data varchar(10) unique,
    primary key (cd_preco),
    constraint fk_cursos_preco foreign key (cd_data) references ca_cursos(cd_data)
);

create table cc_preco_base_hist(
	cd_preco_hist varchar(10),
	dt_inicio date,
	dt_fim date,
	cd_data varchar(10) unique,
    primary key (cd_preco_hist),
    constraint fk_cursos_hist foreign key (cd_data) references ca_cursos(cd_data)
);

create table cf_ficha_de_instrutor(
	cd_ficha varchar(10),
    ic_assistiu_turma boolean,
    ic_fez_prova boolean,
    ic_apto boolean,
    ic_tem_interesse boolean,
    nm_royalties varchar(30),
	cd_pessoa varchar(10) not null,
	cd_colaborador varchar(10),
    cd_curso3dig varchar(3),
    primary key (cd_ficha),
    constraint fk_pessoas_ficha_de_instrutor foreign key (cd_pessoa) references aa_pessoas(cd_pessoa),
    constraint fk_colaboradores_ficha_de_instrutor foreign key (cd_colaborador) references ad_colaboradores(cd_colaborador),
    constraint fk_cursos_ficha_de_instrutor foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);