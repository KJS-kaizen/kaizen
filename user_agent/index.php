<!DOCTYPE html>
<html>

<head>
    <title>operation test of kaizen 2.0</title>
    <link rel="stylesheet" href="../assets/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/landing-2.css">
</head>

<body>

    <div class="container">
        <!-- Material form login -->
        <div class="card mt-sm-5">

            <h3 class="card-header info-color white-text text-center py-5"
                style="color: white; background-color:#33b5e5;">
                <strong>For the operation test of kaizen 2.0 learning platform</strong>
            </h3>

            <!--Card content-->
            <div class="card-body px-lg-5 pt-0">

                <!-- Form -->
                <form id="user_agent_form" action="thanks.php" onsubmit="return validation()" method="post"
                    class="text-center" style="color: #757575;" style="margin-top: 5% !important">

                    <p>
                        <!-- Company name -->
                        <div class="md-form">
                            <label>
                                <h2><i class="fad fa-building fa-fw icon-color"></i> Company Name</h2>
                            </label>
                            <input type="text" class="form-control custom-design" id="companyName"
                                name="companyName" placeholder="Enter Your Company Name Here">
                        </div>
                    </p>

                    <!-- Internet speed -->
                    <div class="md-form">
                        <label>
                          <h2><i class="fad fa-tachometer-alt fa-fw"></i>Internet Speed</h2>
                          <div class="d-flex justify-content-around">
                              <div>
                                  <!-- link of internet speed  -->
                                  <a href="http://fast.com" target="_blank"><h5><i class="fad fa-external-link-alt fa-fw"></i>Click here to find out your Internet speed</h5></a>
                              </div>
                          </div>
                        </label>
                        <div class="row">
                            <div class="col-sm-8">
                                <input type="number" style="border-color:#757575" class="form-control"
                                    id="internetSpeed" name="internetSpeed"
                                    placeholder="Enter Your Internet Speed Here">
                            </div>
                            <p>
                                <div class="col-sm-4">
                                    <select class="custom-select" id="speedUnit" name="speedUnit"
                                        style="border-color:#757575">
                                        <option selected>Choose</option>
                                        <option value="Kbps">Kbps</option>
                                        <option value="Mbps">Mbps</option>
                                        <option value="Gbps">Gbps</option>
                                        <option value="Tbps">Tbps</option>
                                    </select>
                                </div>
                            </p>
                        </div>
                    </div><br>

                    <!-- Submit button -->
                    <button class="btn btn-outline-info btn-rounded btn-block my-4 waves-effect z-depth-0" type="submit"
                        id="register" value="Save" name="submit"><i class="fad fa-paper-plane fa-fw"></i> Submit</button>
                </form>
                <!-- Warning message -->
                <div class="alert alert-danger" style="display:none">
                    <button type="button" class="close" aria-hidden="true">&times;</button>
                    please fill out all the information.
                </div>

            </div>
        </div>

        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script defer src="../assets/css/awesome.min.js"></script>
        <script>

        $(document).on('click', "button.close", function(e) { // Actually live method is absolute for latest Jquery 
            e.preventDefault(); // This is for safe if there any default behavior
            $(this).parent().hide();
        });

        function validation() {

            // var name = document.forms["user_agent_form"]["companyName"].value;
            var copmayName = document.getElementById("companyName").value;
            var internetSpeed = document.getElementById("internetSpeed").value;
            var speedUnit = document.getElementById("speedUnit").value;

            if (copmayName == "") document.getElementById('companyName').style.borderColor = "#ff2b52";
            else document.getElementById('companyName').style.borderColor = "#757575";

            if (internetSpeed == "") document.getElementById('internetSpeed').style.borderColor = "#ff2b52";
            else document.getElementById('internetSpeed').style.borderColor = "#757575";

            if (speedUnit == "Choose") document.getElementById('speedUnit').style.borderColor = "#ff2b52";
            else document.getElementById('speedUnit').style.borderColor = "#757575";

            if (copmayName == "" || internetSpeed == "" || speedUnit == "Choose") {
                $('.alert').show()
                return false;
            }
        }
        </script>
</body>

</html>