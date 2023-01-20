<?php
    function Insert($nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");        
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Pessoa.php");

        $DB = new DB();

        try {
            $res_getId = $DB->Consult(
                "SELECT max(cd_pessoa) FROM aa_pessoas;",
                MYSQLI_USE_RESULT
            );
            $id = $res_getId[0] == null ? "AA00001" : $res_getId[0];
            $newNum = substr($id,2,strlen($id)) + 1;  
            $newId = "AA".str_pad($newNum , 5 ,'0', STR_PAD_LEFT);
            $res_insert = $DB->ExecSQL(
                "INSERT INTO aa_pessoas VALUES (
                    '$newId',
                    '$nome',
                    '$apelido',
                    '$razaoSocial',
                    '$estrangeiro',
                    '$genero',
                    $pf,
                    '$cpfCnpj',
                    $ie,
                    $im,
                    '$fornecedor',
                    '$empresa',
                    '$comentario',
                    $rg,
                    '$dataNascimento');",
                MYSQLI_USE_RESULT
            );
        } catch (Exception $e) {
            return false;
        }
        if($res_insert){
            $pessoa = new Pessoa($newId, $nome, $apelido, $razaoSocial, $estrangeiro, $genero, $pf, $cpfCnpj, $ie, $im, $fornecedor, $empresa, $comentario, $rg, $dataNascimento);
            return $pessoa->expose();
        } else {
            return false;
        }
    }