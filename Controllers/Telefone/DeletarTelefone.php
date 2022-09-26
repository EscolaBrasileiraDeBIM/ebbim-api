<?php
    include "../../Services/Telefone/DeletarTelefone.php";
    file_get_contents('php://input');

    $response = DeletarTelefone(
        $_POST['id'] ?? null
    );

    http_response_code($response->status);
    if($response->status != 201) {
        echo json_encode($response->message);
    }