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
    $image = (string)filter_input(INPUT_POST, 'image');
    $image_path = (string)filter_input(INPUT_POST, 'image_path');
    $prefecture = (string)filter_input(INPUT_POST, 'prefecture');
    // 画像関連処理
    $tmp_file_name = $_FILES['image']['tmp_name'];
    $image_path = '../images/';
    $file_name = date('YmdHis')."-".uniqid().".jpg";
    move_uploaded_file($tmp_file_name, "{$image_path}{$file_name}");

    $sql = 'INSERT INTO local_foods (name, picture, pref_id) VALUES (:name, :image_path, :prefecture)';
    $result = $db->prepare($sql);
    $result -> bindParam(':name',$name,PDO::PARAM_STR);
    $result -> bindParam(':image_path',$file_name,PDO::PARAM_STR);
    $result -> bindParam(':prefecture',$prefecture,PDO::PARAM_INT);
    $result -> execute();
}
// 献立
if(isset($_POST['submit_2'])) {
    $name = (string)filter_input(INPUT_POST, 'name');
    $image = (string)filter_input(INPUT_POST, 'image');
    $image_path = (string)filter_input(INPUT_POST, 'image_path');
    $prefecture = (string)filter_input(INPUT_POST, 'prefecture');
    // 画像関連処理
    $tmp_file_name = $_FILES['image']['tmp_name'];
    $image_path = '../images/';
    $file_name = date('YmdHis')."-".uniqid().".jpg";
    move_uploaded_file($tmp_file_name, "{$image_path}{$file_name}");
    // とりあえずfoodリスト
    $food = "['なす', 'とまと', 'わらび餅']";
    $db = new DB;
    $sql = 'INSERT INTO recipes (name, picture, foods, pref_id) VALUES (:name, :image_path, :foods, :prefecture)';
    $result = $db->prepare($sql);
    $result -> bindParam(':name',$name,PDO::PARAM_STR);
    $result -> bindParam(':image_path',$file_name,PDO::PARAM_STR);
    $result -> bindParam(':prefecture',$prefecture,PDO::PARAM_INT);
    $result -> bindParam(':foods', $food, PDO::PARAM_STR);
    $result -> execute();
}

/**
 * TODO: 食材名で検索できるようにする ajax * php
 * TODO: insertの食材名の配列をidに変更する
 * TODO: 画像のリサイズ
 */