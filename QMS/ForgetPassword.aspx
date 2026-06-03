<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="QMS.ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forget Password</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
     <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #d2d6da;
        }
        .container {
            display: flex;
            flex-direction: row;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            width: 800px;
            max-width: 100%;
            border-radius: 10px;
        }
        .left-panel {
            background-color: #033d66;
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex: 1;
          
        }
        .left-panel img {
            width: 100%;
            height: 100%;
            margin-bottom: 20px;
            border-radius: 50px;
        }
        .right-panel {
            background-color: white;
            padding: 40px;
            flex: 1;
        }
        .right-panel .form-control {
            margin-bottom: 20px;
        }
        .right-panel .btn-primary {
            width: 100%;
            border-radius: 15px;
        }
        .right-panel .text-right {
            margin-bottom: 20px;
        }
      .right-panel input{
        border-radius: 15px;
      }
    </style>
    <form id="form1" runat="server">
        <div class="container">
            <div class="left-panel">
                <img src="forget password1.jpg" alt="Logo">
                <h3>Forget your Password?</h3>
            </div>
<div class="right-panel">
    <!-- Section for Resetting Password -->
    <div id="resetPasswordSection" runat="server" style="display:block;">
        <h2>Reset Your Password</h2>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
        <asp:HiddenField ID="hdnEmail" runat="server" />
        <asp:Button ID="btnContinue" runat="server" CssClass="btn btn-primary" Text="Continue" OnClick="btnContinue_Click" />
    </div>

    <!-- Section for Entering OTP -->
    <div id="enterOtpSection" runat="server" style="display:none;">
        <h2>Enter OTP</h2>
        <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" placeholder="Enter OTP"></asp:TextBox>
        <asp:Button ID="btnVerifyOTP" runat="server" CssClass="btn btn-primary" Text="Verify OTP" OnClick="btnVerifyOTP_Click" />
    </div>

    <!-- Section for Resetting Password (After OTP Verification) -->
    <div id="resetPasswordAfterOTPSection" runat="server" style="display:none;">
        <h2>Reset Your Password</h2>
        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="New Password"></asp:TextBox>
        <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-primary" Text="Reset Password" />
    </div>
</div>
        </div>

    </form>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
