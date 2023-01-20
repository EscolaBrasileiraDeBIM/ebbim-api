<?php
    function SelectTelefonesAA($idaa) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Telefone.php");
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $resGetTelefone = $DB->Consult(
                "SELECT * FROM ac_telefone WHERE cd_pessoa = '$idaa';"
            );
        } catch (Exception $e) {
            return false;
        }

        if($resGetTelefone){
            $telefones = array();
            for($i = 0; $i < sizeof($resGetTelefone); $i = $i + 7){
                $telefone = new Telefone($resGetTelefone[$i],$resGetTelefone[$i+1],$resGetTelefone[$i+2],$resGetTelefone[$i+3],$resGetTelefone[$i+4],$resGetTelefone[$i+5],$resGetTelefone[$i+6]);
                array_push($telefones, $telefone);
            }            
            return $telefones;
        } else {
            return false;
        }
    }