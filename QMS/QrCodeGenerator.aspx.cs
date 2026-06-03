using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using QRCoder;

namespace QMS
{
    public partial class QrCodeGenerator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"];
            string demail = DecodeFromBase64(email);
            int ccode = GetCompanyId(demail);

            // Define the bank name and code
            string bankCode = ccode.ToString();

            // Construct the URL
            string url = $"https://localhost:44326/firstpage.aspx?bc={bankCode}";

            // Generate QR code
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(url, QRCodeGenerator.ECCLevel.L);
            QRCode qrCode = new QRCode(qrCodeData);
            using (Bitmap qrCodeImage = qrCode.GetGraphic(20, Color.Black, Color.White, null))
            {
                // Save the image to a memory stream
                MemoryStream ms = new MemoryStream();
                qrCodeImage.Save(ms, ImageFormat.Png);

                // Store the image in a session variable
                Session["QrCodeImage"] = ms.ToArray();

                // Display the QR code on the page
                imgQrCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(ms.ToArray());
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            byte[] qrCodeImage = (byte[])Session["QrCodeImage"];
            Response.ContentType = "image/png";
            Response.AddHeader("Content-Disposition", "attachment; filename=qr_code.png");
            Response.BinaryWrite(qrCodeImage);
            Response.End();
        }

        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }

        private int GetCompanyId(string demail)
        {
            int newId = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT companycode FROM SignUp WHERE email = @email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", demail);

                    conn.Open();
                    newId = (int)cmd.ExecuteScalar();
                    conn.Close();
                }
            }

            return newId;
        }
    }
}