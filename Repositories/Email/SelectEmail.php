<?php
    function SelectEmail($id) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Email.php");
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $resGetEmail = $DB->Consult(
                "SELECT * FROM ab_email WHERE cd_email = '$id';"
            );
        } catch (Exception $e) {
            return false;
        }

        if($resGetEmail){
            $email = new Email($resGetEmail[0],$resGetEmail[1],$resGetEmail[2],$resGetEmail[3]);
            return $email->expose();
        } else {
            return false;
        }
    }