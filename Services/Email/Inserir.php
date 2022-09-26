<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function Inserir($email, $principal, $idaa): ResultService {
        $result = new ResultService();      

        if($email == null || $principal == null || $idaa == null){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Email/Inserir.php");

        $code = Insert($email, $principal, $idaa);

        if($code){
            $result->Ok(201, $code);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }