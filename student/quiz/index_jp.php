<?php
require_once "../../config.php";

$_SESSION['student'] = array();

//debug($_SESSION);

?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>newlms</title>
<!--[if IE]>
<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>

<![endif]-->
<style>
article, aside, dialog, figure, footer, header,
hgroup, menu, nav, section { display: block; }
</style>
</head>
<body>
<h1><a href="https://<?php echo BASE_URL; ?>/admin/menu/">Menu</a></h1>
<h2><?php echo $_SESSION['auth']['student_name']; ?></h2>
<h2>小テスト(科目一覧)</h2>
  <p><a href="start.php?id=58&list_id=2">回答する(初回)</a></p>
  <p><a href="start.php?id=58&an=98&list_id=5">回答する</a></p>
  <p><a href="https://<?php echo BASE_URL;?>/student/quiz/result.php?id=58&an=98&list_id=5">テスト結果</a></p>
</body>
</html>
