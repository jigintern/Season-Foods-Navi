<?php
require('./flags.php');
session_start();
if (isset($_SESSION["NAME"])) {
    $errorMessage = "ログアウトしました。";
} else {
    $errorMessage = "セッションがタイムアウトしました。";
}
$login = new LL;
$login -> logout();
$is_login = $login -> IsLogin();
$_SESSION = array();
@session_destroy();
?>

<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ログアウト</title>
        <link rel="stylesheet" href="./com/import.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body>
        <?php include('./header.php') ?>
        <main>
            <div class="mc">
                <p><?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></p>
                <a href="login.php" class="btn waves-effect waves-light">ログイン画面に戻る</a>
            </div>
        </main>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>