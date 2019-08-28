<?php
require_once('./class.php');
$db = new DB;
$sql = 'SELECT * FROM prefecture';
$prefecture_list = $db->query($sql);
$prefecture_list_json = array();
foreach($prefecture_list as $row) {
    $tmp_list = array(
        "id" => $row['id'],
        "name" => $row['name'],
    );
    array_push($prefecture_list_json, $tmp_list);
}
header("Content-Type: application/json; charset=utf-8");
echo json_encode($prefecture_list_json);