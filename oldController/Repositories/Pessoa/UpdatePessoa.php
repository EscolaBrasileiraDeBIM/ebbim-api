<?php
    function UpdatePessoa($id, $campo, $novoValor): bool {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $res_insert = $DB->ExecSQL(
                "
                    UPDATE aa_pessoas
                    SET $campo = '$novoValor'
                    WHERE cd_pessoa = '$id'
                ;",
                MYSQLI_USE_RESULT
            );
        } catch (Exception $e) {
            return false;
        }
        if($res_insert){
            return true;
        } else {
            return false;
        }
    }