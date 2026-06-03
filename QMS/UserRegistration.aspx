<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs" Inherits="QMS.UserRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
            &#9776;
        </button>
        <b style="font-size: 25px; margin-left: 35px;" class="text-center">User Registration</b>
        <img src="logo.jpg" alt="" style="border: 1px solid; border-radius: 50%; width: 50px; height: 50px; display: block;">
    </div>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            margin-top: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 0;
        }
        .form-control {
            margin-bottom: 0;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #00d998;
            border-color: #0062cc;
        }
        .input-group {
            margin-bottom: 0;
        }
        .input-group-prepend {
            margin-right: 10px;
        }
        .btn-container {
            display: flex;
        }
    </style>

    <div class="container">
        
            <asp:ValidationSummary ID="vsSummary" runat="server" ForeColor="Red" />
            <div class="row align-items-center">
                <div class="col-md-3">
                    <br />
                    <div class="form-group">
                        <asp:Label ID="lblFullName" runat="server" Text="Full Name:"></asp:Label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
                    </div>
                </div>
                  <div class="col-md-3">
      <br />
      <div class="form-group">
          <asp:Label ID="lblContry" runat="server" Text="Country:"></asp:Label>
          <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" Placeholder="Country"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="txtCountry" ErrorMessage="Country Name is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
      </div>
  </div>
     <div class="col-md-3">
    <br />
    <div class="form-group">
        <asp:Label ID="lblcity" runat="server" Text="City:"></asp:Label>
        <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" Placeholder="City"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvcity" runat="server" ControlToValidate="txtcity" ErrorMessage="City Name is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
    </div>
</div>
                <div class="col-md-3">
                    <br />
                    <div class="form-group">
                        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ForeColor="Red" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ValidationGroup="RegistrationGroup" />
                    </div>
                </div>
               <asp:Label ID="lblErrorMessage" runat="server"> </asp:Label>
            </div>
            <div class="row align-items-center mt-2">
                <div class="col-md-4">
                   
                    <div class="form-group">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="8" Placeholder="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
                    </div>
                </div>
                <div class="col-md-4">
                    <br />
                    <div class="form-group">
                        <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="8" Placeholder="Confirm Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required" ForeColor="Red" ValidationGroup="RegistrationGroup" />
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ValidationGroup="RegistrationGroup" />
                    </div>
                </div>
                <div class="col-md-4">
                    <asp:HiddenField id="hdnmail" runat="server"/>
                    <div class="col-md-12 text-center btn-container align-items-center mt-4">
                        <div>
                            <asp:Button CssClass="btn btn-success" ID="btnRegister" runat="server" Text="Register" OnClick="btnSubmit_Click" ValidationGroup="RegistrationGroup" />
                        </div>
                    </div>
                </div>
            </div>
     
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>
