<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function DeletarEmail($id): ResultService {
        $result = new ResultService();

        if($id == null){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Email/DeleteEmail.php");

        $code = DeleteEmail($id);

        if($code){
            $result->OkNoData(201);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }