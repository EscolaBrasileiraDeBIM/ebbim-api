<?php
    class Pessoas{
        public String $id;
        public String $nome;
        public String $apelido;
        public String $razaoSocial;
        public bool $estrangeiro;
        public String $genero;
        public bool $pf;
        public String $cpfCnpj;
        public String $ie;
        public String $im;
        public String $fornecedor;
        public String $empresa;
        public String $comentario;
        public String $rg;
        public String $dataNascimento;

        function __construct($id, $nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento){
            $this->id = $id;
            $this->nome = $nome;
            $this->apelido = $apelido;
            $this->razaoSocial = $razaoSocial;
            $this->estrangeiro = $estrangeiro;
            $this->genero = $genero;
            $this->pf = $pf;
            $this->cpfCnpj = $cpfCnpj;
            $this->ie = $ie;
            $this->im = $im;
            $this->fornecedor = $fornecedor;
            $this->empresa = $empresa;
            $this->comentario = $comentario;
            $this->rg = $rg;
            $this->dataNascimento = $dataNascimento;
        }

        public function expose(): array
        {
            return get_object_vars($this);
        }
    }