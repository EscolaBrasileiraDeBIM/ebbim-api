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

create table da_apostilas(
	cd_apostila varchar(10),
	nm_titulo varchar(50),
    -- verificar melhor forma para armazenar as imagens
    im_capa mediumblob,
    im_miolo mediumblob,
    primary key (cd_apostila)
);

create table da_certificado_digital(
	cd_certificado_digital varchar(10),
    -- verificar melhor forma para armazenar as imagens
    im_miolo mediumblob,
    qt_certif_num_assinaturas int(3),
    primary key (cd_certificado_digital)
);

create table da_certificado_papel(
	cd_certificado_papel varchar(10),
    -- verificar melhor forma para armazenar as imagens
    im_miolo mediumblob,
    qt_certif_num_assinaturas int(3),
    primary key (cd_certificado_papel)
);

create table da_fichas(
	cd_fichas varchar(10),
    primary key (cd_fichas)
);

create table da_caderno_de_exercicios(
	cd_caderno_de_exercicios varchar(10),
    -- verificar melhor forma para armazenar as imagens
    im_miolo mediumblob,
    primary key (cd_caderno_de_exercicios)
);

create table da_mousepad(
	cd_mousepad varchar(10),
    -- verificar melhor forma para armazenar as imagens
    im_miolo mediumblob,
    primary key (cd_mousepad)
);

create table dg_cadastro_de_kits(
	cd_cadastro_de_kits varchar(10),
	cd_fichas varchar(10),
    cd_caderno_de_exercicios varchar(10),
    cd_mousepad varchar(10),
    primary key (cd_cadastro_de_kits),
    constraint fk_kits_fichas foreign key (cd_fichas) references da_fichas(cd_fichas),
    constraint fk_kits_cad_exercicios foreign key (cd_caderno_de_exercicios) references da_caderno_de_exercicios(cd_caderno_de_exercicios),
    constraint fk_kits_mousepad foreign key (cd_mousepad) references da_mousepad(cd_mousepad)
);

create table ca_cursos(
	cd_curso varchar(10),
	cd_curso3dig varchar(3) unique,
    nm_oficial varchar(50),
    ic_status varchar(15),
	-- dc_interno é o código completo do curso, criado a partir de outros dados. Exemplos PT-CR-01-4DV-A-08, PT-CR-01-VWR-B-08, PT-CR-02-BLD-A-24, e etc
	dc_interno varchar(20),
	-- nm_interno é o apelido do curso
    nm_interno varchar(50),
    nm_link_site varchar(50),
    cd_site varchar(10),
	sg_idioma varchar(2),
    sg_tipo_de_produto varchar(2),
    cd_tipo_de_contrato int(1),
    sg_produto varchar(3),
    cd_versao varchar(1),
    qt_horas_aula int(3),
    -- qt_horas_atendimento define a quantidade de horas de plantão ou disponível para tirar dúvidas
    qt_horas_atendimento int(2),
    qt_duracao_aula_semana int(2),
    qt_duracao_aula_fds int(2),
    qt_aula_semana int(2),
    qt_aula_fds int(2),
    nm_pasta_exercicios varchar(20),
    ds_descricao text,
    ds_dados_tecnicos text,
    -- ds_ext_material_didatico é um complemento manual ao ds_dados_tecnicos que, por sua vez, é um cálculo
    ds_ext_material_didatico text,
    ic_período_dia varchar(5),
    qt_vezes_semana int(1),
    ds_disponibilidade text,
    ds_disponibilidade_manual text,
    ds_conteudo text,
    ds_publico_alvo text,
    ds_pre_requisitos text,
    ds_cronograma text,
    ic_hashtag text,
    qt_minima_alunos int(1),
    qt_maxima_alunos int(2),
    dt_primeira_turma date,
    qt_turmas int(3),
    nm_responsavel varchar(20),
    ic_gera_royalties varchar(3),
    -- referente ao pagamento de royalties ao parceiro do curso
    nm_parceria_nome varchar(50),
    cd_tabela_preco_ativa varchar(20),
    nm_curso_certificado varchar(50),
    -- cd_data é um cálculo no FM (c_tabelaPrecoAtiva) que pega o ID primário da tabela cb_data_reajuste
	cd_data varchar(10) unique,
    cd_apostila varchar(10),
    cd_certificado_digital varchar(10),
    cd_certificado_papel varchar(10),
    cd_cadastro_de_kits varchar(10),
    -- cd_curso_preco é o código de 3 dig do curso acrescido da versão, separados por um hífen
    cd_curso_preco varchar(5) unique,
    primary key (cd_curso),
    constraint fk_cursos_tipo_de_contrato foreign key (cd_tipo_de_contrato) references cd_tipo_de_contrato(cd_tipo_de_contrato),
    constraint fk_cursos_apostilas foreign key (cd_apostila) references da_apostilas(cd_apostila),
    constraint fk_cursos_certif_digital foreign key (cd_certificado_digital) references da_certificado_digital(cd_certificado_digital),
    constraint fk_cursos_certif_papel foreign key (cd_certificado_papel) references da_certificado_papel(cd_certificado_papel),
    constraint fk_cursos_kits foreign key (cd_cadastro_de_kits) references dg_cadastro_de_kits(cd_cadastro_de_kits),
    constraint fk_cursos_tipo_de_produto foreign key (sg_tipo_de_produto) references ce_tipo_de_produto(sg_tipo_de_produto)
);

create table ca_iua_softwares(
	cd_ca_software varchar(10),
    nm_link_download_teste varchar(50),
    ic_principal boolean,
    nm_software varchar(50),
    nm_idioma varchar(20),
    cd_software varchar(10),
	cd_curso3dig varchar(3),
    primary key (cd_ca_software),
    constraint fk_cursos_ca_software foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);

create table cb_data_reajuste(
	cd_data varchar(10),
	dt_inicio date,
	dt_fim date,
	cd_curso3dig varchar(3),
    primary key (cd_data)
);

create table cc_preco_base(
	cd_preco varchar(10),
	dt_atual date,
	dt_inicio date,
	dt_fim date,
    -- nm_status é o c_ativo no FM
    nm_status varchar(15),
    vl_preco_base decimal(7,2),
    vl_preco_indiv decimal(7,2),
    vl_preco_online decimal(7,2),
    vl_preco_promo decimal(7,2),
    vl_preco_sab decimal(7,2),
    vl_preco_sab_indiv decimal(7,2),
    vl_preco_sab_online decimal(7,2),
    vl_preco_sab_promo decimal(7,2),
    -- cd_data é o #ID_CB no FM
	cd_data varchar(10) unique,
    -- cd_curso_preco é o código de 3 dig do curso acrescido da versão, separados por um hífen
    cd_curso_preco varchar(5),
    primary key (cd_preco),
    constraint fk_cursos_preco foreign key (cd_data) references ca_cursos(cd_data),
    constraint fk_cursos_preco_cod foreign key (cd_curso_preco) references ca_cursos(cd_curso_preco),
    constraint fk_data_preco foreign key (cd_data) references cb_data_reajuste(cd_data)
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
	cd_colaborador varchar(10),
    cd_curso3dig varchar(3),
    primary key (cd_ficha),
    constraint fk_colaboradores_ficha_de_instrutor foreign key (cd_colaborador) references ad_colaboradores(cd_colaborador),
    constraint fk_cursos_ficha_de_instrutor foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);

create table cg_eventos(
	cd_evento varchar(10),
    
    cd_evento4dig varchar(3) unique,
    nm_oficial varchar(50),
    nm_interno varchar(50),
    sg_tipo varchar(20),
    ic_status varchar(15),
    cd_site varchar(10),
    
    -- verificar melhor forma para armazenar as imagens
    im_imagem mediumblob,
    dt_evento date,
    hr_inicio datetime,
    hr_termino datetime,
    hr_duracao time,
    nm_promotor varchar(50),
    ic_exibicao varchar(20),
    nm_local varchar(50),
    dc_endereco varchar(100),
    nm_link_inscricao varchar(50),
    nm_link_reuniao varchar(50),
    ic_gratuito varchar(3),
    vl_evento decimal(7,2),
    ds_evento text,
    ds_conteudo text,
    ds_dados_tecnicos text,
    
    ic_facebook varchar(3),
    nm_fc_link varchar(50),
    qt_fc_interessados int(4),
    qt_fc_compareceram int(4),
    qt_fc_convidados int(4),
    
    nm_link_thumb varchar(100),
    -- verificar melhor forma para armazenar as imagens
    im_thumb mediumblob,
    ic_thumb_correta varchar(3),
    ic_cupom_desconto varchar(3),
    pc_cupom_desconto dec(3,2),
    cd_cupom_desconto varchar(20),
    dt_validade_cupom datetime,
    ic_sorteio varchar(3),
    nm_produto_sorteado varchar(50),
    ic_material_apoio varchar(3),
    nm_link_material_apoio varchar(50),
    nm_link_video_nao_editado varchar(50),
    nm_link_video_editado varchar(50),
    
    primary key (cd_evento)
);

create table ci_tabela_royalties(
	cd_royalties varchar(10),
	dt_inicio date,
	dt_termino date,
    cd_pessoa varchar(10),
    ds_obs tinytext,
    pc_turma decimal(3,2),
    vl_aluno decimal(7,2),
    vl_turma decimal(7,2),
    cd_carrinho_aberto varchar(10),
    cd_curso3dig varchar(3),
    primary key (cd_royalties),
    constraint fk_cursos_royalties foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);

create table cm_pontuacao_hist(
	cd_pontuacao varchar(10),
	dt_inicio date,
	dt_fim date,
    qt_pontuacao int(3),
    cd_curso3dig varchar(3),
    primary key (cd_pontuacao),
    constraint fk_cursos_pontuacao foreign key (cd_curso3dig) references ca_cursos(cd_curso3dig)
);

create table gd_inscritos_em_eventos(
	cd_inscrito varchar(10),
    
    nm_funcao varchar(20),
    nm_exibicao varchar(10),
    ic_confirmacao varchar(3),
    ic_envio_link varchar(3),
    ic_email_pre_evento varchar(3),
    
    cd_pessoa varchar(10) not null,
    cd_evento varchar(10),
    primary key (cd_inscrito),
    constraint fk_inscrito_evento foreign key (cd_evento) references cg_eventos(cd_evento),
    constraint fk_inscrito_pessoa foreign key (cd_pessoa) references aa_pessoas(cd_pessoa)
);