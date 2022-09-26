<?php
    function SelectEmailsAA($idaa) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Email.php");
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");

        $DB = new DB();

        try {
            $resGetEmail = $DB->Consult(
                "SELECT * FROM ab_email WHERE cd_pessoa = '$idaa';"
            );
        } catch (Exception $e) {
            echo $e;
            return false;
        }

        if($resGetEmail){
            $emails = array();
            for($i = 0; $i < sizeof($resGetEmail); $i = $i + 4){
                $email = new Email($resGetEmail[$i],$resGetEmail[$i+1],$resGetEmail[$i+2],$resGetEmail[$i+3]);
                array_push($emails, $email);
            }            
            return $emails;
        } else {
            return false;
        }
    }