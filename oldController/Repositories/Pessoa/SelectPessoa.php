<?php
    function SelectPessoa($id) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Pessoa.php");
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $resGetPessoa = $DB->Consult(
                "SELECT * FROM aa_pessoas WHERE cd_pessoa = '$id';"
            );
        } catch (Exception $e) {
            return false;
        }

        if($resGetPessoa){
            $pessoa = new Pessoa(
                $resGetPessoa[0] == null ? "null" : $resGetPessoa[0],
                $resGetPessoa[1] == null ? "null" : $resGetPessoa[1],
                $resGetPessoa[2] == null ? "null" : $resGetPessoa[2],
                $resGetPessoa[3] == null ? "null" : $resGetPessoa[3],
                $resGetPessoa[4] == null ? "null" : $resGetPessoa[4],
                $resGetPessoa[5] == null ? "null" : $resGetPessoa[5],
                $resGetPessoa[6] == null ? "null" : $resGetPessoa[6],
                $resGetPessoa[7] == null ? "null" : $resGetPessoa[7],
                $resGetPessoa[8] == null ? "null" : $resGetPessoa[8],
                $resGetPessoa[9] == null ? "null" : $resGetPessoa[9],
                $resGetPessoa[10] == null ? "null" : $resGetPessoa[10],
                $resGetPessoa[11] == null ? "null" : $resGetPessoa[11],
                $resGetPessoa[12] == null ? "null" : $resGetPessoa[12],
                $resGetPessoa[13] == null ? "null" : $resGetPessoa[13],
                $resGetPessoa[14] == null ? "null" : $resGetPessoa[14]
            );
            return $pessoa->expose();
        } else {
            return false;
        }
    }