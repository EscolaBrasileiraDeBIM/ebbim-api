<?php
    include "../../Services/Telefone/ChangeTelefone.php";
    file_get_contents('php://input');

    $response = ChangeTelefone(
        $_POST['id'] ?? null,
        $_POST['campo'] ?? null,
        $_POST['novoValor'] ?? null
    );

    http_response_code($response->status);
    if($response->status != 201) {
        echo json_encode($response->message);
    }