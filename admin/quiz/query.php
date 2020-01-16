<?php
require_once "../../config.php";
require_once "../../library/permission.php";

//debug($_SESSION);
//debug($_GET);
//debug($_POST);
//debug($_FILES);

$isManager = isset($_SESSION['auth']['manage']) ? $_SESSION['auth']['manage'] : 0;
$permission = isset($_SESSION['auth']['permission']) ? $_SESSION['auth']['permission'] : 0;

if (!$isManager && !isPermissionFlagOn($permission, "1-8")) {
    $_SESSION = array(); //全てのセッション変数を削除 Remove all session variables
    setcookie(session_name(), '', time() - 3600, '/'); //クッキーを削除 Delete cookies
    session_destroy(); //セッションを破棄 Discard session

    header('Location: ../auth/index.php');
    exit();
}

/* For Mapping */

//------Including the category hierarchy-----
error_reporting(~E_NOTICE);
$path = '../../library/category/'; //カテゴリーPHPライブラリの場所（※必須）Category PHP library location (* required)
$csvpath = $path . 'csv/'; //CSVファイルの場所 CSV file location
$_POST['csvfile'] = $csvpath . 'contents.csv';

//カテゴリー計算用ファイルを読込み Load category calculation file
require_once(dirname(__FILE__) . '/' . $path . 'catecalc.php');

/* For Mapping */

// 初期値 initial value
$selection_default_cnt = 5; // 選択肢のデフォルト数 Default number of choices
$error_message = array();
$disabled = '';
$selection = array();

$error_message = array();
$error_p = '';
$disabled = '';

function validation() {
    $error_message = array();

    // バリデーションチェック Validation check
    if ($_POST['query_text'] == '') {
        $error_message['query_text'] = 'Please enter a problem statement.';
    }

    $error = 0;
    foreach ($_POST['text'] as $value) {
        if ($value != '') {
            $error++;
        }
    }

    if ($error == 0) {
        $error_message['text'] = 'Please enter your choice.';
    }

    if (! in_array(1, $_POST['correct'])) {
        $error_message['correct'] = 'Please specify your choice of correct answer.';
    }

    return $error_message;
}
/*For mapping */
function csvToDbConverter($input)
{
	$split = explode("-",$input);
    $split[1]=str_replace("0x","",$split[1]);
    $t="";
    for($i=1;$i<(int)$split[0];$i++)
    {
        $t=$t."0-";
    }
    $output=$t.$split[1];
	return $output;
}
/*For mapping */

// curlのインスタンス化 instantiating curl
$curl = new Curl($url);

// request
$quiz_id = filter_input(INPUT_GET, "id");
$p = filter_input(INPUT_GET, "p");
$bid = filter_input(INPUT_GET, "bid");

// インスタンス化 Instantiate
$Quiz = new Quiz($quiz_id, $curl);
$QueryObj = new Query($quiz_id, $curl);
#$SelectionObj = new QuerySelection($selection_default_cnt, $QueryObj, $curl);
$SelectionObj = new QuerySelection($quiz_id, $curl);
/*For mapping*/

if(isset($_POST['submit']))
{
    //$_SESSION['submitFlag'] = $_POST['submit'];
    if(!empty($_POST['check_list'])) 
    {
        // Loop to store and display values of individual checked checkbox.
        $_SESSION['adminSelectedContents']= array();
        foreach($_POST['check_list'] as $selected) 
        {
            array_push($_SESSION['adminSelectedContents'],$selected);
        }
    }
    else
    {
        if(isset($_SESSION['adminSelectedContents']))
        {
            unset($_SESSION['adminSelectedContents']);
        }
    }
}
/* For mappping */
// tbl_quiz_query にquiz_idが無い場合はinsertする Insert if tbl_quiz_query does not have quiz_id
if ($quiz_id != ''){
    $query = $QueryObj->getQuery();

    if (count($query) == 0) {
        $display_order = 0;
        $query_id = $QueryObj->insertQuery($quiz_id, $display_order);
    }
}

/*For mapping*/
$contents_idToDisplay = [];
$contnents_nameToDisplay = [];
// $servername = "localhost";
// $username = "root";
// $password = "";
// $dbname = "kaizen";
// $con = new mysqli($servername, $username, $password, $dbname);
include('../../news/includes/config.php');
// if ($con->connect_error) {
//     die("Connection failed: " . $con->connect_error);
// }

// print_r($contents_idToDisplay);
// print_r($contnents_nameToDisplay);
$subCategoryList=[];
$parentID=$csvRowC[$bid];
for($i=0;$i<count($csvTree[2][$parentID]);$i++)
{
    if($csvTree[2][$parentID][$i] != $bid)
    {
        $t = csvToDbConverter($csvTree[2][$parentID][$i]);
        $subCategoryList[$t]["contents_id"]=[];
        $subCategoryList[$t]["contents_name"]=[];
        $subCategoryList[$t]["self_name"]=$csvRowD[$csvTree[2][$parentID][$i]];
    }
    
}
foreach($subCategoryList as $key=>$val)
{
    $sql = "SELECT contents_id,contents_name FROM tbl_contents WHERE school_id = (SELECT school_id FROM tbl_admin WHERE admin_id = ".$isManager.") AND enable = 1 AND bit_classroom = '".$key."';";
    $result = $con->query($sql);
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
        array_push($subCategoryList[$key]["contents_id"],$row["contents_id"]);
        array_push($subCategoryList[$key]["contents_name"],$row["contents_name"]);
        }
    }
}

$sql = "SHOW tables LIKE 'tbl_quiz_contents_mapping'";
$tableExistOrNot = $con->query($sql);
if ($tableExistOrNot->num_rows > 0) {

    // if($_POST['submit']=='prev' || $_POST['submit']=='next' || $_POST['submit']=='add' || $_POST['submit']=='save' || $_POST['submit']=='confirm')
    // {
    //     $sql= "SELECT * FROM tbl_quiz_contents_mapping WHERE quiz_id = ".$quiz_id." and query_id = ".$_POST['query_id'];
    //     $result = $con->query($sql);
    //     if ($result->num_rows > 0) 
    //     {
    //         if(!isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
    //         {
    //             while($row = $result->fetch_assoc()) 
    //             {
    //                 if(!isset($_SESSION['mapping'][$row['quiz_id']][$row['query_id']]))
    //                 {
    //                     $_SESSION['mapping'][$row['quiz_id']][$row['query_id']] = array();
    //                 }
    //                 array_push($_SESSION['mapping'][$row['quiz_id']][$row['query_id']],$row["contents_id"]);
    //             }
    //         }
    //     }
    // }
    if(!isset($_SESSION['mapping'][$quiz_id]))
    {
        $arra = [];
        $sql= "SELECT * FROM tbl_quiz_contents_mapping WHERE quiz_id = ".$quiz_id." and enable=1";
        $result = $con->query($sql);
        if ($result->num_rows > 0)
        {
            while($row = $result->fetch_assoc()) 
            {
                if(!isset($_SESSION['mapping'][$row['quiz_id']][$row['query_id']]))
                {
                    $_SESSION['mapping'][$row['quiz_id']][$row['query_id']] = array();
                    array_push($_SESSION['mapping'][$row['quiz_id']][$row['query_id']],$row["contents_id"]);
                }
                else
                {
                    array_push($_SESSION['mapping'][$row['quiz_id']][$row['query_id']],$row["contents_id"]);
                }
            }
        }
    }
}
else
{
    $sql = "create table tbl_quiz_contents_mapping(quiz_id INT,query_id INT,contents_id int,enable int)";
    $tableCreation = $con->query($sql);
}
/*For mapping*/

// 問題の取得 Get problem
$query_data = $QueryObj->getQuery();

//debug($query_data);
// 2019/6/03 count関数対策 2019/6/03 count function countermeasure
$p_max = 0;
if(is_countable($query_data)){
  $p_max = count($query_data);
}
//$p_max = count($query_data);


function save($QueryObj, $SelectionObj){
    $data['query_id'] = filter_input(INPUT_POST, "query_id");
    $data['query_text'] = filter_input(INPUT_POST, "query_text", FILTER_SANITIZE_SPECIAL_CHARS);
    $data['score'] = filter_input(INPUT_POST, "score");
    $data['description'] = filter_input(INPUT_POST, "description", FILTER_SANITIZE_SPECIAL_CHARS);


    // 更新 update
    $QueryObj->updateQuery($data);

    // 選択肢の保存 Save choice
    $SelectionObj->saveSelection($data['query_id']);

    $correct_cnt = $SelectionObj->countCorrect($data['query_id']);

    if ($correct_cnt['count_correct'] >= 2) {
        $post_data['query_id'] = $data['query_id'];
        $post_data['query_type'] = 1;
    } else {
        $post_data['query_id'] = $data['query_id'];
        $post_data['query_type'] = 0;
    }

    $QueryObj->updateQueryType($post_data);

    // image file upload
    $QueryObj->setQueryId($data['query_id']);
    $QueryObj->imageFileUpload();

}


if (filter_input(INPUT_POST, "submit") == 'prev') {
    save($QueryObj, $SelectionObj);
    /*For Mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
        else
        {
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
    }
    
    /*For Mapping */
    if ($p > 0) {
        $p = $p - 1;
    }

    $Quiz->redirect("query.php?id=$quiz_id&p=$p&bid=$bid");
}

if (filter_input(INPUT_POST, "submit") == 'next') {
    save($QueryObj, $SelectionObj);

    /*For Mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
        else
        {
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
    }
    
    /*For Mapping */

    $p = $p + 1;

    if ($p_max == $p) {
        $p = $p - 1;
    }

    $Quiz->redirect("query.php?id=$quiz_id&p=$p&bid=$bid");
}

if (filter_input(INPUT_POST, "submit") == 'confirm') {
    /*checkbox value fetch kor*/
    save($QueryObj, $SelectionObj);

    /*For Mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
        else
        {
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
    }
    
    /*For Mapping */

    // すべての問題をチェック Check all problems
    $query_data = $QueryObj->getQuery();

    foreach ($query_data as $key => $value) {
        if ($value['query_text'] == '') {
            $error_p = $key;
            $error_message['query_text'] = sprintf('Q%dPlease enter your problem statement.', $error_p + 1);
        }

        // 選択肢の正解フラグ漏れをチェック Check for missing correct answer flags
        $sum = 0;
        foreach ($SelectionObj->getSelection($value['query_id']) as $item) {
            $sum += (int) $item['correct_flg'];
            $correct[$key] = $sum;
        }
    }

    if (in_array(0, $correct)) {
        $error_p = array_search(0, $correct);
        $error_message['correct'] = sprintf('Q%dPlease specify the correct answer.', $error_p + 1);
    }

    if (count($error_message) > 0) {
        // 確認ボタンを押せなくする Disable the confirmation button
        $disabled = ' disabled';
    } else {
        $Quiz->redirect("confirm.php?id=$quiz_id&bid=$bid");
    }
}

// quiz_queryの保存 Save quiz_query
if (filter_input(INPUT_POST, "submit") == 'save') {
    save($QueryObj, $SelectionObj, $p);

    /*For Mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
        else
        {
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
    }
    
    /*For Mapping */

    $error_message = validation();

    if (count($error_message) > 0) {
        // 確認ボタンを押せなくする Disable the confirmation button
        $disabled = ' disabled';
    }
    

}

$status = filter_input(INPUT_GET, "status");

if ($error_p == '') {
    $p = filter_input(INPUT_GET, "p");
    if ($p == '' && empty($status)) die ('Problem number is unknown.');
} else {
    $p = $error_p;
}

$page = $p + 1;
$nav_title = sprintf("q%dQ", $page);

// query_idの取得 Get query_id
$query_id = $query_data[$p]['query_id'];

/*
if ($query_data) {

    if ($p_max > $p) {
        $p = $p_max - 1;
    }
}
*/

// ナビゲーション navigation
$nav = $QueryObj->makeQueryNav();
// 2019/6/03 count関数対策 2019/6/03 count function countermeasure
$last = 0;
if(is_countable($nav)){
  $last = count($nav);
}
//$last = count($nav);

// 問題を追加する場合 When adding a problem
if (filter_input(INPUT_POST, "submit") == 'add') {
    save($QueryObj, $SelectionObj, $p);

    /*For Mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
        else
        {
            if(isset($_SESSION['adminSelectedContents']))
            {
                $_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']] = $_SESSION['adminSelectedContents'];
                unset($_SESSION['adminSelectedContents']);
            }
        }
    }
    
    /*For Mapping */

#    $query_data = $QueryObj->getQuery();
    // 2019/6/03 count関数対策 // 2019/6/03 count function countermeasure
    $display_order = 0;
    if(is_countable($query_data)){
      $display_order = count($query_data) + 1;
    }
    //$display_order = count($query_data) + 1;

    // 新規のレコードを作成しquery_idを得る Create a new record and get query_id
    $query_id = $QueryObj->insertQuery($quiz_id, $display_order);
    //debug($query_id);

    // 5つ空の選択肢を作成しselection_idを取得 Create 5 empty choices and get selection_id
    for ($i = 0; $i < $selection_default_cnt; $i++) {
        $selection[] = $SelectionObj->insertSelectionNoData($query_id, $i);
    }

    // 追加した問いをリダイレクト表示 Redirect display of added questions
    header("location: query.php?id=$quiz_id&p=$last&bid=$bid");
    exit();
}


// フォローコンテンツ Follow content
$FollowObj = new QueryFollow($query_id, $Quiz, $curl);

// 削除の場合 When deleting
if (filter_input(INPUT_POST, "submit") == 'delete') {
    $error_message = array();
    $disabled = '';

    /* For mapping */

    if(isset($_POST['quiz_id']) && isset($_POST['query_id']))
    {
        if(isset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]))
        {
            unset($_SESSION['mapping'][$_POST['quiz_id']][$_POST['query_id']]);
        }
    }

    /*For Mapping */

    $query_id = filter_input(INPUT_POST, "query_id");

    

    $error_message = validation();

    if (count($error_message) > 0) {
        // 確認ボタンを押せなくする Disable the confirmation button
        $disabled = ' disabled';
    }

    // 無効フラグ設定 Invalid flag setting
    $QueryObj->removeQuery($query_id);
    $SelectionObj->removeQuerySelection($query_id);

    // 問1を表示 Display question 1
    header("location: query.php?id=$quiz_id&p=0&bid=$bid");
    exit();
}


# viewの表示 View display


// 画像の取消 Cancel image
if (filter_input(INPUT_POST, "image_remove") == 'image_remove') {
    // quiz_queryをnullでupdate
    $QueryObj->removeImageFile($query_id);
}

// 音声の取消 Cancel audio
/*
if (filter_input(INPUT_POST, "sound_remove") == 'sound_remove') {
    // quiz_queryをnullでupdate
    $QueryObj->removeSoundFile($query_id);
}
*/

// 現在の問題数 Current number of problems
$count_query = $QueryObj->countQuery();


// 選択肢 Choice
if (isset($query_id) && $query_id > 0) {
    $selection = $SelectionObj->makeSelectionInput($query_id);
}

//debug($selection);

// 関連コンテンツ Related content
$subject_section = $FollowObj->followContents();
//debug($subject_section);

// 問題の情報 Problem information
$query_item = $QueryObj->getQueryInfo($query_id);
//debug($query_item);

// path
$path = $query_item['quiz_id'] . '_' . $query_item['query_id'] . '.deploy';

// 画像ファイルの取得 Get image file
$image = $query_item['image_file_name'];
$image_file_path = $url2 . 'file/image/' . $path;

// 音声ファイルの取得 Get audio file
#$sound = $query_item['sound_file_name'];
#$sound_file_path = $url2 . 'file/sound/' . $path;

/*For mapping*/

// if(isset($_SESSION['submitFlag'])){
//     $subKey = null;
//     if($_SESSION['submitFlag'] == "add")
//     {
//         $subKey = (string)((int)$query_id-1);
//     }
//     // elseif($_SESSION['submitFlag'] == "delete")
//     // {
//     //     $subKey = (string)((int)$query_id+1);
//     // }
//     else
//     {
//         $subKey = $query_id;
//     }
//     if($_SESSION['submitFlag'] == "add" or $_SESSION['submitFlag'] == "save")
//     {
//         if(isset($_SESSION['mapping'][$quiz_id][$subKey]))
//         {
//             unset($_SESSION['mapping'][$quiz_id][$subKey]);
//             if(isset($_SESSION['adminSelectedContents']))
//             {
//                 $_SESSION['mapping'][$quiz_id][$subKey] = $_SESSION['adminSelectedContents'];
//                 unset($_SESSION['adminSelectedContents']);
//             }
//         }
//         else
//         {
//             if(isset($_SESSION['adminSelectedContents']))
//             {
//                 $_SESSION['mapping'][$quiz_id][$subKey] = $_SESSION['adminSelectedContents'];
//                 unset($_SESSION['adminSelectedContents']);
//             }
//         }
//     }
    
//     unset($_SESSION['submitFlag']);
//     unset($_SESSION['adminSelectedContents']);
// }

/* For mappping */
?>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ThinkBoard LMS Administrator</title>
    <!-- favicon -->
    <link rel="shortcut icon" href="../images/favicon.ico">
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-reboot.css">
    <link rel="stylesheet" type="text/css" href="../css/icon-font.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/quiz.css">
    <!-- js -->
    <script src="../../js/jquery-3.1.1.js"></script>
    <script src="../../js/popper.min.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/script.js"></script>

<style>
article, aside, dialog, figure, footer, header,
hgroup, menu, nav, section { display: block; }
td.sort {text-align: center;}
td.sort:hover {cursor: move; text-align: center;}
img {
    margin:0 5px 5px 0;
    max-width:200px;
    vertical-align:bottom;
}
</style>
<script src="../../js/jquery-1.10.2.js"></script>
<script src="../../js/jquery-ui-1.10.4.custom.js"></script>
<script src="../../js/jquery.upload_thumbs.js"></script>
</head>
<body>

<div id="wrap">

    <!-- ▼navgation -->
    <div id="nav-fixed">
        <!-- ▼h1 -->
        <div class="brand">
            <a href="../info.php">
                <h1>
                    <div class="img_h1"><img src="../images/logo.jpg" alt="ThinkBoard LMS"></div>
                    <p class="authority">For administrators</p>
                </h1>
            </a>
        </div>
        <!-- ▼scrol erea -->
        <div id="scrollerea">
            <nav id="mainnav">
                <ul id="accordion" class="accordion">
                    <li>
                        <a href="../info.php"><span class="icon-main-home"></span>HOME</a>
                    </li>
                    <?php if ($isManager || isPermissionFlagOnArray($permission, "1-1", "1-1000")) { ?>
                    <li>
                        <a class="togglebtn"><span class="icon-user-add"></span>Student affiliation / ID setting</a>
                        <ul class="togglemenu">
                            <?php if ($isManager || isPermissionFlagOn($permission, "1-1")) { ?>
                            <li><a href="../access/users.php">Affiliation group setting</a></li>
                            <?php } ?>
                            <!--<li><a href="#">講師ID設定</a></li>-->
                            <?php if ($isManager || isPermissionFlagOnArray($permission, "1-1000")) { ?>
                            <li><a href="../user/student.php">Student ID setting</a></li>
                            <?php } ?>
                        </ul>
                    </li>
                    <?php } ?>
                    <?php if ($isManager || isPermissionFlagOnArray($permission, "1-1", "1-2000")) { ?>
                    <li class="open">
                        <a class="togglebtn"><span class="icon-movie-manage"></span>Content setting</a>
                        <ul class="togglemenu open">
                            <?php if ($isManager || isPermissionFlagOn($permission, "1-1")) { ?>
                            <li><a href="../access/contents.php">Content group setting</a></li>
                            <?php } ?>
                            <?php if ($isManager || isPermissionFlagOnArray($permission, "1-2000")) { ?>
                            <li><a href="../contents/index.php" class="active">Content registration / editing</a></li>
                            <?php } ?>
                        </ul>
                    </li>
                    <?php } ?>
                    <?php if ($isManager || isPermissionFlagOn($permission, "1-1")) { ?>
                    <li>
                        <a href="../access/contents-control.php"><span class="icon-movie-set"></span>Target setting</a>
                    </li>
                    <?php } ?>
                    <?php if ($isManager || isPermissionFlagOn($permission, "1-20")) { ?>
                    <li>
                        <a class="togglebtn"><span class="icon-graph"></span>Attendance status</a>
                        <ul class="togglemenu">
                            <li><a href="../history/index.php">Confirmation from the student</a></li>
                            <!--<li><a href="dateWiseViewing/index.php">動画授業から確認</a></li>-->
                        </ul>
                    </li>
                    <?php } ?>
                    <?php if ($isManager || isPermissionFlagOnArray($permission, "1-4000")) { ?>
                    <li>
                        <a href="../message/message_list.php"><span class="icon-main-message"></span>message</a>
                    </li>
                    <?php } ?>
                    <li>
                        <a href="../help/TBLMS_Administrator.pdf" target="_blank"><span class="icon-hatena"></span>help</a>
                    </li>
                    <?php if ($isManager) { ?>
                    <li>
                        <a href="../user/admin.php"><span class="icon-user-add"></span>Administrator ID, authority setting</a>
                    </li>
                    <?php }; ?>
                </ul>
            </nav>
        </div>
    </div>
    <!-- ▲navgation -->

    <!-- ▼header -->
    <div id="header">
        <!-- ▼topicpath -->
        <div id="topicpath">
            <ol>
                <li><a href="../info.php">HOME</a></li>
                <li>Content setting</li>
                <li><a href='../contents/index.php?bid=<?php echo $bid ?>'>Content registration / editing</a></li>
                <li class="active"><a>Test creation</a></li>
            </ol>
        </div>
        <!-- ▼user information -->
        <div id="userinfo" class="button-dropdown">
            <a class="link" href="javascript:void(0)">
                <div class="erea-image"></div>
                <div class="erea-name">
                    <p class="authority">School Admin</p>
                    <p class="username"><?php echo $_SESSION['auth']['admin_name']; ?></p>
                </div>
            </a>
            <ul class="submenu">
                <li role="presentation"><a href="../account/index.php"><span class="icon-lock"></span>Account Setting</a></li>
                <li role="presentation"><a href="../auth/logout.php"><span class="icon-sign-out"></span>Logout</a></li>
            </ul>
        </div>
    </div>
    <!-- ▲header -->

    <!-- ▼main-->
    <div id="maincontents">

        <!-- ▼h2 -->
        <div class="h2">
            <h2>Test creation</h2>
        </div>
        <!-- ▲h2 -->

        <!-- progress -->
        <div id="progress">
            <ul class="clearfix">
                <li class="active">
                    <span class="text">Basic setting</span>
                    <span class="circle"></span>
                </li>
                <li class="active">
                    <span class="text">Quiz creation</span>
                    <span class="circle"></span>
                </li>
                <li>
                    <span class="text">Detail confirmation</span>
                    <span class="circle"></span>
                </li>
            </ul>
        </div>

        <form action="" method="post" enctype="multipart/form-data">
        <div id="col-item-control" class="clearfix">

            <!-- 各問題 Each problem-->
            <div id="col-quizlist">
                <div class="in">
                    <ul id="nav-list">
                    <?php foreach ((array) $nav as $key => $item): ?>
                        <li id="sortitem_<?php echo $item['query_id']; ?>">
                            <p class="handle active">
                                Q <span class="number"><?php echo $key+1; ?></span>
                                <span class="title"><?php echo $item['title']; ?></span>
                            </p></li>

                    <?php endforeach; ?>
                    <!-- アクティブ時は<a class="active"> -->
                    </ul>
                    <!-- <a class="btn-add" href="query.php?id=<?php echo $quiz_id; ?>&status=add&bid=<?php echo $bid; ?>">問題を追加</a>  -->
                    <!-- <button class="btn-add" type="submit" name="submit" id="submit" value="add">問題を追加</button> -->
                    <!-- <p class="btn-save"><button type="submit" name="submit" id="submit" value="save">この問題を保存</button></p> -->
                </div>
            </div>

            <!-- 情報入力 Information input-->
            <div id="col-inputcontents">
                <p><?php echo $nav_title; ?></p>
                <!-- 必須情報 Required information-->
                <div class="box-required">

                   <!-- 問題文 Problem statement-->
                   <dl class="input-group">
                       <dt>Problem statement<span class="text_limit">Within 250 characters</span></dt>
                       <dd><textarea rows="5" name="query_text"><?php echo $query_item['query_text'];?></textarea></dd>
                       <p class="attention"><?php echo (! empty($error_message['query_text'])) ? $error_message['query_text'] : ''; ?> </p>
                   </dl>
                   

                   <!-- 配点 Scoring-->
                   <dl class="input-group">
                       <dt>Allocation of points</dt>
                       <dd><input type="number" min="1" max="100" name="score" value="<?php echo isset($query_item['score']) ? $query_item['score'] : '10'; ?>"> point</dd>
                   </dl>

                   <!-- 選択肢 Choice-->
                   <dl class="input-group">
                       <dt>Choice</dt>
                       <dd>
                           <table class="select-answer">
                               <thead>
                               <tr>
                                   <th class="move"></th>
                                   <th class="correct">Correct answer</th>
                                   <th class="answer">Answer</th>
                                   <th class="delete">Delete</th>
                               </tr>
                               </thead>
                               <tbody id="querydata">
                               <?php $j=0;?>
                               <?php foreach ($selection as $i => $item): ?>
                               <?php $j++;?>
                               <tr>
                                   <td class="move"></td>
                                   <td class="correct"><label for="lbl<?php echo $j;?>" class="checkbox"><input type="hidden" name="correct[<?php echo $i; ?>]" value="0"/>
                                            <input id="lbl<?php echo $j;?>" type="checkbox" name="correct[<?php echo $i; ?>]" value="1"<?php echo $item['checked']; ?> /><span class="icon"></span></label></td>
                                   <td class="answer"><input type="text" name="text[<?php echo $i; ?>]" value="<?php echo $item['text']; ?>" /></td>
                                   <input type="hidden" name="selection_id[<?php echo $i; ?>]" value="<?php echo $item['selection_id']; ?>" />
                                   <td class="delete"><button type="button" class="rowRemove" value="delete"><span class="icon-cross"></span></button></td>
                               </tr>
                               <?php endforeach; ?>
                               </tbody>
                           </table>
                           <p><button type="button" id="rowAdd" class="btn-add">Add choice</button></p>
                       </dd>
                       <p class="attention"><?php echo (! empty($error_message['text'])) ? $error_message['text'] : ''; ?> </p>
                       <p class="attention"><?php echo (! empty($error_message['correct'])) ? $error_message['correct'] : ''; ?> </p>
                   </dl>
                </div>

                <!-- ファイル File-->
                <div class="box-accordion">
                    <p class="title clearfix"><span>Reference file</span></p>
                    <div class="in">
                        <button class="navbar-toggler collapsed query-edit" type="button" data-toggle="collapse" data-target="#query-file" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">Edit</button>
                        <div class="contents clearfix navbar-collapse collapse" id="query-file">

                            <!-- 画像 image-->
                            <div class="w-50">
                                <dl class="input-group">
                                <?php if (file_exists($image_file_path) || $image != ''): ?>
                                <img class="thumbs" src="<?php echo $image_file_path; ?>" alt="image" />
                                <p>ファイル名： <?php echo $image; ?></p>
                                <?php endif; ?>
                                    <dt>image plz<button type="submit" name="image_remove" value="image_remove">cancel plz</button></dt>
                                    <dd><input type="file" name="images[0]" accept="image/*"></dd>
                                </dl>
                            </div>

                            <!-- 音声 voice
                            <div class="w-50">
                                <dl class="input-group">
                                <?php //if (file_exists($sound_file_path) || $sound != ''): ?>
                                <audio controls><source src="<?php //echo $sound_file_path; ?>"></audio>
                                <p>ファイル名： <?php //echo $sound; ?></p>
                                <?php //endif; ?>
                                    <dt>音声<button type="submit" name="sound_remove" value="sound_remove">取消</button></dt>
                                    <dd><input type="file" name="sound" accept="audio/*"></dd>
                                </dl>
                            </div>
                            -->

                        </div>
                    </div>
                </div>
                
                <div class="box-accordion">
                    <p class="title clearfix"><span>Mapping file *</span></p>
                    <div class="in">
                        <button class="navbar-toggler collapsed query-edit" type="button" data-toggle="collapse" data-target="#mappingBlock" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">Add</button>
                        <div class="contents navbar-collapse collapse" id="mappingBlock">
                        <div class="w-100">
                            <dl>
                                <dt><br><table class="select-answer">
                               <thead>
                               <tr>
                                   <th class="correct">Select the lesson from which the question actually belongs</th>
                                </tr>
                               </thead>
                                </table></dt>
                                <dd>
                                    <?php 
                                        echo "<br>";
                                        foreach($subCategoryList as $key=>$value)
                                        {
                                            
                                            echo("<p> FROM the contents of <b>'".$subCategoryList[$key]["self_name"]."'</b> of <b>'".$csvRowD[$parentID]."'</b>:- </p><br/>");
                                            for($i=0;$i<count($value["contents_name"]);$i++)
                                            {
                                                $checkedOrNot="";
                                                // if(in_array($value["contents_id"][$i],$alreadyExistingConnection))
                                                // {
                                                //     $checkedOrNot = "checked=checked";
                                                // }
                                                if(isset($_SESSION['mapping'][$quiz_id][$query_id]))
                                                {
                                                    if(in_array($value["contents_id"][$i],$_SESSION['mapping'][$quiz_id][$query_id]))
                                                    {
                                                        $checkedOrNot = "checked=checked";
                                                    }
                                                }
                                                echo('<label class="customcheck"><input type="checkbox"  name="check_list[]" value="'.$value["contents_id"][$i].'" '.$checkedOrNot.'> '.$value["contents_name"][$i].'<span class="checkmark"></span></label><p></p>') ;                                                
                                            }                                                
                                            echo("<br>");
                                        }
                                    ?>
                                </dd>
                                
                            </dl>
                                    </div>
                        </div>
                    </div>
                </div>
                <!-- 不正解時の解説 Explanation of incorrect answers-->
                <div class="box-accordion">
                    <p class="title clearfix"><span>Commentary on incorrect answer</span></p>
                    <div class="in">
                        <button class="navbar-toggler collapsed query-edit" type="button" data-toggle="collapse" data-target="#query-incorrect-explanation" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">Edit</button>

                        <div class="contents navbar-collapse collapse" id="query-incorrect-explanation">
                            <div class="w-100">
                                <!-- 解説文 Commentary-->
                                <dl class="input-group">
                                    <dt>Commentary<span class="text_limit">Within 250 characters</span></dt>
                                    <dd><textarea rows="5" name="description"><?php echo $query_item['description']; ?></textarea></dd>
                                </dl>
                                <!-- コンテンツ content-->
                                <!--
                                <dl class="input-group">
                                    <dt>コンテンツ</dt>
                                    <dd>
                                        <table class="incorrect-explanation">
                                        <?php foreach ((array) $subject_section as $item): ?>
                                            <tr>
                                              <td><label class="checkbox"><input type="checkbox" name="contents[]" value="<?php echo $item['contents_id']; ?>" <?php echo $item['checked']; ?>/><span class="icon"></span></label></td>
                                              <td><?php echo $item['subject_section_name']; ?></td>
                                              <td><?php echo $item['contents_name']; ?></td>
                                            <tr>
                                        <?php endforeach; ?>

                                            <tr>
                                                <td><label class="checkbox"><input type="radio"><span class="icon"></span></label></td>
                                                <td>関連コンテンツ</td>
                                            </tr>
                                            <tr>
                                                <td><label class="checkbox"><input type="radio"><span class="icon"></span></label></td>
                                                <td>関連コンテンツ</td>
                                            </tr>
                                            <tr>
                                                <td><label class="checkbox"><input type="radio"><span class="icon"></span></label></td>
                                                <td>関連コンテンツ</td>
                                            </tr>
                                            <tr>
                                                <td><label class="checkbox"><input type="radio"><span class="icon"></span></label></td>
                                                <td>関連コンテンツ</td>
                                            </tr>
                                            <tr>
                                                <td><label class="checkbox"><input type="radio"><span class="icon"></span></label></td>
                                                <td>関連コンテンツ</td>
                                            </tr>
                                        </table>
                                    </dd>
                                </dl>
                                -->
                            </div>
		                </div>
					</div>
				</div>

<input type="hidden" name="quiz_id" value="<?php echo $quiz_id; ?>" />
<input type="hidden" name="query_id" value="<?php echo $query_id; ?>" />
<input type="hidden" name="status" value="<?php echo $status; ?>" />
<input type="hidden" name="p" value="<?php echo $p; ?>" />

	            <!-- 問題削除 Delete problem-->
		        <!-- <div class="box-delete">
		            <a href="query.php?id=<?php echo $quiz_id; ?>&qn=<?php echo $query_id; ?>&status=disable&bid=<?php echo $bid; ?>">この問題を削除</a>
		        </div> -->

		        <div class="box-controlbtns">
		        	<ul>
		        		<li>
		        			<button type="submit" name="submit" value="prev" class="prev">Forward</button>
		        		</li>
		        		<li> <?php echo $page; ?> / <?php echo $last; ?> </li><!-- 現在の問 / 全問題数 Current questions / total number of questions-->
						<li>
		        			<button type="submit" name="submit" value="next" class="next">next</button>
		        		</li>
		        	</ul>
		        	<ul>
		        		<li>
		        			<button type="submit" name="submit" value="delete" class="delete">Delete question</button>
		        		</li>
						<li>
		        			<button type="submit" name="submit" value="add" class="add">Add questions</button>
		        		</li>
		        		<li>
		        			<button type="submit" name="submit" value="save" class="save">Save the question</button>
		        		</li>
		        	</ul>
		        </div>
			</div>
        </div>

        <!-- 保存 Save-->
        <div id="col-mainbtn" class="clearfix">
            <ul class="clearfix">
              <li class="save"><button type="submit" name="submit" id="submit" value="confirm"<?php echo $disabled; ?>>Detail confirmation</button></li>
            </ul>
        </div>
        </form>
    </div>
    <!-- ▲main -->
</div>

<script type="text/javascript">
    $(document).ready(function() {
            $("#nav-list").sortable({
                handle : '.handle',
                update : function () {
                    var order = $('#nav-list').sortable('serialize');
                    $("#info").load("nav_sortable.php?"+order);
                }
            });
    });
</script>
<script type="text/javascript">
$('#rowAdd').on('click', function() {
        $('#querydata').append('<tr><td class="move"></td><td class="correct"><label class="checkbox"><input type="hidden" name="correct[<?php echo $i+1; ?>]" value="0"/><input type="checkbox" name="correct[<?php echo $i+1; ?>]" value="1"<?php echo $item['checked']; ?> /><span class="icon"></span></label></td><td class="answer"><input type="text" name="text[<?php echo $i+1; ?>]" value="" /></td><td class="delete"><button type="button" class="rowRemove" name="remove" value="Delete"><span class="icon-cross"></span></button></td></tr>');
        });
//追加したボタンにもイベントを適用させるため、onイベント内にクラス名を記述する In order to apply the event to the added button, describe the class name in the on event.
$(document).on('click', '.rowRemove', function() {
        $(this).parent().parent().remove();
        });
</script>
<script>
//$(function() {
//        $('#querydata') . sortable();
//        $('#querydata') . disableSelection();
//        });
</script>

<script>
//$(function() {
//        $('#jquery-ui-sortable') . sortable();
//        $('#jquery-ui-sortable') . disableSelection();
//        });
</script>
<script>
$(function() {
        // jQuery Upload Thumbs (https://www.dekasu.net/upload_thumbs/)
        $('form input:file').uploadThumbs({
position : 0,      // 0:before, 1:after, 2:parent.prepend, 3:parent.append,
// any: arbitrarily jquery selector
imgbreak : true    // append <br> after thumbnail images
});
        });
</script>

<!-- <script>
/*For mapping*/
function getValue() {
    var checks = document.getElementsByClassName("fetch");
    var str = [];
    for ( i = 0; i < checks.length; i++) {
        if ( checks[i].checked === true ) {
            str.push(checks[i].value);
        }
    }
    alert(str);
    //if()
    $.ajax({
        type: "post",
        url: "query.php",
        dataType: 'json',
        data: {"adminSelectedContents":str},
        cache: false
    });
}

</script> -->


<pre> <div id="info"></div> </pre>

</body>
</html>
