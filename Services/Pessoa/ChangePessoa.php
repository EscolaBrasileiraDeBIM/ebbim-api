<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function ChangePessoa($id, $campo, $novoValor): ResultService {
        $result = new ResultService();

        if($id == null || $campo == null || $novoValor == null){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Pessoa/UpdatePessoa.php");

        $code = UpdatePessoa($id, $campo, $novoValor);

        if($code){
            $result->OkNoData(201);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }