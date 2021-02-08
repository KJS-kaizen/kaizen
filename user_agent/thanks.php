<?php
date_default_timezone_set('Asia/Tokyo');// change according timezone
              
if(isset($_POST['submit']))// submit form data in .txt file
{
    // $user = $_SERVER['HTTP_USER_AGENT'];
    // $root = "../file/userAgent/";
    // $data = 'Company Name:' . $_POST['companyName'] ."\n". 'Internet Speed: ' . $_POST['internetSpeed'].' '. $_POST['speedUnit'] . "\n". 'User Agent: '. $user. "\n" ;
    // $companyName = $_POST['companyName'];
    // $fp = fopen($root ."User_agent.csv", 'a');
    // // unset($_POST['submit']);
    // fwrite($fp, $data);
    // fclose($fp);

    $root = "../file/userAgent/";
    $user = $_SERVER['HTTP_USER_AGENT'];
    $line = [
        $_POST['companyName'],
        $_POST['internetSpeed'].' '. $_POST['speedUnit'],
        $user
    ];

    $csvFile = fopen($root."userAgent".".csv", 'a');
    fputcsv($csvFile, $line);
    fclose($csvFile); 
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body>
    <div class="form-group shadow-textarea">
        <div class="card" style = "margin-top: 150px ; margin-bottom: 100px ; margin-right: 150px; margin-left: 80px;">
            <div class="jumbotron text-center">
                <h1 class="card-header info-color white-text text-center py-4" style="color: white; background-color:#33b5e5; text-align: center">For the operation test of kaizen 2.0 learning platform</h1>
                <br>
                <br>
                <p><h1 style = "color: green; text-align: center"><strong>Thank You For Your Contribution!</strong><h1></p>
                
            </div>
            <br>
            <hr>
        </div>
    </div>
    </div>
</body>
</html>