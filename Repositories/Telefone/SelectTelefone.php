<?php
    function SelectTelefone($id) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Telefone.php");
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $resGetTelefone = $DB->Consult(
                "SELECT * FROM ac_telefone WHERE cd_telefone = '$id';"
            );
        } catch (Exception $e) {
            return false;
        }

        if($resGetTelefone){
            $telefone = new Telefone($resGetTelefone[0],$resGetTelefone[1],$resGetTelefone[2],$resGetTelefone[3],$resGetTelefone[4],$resGetTelefone[5],$resGetTelefone[6]);
            return $telefone->expose();
        } else {
            return false;
        }
    }