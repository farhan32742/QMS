<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProgressReport.aspx.cs" Inherits="QMS.ProgressReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
       <asp:Button CssClass="navbar-toggler d-lg-none" ID="btnToggle" runat="server" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation" Text="&#9776;" />
       <asp:Label CssClass="text-center" ID="lblTitle" runat="server" Text="Progress Report" Font-Size="25px" style="margin-left: 35px;"></asp:Label>
       <asp:Image CssClass="img-fluid" ID="imgLogo" runat="server" ImageUrl="logo.jpg" AlternateText="" style="border: 1px solid; border-radius: 50%; width: 50px; height: 50px; display: block;" />
   </div>
    <style>
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
        .container {
            margin-top: 20px;
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            width: 100px;
            height: auto;
            border: 1px solid rebeccapurple;
            border-radius: 50%;
        }

    </style>

    <section>
        <div class="container-fluid">
     <div class="row mt-4">
    <div class="col-3">
        <div class="input-group mb-3">
            <asp:Label AssociatedControlID="startDate" CssClass="input-group-text" runat="server">Start Date:</asp:Label>
            <asp:TextBox ID="startDate" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
        </div>
    </div>
    <div class="col-3">
        <div class="input-group mb-3">
            <asp:Label AssociatedControlID="endDate" CssClass="input-group-text" runat="server">End Date:</asp:Label>
            <asp:TextBox ID="endDate" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
        </div>
    </div>

  <div class="col-3">
      <asp:HiddenField id="hdnmail" runat="server"/>
   <div class="input-group mb-3">
    <asp:Label AssociatedControlID="loginpersonid" CssClass="input-group-text" runat="server">Name:</asp:Label>
    <asp:DropDownList ID="loginpersonid" CssClass="form-control" runat="server" />
</div>
</div>
    <div class="col-3">
        <asp:Button ID="showButton" CssClass="btn btn-success btn-block" runat="server" Text="Show" OnClick="show" />
        <asp:Button ID="printButton" CssClass="btn btn-primary btn-block" runat="server" Text="Print" OnClientClick="printDiv(); return false;" />
    </div>
</div>
            <div id="divToPrint"  >
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
        <table>
            <thead>
                <tr>
                    <td style="text-align:center;">PROGRESS REPORT</td>
                </tr>
            </thead>
            <tbody style="margin-top: 10px;">
                <tr style="font-size: 20px;">
                 <td><%= ShowName() %></td>
                    <td id="printDate">Print Date:</td>
                </tr>
                <tr style="margin-top: 15px; font-size: 20px;">
                   <td><%= startDate.Text %>/<%= endDate.Text %></td>
                </tr>
            </tbody>
        </table>
    </div>
</section>

                   <div class="row" style="margin-top:30px; margin-left:10px; margin-right:10px;"> 
             <asp:Repeater ID="rptAttendance" runat="server">
    <HeaderTemplate>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>Sr#</th>
                    <th>LogIn Id</th>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Total served</th>
                     <th>Serving time/person</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Container.ItemIndex+1 %></td>
             <td><%# Eval("loginid") %></td>
            <td><%# Eval("date") %></td>
            <td><%# Eval("fullname") %></td>
            <td><%# Eval("CountOfClosedStatus") %></td>
            <td><%# Eval("AvgRunningTime") %></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

   </div>  
            </div>
        </div>
    </section>
 
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

            var currentDate = new Date();
            document.getElementById("printDate").innerHTML = "Print Date: " + currentDate.toLocaleDateString();
  
    </script>
</asp:Content>
