<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="QMS.signUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QMS Admin Signup</title>
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
            margin-bottom: 5px;
        }
        .right-panel .btn-primary {
            width: 100%;
            border-radius: 15px;
        }
        .right-panel .text-right {
            margin-bottom: 10px;
        }
        .right-panel input {
            border-radius: 15px;
        }
        .drl {
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
                <p>Create your account to access the QMS Admin Dashboard. Manage queues, monitor service requests, and enhance your operational efficiency.</p>
            </div>
            <div class="right-panel">
                <h2>Sign Up Your Bank Account</h2>
                <p>Already have an account? <a href="signIn.aspx">Signin</a></p>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required" ForeColor="Red" />
                
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email"></asp:TextBox>
                 <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ForeColor="Red" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
                
 

                 <asp:TextBox ID="bnkname" runat="server" CssClass="form-control" Placeholder="Bank Name"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvbnkname" runat="server" ControlToValidate="bnkname" ErrorMessage="Bank Name is required" ForeColor="Red" />

                 <%--<asp:TextBox ID="countryname" runat="server" CssClass="form-control" Placeholder="country Name"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvcountryname" runat="server" ControlToValidate="countryname" ErrorMessage="country Name is required" ForeColor="Red" />

                 <asp:TextBox ID="cityname" runat="server" CssClass="form-control" Placeholder="city Name"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvcityname" runat="server" ControlToValidate="cityname" ErrorMessage="city Name is required" ForeColor="Red" />--%>

                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control drl mb-4" AutoPostBack="true" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
    <asp:ListItem Value="" Text="Select Country"></asp:ListItem>
    <asp:ListItem Value="Pakistan">Pakistan</asp:ListItem>
    <asp:ListItem Value="UK">UK</asp:ListItem>
    <asp:ListItem Value="USA">USA</asp:ListItem>
    
</asp:DropDownList>

<asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control drl mb-4">
    <asp:ListItem Value="" Text="Select City"></asp:ListItem>
</asp:DropDownList>

                <asp:TextBox ID="codeNumber" runat="server" CssClass="form-control" Placeholder="Branch Code"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="codeNumber" ErrorMessage="Branch Code is required" ForeColor="Red" />
               

                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="8" Placeholder="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" />
                
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="8" Placeholder="Confirm Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required" ForeColor="Red" />
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match" ForeColor="Red" />
                
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Register Your Bank" OnClick="btnSubmit_Click" />
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </form>
</body>
</html>
