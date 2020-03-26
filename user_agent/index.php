<!DOCTYPE html>
<html>
  <head>
    <title>operation test of kaizen 2.0
    </title>
    <link rel="stylesheet" href="../assets/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="../assets/css/style.css">
  </head>
  <body>
    <div class="container">
      <!-- Material form login -->
      <div class="card mt-sm-5">
        <h3 class="card-header custom-header info-color white-text text-center py-5">
          <strong>For the operation test of kaizen 2.0 learning platform
          </strong>
        </h3>
        <!--Card content-->
        <div class="card-body px-lg-5 pt-0 mt-sm-5">
          <!-- Form -->
          <form id="user_agent_form" action="thanks.php" onsubmit="return validation()" method="post"
                class="text-center" style="color: #757575;" style="margin-top: 5% !important">
            <p>
              <!-- Company name -->
            <div class="md-form">
              <label>
                <h2>
                  <i class="fad fa-building fa-fw">
                  </i> Company Name
                </h2>
              </label>
              <input type="text" class="form-control custom-input" id="companyName"
                     name="companyName" placeholder="Enter Your Company Name Here">
            </div>
            </p>
          <br>
          <!-- Internet speed -->
          <div class="md-form">
            <label>
              <h2>
                <i class="fad fa-tachometer-alt fa-fw">
                </i> Internet Speed
              </h2>
              <div class="d-flex justify-content-around">
                <div>
                  <!-- link of internet speed  -->
                  <a href="http://fast.com" target="_blank">
                    <h4>
                      <i class="fad fa-external-link-alt fa-fw">
                      </i> Click here to find out your Internet speed
                    </h4>
                  </a>
                  <p class="par-font">Note:After clicking the link above, Please wait some moments for getting the exact internet speed.
                  </p>
                </div>
              </div>
            </label>
            <div class="row">
              <div class="col-sm-8">
                <input type="number" class="form-control custom-input"
                       id="internetSpeed" name="internetSpeed"
                       placeholder="Enter Your Internet Speed Here">
              </div>
              <p>
              <div class="col-sm-4">
                <select class="custom-select custom-input" id="speedUnit" name="speedUnit">
                  <option class="custom-title" selected>Choose
                  </option>
                  <option value="Kbps">Kbps
                  </option>
                  <option value="Mbps">Mbps
                  </option>
                </select>
              </div>
              </p>
          </div>
        </div>
        <br>
        <!-- Submit button -->
        <button class="btn btn-primary btn-rounded btn-block btn-font mt-5 mb-4 waves-effect z-depth-0" type="submit"
                id="register" value="Save" name="submit">
          <i class="fad fa-paper-plane fa-fw">
          </i> Submit
        </button>
        </form>
      <!-- Warning message -->
      <div class="alert alert-danger alert-font" style="display:none">
        <button type="button" class="close d-none" aria-hidden="true">&times;
        </button>
        please fill out all the information.
      </div>
    </div>
    </div>
  <script src="../assets/js/jquery.min.js">
  </script>
  <script src="../assets/js/bootstrap.min.js">
  </script>
  <script defer src="../assets/css/awesome.min.js">
  </script>
  <script>
    $(document).on('click', "button.close", function(e) {
      // Actually live method is absolute for latest Jquery 
      e.preventDefault();
      // This is for safe if there any default behavior
      $(this).parent().hide();
    }
                  );
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