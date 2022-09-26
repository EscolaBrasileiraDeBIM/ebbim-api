<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function GetEmailsAA($idaa): ResultService {
        $result = new ResultService();
        

        if($idaa == null){
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }
        
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Email/SelectEmailsAA.php");
        $code = SelectEmailsAA($idaa);
        
        if($code){
            $result->Ok(201, $code);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }