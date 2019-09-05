<?php
require_once('./class.php');
// require('./flags.php');
session_start();
// $login = new LL;
// $is_login = $login -> IsLogin();
// var_dump($is_login);
$login_screen = true;
$db = new DB;
$error_message = '';
if(isset($_POST['login'])) {
    if(empty($_POST['username'])) {
        $error_message = 'ユーザーIDが未入力です';
    } else if(empty($_POST['password'])){
        $error_message = 'パスワードが未入力です';
    }
    if(!empty($_POST['login']) && !empty($_POST['username'])) {
        // $user_id = $_POST['userid'];
        $user_name = $_POST['username'];
        $sql = "SELECT * FROM userData WHERE name = ?";
        $stmt = $db -> prepare($sql);
        $stmt->execute(array($user_name));
        $password = $_POST['password'];
        if($row = $stmt -> fetch(PDO::FETCH_ASSOC)) {
            if(password_verify($password, $row['password'])) {
                session_regenerate_id(true);
                $id = $row['id'];
                $sql = "SELECT * FROM userData WHERE id = $id";
                $stmt = $db -> query($sql);
                foreach($stmt as $row) {
                    $row['name'];
                }
                // $login -> login();
                $_SESSION['NAME'] = $row['name'];
                header('Location: index.php');
                exit();
            } else {
                $errorMessage = 'ユーザーIDあるいはパスワードに誤りがあります。';
            }
        } else {
            $errorMessage = 'ユーザーIDあるいはパスワードに誤りがあります。';
        }
    }
}
/**
 * TODO: errorのときはいい感じのモーダルが横から出てくるようにする
 * TODO: ログインされているかどうかでnavの表示を変更する
 * TODO: 管理画面で上に戻りやすくする
 * TODO: scssでいい感じにする
 */
?>
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ログイン</title>
        <link rel="stylesheet" href="./com/import.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body>
        <?php include('./header.php') ?>
        <main>
            <div class="mc">
                <div class="form" style="margin-top: 2em;">
                    <form id="loginForm" name="loginForm" action="" method="POST">
                        <div><?php echo htmlspecialchars($errorMessage, ENT_QUOTES); ?></div>
                        <div class="input-field">
                            <input placeholder="ユーザーID" id="username" type="text" name="username">
                            <label for="username">自治体名</label>
                        </div>
                        <div class="input-field">
                            <input placeholder="パスワードを入力" id="password" type="password" class="validate" name="password">
                            <label for="password">パスワード</label>
                        </div>
                        <input type="submit" name="login" class="btn waves-effect waves-light" value="ログイン">
                    </form>

                    <form action="signup.php">
                        <div class="input-field">
                            <input type="submit" value="新規登録" class="btn waves-effect waves-light">
                        </div>
                    </form>
                </div>
            </div>
        </main>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>