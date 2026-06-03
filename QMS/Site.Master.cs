using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string email = Request.QueryString["email"];
                //mail.Value = email;
                string email = Request.QueryString["email"];
                if (!string.IsNullOrEmpty(email))
                {
                    // Encode the email to Base64
                    string encodedEmail = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(email));
                    mail.Value = encodedEmail;
                }
            }
        }

        //protected void lnkDashboard_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("dashboard.aspx?email="+mail.Value);
        //}

        //protected void lnkReports_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("ReportsMainPage.aspx?email="+mail.Value);
        //}

        //protected void lnkStaffRegistration_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("Staffreg.aspx?email="+mail.Value);
        //}

        //protected void lnkAttendance_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("Attendance.aspx?email=" + mail.Value);
        //}
        //protected void lnkUserRegistration_Click(object sender, EventArgs e)
        //{

        //    Response.Redirect("UserRegistration.aspx?email=" + mail.Value);
        //}
        protected void lnkDashboard_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("dashboard.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void lnkReports_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("ReportsMainPage.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void lnkStaffRegistration_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("Staffreg.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void lnkAttendance_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("Attendance.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void lnkUserRegistration_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("UserRegistration.aspx?email=" + HttpUtility.UrlEncode(email));
        }
        protected void lnkqrcode_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("QrCodeGenerator.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        public string GetBankName()
        {
            string bankName = string.Empty;
            //string email = (string)Session["EmailAddress"];
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT bankName FROM BankRegistration WHERE email = @email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", mail.Value);

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        bankName = result.ToString();
                    }
                    conn.Close();
                }
            }

            return bankName;
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
    }
}