<?php
    class Email{
        public String $id;
        public String $email;
        public bool $principal;
        public String $id_aa;

        function __construct($id, $email, $principal, $id_aa){
            $this->id = $id;
            $this->email = $email;
            $this->principal = $principal;
            $this->id_aa = $id_aa;
        }

        public function expose(): array
        {
            return get_object_vars($this);
        }
    }