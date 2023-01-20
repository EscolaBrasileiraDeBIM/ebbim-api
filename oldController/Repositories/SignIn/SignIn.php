<?php
    function SignIn($login, $senha) {
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Connection.php");        
        include($_SERVER['DOCUMENT_ROOT']."/ebbim-api/Entities/Usuario.php");

        $DB = new DB();

        try {
            $res_getUser = $DB->Consult(
                "SELECT * FROM tb_usuario where cd_login = '$login' and nm_senha = '$senha';",
                MYSQLI_USE_RESULT
            );
        } catch (Exception $e) {
            return false;
        }
        if($res_getUser){
            $user = new Usuario($res_getUser[0], $res_getUser[1], $res_getUser[2]);
            return $user->expose();
        } else {
            return false;
        }
    }