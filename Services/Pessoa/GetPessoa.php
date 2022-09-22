<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function GetPessoa($id): ResultService {
        $result = new ResultService();
        

        if($id == null){
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Pessoa/SelectPessoa.php");
        $code = SelectPessoa($id);
        
        if($code){
            $result->Ok(201, $code);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }