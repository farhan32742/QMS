// ResetPassword.aspx.cs
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;

namespace QMS
{
    public partial class ResetPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Add any initialization logic here
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (newPassword != confirmPassword)
            {
                // Display an error message if passwords do not match
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passwords do not match. ');", true);
                return;
            }

            string email = Request.QueryString["email"]; // Get the email from the query string
            if (string.IsNullOrEmpty(email))
            {
                // Display an error message if email is not provided
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid request. ');", true);
                return;
            }

            // Update the password in the database
            if (UpdatePassword(email, newPassword))
            {
                // Redirect to a success page or login page
                Response.Redirect("SignIn.aspx");
            }
            else
            {
                // Display an error message if the password update fails
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error updating password. ');", true);
            }
        }

        private bool UpdatePassword(string email, string newPassword)
        {
            bool isUpdated = false;

            // Hash the new password before storing it
            byte[] salt = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }
            string hashedPassword = HashPassword(newPassword, salt);

            // Store the salt value and hashed password in the database
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE SignUp SET Password = @Password, OTP = NULL WHERE Email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", Convert.ToBase64String(salt) + ":" + hashedPassword);
                    cmd.Parameters.AddWithValue("@Email", email);
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        isUpdated = true;
                    }
                }
            }

            return isUpdated;
        }

        private string HashPassword(string password, byte[] salt)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000))
            {
                byte[] hash = pbkdf2.GetBytes(20);
                return Convert.ToBase64String(hash);
            }
        }

        private string HashPassword(string password)
        {
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);

            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);

            string hashedPassword = Convert.ToBase64String(hashBytes);
            return hashedPassword;
        }
    }
}