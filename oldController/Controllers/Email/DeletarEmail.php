<?php
    include "../../Services/Email/DeletarEmail.php";
    file_get_contents('php://input');

    $response = DeletarEmail(
        $_POST['id'] ?? null
    );

    http_response_code($response->status);
    if($response->status != 201) {
        echo json_encode($response->message);
    }