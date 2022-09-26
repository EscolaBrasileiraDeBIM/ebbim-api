<?php
    function UpdateTelefone($id, $campo, $novoValor): bool {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $res_insert = $DB->ExecSQL(
                "
                    UPDATE AC_TELEFONE
                    SET $campo = '$novoValor'
                    WHERE CD_TELEFONE = '$id'
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