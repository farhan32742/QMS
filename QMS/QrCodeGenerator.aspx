<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QrCodeGenerator.aspx.cs" Inherits="QMS.QrCodeGenerator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style>
        .hover-orange:hover {
    background-color: #ffa07a; /* orange color */
    border-color: #ffa07a;
    color: #ffffff; /* white text color */
}
    </style>
    <form id="form1" runat="server">
        <div style="text-align: center;">
            <asp:Image ID="imgQrCode" runat="server" />
            
            <div class="row text-center ">
 <div class="col-md-3 ">
</div>
    <div class="col-md-6 text-center align-items-center" style="text-align: center;">
    <asp:Button ID="btnDownload" runat="server" Text="Download QR Code" OnClick="btnDownload_Click" 
        CssClass="btn btn-lg btn-primary btn-block hover-orange" 
        style="font-size: 24px; padding: 10px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
    </asp:Button>
</div>
                 <div class="col-md-3">
</div>
            </div>
       <%--    <asp:Button ID="btnDownload" runat="server" Text="Download QR Code" OnClick="btnDownload_Click" />--%>
   
        </div>
            </form>
</body>
</html>
