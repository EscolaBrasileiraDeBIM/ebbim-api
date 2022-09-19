<?php
    include($_SERVER['DOCUMENT_ROOT']."/dream_team_api/Entities/Pessoa.php");
    include($_SERVER['DOCUMENT_ROOT']."/dream_team_api/Services/ResultService.php");

    function Inserir($nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento): ResultService {
        $result = new ResultService();
        

        if($nome == null || $apelido == null || $razaoSocial == null || $estrangeiro == null || $genero == null || $pf == null || $cpfCnpj == null || $ie == null || $im == null || $fornecedor == null || $empresa == null || $comentario == null || $rg == null || $dataNascimento){
            //Validação dos campos aqui, caso algum esteja errado o erro é 400.
            $result->Fail(400, "One or more fields are incorrect.");
            return $result;
        }

        include($_SERVER['DOCUMENT_ROOT']."/dream_team_api/Repositories/User/Insert.php");

        $user = new User($name, $email, $birthday, $leonita, $ametista, $password, $nickname, $point, $sponsorsLeague);
        $code = Insert($user);

        if($code){
            $result->Ok(201, $user->expose());
        }
        else{
            $result->Fail(500, "Internal Server Error. Please, try again later.");
        }

        return $result;
    }