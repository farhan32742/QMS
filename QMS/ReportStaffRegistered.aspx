<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportStaffRegistered.aspx.cs" Inherits="QMS.ReportStaffRegistered" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
        <asp:Button CssClass="navbar-toggler d-lg-none" ID="btnToggle" runat="server" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation" Text="&#9776;" />
        <asp:Label CssClass="text-center" ID="lblTitle" runat="server" Text="Staff Report" Font-Size="25px" style="margin-left: 35px;"></asp:Label>
        <asp:Image CssClass="img-fluid" ID="imgLogo" runat="server" ImageUrl="logo.jpg" AlternateText="" style="border: 1px solid; border-radius: 50%; width: 50px; height: 50px; display: block;" />
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

    <div class="container">
    <div class="row align-items-center">
        <div class="col-md-4">
            <div class="form-group">
                <asp:Label ID="lblFirstName" runat="server" Text="First Name:"></asp:Label>
                <asp:TextBox CssClass="form-control" ID="txtFirstName" runat="server" placeholder="Enter Your First Name"></asp:TextBox>
            </div>
        </div>
        <div class="col-md-4">
            <asp:HiddenField  ID = "hdnmail" runat = "server"/>
            <div class="form-group">
                <asp:Label ID="lblLastName" runat="server" Text="Last Name:"></asp:Label>
                <asp:TextBox CssClass="form-control" ID="txtLastName" runat="server" placeholder="Enter Your Last Name"></asp:TextBox>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <asp:Label ID="lblDepartment" runat="server" Text="Department:"></asp:Label>
                <asp:DropDownList CssClass="form-control" ID="ddlDepartment" runat="server">
                    <asp:ListItem Value="NULL" Text="--select--"></asp:ListItem>
                    <asp:ListItem Value="IT" Text="IT"></asp:ListItem>
                    <asp:ListItem Value="Sales" Text="Sales"></asp:ListItem>
                    <asp:ListItem Value="Marketing" Text="Marketing"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div class="row align-items-center mt-4">
        
        <div class="col-md-4">
            <div class="form-group">
                <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                <asp:DropDownList CssClass="form-control" ID="ddlGender" runat="server">
                    <asp:ListItem Value="NULL" Text="--select--"></asp:ListItem>
                    <asp:ListItem Value="Male" Text="Male"></asp:ListItem>
                    <asp:ListItem Value="Female" Text="Female"></asp:ListItem>
                   
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of Birth:"></asp:Label>
                <asp:TextBox CssClass="form-control" ID="txtDateOfBirth" runat="server" placeholder="Enter Your Date of Birth" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <div class="col-md-4">
  <div class="col-md-12 text-center btn-container align-items-center mt-4">
      <div>
    <asp:Button CssClass="btn btn-success" ID="btnShow" runat="server" Text="Show" OnClick =" btnShow_Click" />
     </div>
      <div style="margin-left:8px;"> 
      <asp:Button ID="printButton" CssClass="btn btn-primary btn-block" runat="server" Text="Print" OnClientClick="printDiv(); return false;" />
</div>
      </div>
</div>
    </div>
          <div class="row" style="margin-top:30px" id="divToPrint"> 
     <style>
     table {
  width: 100%;
}

 table thead tr td {
  text-align: center;
  font-weight: bold;
   vertical-align: middle;
   font-size: 25px;
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

@media print {
    #printSection {
        display: block;
    }
}

@media screen {
    #printSection {
        display: none;
    }
}
     
    </style>   
    <section id="printSection">
    <div class="container"> 
        <table style="margin-top:10px;">
            <thead>
                <tr>
                    <td style="text-align:center;">PROGRESS REPORT</td>
                </tr>
            </thead>
            <tbody style="margin-top: 10px;">
                <tr style="font-size: 20px;">
                 <td>User Name: <%= ShowName() %></td>
                   <td id="printDate">Print Date:</td>
                </tr>
              
            </tbody>
        </table>
    </div>
</section>
 <asp:Repeater ID="staffRepeater" runat="server">
    <HeaderTemplate>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Date of Birth</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Country</th>
                    <th>City</th>
                    <th>Department</th>
                    <th>Job Title</th>
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
    
</div>
  
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
      <script>
      function printDiv() {
          var divToPrint = document.getElementById('divToPrint');
        
          var newWin = window.open('', '', '');
          newWin.document.write('<html><head><title>Print Page</title>');
          newWin.document.write('</head><body>');
          newWin.document.write(divToPrint.innerHTML);
          newWin.document.write('</body></html>');
          newWin.print();
          newWin.close();
      }

         

      </script>
</asp:Content>
