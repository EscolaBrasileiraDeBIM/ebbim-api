<?php
    class Usuario{
        public String $id;
        public String $nome;
        public String $senha;

        function __construct($id, $nome, $senha){
            $this->id = $id;
            $this->nome = $nome;
            $this->apelido = $senha;
        }

        public function expose(): array
        {
            return get_object_vars($this);
        }
    }