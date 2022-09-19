<?php
    class Telefone{
        public String $id;
        public String $tipo;
        public String $ddi;
        public String $ddd;
        public String $numero;
        public String $ramal;
        public String $id_aa;

        function __construct($id ,$tipo ,$ddi ,$ddd ,$numero ,$ramal ,$id_aa){
            $this->id = $id;
            $this->tipo = $tipo;
            $this->ddi = $ddi;
            $this->ddd = $ddd;
            $this->numero = $numero;
            $this->ramal = $ramal;
            $this->id_aa = $id_aa;
        }

        public function expose(): array
        {
            return get_object_vars($this);
        }
    }