<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="QMS.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
            &#9776;
        </button>
        <b style="font-size: 25px; margin-left: 35px;" class="text-center">Attendance</b>
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
        .form-label {
            font-weight: bold;
        }
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
        .btn-primary {
    width: 100%;
}
         .repeater-header {
            background-color: #e9ecef;
            font-weight: bold;
            border-bottom: 2px solid #dee2e6;
            padding: 10px;
        }
        .repeater-item {
            border-bottom: 1px solid #dee2e6;
            padding: 10px;
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
            border: 1px solid #ddd;
        }
      
        .custom-table th {
            font-weight: bold;
        }
         .custom-table tbody tr:nth-child(odd) {
            background-color: #f9f9f9; /* Light gray background for odd rows */
        }
        .custom-table tbody tr:nth-child(even) {
            background-color: #fff; /* White background for even rows */
        }
        #btnSave{
            color:#9fbcdc;
        }
    
    </style>
    
    <section>
        <div class="container">
            <h1>Attendance</h1>
            <asp:Panel ID="AttendanceFormPanel" runat="server">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="employeeId" class="form-label">Employee Id:</label>
                        <asp:TextBox ID="txtEmployeeId" runat="server" CssClass="form-control" placeholder="ABC123" />
                    </div>
                    <div class="col-md-3 mb-3">
                        <asp:HiddenField id ="hdnmail" runat="server"/>
                        <label for="fullName" class="form-label">Full name:</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="gender" class="form-label">Gender:</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Male">Male</asp:ListItem>
                            <asp:ListItem Value="Female">Female</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="date" class="form-label">Date:</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
               
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="status" class="form-label">Attendance Status:</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">-Select-</asp:ListItem>
                            <asp:ListItem Value="Present">Present</asp:ListItem>
                            <asp:ListItem Value="Absent">Absent</asp:ListItem>
                            <asp:ListItem Value="Late">Late</asp:ListItem>
                            <asp:ListItem Value="Leave">Leave</asp:ListItem>
                            <asp:ListItem Value="Holiday">Holiday</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                
                    <div class="col-md-3 mb-3">
                        <label for="department" class="form-label">Department:</label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">-Select-</asp:ListItem>
                            <asp:ListItem Value="IT">IT</asp:ListItem>
                            <asp:ListItem Value="Sales">Sales</asp:ListItem>
                            <asp:ListItem Value="Marketing">Marketing</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="checkInTime" class="form-label">Check-In Time:</label>
                        <asp:TextBox ID="txtCheckInTime" runat="server" CssClass="form-control" TextMode="Time" />
                    </div>
                     <div class="col-md-3 mb-3 justify-content-center">
                         <br /> 
                         
   <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary mx-2" OnClick="btnSave_Click" Style="background-color: #3093d0" />
       </div>
                </div>
               
                <asp:Label ID="successLabel" runat="server" ForeColor="Green" />
                <asp:Label ID="errorLabel" runat="server" ForeColor="Red" />
            </asp:Panel>
        

                <asp:Label ID="Label1" runat="server" ForeColor="Green" />
                <asp:Label ID="Label2" runat="server" ForeColor="Red" />
            
            <div style="margin-top:30px"> 
                     <asp:Repeater ID="rptAttendance" runat="server">
            <HeaderTemplate>
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>Employee Id</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Department</th>
                            <th>Check-In-Time</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("EmployeeId") %></td>
                    <td><%# Eval("FullName") %></td>
                    <td><%# Eval("Gender") %></td>
                    <td><%# Eval("Date", "{0:yyyy-MM-dd}") %></td>
                    <td><%# Eval("Status") %></td>
                    <td><%# Eval("Department") %></td>
                    <td><%# Eval("CheckInTime") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

           </div>  
       </div>
    </section>
</asp:Content>
