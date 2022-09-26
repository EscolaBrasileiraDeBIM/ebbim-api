<?php
    function Insert($tipo, $ddi, $ddd, $numero, $ramal, $idaa) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");        
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Telefone.php");

        $DB = new DB();

        try {
            $res_getId = $DB->Consult(
                "SELECT max(cd_telefone) FROM ac_telefone;",
                MYSQLI_USE_RESULT
            );
            $id = $res_getId[0] == null ? "AC00001" : $res_getId[0];
            $newNum = substr($id,2,strlen($id)) + 1;  
            $newId = "AC".str_pad($newNum , 5 ,'0', STR_PAD_LEFT);
            $res_insert = $DB->ExecSQL(
                "INSERT INTO ac_telefone VALUES (
                    '$newId',
                    '$tipo',
                    '$ddi',
                    '$ddd',
                    '$numero',
                    '$ramal',
                    '$idaa');",
                MYSQLI_USE_RESULT
            );
        } catch (Exception $e) {
            echo $e;
            return false;
        }
        if($res_insert){
            $telefone = new Telefone($newId ,$tipo ,$ddi ,$ddd ,$numero ,$ramal ,$idaa);
            return $telefone->expose();
        } else {
            echo "a";
            return false;
        }
    }