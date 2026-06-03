<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="signIn.aspx.cs" Inherits="QMS.signIn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QMS Admin Login</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
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
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
            border-radius: 50%;
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
        .right-panel input {
            border-radius: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="left-panel">
                <img src="login and logout.jpg" alt="Logo" />
                <h2>Welcome to QMS</h2>
                <p>Welcome to the QMS Admin Dashboard. Sign in to manage queues, track service requests, and optimize operations.</p>
            </div>
            <div class="right-panel">
                <h2>Sign In Your Account</h2>
                <p>New Here? <a href="signUp.aspx">Create an Account</a></p>
                <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" />
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password" />
                <div class="text-right">
                    <a href="ForgetPassword.aspx">Forgot Password?</a>
                </div>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Continue" OnClick="btnLogin_Click" />
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </form>
</body>
</html>