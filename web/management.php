<?php
declare(strict_types=1);
require_once('./class.php');
$db = new DB;
$sql = 'SELECT * FROM recipes';
$recipes = $db -> query($sql);
?>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>献立管理画面</title>
<link rel="stylesheet" href="./com/import.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
</head>
<body>
    <?php include('./header.php') ?>
    <main>
        <div class="management">
            <style>
            .management {
                width: 1000px;
                margin: 0 auto;
                display: flex;
                flex-wrap: wrap;
            }
            .card {
                width: 300px;
                margin-left: 1em;
            }
            </style>
            <?php foreach($recipes as $row): ?>
            <div class="card">
                <div class="card-image">
                    <?php if($row['picture'] != null):?>
                    <img src="./images/<?=$row['picture']?>">
                    <?php endif; ?>
                </div>
                <div class="card-content">
                    <span class="card-title"><?=$row['name']?></span>
                    <p><?=$row['howto']?></p>
                </div>
            </div>
        <?php endforeach; ?>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>