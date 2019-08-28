<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <Meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>旬食ナビ 投稿</title>
    <link rel="stylesheet" href="./com/import.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
</head>
<body>
    <header>
        <nav>
            <div class="nav-wrapper">
                <a href="#" class="brand-logo center">旬食ナビ</a>
            </div>
        </nav>
    </header>
    <main>
        <div class="mc">
            <div class="syokuzai">
                <h3>ローカル食材</h3>
                <form action="./form.php" method="post" name="syokuzai" enctype="multipart/form-data">
                    <div>
                        <div class="input-field">
                            <input placeholder="トマト" id="name" type="text" class="validate" name="name">
                            <label for="name">食材名</label>
                        </div>
                    </div>
                    <div>
                        <label for="">食材画像</label>
                        <div class="file-field input-field">
                            <div class="btn">
                                <span>File</span>
                                <input type="file" name="image">
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text" name="image_path">
                            </div>
                        </div>
                    </div>
                    <div class="input-field">
                        <select name="prefecture" id="prefecture_1">
                        </select>
                        <label for="prefecture_1">地域名</label>
                    </div>
                    <button class="btn" name="submit_1">送信</button>
                </form>
            </div>
            <div class="kondate">
                <h3>献立</h3>
                <form action="./form.php" method="post" name="kondate" enctype="multipart/form-data">
                        <div class="input-field">
                            <input placeholder="jigカレー" id="name" type="text" class="validate" name="name">
                            <label for="name">献立名</label>
                        </div>
                        <div>
                            <label for="">献立画像</label>
                            <div class="file-field input-field">
                                <div class="btn">
                                    <span>File</span>
                                    <input type="file" name="image">
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text" name="image_path">
                                </div>
                            </div>
                        </div>
                    <div class="input-field">
                        <select name="prefecture" id="prefecture_2">
                        </select>
                        <label for="prefecture_2">地域名</label>
                    </div>
                    <label for="">使用する食材</label>
                    <p>
                    jig課題のときと同じ検索方法
                    データベースから食材一覧をとってきてjs配列に持たせてfilterで正規表現を使いながら検索する
                    </p>
                    <button class="btn" name="submit_2">送信</button>
                </form>
            </div>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="./index.js"></script>
</body>
</html>