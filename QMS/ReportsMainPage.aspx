<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportsMainPage.aspx.cs" Inherits="QMS.ReportsMainPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center p-3" style="background-color: #dbe2f0;">
        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
            &#9776;
        </button>
        <b style="font-size: 25px; margin-left: 35px;" class="text-center">Reports</b>
        <img src="logo.jpg" alt="" style="border: 1px solid; border-radius: 50%; width: 50px; height: 50px; display: block;">
    </div>

    <style>
       .report-card {
            border: 2px solid #f6cd92;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
            transition: transform 0.3s;
            background-color:aliceblue;
        }
       .report-card:hover {
            transform: scale(1.05);
            cursor: pointer;
        }
       .report-card img {
            width: 50px;
            height: 50px;
            border-radius:50%;
            border: 1px solid darkred;
            
        }
      .btn-decor-none {
  text-decoration:none;
  color: black;
}
    </style>

    <div class="container mt-5">
        <div class="tab-content mt-3">
            <div class="tab-pane fade show active" id="restaurant" role="tabpanel" aria-labelledby="restaurant-tab">
                <div class="row">
                    <div class="col-md-4">
                        <asp:LinkButton ID="LinkButton1" runat="server"  CssClass="btn-decor-none" OnClick="LinkButton1_Click">
                            <div class="report-card">
                                <img src="login and logout.jpg" alt="QMS">
                                <h5>Progress Report</h5>
                            </div>
                        </asp:LinkButton>
                    </div>
                    <div class="col-md-4">
                        <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass="btn-decor-none">
                            <div class="report-card">
                                <img src="login and logout.jpg" alt="QMS">
                                <h5>Attendance Report</h5>
                            </div>
                        </asp:LinkButton>
                    </div>
                    <div class="col-md-4">
                        <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CssClass="btn-decor-none">
                            <div class="report-card">
                                <img src="login and logout.jpg" alt="QMS">
                                <h5>Staff Report</h5>
                            </div>
                        </asp:LinkButton>
                        <asp:HiddenField id="mail" runat="server"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>