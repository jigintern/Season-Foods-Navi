<?php
class DB{
	private $dbh;
	function __construct(){
		$DB_HOST = 'mariadb:3306';
		$DB_USER = 'SeasonFoodsNavi';
		$DB_PASSWORD = 'SeasonFoodsNavi';
		$DB_NAME = 'season_foods_navi';
		
		try{
			$dsn = "mysql:dbname={$DB_NAME};host={$DB_HOST};charset=utf8";
            $this->dbh = new PDO($dsn,$DB_USER,$DB_PASSWORD);
		}catch(PDOException $e){
			echo 'Database Connection failed:'.'  '.$e->getMessage();
			exit;
		}
    }
    // ユーザーからの入力を利用する excuteが必要になる
	function prepare($statement){
		return $this->dbh->prepare($statement);
    }
    // ユーザーからの入力を利用しない
	function query($statement){
		return $this->dbh->query($statement);
	}
}