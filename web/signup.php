<?php
require_once('./class.php');
// require('./flags.php');
session_start();
$error_message = "";
$signup_message = "";
$signup_screen = true;
// $login = new LL;
// $is_login = $login -> IsLogin();

if(isset($_POST['signUp'])) {
    if (empty($_POST["username"])) {
        $errorMessage = 'ユーザーIDが未入力です。';
    } else if (empty($_POST["password"])) {
        $errorMessage = 'パスワードが未入力です。';
    } else if (empty($_POST["password2"])) {
        $errorMessage = 'パスワードが未入力です。';
    }
    if (!empty($_POST["username"]) && !empty($_POST["password"]) && !empty($_POST["password2"]) && $_POST["password"] === $_POST["password2"]) {
        $username = $_POST["username"];
        $password = $_POST["password"];
        $db = new DB;
        $sql = "INSERT INTO userData(name, password) VALUES (?, ?)";
        $stmt = $db -> prepare($sql);
        $stmt->execute(array($username, password_hash($password, PASSWORD_DEFAULT)));
        $userid = $db -> lastinsertid();
        $signUpMessage = '登録が完了しました。あなたの自治体名は '.$username. ' です。パスワードは '. $password. ' です。';
    } else if($_POST["password"] != $_POST["password2"]) {
        $errorMessage = 'パスワードに誤りがあります。';
    }
}
?>
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>新規登録</title>
        <link rel="stylesheet" href="./com/import.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body>
        <?php include('./header.php') ?>
        <main>
            <div class="mc">
                <p><?php echo htmlspecialchars($signUpMessage, ENT_QUOTES); ?></p>
                <p><?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></p>
                <div class="form">
                    <form id="loginForm" name="loginForm" action="" method="POST">
                        <div class="input-field">
                        <input type="text" id="username" name="username" placeholder="ユーザー名を入力" value="<?php if (!empty($_POST["username"])) {echo htmlspecialchars($_POST["username"], ENT_QUOTES);} ?>"> 
                        <label for="username">自治体名</label>
                        </div>
                        <div class="input-field">
                        <input type="password" id="password" name="password" value="" placeholder="パスワードを入力"> 
                        <label for="password">パスワード</label>
                        </div>
                        <div class="input-field">
                            <input type="password" id="password2" name="password2" value="" placeholder="再度パスワードを入力">
                            <label for="password2">パスワード(確認用)</label>
                        </div>
                        <div class="input-field">
                            <input type="submit" value="新規登録" class="btn waves-effect waves-light" id="signUp" name="signUp" value="新規登録">
                        </div>
                    </form>
                </div>
            </div>
        </main> 
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </body>
</html>