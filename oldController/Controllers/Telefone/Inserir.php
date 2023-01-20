<?php
    include "../../Services/Telefone/Inserir.php";
    file_get_contents('php://input');

    $response = Inserir(
        $_POST['tipo'] == null ? "null" : $_POST['tipo'],
        $_POST['ddi'] == null ? "null" : $_POST['ddi'],        
        $_POST['ddd'] == null ? "null" : $_POST['ddd'],
        $_POST['numero'] == null ? null : $_POST['numero'],
        $_POST['ramal'] == null ? "null" : $_POST['ramal'],
        $_POST['idaa'] == null ? null : $_POST['idaa']
    );

    http_response_code($response->status);
    if($response->status == 201){
        echo json_encode($response->data);
    }
    else{
        echo json_encode($response->message);
    }