<?php
    include "../../Services/Pessoa/DeletarPessoa.php";
    file_get_contents('php://input');

    $response = DeletarPessoa(
        $_POST['id'] ?? null
    );

    http_response_code($response->status);
    if($response->status != 201) {
        echo json_encode($response->message);
    }