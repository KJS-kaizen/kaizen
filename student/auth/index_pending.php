<?php error_reporting(0); 
include( '../../news/includes/config.php'); 
require_once "../../config.php";
$call_sign = "kai";

if (isset($_POST['register'])) {

    $fullname=$_POST['fullname'];
    $company=$_POST['company'];
	$email=$_POST['email'];
	$enquiery_subject=$_POST['enquiery_subject'];
	$enquiery=$_POST['enquiery'];
	$ip_addr = getUserIpAddr();
  	$browser = $_SERVER['HTTP_USER_AGENT'];

    $to = "$email";
    $to1 = "info@e-kjs.jp";
    $subject = mb_encode_mimeheader("Thanks For Your Inquiry. Please do not reply to this E-mail, it is auto-generated");
    $subject1 = mb_encode_mimeheader("Kaizen2.0- New inquiry from the customer"); 
    $headers_from = 'From: info@e-kjs.jp' . "\n";
    //$headers = 'From: info@e-kjs.jp' . "\n";
    $headers = 'MIME-Version: 1.0' . "\n";
    $headers .= 'Content-type: text/html; charset=UTF-8' . "\n";
    $message = "<html><body style=font-family:メイリオ leftmargin=10 topmargin=0 marginheight=0 marginwidth=0 height=100%>
                    <table width=100% margin=0>  <tbody>  <!---outer table -->
                    <tr><td>Dear $fullname </td></tr><br>
                    <tr><td></td></tr>
                    <tr><td>Thank you for your inquiry to us, Kaizen2.0 project! </td></tr> 
                    <tr><td></td></tr>                              
                    <tr><td>Now, we are checking your inquiry,so please wait a few days for our reply to you.Thank you. </td></tr><br>
                    <tr><td></td></tr>
                    <tr><td>Best Regards,</td></tr>
                    <tr><td>------------------------------------------------------------------------------------------------------------</td></tr><br>
                    <tr><td>KAIZEN2.0: MICROLEARNING WITH A DIGITAL BRAIN project </td></tr>
                    <tr><td>email:〇〇〇〇 </td></tr>
                    <tr><td>HP:〇〇〇〇 </td></tr>
                    <tr><td>------------------------------------------------------------------------------------------------------------</td></tr><br>
                    </table>
                    </body>
                    </html>";
    mail($to,$subject,$message, $headers_from.$headers);

    $headers_from = "From: $email ". "\n";
    $message1 = "<html><body style=font-family:メイリオ leftmargin=10 topmargin=0 marginheight=0 marginwidth=0 height=100%>
                    <table width=100% margin=0>  <tbody>  <!---outer table -->
                    <tr><td>Dear Kaizen2.0 Admin,</td></tr><br>
                    <tr><td></td></tr>
                    <tr><td>We have a new inquiry from the below mentioned customer</td></tr><br>
                    <tr><td></td></tr>
                    <tr><td>------------------------------------------------------------------------------------------------------------</td></tr><br>
                    <tr><td><strong>Name：</strong>$fullname</td></tr>
                    <tr><td><strong>Company：</strong>$company</td></tr>
					<tr><td><strong>E-mail：</strong>$email</td></tr>
					<tr><td><strong>E-mail：</strong>$enquiery_subject</td></tr>
                    <tr><td><strong>Message：</strong>$enquiery</td></tr>
                    <tr><td>------------------------------------------------------------------------------------------------------------</td></tr><br>
                    <tr><td>Please respond to the inquiry as soon as possible.</td></tr>
                    <tr><td><strong>User's additional Information  ：</strong></td></tr>
					<tr><td><strong>IP address      ：</strong>$ip_addr</td></tr>
					<tr><td><strong>Browser Details ：</strong>$browser</td></tr>
					<tr><td><hr></td></tr>
                    </table>
                    </body>
                    </html>";
    mail($to1,$subject1,$message1, $headers_from.$headers.$headers);
    session_destroy();
  }

  function getUserIpAddr(){
	if(!empty($_SERVER['HTTP_CLIENT_IP'])){
		//ip from share internet
		$ip = $_SERVER['HTTP_CLIENT_IP'];
	}elseif(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
		//ip pass from proxy
		$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	}else{
		$ip = $_SERVER['REMOTE_ADDR'];
	}
	return $ip;
  }


  // セッションがあればメニューへ
  if (isset($_SESSION['auth']['student_id'])) {
      $base = (empty($_SERVER["HTTPS"]) ? "http://" : "https://") . $_SERVER["HTTP_HOST"];
      //header('Location: ' . $base . '/student/menu/');
      header('Location: ' . $base . '/student/info.php');
      exit();
  }

  // post データより
  $id = filter_input(INPUT_POST, "username", FILTER_SANITIZE_SPECIAL_CHARS);
  $pw = filter_input(INPUT_POST, "password", FILTER_SANITIZE_SPECIAL_CHARS);

  if ($id != '' && $pw != '') {
      $curl = new Curl($url);
      $student = new StudentAuth($call_sign . $id, $pw);
      $data = $student->authCheck();
      $result = $curl->send($data);

      if ($result['enable'] == 1 && $result['joining'] == 1) {
          $curl->send($student->updateAccessDate($result["student_id"]));
          //debug($result);
          $_SESSION['auth'] = $result;
          //$_SESSION['auth']['level'] = 'student';
          $base = (empty($_SERVER["HTTPS"]) ? "http://" : "https://") . $_SERVER["HTTP_HOST"];
          //header('Location: ' . $base . '/student/menu/');
          header('Location: ' . $base . '/student/info.php');
          exit();
      }
  }



?>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Kaizen2.0</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="author" content="Themesbrand" />
	<link rel="shortcut icon" href="images/favicon.ico">
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="../../assets/css/bootstrap.css" type="text/css">
	<!-- Icon -->
	<link rel="stylesheet" type="text/css" href="../../assets/css/themify-icons.css" />
	<link rel="stylesheet" type="text/css" href="../../assets/fonts/fontawesome/css/font-awesome.min.css" />
	<!--Slider-->
	<link rel="stylesheet" href="../../assets/css/owl.carousel.css" />
	<link rel="stylesheet" href="../../assets/css/owl.theme.css" />
	<link rel="stylesheet" href="../../assets/css/owl.transitions.css" />
	<!-- Custom  Css -->
	<link rel="stylesheet" type="text/css" href="../../assets/css/style.css" />
	<link rel="stylesheet" type="text/css" href="../../assets/css/custom.css" />
	<link rel="stylesheet" type="text/css" href="../../assets/css/colors/pink.css" />
	<link rel="stylesheet" type="text/css" href="../../assets/css/navlink.css" />
	<link href="https://vjs.zencdn.net/7.6.6/video-js.css" rel="stylesheet" />
	<script src="../js/alert.js"></script>
	<script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
	
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light fixed-top navbar-custom sticky">
		<div class="container">
			<a href="index.php" rel="home" class="main-logo">
				<img src="../../assets/images/logo2.png" alt="kaizen2.0"  data-retina="assets/img/logo-small@2x.png" data-width="186" data-height="39">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"> <span class="ti-menu">
          </span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"> <a class="nav-link" href="#kaizen">Kaizen
              </a>
					</li>
					<li class="nav-item"> <a class="nav-link" href="#join">Join
              </a>
					</li>
					<li class="nav-item"> <a class="nav-link" href="#enquiery">Contact Us
              </a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- START HOME -->
	<section class="section bg-gradient half-home" id="kaizen">
		<div class="home-center">
			<div class="home-desc-center">
				<div class="container">
					<div class="row">
						<div class="col-lg-7 col-sm-6"></div>
						<div class="col-lg-5 col-sm-6">
							<div class="bg-white p-4 rounded pb_form_v1">
								<div class="text-center">
									<h4 class="font-weight-bold mb-3">KAIZEN Microlearning Platform
                      </h4>
									<h5 class="font-weight-bold mb-3">Login
                      </h5>
								</div>
								<form  action=<?php echo $_SERVER[ 'REQUEST_URI'] ?>  method="POST" class="login-form">
									<div class="row">
										<div class="col-lg-12 mt-3">
											<input type="text" class="form-control" placeholder="ID" name="username" value="<?php echo htmlspecialchars($id, ENT_QUOTES); ?>">
										</div>
										<div class="col-lg-12 mt-3">
											<input type="password" class="form-control" placeholder="Password" name="password" value="<?php echo htmlspecialchars($pw, ENT_QUOTES); ?>">
										</div>
										<div class="col-lg-12 mt-4 mb-3">
											<input type="submit" name="submit"  class="btn btn-custom w-100" value="login">
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- END HOME -->
	<?php
                if ($id != '' && $pw != '' && ($result['enable'] == '' && $result['joining'] == '')) {
                    print "<script language=javascript>alertMessage('Wrong ID or Password. Please confirm and re-enter the ID and password.')</script>";
                } else if ($id != '' && $pw != '' && ($result['enable'] == 0 || $result['joining'] == 0)) {
                    print "<script language=javascript>alertMessage('The ID and password you entered are currently unavailable. Please contact the administrator.')</script>";
                } else if ($id != '' && $pw == '') {
                    print "<script language=javascript>alertMessage('Password has not been entered')</script>";
                } else if ($id == '' && $pw != '') {
                    print "<script language=javascript>alertMessage('The ID has not been entered.')</script>";
                }
            ?>

	<!-- Start Services -->
	<section class="section3">
		<div class="container">
			<div class="row justify-content-center text-center">
				<div class="col-lg-12">
					<div class="mt-3 mb-3">
						<h3 class="title">
                <i class="fa fa-line-chart title-icon text-muted">
                </i>
                <span class="font-weight-bold">  KAIZEN2.0：MICROLEARNING WITH A DIGITAL BRAIN
                </span>
              </h3>
					</div>
					<div class="mt-3 mb-5">
						<p class="explanation">The objective of Kaizen 2.0 is to pilot the use of a mobile internet-based, artificial intelligence-powered microlearning platform – to teach Japanese Kaizen processes to SMEs in order to improve productivity and managerial skills.</p>
					</div>
				</div>
			</div>
	</section>
	<!-- End Services -->
	<!-- START HOME -->
	<section class="section bg-gradient1">
		<div class="container">
			<div class="row justify-content-center text-center">
				<div class="col-lg-12 col-md-12">
					<!-- <i class="ti-ruler-pencil title-icon text-muted"></i> -->
					<div class="mt-1 mb-3">
						<h3 class="text-center">
                  <span class="font-weight-bold">  Introduction of Kaizen
                  </span>
                </h3>
					</div>
				</div>
			</div>
			<summary>
				<ul class="tabs">
					<div class="row">
						<div class="col-4">
							<li> <a class="nav-title bg-color1" href="#tab1">What is Kaizen
                      </a>
							</li>
						</div>
						<div class="col-4">
							<li> <a class="nav-title bg-color1" href="#tab2">Benefits
                      </a>
							</li>
						</div>
						<div class="col-4">
							<li> <a class="nav-title bg-color1" href="#tab3">Workflow
                      </a>
							</li>
						</div>
					</div>
				</ul>
				<br>
				<summary class="wrapper block">
					<article id="tab1">
						<div class="row align-items-center justify-content-center text-center">
							<div class="col-lg-6 col-md-12 col-sm-12">
								<div class="nav-expl"> <span class="font-weight-bold">“Kaizen” 
                            </span>is a Japanese word which means <span class="col-blue">
                              <br>‘change for the better’.
                            </span>
								</div>
								<img src="../../assets/images/kaizen.png" alt="Image placeholder" class="img-fluid">
								<div class="nav-expl">Kaizen is a Japanese methodology which has a proven track-record in improving productivity and quality. Kaizen has been increasingly adopted by organizations around the world. Although Kaizen has started from industries, it is now spread out to all kinds of public and private sectors.</div>
							</div>
							<div class="col-lg-6 col-md-12 col-sm-12 mt-5">
								<video id="my-video" class="video-js vjs-default-skin vjs-big-play-centered video-center" controls preload="auto" width="450" height="300" data-setup='{ "playbackRates": [1, 1.5, 2] }'>
									<source src="../../assets/images/kaizen-intro.mp4" type="video/mp4" />
									<source src="../../assets/images/kaizen-intro.webm" type="video/webm" />
								</video>
							</div>
						</div>
					</article>
					<article id="tab2">
						<div class="row align-items-center justify-content-center text-center">
							<div class="col-lg-6 col-md-6 col-sm-12">
								<div class="nav-subtitle"> <i class="fa fa-superpowers pb_icon-gradient">
                            </i> Objectives</div>
								<p class="nav-expl">It contributes to improve not only productivity but also quality and delivery by recognizing the existing situation and solving the problems of the organization.</p>
								<div class="nav-subtitle"> <i class="fa fa-level-up pb_icon-gradient">
                            </i> Benefits</div>
								<p class="nav-expl">“Kaizen” methodology can help a company to create “continuous improvement culture” to meet in/external customers’ satisfaction and expectation.Kaizen also contributes to increase income and profit by raising productivity and reducing cost.</p>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-12">
								<img src="../../assets/images/benefit-diagram.png" alt="Image placeholder" class="img-fluid">
							</div>
						</div>
					</article>
					<article id="tab3">
						<div class="row justify-content-center text-center">
							<div class="col-lg-12 ">
								<div class="nav-subtitle"> <i class="fa fa-leanpub pb_icon-gradient">
                            </i> Micro-learning environment</div>
							</div>
						</div>
						<br>
						<div class="row align-items-center justify-content-center text-center">
							<div class="col-lg-6 col-md-6 col-sm-12">
								<p class="nav-expl">You fill up the assessment form for registration of Kaizen2.0 then administrator send your login ID & password by E-mail. After that you login to the platform and learn about Kaizen from the video lessons created by Japanese experts. </p>
								<img src="../../assets/images/work1.jpg" alt="Image placeholder" class="img-fluid">
							</div>
							<div class="col-lg-6 col-md-6 col-sm-12">
								<p class="nav-expl">Afterwards, you conduct Kaizen activity by yourself and report its results to Japanese experts. They will provide feedbacks and suggestions to you.</p>
								<br>
								<img src="../../assets/images/work2.jpg" alt="Image placeholder" class="img-fluid">
							</div>
					</article>
				</summary>
			</summary>
			</div>
		</div>
	</section>
	<!-- END HOME -->
	<!-- Start Features -->
	<section class="section bg-light" id="join">
		<div class="container">
			<div class="row align-items-center justify-content-center text-center">
				<div class="col-lg-12">
					<h3 class="title">
                      <i class="fa fa-handshake-o title-icon text-muted">
                      </i>
                      <span class="font-weight-bold">Join Kaizen2.0
                      </span>
                    </h3>
				</div>
			</div>
			<div class="row  align-items-center justify-content-center mt-5">
				<div class="col-lg-6 mb-3">
					<div class="mb-5">
						<p class="title1 text-center"> <span class="font-weight-bold">Instruction Video For Beginners
                          </p>
                    </div>
                    <video
                           id="my-video"
                           class="video-js vjs-default-skin vjs-big-play-centered video-center"
                           controls
                           preload="auto"
                           width="450"
                           height="300"
                           data-setup='{ "playbackRates": [1, 1.5, 2] }'
                           >
                      <source src="../../assets/images/kaizen-intro.mp4" type="video/mp4" />
                      <source src="../../assets/images/kaizen-intro.webm" type="video/webm" />
                    </video>
                  </div>
                  <div class="col-lg-1">
                  </div>
                  <div class="col-lg-5">
                    <div class="bg-white p-4 mt-3 rounded pb_form_join">
                      <div class="text-center">
                        <h4 class="title1 mt-5">
                          <span class="font-weight-bold">Registration for KAIZEN 2.0
                          </span>
							</h4>
					</div>
					<h5 class="explanation text-center mt-5">Please click the button below and fill The Assesment form for registration.
                      </h5>
					<form class="login-form">
						<div class="row">
							<div class="col-lg-12 mt-5 mb-5">
								<p class="mb-0"></p> <a href="https://docs.google.com/forms/d/e/1FAIpQLSci8dNssfkZ59aYltDatjGCoTm6F2Fyn6mFBhbd47WPyAWJtg/viewform" target="_blank" role="button" class="btn btn-custom w-100">Registration
                            </a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		</div>
	</section>
	<!-- End Features -->
	<!-- CONTACT FORM START-->
	<section class="section1" id="enquiery">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-6 col-md-12 col-sm-12">
					<div class="news">
						<h2 class="text-center"> 
							<i class="fa fa-newspaper-o title-icon text-muted">
							</i> News & Updates
                    	</h2>
						<div class="mt-4 pt-4">
							<div id="pb_faq" class="pb_accordion" data-children=".item">
                          <?php
                              $query=mysqli_query($con,"SELECT tblcms_posts.id,tblcms_posts.PostTitle,tblcms_posts.PostDetails,tblcms_posts.PostingDate from tblcms_posts WHERE tblcms_posts.Is_Active=1 ORDER BY tblcms_posts.id DESC ");
							  while ($row=mysqli_fetch_array($query))
							  {
							  $newsdet=$row['PostDetails'];
							  $findQuery=mysqli_query($con,"SELECT MAX(PostingDate) as last_date FROM tblcms_posts WHERE tblcms_posts.Is_Active=1");
							  $findQuery =mysqli_fetch_array($findQuery);
							  $datetime1 = new DateTime($row['PostingDate']);
							  $datetime2 = new DateTime();
							  $interval = $datetime1->diff($datetime2);
							  if($findQuery['last_date']==$row['PostingDate'] &&  $interval->format('%a') < 30)
							  {
                          ?>
									<div class="item">
										<a data-toggle="collapse" data-parent="#pb_faq" href="#pb_faq<?php echo$row['id'];?>" aria-expanded="false" aria-controls="pb_faq<?php echo$row['id'];?>" class="pb_font-22 py-4">
											<p class="day">
												<?php echo $row[ 'PostingDate'];?>
											</p>
											<p class="news-title">
												<?php echo $row[ 'PostTitle'];?>
												<img src="../../assets/images/new02.png" style="height: 22px;">
											</p>
										</a>
										<div id="pb_faq<?php echo$row['id'];?>" class="collapse" role="tabpanel">
											<div class="py-3">
												<?php echo (substr($newsdet,0));?>
											</div>
										</div>
									</div>
									          <?php }else{ ?>
									<div class="item">
										<a data-toggle="collapse" data-parent="#pb_faq" href="#pb_faq<?php echo$row['id'];?>" aria-expanded="false" aria-controls="pb_faq<?php echo$row['id'];?>" class="py-4">
											<p class="day">
												<?php echo $row[ 'PostingDate'];?>
											</p>
											<p class="news-title">
												<?php echo $row[ 'PostTitle'];?>
											</p>
										</a>
										<div id="pb_faq<?php echo$row['id'];?>" class="collapse" role="tabpanel">
											<div class="py-3">
												<?php echo (substr($newsdet,0));?>
											</div>
										</div>
									</div>
									          <?php }}?>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-12 col-sm-12">
					<div class="enquiery">
						<h2 class="text-center"> 
                      <i class="ti-headphone-alt title-icon text-muted">
                      </i>  Contact Us
                    </h2>
						<div class="bg-white p-4 rounded">
							<div class="bg-white p-4 mt-0 rounded ">
								<div class="text-center">
									<h4 class="font-weight-bold">
                          </h4>
								</div>
								<form class="login-form" method="POST" id="enquiery">
									<div class="row">
										<div class="col-lg-12 mt-2">
											<input type="text" class="form-control" name="fullname" placeholder="Your Name" required="">
										</div>
										<div class="col-lg-12 mt-2">
											<input type="text" class="form-control"  name="company" placeholder="Company Name" required="">
										</div>
										<div class="col-lg-12 mt-2">
											<input type="email" class="form-control" name="email" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,3}$" required="">
										</div>
										<div class="col-lg-12 mt-2">
											<input type="text" class="form-control" name="enquiery_subject" placeholder="Subject" required="">
										</div>
										<div class="col-lg-12 mt-2">
											<label for="exampleFormControlTextarea1" class="explanation">Enquiery Details</label>
											<textarea type="text" class="form-control pb_height-100" name="enquiery" required></textarea>
										</div>
										<div class="col-lg-12 mt-4">
											<section>
												<input type="text" class="form-control" id="UserCaptchaCode" placeholder='Enter Captcha - Case Sensitive'  onBlur="CheckCaptcha()" required>
												<span id="WrongCaptchaError" class="error"></span>
											</section>
											<section>
												<span id="SuccessMessage" class="success">Hurray! Your have successfully entered the captcha.</span>
												<div class='CaptchaWrap'>
													<div id="CaptchaImageCode" class="CaptchaTxtField">
														<canvas id="CapCode" class="capcode" width="300" height="80"></canvas>
													</div> 
													<input type="button" class="ReloadBtn" onclick='CreateCaptcha();'>
												</div>
											</section>
										</div>
										<div class="col-lg-12 mt-4">
											<input type="submit" class="btn btn-custom w-100" name="register" value="Send" onclick="return confirm('Are you sure to register all information you entered');">
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
	</section>
	<!-- CONTACT FORM END -->

 <!--START modal -->
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel">Thank you for contacting us!</h4>
                </div>
                <div class="modal-body">
                    We have received your message and would like to thank you for writing to us.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" name="close">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ENDs model -->



	<!-- Start Footer -->
	<section class="section1 bg-footer">
		<!-- <div class="bg-overlay"></div> -->
		<div class="container">
			<div class="row align-items-center justify-content-center text-center ml-auto">
				<div class="col-6 col-md mt-4">
					<a href="https://www.thegpsc.org/sites/gpsc/files/partnerdocs/program_book_-_world_bank_learning_event_-_disruptive_technologies_for_development_20180627.pdf" target="blank">
						<img src="../../assets/images/DT4D11.png" alt="Image placeholder" height="175">
					</a>
				</div>
				<div class="col-6 col-md mt-4">
					<a href="https://www.worldbank.org" target="blank">
						<img src="../../assets/images/worldbank1.png" alt="Image placeholder" height="175">
					</a>
				</div>
				<div class="col-6 col-md mt-4">
					<a href="https://www.jpc-net.jp/eng/" target="blank">
						<img src="../../assets/images/jpc1.png" alt="Image placeholder" height="175">
					</a>
				</div>
				<div class="col-6 col-md mt-4">
					<a href="https://www.avivatechnologies.com/home.html" target="blank">
						<img src="../../assets/images/aviva.png" alt="Image placeholder" height="175">
					</a>
				</div>
				<div class="col-6 col-md mt-4">
					<a href="https://www.e-kjs.jp/en/index.php" target="blank">
						<img src="../../assets/images/kjs1.png" alt="Image placeholder" height="175">
					</a>
				</div>
			</div>
			<div>
	</section>
	<section class="section1 bg-footer">
		<div class="container-fluid">
			<hr class="style-six">
		</div>
	</section>
	<section class="section1 bg-footer">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<ul class="list-unstyled address">
						 <li>Local consultant contact:</li>
						<li>Aviva Technologies Ltd.,</li>
						<li>5th Floor, Utumishi Co-Op House,</li>
						<li>Mamlaka Road, (behind Serena Hotel).</li>
						<li>P.O. Box 7564 - 00200 City Square, Nairobi Kenya.</li>
				</div>
				<div class="col-lg-6 col-md-6">
					<ul class="address list-unstyled ">
						<li><br></li>
						<li>Tel: +254-20-269-6387;</li>
						<li>Mobile: 0721-910-856;</li>
						<li>Email: info@aviva.co.ke</li>
						<li>
							<a class="footer1" href="https://maps.app.goo.gl/yH6izjSTUw9Gs6AT7" target="blank"> <u>location map
                                  </u>
							</a>
						</li>
				</div>
			</div>
		</div>
		</div>
	</section>
	<section class="section2 bg-footer1">
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<p class="footer2">&copy; All Rights Reserved by
						<a href="https://www.e-kjs.jp/en/index.php" target="_blank" rel="nofollow"> <span class="companyname">KJS
                                  </span>
						</a>
					</p>
				</div>
			</div>
		</div>
	</section>
	<!-- End Footer -->
	<!-- Back to top -->
	<a href="#" class="back-to-top" id="back-to-top"> <i class="ti-angle-up"> 
                        </i> 
	</a>
	<!-- JAVASCRIPTS -->
	<script src="../../assets/js/jquery.min.js"></script>
	
	<script src="../../assets/js/popper.min.js"></script>
	<script src="../../assets/js/bootstrap.bundle.min.js"></script>
	<script src="../../assets/js/jquery.easing.min.js"></script>
	<script src="../../assets/js/scrollspy.min.js"></script>
	<script src="../../assets/js/owl.carousel.min.js"></script>
	<script src="../../assets/js/navlink.js"></script>
	<script src="../../assets/js/captcha.js"></script>
	<!-- SCROLLSPY JS -->
	<script src="../../assets/js/scrollspy.min.js"></script>
	<!-- CUSTOM JS -->
	<script src="../../assets/js/app.js"></script>
	<script src="https://vjs.zencdn.net/7.6.6/video.js"></script>
	<?php if (isset($_POST['register'])) { ?>
        <script>
            $('#myModal').modal('show')
        </script>
        <?php } ?>
</body>
</html>