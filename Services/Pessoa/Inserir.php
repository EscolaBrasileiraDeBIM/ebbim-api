<?php
    include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Services/ResultService.php");

    function Inserir($nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento): ResultService {
        $result = new ResultService();      

        if($nome == null || $genero == null || $pf == null){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Repositories/Pessoa/Inserir.php");

        $code = Insert($nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento);

        if($code){
            $result->Ok(201, $code);
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }