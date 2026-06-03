using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Net.Mail;
using System.Net;

namespace QMS
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Add any initialization logic here
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                Session["Email"] = email;

                // Generate an OTP
                string otp = GenerateOTP();

                // Store the OTP in the database
                StoreOTPInDatabase(email, otp);

                // Send the OTP to the user's email
                SendOTPEmail(email, otp);

                enterOtpSection.Style.Add("display", "block");
                resetPasswordSection.Style.Add("display", "none");
            }
            catch (Exception ex)
            {

            }
  
        }

        private bool CheckIfEmailExists(string email)
        {
            try
            {
                bool emailExists = false;

                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT COUNT(1) FROM SignUp WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        int count = (int)cmd.ExecuteScalar();
                        emailExists = count > 0;
                    }
                }

                return emailExists;
            }
            catch
            { 
                return false;  
            }

           
        }

        private string GenerateOTP()
        {
            // Generate a random 6-digit OTP
            Random random = new Random();
            string otp = random.Next(100000, 999999).ToString();
            return otp;
        }

        private void SendOTPEmail(string email, string otp)
        {
            try
            {
                string smtpServer = ConfigurationManager.AppSettings["smtpServer"];
                string smtpPort = ConfigurationManager.AppSettings["smtpPort"];
                string fromEmail = ConfigurationManager.AppSettings["fromEmail"];
                string fromPassword = ConfigurationManager.AppSettings["fromPassword"];

                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.From = new MailAddress(fromEmail);
                mail.Subject = "OTP for Password Reset";
                mail.Body = $"Your OTP is: {otp}";

                SmtpClient smtp = new SmtpClient();
                smtp.Host = smtpServer;
                smtp.Port = int.Parse(smtpPort);
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential(fromEmail, fromPassword);
                smtp.Send(mail);
            }
            catch
            {

            } 
          
        }

        private void StoreOTPInDatabase(string email, string otp)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "UPDATE SignUp SET OTP = @OTP WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@OTP", otp);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch 
            {

            }

          
        }
        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            try
            {
                string email = (string)Session["Email"];
                string otp = txtOTP.Text.Trim();

                // Check if the email exists in the database
                if (CheckIfEmailExists(email))
                {
                    // Get the OTP from the database
                    string storedOtp = GetOTPFromDatabase(email);

                    if (otp == storedOtp)
                    {
                        // Redirect to ResetPassword.aspx
                        Response.Redirect("ResetPassword.aspx", true);
                    }
                    else
                    {
                        // Display an error message
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid OTP.');", true);
                    }
                }
                else
                {
                    // Display an error message if the email is not found
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email address not found.');", true);
                }
            }
            catch
            { 
            }
       
        }
        private string GetOTPFromDatabase(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string otp = string.Empty;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT OTP FROM SignUp WHERE Email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    object result = cmd.ExecuteScalar();
                    otp = result != null ? result.ToString() : string.Empty;
                }
            }

            return otp;
        }

    }
}