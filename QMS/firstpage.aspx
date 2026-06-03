
<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="firstpage.aspx.cs" Inherits="QMS.firstpage" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <title>Your registration</title>
    <style>
        .custom-input {
            border: none;
            background-color: #f8f9fe;
            outline: none; /* Remove the default focus outline */
            transition: box-shadow 0.3s ease; /* Add transition effect for box-shadow */
        }
        h1 {
            font-size: 30px;
            color: #333;
            font-weight: bold;
        }
        p {
            color: #666;
            font-size: 20px;
        }
        .btn-custom {
            border-radius: 15px;
            background-color: #4c7780;
            color: #ffffff;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-custom:active {
            background-color: #2a4a5a;
        }
    </style>
</head>

<body>
    <section>
       
        <div class="class container-fluid">
            <div class="row" style="margin-top: 15px;">
                <div class="col-3"></div>
                <div class="col-6 d-flex justify-content-center">
                    <p style="font-size: 35px; font-weight: bold; padding-left: 10px; padding-right: 10px;">QMS</p>
                </div>
                <div class="col-3"></div>
            </div>
        </div>
    </section>

    <section>
        <div class="class container">
            <div class="row">
                <div class="col-12">
                    <img src="login and logout.jpg" alt="" width="100%" height="100%">
                </div>
            </div>
        </div>
        <h1 class="text-center mb-3">Book Your Ticket Now!</h1>
        <p class="text-center mb-4">Please enter your details below:</p>
    </section>

    <section>
        <div class="class container-fluid" style="background-color: #f8f9fe; border-radius: 25px;">
            <div class="row">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" BorderStyle="None"></asp:Label>
                <form id="signupForm" runat="server" method="post" style="padding: 30px; padding-top: 0px; padding-bottom: 0px;" class="mt-3">
                    <div class="col-12">
                        <label style="font-size: 20px;" for="fname">Full Name </label> <br>
                        <i class="fas font-family margin-right"></i><span style="margin-left: 2px;">|</span>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="custom-input" placeholder="enter your name"  ></asp:TextBox>
               

                        </div>
                     
                    <hr class="m-0 p-0">

                  <!--  <div class="col-12 mt-3">
                        <label style="font-size: 20px;" for="lname">Last Name </label> <br>
                        <i class="fas font-family margin-right"></i><span style="margin-left: 2px;">|</span>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="custom-input" placeholder="enter your name" required="required"></asp:TextBox>
                    </div> 
                    <hr class="m-0 p-0">   -->
                    <div class="col-12 mt-3">
                        <label style="font-size: 20px;" for="phone">Phone No</label> <br>
                        <i class="fas fa-phone"></i><span style="margin-left: 2px;">|</span>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="custom-input" placeholder="xxxx-xxxxxxx" TextMode="Phone"></asp:TextBox>
                    </div>
                    <hr class="m-0 p-0">
                    <div class="row mt-5">
                        <div class="col-12 text-center">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn-custom w-100 text-center" Text="Submit" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                       <div class="row mt-3">
       <div class="col-12 text-center" >
           <asp:Button ID="Btnskip" runat="server" CssClass="btn-custom w-100 text-center btn-custom bg-danger" Text="Skip" OnClick="btnSkip_Click" />
       </div>
   </div>
                     <asp:HiddenField id="hdnccode" runat="server"/>
                </form>
            </div>
        </div>
    </section>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>

</html>
