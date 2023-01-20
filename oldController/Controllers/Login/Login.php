<?php
    include "../../Services/Login/Login.php";
    file_get_contents('php://input');

    $response = Login(
        $_POST['login'] ?? null,
        $_POST['senha'] ?? null
    );

    http_response_code($response->status);
    if($response->status == 201){
        echo json_encode($response->data);
    }
    else{
        echo json_encode($response->message);
    }