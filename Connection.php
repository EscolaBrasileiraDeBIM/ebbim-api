<?php
    class DB{
        public function __construct() {
            $this->user = 'tilabc78_sistema';
            $this->password = 'Qf{Q%4+$Yg49';
            $this->database = 'tilabc78_sistema';
            $this->host = 'localhost:3306';

            $this->Connect();
        }

        // public function __construct() {
        //     $this->user = 'root';
        //     $this->password = '';
        //     $this->database = 'db_ebbim';
        //     $this->host = 'localhost:3306';

        //     $this->Connect();
        // }

        protected function Connect() {
            $this->mysqli = new mysqli($this->host, $this->user, $this->password, $this->database);

            if (mysqli_connect_errno()) {
                die('Não foi possível conectar-se ao banco de dados');
                exit();
            }
        }

        public function CloseConnection() {
            $this->mysqli->close();
        }

        public function ExecSQL($sql): bool {
            $this->Connect();
            $this->sql = $this->mysqli->query($sql);
            $this->CloseConnection();

            return $this->sql;
        }

        public function Consult($dados) {
            $this->Connect();
            $this->sql = $this->mysqli->query($dados);
            $this->result = array();
            while($row = $this->sql->fetch_assoc()){
                foreach($row as $Result=>$Column) {
                    array_push($this->result, $Column);
                }
            }
            $this->CloseConnection();
            return $this->result;
        }
    }