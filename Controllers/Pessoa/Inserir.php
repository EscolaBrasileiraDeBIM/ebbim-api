<?php
    include "../../Services/Pessoa/Insert.php";
    file_get_contents('php://input');

    $response = Inserir(
        $_POST['nome'] ?? null,
        $_POST['apelido'] ?? null,        
        $_POST['razaoSocial'] ?? null,
        $_POST['estrangeiro'] ?? null,
        $_POST['genero'] ?? null,
        $_POST['pf'] ?? null,
        $_POST['cpfCnpj'] ?? null,
        $_POST['ie'] ?? null,
        $_POST['im'] ?? null,
        $_POST['fornecedor'] ?? null,
        $_POST['empresa'] ?? null,
        $_POST['comentario'] ?? null,
        $_POST['rg'] ?? null,
        $_POST['dataNascimento'] ?? null
    );

    http_response_code($response->status);
    if($response->status == 201){
        echo json_encode($response->data);
    }
    else{
        echo json_encode($response->message);
    }