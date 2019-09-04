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
                    <div class="input-field">
                        <select name="base_food" id="base_food">
                        </select>
                        <label for="base_food">もとの食材</label>
                    </div>
                    <div class="input-field">
                        <h6>旬の選択</h6>
                        <style>
                            .month_checkbox {
                                margin-right: 1em;
                            }
                        </style>
                        <p>
                            <label class="month_checkbox">
                                <input type="checkbox" value="1" name="month[]"/>
                                <span>1月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="2"name="month[]"/>
                                <span>2月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="3"name="month[]"/>
                                <span>3月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="4"name="month[]"/>
                                <span>4月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="5"name="month[]"/>
                                <span>5月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="6"name="month[]"/>
                                <span>6月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="7"name="month[]"/>
                                <span>7月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="8"name="month[]"/>
                                <span>8月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="9"name="month[]"/>
                                <span>9月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="10"name="month[]"/>
                                <span>10月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="11"name="month[]"/>
                                <span>11月</span>
                            </label>
                            <label class="month_checkbox">
                                <input type="checkbox" value="12"name="month[]"/>
                                <span>12月</span>
                            </label>
                        </p>
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
                    <div class="input-field">
                        <select name="foods[]" id="foods" multiple>
                        </select>
                        <label for="foods">食材名</label>
                    </div>
                    <div class="input-field">
                        <textarea id="textarea1" class="materialize-textarea" name="howto"></textarea>
                        <label for="textarea1">作り方</label>
                    </div>
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