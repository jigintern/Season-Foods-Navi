<?php
declare(strict_types=1);
require_once('./class.php');
$db = new DB;
$sql = 'SELECT name, base_food, picture, months, pref_id FROM foods';
$foods = $db -> query($sql);
$sql = 'SELECT name FROM prefecture';
$prefectures_pdo_object = $db -> query($sql);
$prefectures_list = array();
while($result = $prefectures_pdo_object -> fetch(PDO::FETCH_ASSOC)) {
    array_push($prefectures_list, $result['name']);
}
$foods_list = array();
while($result = $foods -> fetch(PDO::FETCH_ASSOC)) {
    array_push($foods_list, $result['name']);
}
$foods -> execute();
?>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>食材管理画面</title>
<link rel="stylesheet" href="./com/import.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
</head>
<body>
    <?php include('./header.php'); ?>
    <main>
        <style>
            .management {
                width: 1000px;
                margin: 0 auto;
            }
        </style>
        <div class="management">
            <table>
                <thead>
                <tr>
                    <th>食品名</th>
                    <th>もとの食材</th>
                    <th>旬の月</th>
                    <th>県名</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach($foods as $row): ?>
                <tr>
                    <td><?=$row['name']?></td>
                    <td><?=$foods_list[$row['base_food']-1]?></td>
                    <td><?=$row['months']?></td>
                    <td><?=$prefectures_list[$row['pref_id']]?></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>