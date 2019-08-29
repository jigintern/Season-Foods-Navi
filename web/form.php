<?php
require_once('./class.php');
function h($str) {
    return htmlspecialchars($str, ENT_QUOTES, 'UTF-8');
}
function br() {
    echo '<br/>';
}
// 食材
if(isset($_POST['submit_1'])) {
    $db = new DB;
    $name = (string)filter_input(INPUT_POST, 'name');
    $image_path = (string)filter_input(INPUT_POST, 'image_path');
    $prefecture = (string)filter_input(INPUT_POST, 'prefecture');
    $base_food = (string)filter_input(INPUT_POST, 'base_food');
    $months = $_POST['month'];
    $post = 1;
    $months_string = "[";
    $i = 0;
    foreach($months as $row) {
        if($i != 0) {
            $months_string.=",";
        }
        $months_string.=$row;
        $i+=1;
    }
    $months_string .= "]";
    // 画像関連処理
    $tmp_file_name = $_FILES['image']['tmp_name'];
    $image_path = '../images/';
    $file_name = date('YmdHis')."-".uniqid();
    $file_name .= '.jpg';
    move_uploaded_file($tmp_file_name, "{$image_path}{$file_name}");
    picutre_resize($image_path.$file_name);
    $sql = 'INSERT INTO foods (name, base_food, picture, months, pref_id, post) VALUES (:name, :base_food, :picture, :months_string, :pref_id, :post)';
    $result = $db->prepare($sql);
    $result -> bindParam(':name',$name,PDO::PARAM_STR);
    $result -> bindParam(':base_food',$base_food,PDO::PARAM_INT);
    $result -> bindParam(':picture',$file_name,PDO::PARAM_STR);
    $result -> bindParam(':months_string',$months_string,PDO::PARAM_STR);
    $result -> bindParam(':pref_id',$prefecture,PDO::PARAM_INT);
    $result -> bindParam(':post',$post,PDO::PARAM_INT);
    $result -> execute();
    echo '<h3>食材の投稿が完了しました</h3>';
}
// 献立
if(isset($_POST['submit_2'])) {
    $name = (string)filter_input(INPUT_POST, 'name');
    $image = (string)filter_input(INPUT_POST, 'image');
    $image_path = (string)filter_input(INPUT_POST, 'image_path');
    $prefecture = (string)filter_input(INPUT_POST, 'prefecture');
    $howto = (string)filter_input(INPUT_POST, 'howto');
    $post = 1;
    $foods_post = $_POST['foods'];
    $foods_string = "[";
    $i = 0;
    foreach($foods_post as $row) {
        if($i != 0) {
            $foods_string.=",";
        }
        $foods_string.=$row;
        $i+=1;
    }
    $foods_string .= "]";
    // 画像関連処理
    $tmp_file_name = $_FILES['image']['tmp_name'];
    $image_path = '../images/';
    $file_name = date('YmdHis')."-".uniqid();
    $file_name .= '.jpg';
    move_uploaded_file($tmp_file_name, "{$image_path}{$file_name}");
    picutre_resize($image_path.$file_name);
    $db = new DB;
    $sql = 'INSERT INTO recipes (name, picture, foods, pref_id, howto, post) VALUES (:name, :image_path, :foods, :prefecture, :howto, :post)';
    $result = $db->prepare($sql);
    $result -> bindParam(':name',$name,PDO::PARAM_STR);
    $result -> bindParam(':image_path',$file_name,PDO::PARAM_STR);
    $result -> bindParam(':prefecture',$prefecture,PDO::PARAM_INT);
    $result -> bindParam(':foods', $foods_string, PDO::PARAM_STR);
    $result -> bindParam(':howto', $howto, PDO::PARAM_STR);
    $result -> bindParam(':post', $post, PDO::PARAM_INT);
    $result -> execute();
    echo '<h3>献立の投稿が完了しました</h3>';
}
function picutre_resize($base_picture) {
    list($width, $hight) = getimagesize($base_picture); // 元の画像名を指定してサイズを取得
    $baseImage = imagecreatefromjpeg($base_picture); // 元の画像から新しい画像を作る準備
    $image = imagecreatetruecolor(150, 150); // サイズを指定して新しい画像のキャンバスを作成
    // 画像のコピーと伸縮
    imagecopyresampled($image, $baseImage, 0, 0, 0, 0, 150, 150, $width, $hight);
    // コピーした画像を出力する
    $pattern = array('/.jpg/', '/.png/', '/.jpeg/');
    $base_picture = preg_replace($pattern, '', $base_picture);
    imagejpeg($image, $base_picture.'-thumbnail'.'.jpg');
}
/**
 * TODO: formへの送信をajaxにして画面遷移させないようにする
 */