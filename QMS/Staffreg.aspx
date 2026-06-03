<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Staffreg.aspx.cs" Inherits="QMS.Staffreg" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
            &#9776;
        </button>
        <b style="font-size: 25px; margin-left: 35px;" class="text-center">Staff Registration</b>
        <img src="logo.jpg" alt="" style="border: 1px solid; border-radius: 50%; width: 50px; height: 50px; display: block;">
    </div>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 30px; 
        }
        h1 {
            color: #1384c9e0;
            text-align: center;
            margin-bottom: 30px;
        }
        .btn-primary {
            width: 100%;
        }
        .form-label {
            font-weight: bold;
        }
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
          .custom-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            text-align: left;
        }
        .custom-table thead {
            background-color: #17a2b8;
            color: #fff;
        }
        .custom-table th, .custom-table td {
            padding: 6px;
            border-bottom: 1px solid black; /* Solid black border */
        }
        .custom-table tbody tr:nth-child(odd) {
            background-color: #f9f9f9; /* Light gray background for odd rows */
        }
        .custom-table tbody tr:nth-child(even) {
            background-color: #fff; /* White background for even rows */
        }
        .custom-table tbody tr:hover {
            background-color: #e9ecef; /* Light gray background on row hover */
        }
        .custom-table th {
            font-weight: bold;
        }
        .custom-table td {
            color: #333; /* Default text color */
        }
        .custom-table td.highlight {
            color: #337ab7; 
    font-size: 20px
        }
       
  
    </style>

    <section>
        <div class="container">
            <h1>Employee Registration</h1>
            <asp:Panel ID="RegistrationPanel" runat="server">
                <asp:Form >
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblFirstName" runat="server" CssClass="form-label">First Name:</asp:Label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblLastName" runat="server" CssClass="form-label">Last Name:</asp:Label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblGender" runat="server" CssClass="form-label">Gender:</asp:Label>
                            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblDateOfBirth" runat="server" CssClass="form-label">Date of Birth:</asp:Label>
                            <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date" />
                            <asp:HiddenField id="hdnmail" runat="server"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <asp:Label ID="lblAddress" runat="server" CssClass="form-label">Address:</asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="1" />
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblPhone" runat="server" CssClass="form-label">Phone Number:</asp:Label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblEmail" runat="server" CssClass="form-label">Email:</asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <asp:Label ID="lblCountry" runat="server" CssClass="form-label">Country:</asp:Label>
                         <asp:DropDownList ID="countryDropDown" runat="server" CssClass="form-select" AutoPostBack="true" >
    <asp:ListItem Value="" Text="-Select-" />
    <asp:ListItem Value="AF" Text="Afghanistan" />
    <asp:ListItem Value="AL" Text="Albania" />
    <asp:ListItem Value="DE" Text="Germany" />
    <asp:ListItem Value="AR" Text="Argentina" />
    <asp:ListItem Value="AU" Text="Australia" />
    <asp:ListItem Value="AT" Text="Austria" />
    <asp:ListItem Value="BD" Text="Bangladesh" />
    <asp:ListItem Value="BE" Text="Belgium" />
    <asp:ListItem Value="BR" Text="Brazil" />
    <asp:ListItem Value="CA" Text="Canada" />
    <asp:ListItem Value="CN" Text="China" />
    <asp:ListItem Value="CO" Text="Colombia" />
    <asp:ListItem Value="DK" Text="Denmark" />
    <asp:ListItem Value="EG" Text="Egypt" />
    <asp:ListItem Value="FR" Text="France" />
    <asp:ListItem Value="GH" Text="Ghana" />
    <asp:ListItem Value="GR" Text="Greece" />
    <asp:ListItem Value="HK" Text="Hong Kong" />
    <asp:ListItem Value="HU" Text="Hungary" />
    <asp:ListItem Value="IN" Text="India" />
    <asp:ListItem Value="ID" Text="Indonesia" />
    <asp:ListItem Value="IE" Text="Ireland" />
    <asp:ListItem Value="IT" Text="Italy" />
    <asp:ListItem Value="JP" Text="Japan" />
    <asp:ListItem Value="KE" Text="Kenya" />
    <asp:ListItem Value="KR" Text="South Korea" />
    <asp:ListItem Value="MX" Text="Mexico" />
    <asp:ListItem Value="NG" Text="Nigeria" />
    <asp:ListItem Value="NL" Text="Netherlands" />
    <asp:ListItem Value="NZ" Text="New Zealand" />
    <asp:ListItem Value="NO" Text="Norway" />
    <asp:ListItem Value="PK" Text="Pakistan" />
    <asp:ListItem Value="PE" Text="Peru" />
    <asp:ListItem Value="PH" Text="Philippines" />
    <asp:ListItem Value="PT" Text="Portugal" />
    <asp:ListItem Value="RU" Text="Russia" />
    <asp:ListItem Value="SA" Text="Saudi Arabia" />
    <asp:ListItem Value="ZA" Text="South Africa" />

                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblCity" runat="server" CssClass="form-label">City:</asp:Label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblDepartment" runat="server" CssClass="form-label">Department:</asp:Label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">-Select-</asp:ListItem>
                                <asp:ListItem Value="IT">IT</asp:ListItem>
                                <asp:ListItem Value="Sales">Sales</asp:ListItem>
                                <asp:ListItem Value="Marketing">Marketing</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-3 mb-3">
                            <asp:Label ID="lblJobTitle" runat="server" CssClass="form-label">Job Title:</asp:Label>
                            <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3"></div>
                        
                        <div class="col-lg-6 text-center">
                            <asp:Button ID="SubmitButton" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="SubmitButton_Click" Style="background-color: #3093d0" />
                        </div>
                         <div class="col-lg-3"></div>
                    </div>
                </asp:Form>
            </asp:Panel>

            <h1 class="text-center mt-4 mb-4">Registered Staff</h1>
 <asp:Repeater ID="staffRepeater" runat="server">
            <HeaderTemplate>
                <table class="custom-table">
                    <thead >
                        <tr ">
                            <th style="border:solid black 1px; text-align:center;">ID</th>
                            <th style="border:solid black 1px; text-align:center;">First Name</th>
                            <th style="border:solid black 1px; text-align:center;">Last Name</th>
                            <th style="border:solid black 1px; text-align:center;">Gender</th>
                            <th style="border:solid black 1px; text-align:center;">Date of Birth</th>
                            <th style="border:solid black 1px; text-align:center;">Address</th>
                            <th style="border:solid black 1px;text-align:center;">Phone</th>
                            <th style="border:solid black 1px;text-align:center;">Email</th>
                            <th style="border:solid black 1px;text-align:center;">Country</th>
                            <th style="border:solid black 1px;text-align:center;">City</th>
                            <th style="border:solid black 1px;text-align:center;">Department</th>
                            <th style="border:solid black 1px;text-align:center;">Job Title</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="highlight"><%# Eval("Id") %></td>
                    <td><%# Eval("FirstName") %></td>
                    <td><%# Eval("LastName") %></td>
                    <td><%# Eval("Gender") %></td>
                    <td><%# Eval("DateOfBirth", "{0:yyyy-MM-dd}") %></td>
                    <td><%# Eval("Address") %></td>
                    <td><%# Eval("Phone") %></td>
                    <td><%# Eval("Email") %></td>
                    <td><%# Eval("Country") %></td>
                    <td><%# Eval("City") %></td>
                    <td><%# Eval("Department") %></td>
                    <td><%# Eval("JobTitle") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        </div>
    </section>
</asp:Content>
