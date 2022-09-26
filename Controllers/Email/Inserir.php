<?php
    include "../../Services/Email/Inserir.php";
    file_get_contents('php://input');

    $response = Inserir(
        $_POST['email'] ?? null,
        $_POST['principal'] ?? null,
        $_POST['idaa'] ?? null
    );

    http_response_code($response->status);
    if($response->status == 201){
        echo json_encode($response->data);
    }
    else{
        echo json_encode($response->message);
    }