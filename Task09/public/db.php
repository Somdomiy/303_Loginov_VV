<?php
try {
	$pdo = new PDO('sqlite:../data/database.db');
} catch (PDOException $e) {
	die('Ошибка соединения с базой'.$e->getMessage());
}