<?php
    include "../../Services/Pessoa/Inserir.php";
    file_get_contents('php://input');

    $response = Inserir(
        $_POST['nome'] == null ? null : $_POST['nome'],
        $_POST['apelido'] == null ? "null" : $_POST['apelido'],        
        $_POST['razaoSocial'] == null ? "null" : $_POST['razaoSocial'],
        $_POST['estrangeiro'] == null ? "null" : $_POST['estrangeiro'],
        $_POST['genero'] == null ? "null" : $_POST['genero'],
        $_POST['pf'] == null ? null : $_POST['pf'],
        $_POST['cpfCnpj'] == null ? "null" : $_POST['cpfCnpj'],
        $_POST['ie'] == null ? "0" : $_POST['ie'],
        $_POST['im'] == null ? "0" : $_POST['im'],
        $_POST['fornecedor'] == null ? "null" : $_POST['fornecedor'],
        $_POST['empresa'] == null ? "null" : $_POST['empresa'],
        $_POST['comentario'] == null ? "null" : $_POST['comentario'],
        $_POST['rg'] == null ? "0" : $_POST['rg'],
        $_POST['dataNascimento'] == null ? "null" : $_POST['dataNascimento']
    );

    http_response_code($response->status);
    if($response->status == 201){
        echo json_encode($response->data);
    }
    else{
        echo json_encode($response->message);
    }