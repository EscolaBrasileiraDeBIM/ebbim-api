<?php
    function DeleteEmail($id): bool {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $res_insert = $DB->ExecSQL(
                "
                    DELETE FROM
                        AB_EMAIL
                    WHERE cd_email = '$id'
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