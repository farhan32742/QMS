<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

  <title>Mobile App</title>
</head>

<body>
  <style>
    .navbar-toggler {
      /* background-color: transparent; */
      border: none;
      color: #000;
      font-size: 40px;
      cursor: pointer;
    }

    .ticket {
      background-color: #dae7ff;
      margin-top: 10px;
      border-radius: 20px;
    }

    .tickting img {
      width: 170px;
      height: 140px;

    }

    .yourtoken {
      background-color: #dae7ff;
      border-radius: 20px;
    }

    .icon_img img {
      border-radius: 50%;

    }

    .sidebar {
      background-color: #6c5ce7;
      color: #dbe2f0;
      padding: 15px;
      position: fixed;
      top: 0;
      left: -250px;
      width: 250px;
      height: 100vh;
      transition: left 0.3s ease;
    }

    .sidebar a {
      text-decoration: none;
      color: #dbe2f0;
      font-size: 15px;
      font-weight: bold;
    }

    .sidebar.open {
      left: 0;
    }

    .close-btn {
      background-color: transparent;
      border: none;
      color: #dbe2f0;
      font-size: 20px;
      position: absolute;
      top: 15px;
      right: 15px;
      cursor: pointer;
    }

    .navbar-toggler {
      background-color: transparent;
      border: none;
      color: #000;
      font-size: 20px;
      cursor: pointer;
    }

    .bottom-buttons {
      position: absolute;
      bottom: 15px;
      /* Adjust as needed */
      left: 15px;
      /* Adjust as needed */
      width: calc(100% - 30px);
      /* Adjust to match sidebar width */
      text-align: center;

    }

    .sidebar-btn {
      /* background-color: white; */
      border: 1px solid;
      color: #eb5611;
      padding: 8px 20px;
      margin: 5px;
      cursor: pointer;
      font-size: 15px;
      font-weight: bold;
      border-radius: 10px;
      border-color: #eb5611;
    }

    .sidebar-btn:hover {
      /* background-color: #726b6ff3; */
      color: #6c5ce7;
    }

    .dropdown-content {
      display: none;
      padding-left: 15px;
      /* Adjust as needed */

    }

    .dropdown-content a {
      display: block;
      padding: 8px 0;
      color: #dbe2f0;
      text-decoration: none;
      font-weight: bold;
    }

    .dropdown-content a:hover {
      background-color: #6c5ce7;
    }

    .dropdown-toggle .arrow {
      float: right;
    }

    .dropdown-toggle.open .arrow {
      transform: rotate(-180deg);
    }

    .dropdown-toggle::after {
      display: inline-block;
      margin-left: .255em;
      vertical-align: .255em;
      content: none;
      border-top: .3em solid;
      border-right: .3em solid transparent;
      border-bottom: 0;
      border-left: .3em solid transparent;
    }



.emoji-btn {
      font-size: 2rem;
      background: none;
      border: none;
      cursor: pointer;
    }
   
    .feedback-form {
      display: none;
    }
    .form-group {
      margin-bottom: 10px;
    }
    .form-group label {
      display: block;
      font-weight: bold;
    }
    .form-group input[type="text"],
    .form-group textarea {
      width: 100%;
      padding: 5px;
      font-size: 16px;
      outline: none;
    }
    .icon_img {
      cursor: pointer;
      text-align: center;
    }
    .form-group input[type="text"], .form-group textarea {
    width: 100%;
    padding: 5px;
    font-size: 16px;
    outline: none;
    border: none;
    transition: background-color 0.3s, border-color 0.3s; /* Add smooth transition */
}

.form-group input[type="text"]:hover, .form-group textarea:hover {
  background-color: #ffffff00;
    border: 1px solid #035cff;
    border-radius: 10px;
}

  </style>
  <section>
    <div class="container-fluid">
      <div class="row">
        <div class="col-12 head">
          <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar"
            aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
            &#9776;
          </button>

        </div>
      </div>
      <section>
        <div class="container-fluid">
          <div class="row  ticket">
            <div class="col-6 ">
              <p style="padding-top: 15px; padding-left: 5px; font-size: 25px;">Welcome to <br> <b
                  style="font-size: 35px;">QMS</b></p>
            </div>
            <div class="col-6 tickting">
              <img src="used in ticking.png" alt="">
            </div>
          </div>
        </div>
      </section>

      <section style="margin-top:12px">
        <div class="container-fluid mt-3 =">
          <div class="row ">
            <div class="col-2 d-flex justify-content-center pt-2">
              <img src="icons8-100--100.png" alt="" width="35px" height="35px"
                style="border-radius: 50%; margin-right: 5px;">
            </div>
            <div class="col-7 ">
              <span style="font-size: 30px; color: #00aaff;">Now Serving </span>
            </div>
            <div class="col-3 d-flex justify-content-center align-items-center"
              style="background-color: #e3edff; border-radius: 20px;">
              <span style="font-weight: bold; font-size: 30px;">2123</span>
            </div>

          </div>
          <div class="row mt-3">
            <div class="col-2"></div>
            <div class="col-8 d-flex justify-content-center align-items-center yourtoken">
              <p style="font-size: 25px;">YOUR TOKEN <br><b
                  style="font-size: 60px; display: flex; justify-content: center;">25</b></p>

            </div>
            <div class="col-2"></div>

          </div>

          <div class="row mt-3">
            <div class="col-1"></div>
            <div class="col-10 ">
              <h2 class="d-flex justify-content-center" style="font-size: 20px; color: #478bff;">Estimated waiting time
                <br>
              </h2>
              <h1 id="timer" class="d-flex justify-content-center" style="color: #478bff;  font-size: 40px;">00:45:30
              </h1>
            </div>
            <div class="col-1"></div>

          </div>

          <div class="row">
            <div class="col-12">
              <div class="row">
                <div class="col-9">
                  <div onclick="toggleFeedback()" style="cursor: pointer; color: #478bff;">
                    <h3>Feedback</h3>
                  </div>
                </div>
                <div class="col-3">
                  <div class="icon_img" onclick="sendFeedbackcomment()">
                    <img src="icons8-right-arrow-48.png" alt="Arrow" width="30px" height="30px">
                  </div>
                </div>
              </div>
          
              <div class="feedback-form mt-2" id="feedbackForm" style="display: none;">
                <div class="form-group">
                  <label for="nME">Full name</label>
                  <input type="text" id="nME" placeholder="Enter your name" >
                </div>
                <div class="form-group">
                  <label for="txtbx">Comment</label>
                  <input type="text" id="txtbx" placeholder="Enter your Comment" >
              
                </div>
              </div>
            </div>


              <hr class="m-0 p-0">
            
            <div class="col-1"></div>
            <div class="col-10 d-flex justify-content-center">
              <button class="emoji-btn" onclick="sendFeedback('😊')">😊</button>
              <button class="emoji-btn" onclick="sendFeedback('😢')">😢</button>
              <button class="emoji-btn" onclick="sendFeedback('😟')">😟</button>
              <button class="emoji-btn" onclick="sendFeedback('😐')">😐</button>
            </div>
            <div class="col-1"></div>
   
            <div class="row " style="margin-top:12px">
              <div class="col-11">
                <div class="input-group mt-4">
                  <input type="text" class="form-control" placeholder="Name or contact number"
                    style="border-radius: 10px; background-color: #a97aff;">
                </div>
              </div>
              <div class="col-1">
                <div class="input-group mt-4 icon_img">
                  <img  src="icons8-right-arrow-48.png" alt="" width="40px" height="40px">
  
                </div>
              </div>

            </div>
           
            </div>

          </div>

          </section>
        </div>
   
  </section>
  <!-- Sidebar -->
  <div id="sidebar" class="sidebar">
    <button class="close-btn">×</button>
    <div class="pages">
      <p><b style="font-size: 25px;">QMS</b></p>
      <div class="sub_page">
        <a href="#" class="dropdown-toggle">Appointment <span class="arrow">&#9660;</span></a>
        <div class="dropdown-content">
          <a href="#">Doctor List</a>
          <a href="#">Calendar</a>
          <a href="#">Reminder</a>
        </div>
        <hr>
        <a href="#">Alert</a>
        <hr>
        <a href="#" style="white-space: nowrap;">Staff Registration</a>
        <hr>
        <a href="#">Attendance</a>
        <hr>
        <a href="#">Take Appointment</a>
        <hr>
      </div>
    </div>

    <div class="bottom-buttons d-flex justify-content-center">
      <a href="signup.html" class="sidebar-btn" style="background-color: #dae7ff; color: #02070f; transition: background-color 0.3s, color 0.3s;">Sign Up</a>
      <a href="signin1.html" class="sidebar-btn" style="background-color: #dae7ff; color: #01060f; transition: background-color 0.3s, color 0.3s;">Sign In</a>
    </div>
    
  </div>







  <!-- Optional JavaScript; choose one of the two! -->

  <!-- Option 1: Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

  <!-- Option 2: Separate Popper and Bootstrap JS -->
  <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->
  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      var sidebar = document.querySelector('#sidebar');
      var toggler = document.querySelector('.navbar-toggler');
      var closeBtn = document.querySelector('.close-btn');

      // Function to open sidebar
      function openSidebar() {
        sidebar.classList.add('open');
      }

      // Function to close sidebar
      function closeSidebar() {
        sidebar.classList.remove('open');
      }

      // Event listener for toggler button
      toggler.addEventListener('click', function () {
        sidebar.classList.toggle('open');
      });

      // Event listener for close button
      closeBtn.addEventListener('click', function () {
        sidebar.classList.remove('open');
      });
    });

    document.addEventListener('DOMContentLoaded', function () {
      var dropdownToggle = document.querySelector('.dropdown-toggle');

      dropdownToggle.addEventListener('click', function () {
        var dropdownContent = this.nextElementSibling;
        this.classList.toggle('open');
        if (dropdownContent.style.display === 'block') {
          dropdownContent.style.display = 'none';
        } else {
          dropdownContent.style.display = 'block';
        }
      });
    });

function sendFeedback(emoji) {
      alert("Feedback sent: " + emoji);
      // Implement the logic to send the emoji feedback
    }
    function toggleFeedback() {
      var feedbackForm = document.getElementById('feedbackForm');
      feedbackForm.style.display = (feedbackForm.style.display === 'none' || feedbackForm.style.display === '') ? 'block' : 'none';
    }
    function sendFeedbackcomment() {
      var fullName = document.getElementById('nME').value;
      var comment = document.getElementById('txtbx').value;

      // Perform validation if needed

      // Simulate sending feedback (you can replace this with actual sending logic)
      console.log('Sending feedback:');
      console.log('Full Name:', fullName);
      console.log('Comment:', comment);

      // Reset form fields or show a confirmation message
      document.getElementById('nME').value = '';
      document.getElementById('txtbx').value = '';

      // Optionally, hide the feedback form after sending
      var feedbackForm = document.getElementById('feedbackForm');
      feedbackForm.style.display = 'none';
    }


  </script>




</body>

</html>