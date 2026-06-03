using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class UserRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"];
            email = DecodeFromBase64(email);
            hdnmail.Value = email;
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
     int companycode =GetCompanyId(hdnmail.Value);
            string email = txtEmail.Text.Trim();
            string country = txtCountry.Text.Trim();
            string city = txtcity.Text.Trim();  
            string password = txtPassword.Text.Trim();

            // Check if email already exists in database
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

                    if (emailCount > 0)
                    {
                        // Email already exists, show error message
                        lblErrorMessage.Text = "This email is already registered. Please use a different email.";
                        lblErrorMessage.Visible = true;
                        return;
                    }
                    else
                    {
                        // Email doesn't exist, generate salt and hash password
                        byte[] salt = new byte[16];
                        using (var rng = RandomNumberGenerator.Create())
                        {
                            rng.GetBytes(salt);
                        }

                        string hashedPassword = HashPassword(password, salt);

                        // Insert record into database
                        query = "INSERT INTO SignUp (FullName, Email, Password,companycode,country,city) VALUES (@FullName, @Email, @Password, @companycode, @country, @city)";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", Convert.ToBase64String(salt) + ":" + hashedPassword);
                        cmd.Parameters.AddWithValue("@companycode", companycode);
                        cmd.Parameters.AddWithValue("@country", country);
                        cmd.Parameters.AddWithValue("@city", city);

                        cmd.ExecuteNonQuery();



                        // Redirect to signIn.aspx page
                        // Response.Redirect("signIn.aspx");
                        Response.Write("<script>alert('Registration Successful!');</script>");
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
        private int GetCompanyId(string email)
        {
            int newId = 0;
            //string email = (string)Session["EmailAddress"];
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT comapnycode FROM BankRegistration WHERE email = @email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", email);

                    conn.Open();
                    newId = (int)cmd.ExecuteScalar();
                    conn.Close();
                }
            }

            return newId;
        }
    }
}