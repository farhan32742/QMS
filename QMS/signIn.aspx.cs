using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Web;

namespace QMS
{
    public partial class signIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // Session["EmailAddress"] = txtEmail.Text.Trim();
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
           // StoreEmailInDatabase(email);
            // Check if email exists in database
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM SignUp WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    conn.Open();
                    int emailCount = (int)cmd.ExecuteScalar();

                    if (emailCount == 0)
                    {
                        // Email does not exist, show message to sign up and register
                        ShowErrorMessage("Email does not exist. Please sign up and register yourself.");
                        return;
                    }
                    else
                    {
                        // Email exists, retrieve the hashed password (with salt) from the database
                        query = "SELECT Password FROM SignUp WHERE Email = @Email";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Email", email);

                        string storedPassword = (string)cmd.ExecuteScalar();

                        // Extract the salt value from the stored password
                        string[] parts = storedPassword.Split(':');
                        byte[] salt = Convert.FromBase64String(parts[0]);
                        string storedHash = parts[1];

                        // Hash the input password with the extracted salt value
                        string hashedPassword = HashPassword(password, salt);

                        // Compare the hashed password with the stored hashed password
                        if (hashedPassword == storedHash)
                        {
                            email = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(email));
                            Response.Redirect($"dashboard.aspx?email={email}");
                        }
                        else
                        {
                            // Password does not match, show error message
                            ShowErrorMessage("Invalid password.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }
     
        private string HashPassword(string password, byte[] salt)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000))
            {
                byte[] hash = pbkdf2.GetBytes(20);
                return Convert.ToBase64String(hash);
            }
        }
  
        private void ShowErrorMessage(string message)
        {
            // Display error message to the user
            lblErrorMessage.Text = message;
            lblErrorMessage.Visible = true;
        }
        // Method to hash input password
        private string GetHashedPassword(string password)
        {
            // Use a hashing algorithm like SHA256 or bcrypt to hash the password
            // For example, using SHA256:
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(bytes).Replace("-", "").ToLower();
            }
        }
        private void StoreEmailInDatabase(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Signin (Email) VALUES (@Email)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }
    }
}
