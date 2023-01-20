<?php
    function Insert($email, $principal, $idaa) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");        
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Email.php");

        $DB = new DB();

        try {
            $res_getId = $DB->Consult(
                "SELECT max(cd_email) FROM ab_email;",
                MYSQLI_USE_RESULT
            );
            $id = $res_getId[0] == null ? "AB00001" : $res_getId[0];
            $newNum = substr($id,2,strlen($id)) + 1;  
            $newId = "AB".str_pad($newNum , 5 ,'0', STR_PAD_LEFT);
            $res_insert = $DB->ExecSQL(
                "INSERT INTO ab_email VALUES (
                    '$newId',
                    '$email',
                    $principal,
                    '$idaa');",
                MYSQLI_USE_RESULT
            );
        } catch (Exception $e) {
            return false;
        }
        if($res_insert){
            $email = new Email($newId, $email, $principal, $idaa);
            return $email->expose();
        } else {
            return false;
        }
    }