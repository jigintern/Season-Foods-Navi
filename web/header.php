<header>
    <nav>
        <div class="nav-wrapper">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="./login.php">ログイン</a></li>
                <?php if(!$signup_screen) : ?>
                <li><a href="./logout.php">ログアウト</a></li>
                <?php endif; ?>
                <li><a href="./signup.php">サインアップ</a></li>
            </ul>
            <a href="./index.php" class="brand-logo center">旬レシピ</a>
            <?php if(!$signup_screen) : ?>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="./foods.php">食材管理</a></li>
                <li><a href="./management.php">献立管理</a></li>
            </ul>
            <?php endif; ?>
        </div>
    </nav>
</header>