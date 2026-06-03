using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class ReportsMainPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
        //protected void LinkButton1_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("ProgressReport.aspx?email=" + mail.Value);
        //}

        //protected void LinkButton2_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("AttendanceReport.aspx?email=" + mail.Value);
        //}

        //protected void LinkButton3_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("ReportStaffRegistered.aspx?email=" + mail.Value);
        //}

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("ProgressReport.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("AttendanceReport.aspx?email=" + HttpUtility.UrlEncode(email));
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            string encodedEmail = mail.Value;
            string email = DecodeFromBase64(encodedEmail);
            Response.Redirect("ReportStaffRegistered.aspx?email=" + HttpUtility.UrlEncode(email));
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
    }
}