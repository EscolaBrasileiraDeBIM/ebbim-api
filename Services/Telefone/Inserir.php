<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function Inserir($tipo, $cdi, $ddd, $numero, $ramal, $idaa): ResultService {
        $result = new ResultService();      

        if($numero == null || $idaa == null){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Telefone/Inserir.php");

        $code = Insert($tipo, $cdi, $ddd, $numero, $ramal, $idaa);

        if($code){
            $result->Ok(201, $code);
        }
        else{
            echo json_encode("a");
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }