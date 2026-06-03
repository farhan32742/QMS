<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="QMS.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
                function playAlertSound() {
                    var audio = document.getElementById('alertAudio');
                    alert("hello");
                    if (audio) {
                       
                        audio.play().catch(function (error) {
                            console.error('Audio play error:', error);
                        });
                    }
                }

                // Example call to function - adjust as needed
               
            });
    </script>
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
      width: 200px;
      height: 170px;

    }

    .yourtoken {
      background-color: #dae7ff;
      border-radius: 20px;
    }

    .icon_img img {
      border-radius: 50%;

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
     .yourtoken-display {
         font-size: 60px;
         color: #333; /* Adjust the color as needed */
         text-align: center;
     }
       .yourtoken-display-blink {
      font-size: 35px;
      color: mediumvioletred; /* Adjust the color as needed */
      text-align: center;
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

/* Base styling for the LinkButton */
.btn-success {
    display: inline-flex;
    align-items: center;
    background-color: #007bff; /* Default button color */
    color: white; /* Text color */
    border: 1px solid transparent;
    border-radius: 5px; /* Rounded corners */
    padding: 10px 20px; /* Padding around text and image */
    text-decoration: none; /* Remove underline */
    font-size: 18px; /* Font size */
    font-weight: bold; /* Font weight */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease; /* Smooth color transition */
}

/* Hover effect */
.btn-primary:hover {
    background-color: #9f1e1e; /* Darker button color on hover */
    color: #e0e0e0; /* Lighter text color on hover */
    border-color: #adea49; /* Border color on hover */
    cursor:pointer;
}

/* Focus effect */
.btn-primary:focus {
    outline: none; /* Remove default focus outline */
    box-shadow: 0 0 0 2px rgba(38, 143, 255, 0.5); /* Add a custom focus outline */
}

.error-message {
    color: red;
    font-weight: bold;
    font-size: 12px;
    margin-bottom: 10px;
}
@keyframes blink {
    0% { opacity: 1; }
    50% { opacity: 0; }
    100% { opacity: 1; }
}

.blinking {
    animation: blink 1s infinite; /* Adjust the duration as needed */
}


  </style>
    <form runat="server">
  <section>
    <div class="row">
      <div class="col-12 head">
        

      </div>
    </div>
    <div class="container-fluid" style="margin-top:20px;;">
  
      <section>
        <div class="container-fluid">
          <div class="row  ticket">
            <div class="col-6 ">
              <p style="padding-top: 15px; padding-left: 5px; font-size: 30px;">WELCOME  <br> 
                  <p style="font-size: 30px; margin-bottom:0px;">TO</p><b
                  style="font-size: 45px;">QMS</b></p>
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
              <span runat="server" style="font-weight: bold; font-size: 30px;"><%=getTokenforCounter() %></span>
                <asp:HiddenField id="hdncountertoken" runat="server"/>
            </div>

          </div>
          <div class="row mt-4">
            <div class="col-2"></div>

<div class="col-8 d-flex justify-content-center align-items-center yourtoken" style="text-align:center;" id="tokenDiv" runat="server">
    <p style="font-size: 30px;">YOUR TOKEN <br>
        <b id="tokenValue">
            <asp:Label ID="lblTokenValue" runat="server" CssClass="yourtoken-display" />
            <asp:HiddenField id="hdnyourtoken" runat="server"/>
            <asp:HiddenField id="hdncode" runat="server"/>
        </b>
    </p>
</div>

<div class="col-8 d-flex justify-content-center align-items-center yourtoken blinking" style="text-align:center;" id="messageDiv" runat="server" visible="false">
    <p style="font-size: 40px;">It's your turn now! <br>
        <b>
            <asp:Label ID="LabeelMessage" runat="server" CssClass="yourtoken-display-blink" />
        </b>
    </p>
</div>
            
            
     
            <div class="col-2"></div>

          </div>

          <div class="row mt-3">
            <div class="col-1"></div>
            <div class="col-10 ">
              <h2 class="d-flex justify-content-center" style="font-size: 25px; color: #478bff;">Estimated waiting time
                <br>
              </h2>
              <h1 id="timer" runat="server" class="d-flex justify-content-center" style="color: #607D8B;  font-size: 30px;"><%=getAverageTime() %>
              </h1>
            </div>
            <div class="col-1"></div>

          </div>

     
<div class="row">
    <div class="col-12">
        <div class="row mt-4">
            <div class="col-9">
                <div  style="cursor: pointer; color: #478bff;">
                    <h3>Feedback</h3>
                </div>
            </div>
            <div class="col-3">
                               <div class="icon_img" >
                    
  <!-- <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="icons8-right-arrow-48.png" 
             Width="30px" Height="30px" style="border-radius: 50%" OnClick="btnSaveComment_Click" /> -->
</div>
            </div>
        </div>

        <div class="feedback-form mt-2" id="feedbackForm" style="display: block;">
            <div class="form-group">
                
                <asp:TextBox ID="txtbx" runat="server" Placeholder="Enter your Comment"></asp:TextBox>
                <asp:Label ID="lblErrorMessage" runat="server" Text="" Visible="false" CssClass="error-message"></asp:Label>
            </div>
        </div>

        <hr class="m-0 p-0">

        <div class="col-1 mt-2"></div>
        <div class="col-10 d-flex justify-content-center mt-2">
            <button class="emoji-btn" onclick="sendFeedback('HAPPY'); return false;">😊</button>
            <button class="emoji-btn" onclick="sendFeedback('SAD'); return false;">😢</button>
            <button class="emoji-btn" onclick="sendFeedback('ANGRY'); return false;">😟</button>
            <button class="emoji-btn" onclick="sendFeedback('SATISFIED'); return false;">😐</button>
        </div>
        <div class="col-1 mt-2"></div>

        <div class="row" style="margin-top:12px">
            <div class="col-3"></div>
            <div class="col-6 mt-4">
                 <div class="icon_img">
                     <asp:LinkButton ID="btnSaveComment" runat="server" OnClick="btnSaveComment_Click" CssClass="btn btn-success" >
                          Send
    <img src="icons8-right-arrow-48.png" alt="Arrow" width="25px" height="25px" style="vertical-align: middle; margin-left:5px" />
   
</asp:LinkButton>

<audio id="alertAudio" src="LET2M79-intruder-alert.wav" preload="auto"></audio>

    
 </div>
            </div>
            <div class="col-3"></div>
        </div>
    </div>
</div>
        </form>






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

      function sendFeedback(emoji) {
          // Show the feedback form
          document.getElementById('feedbackForm').style.display = 'block';

          // Fill the comment input with the selected emoji
          document.getElementById('txtbx').value = emoji;

          // Optionally, you could submit the form or trigger additional actions here
          // For example, auto-submit after setting the emoji if that's desired
          // sendFeedbackcomment();
      }
      function refreshPage() {
          window.location.reload();
      }

      // Set interval to refresh every 30 seconds (30000 milliseconds)
      setInterval(refreshPage, 30000);

     
      // Call the function to play the audio
   
    

   
  </script>

</body>
</html>
