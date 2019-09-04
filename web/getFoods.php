<?php
require_once('./class.php');
$db = new DB;
$sql = 'SELECT id, name FROM foods';
$local_foods = $db -> query($sql);
$local_foods_json = array();
foreach($local_foods as $row) {
    $tmp_list = array(
        "id" => $row['id'],
        "name" => $row['name'],
    );
    array_push($local_foods_json, $tmp_list);
}
header("Content-Type: application/json; charset=utf-8");
echo json_encode($local_foods_json);