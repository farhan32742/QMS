using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class signUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic if needed
        }
        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCountry = ddlCountry.SelectedValue;
            ddlCity.Items.Clear();
            ddlCity.Items.Add(new ListItem("Select City", ""));

            if (selectedCountry == "Pakistan")
            {
                ddlCity.Items.Add(new ListItem("Karachi", "Karachi"));
                ddlCity.Items.Add(new ListItem("Lahore", "Lahore"));
                ddlCity.Items.Add(new ListItem("Islamabad", "Islamabad"));
                // Add more cities for Pakistan here
            }
            else if (selectedCountry == "UK")
            {
                ddlCity.Items.Add(new ListItem("London", "London"));
                ddlCity.Items.Add(new ListItem("Manchester", "Manchester"));
                ddlCity.Items.Add(new ListItem("Birmingham", "Birmingham"));
                // Add more cities for UK here
            }
            else if (selectedCountry == "USA")
            {
                ddlCity.Items.Add(new ListItem("New York", "New York"));
                ddlCity.Items.Add(new ListItem("Los Angeles", "Los Angeles"));
                ddlCity.Items.Add(new ListItem("Chicago", "Chicago"));
                // Add more cities for USA here
            }
            // Add more countries and cities here
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string bankName = bnkname.Text.Trim();
            string countryName = ddlCountry.SelectedItem.Value;
            string cityName = ddlCity.SelectedItem.Value;
            string branchCode = codeNumber.Text.Trim();
            int companyCode = GetCompanyId();
 
            // Check if email already exists in database
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if email exists in BankRegistration table
                string query = "SELECT COUNT(*) FROM BankRegistration WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                int emailCountBankRegistration = (int)cmd.ExecuteScalar();

                // Check if email exists in SignUp table
                query = "SELECT COUNT(*) FROM SignUp WHERE Email = @Email";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                int emailCountSignUp = (int)cmd.ExecuteScalar();

                if (emailCountBankRegistration > 0 || emailCountSignUp > 0)
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
                    query = "INSERT INTO BankRegistration (Fullname, email,bankName,countryName,cityName,BranchCode,comapnycode, bankpassword,UserRole) VALUES (@Fullname, @email,@bankName,@countryName,@cityName,@BranchCode,@comapnycode, @bankpassword,'Bank')";
                    cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Fullname", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@bankName", bankName);
                    cmd.Parameters.AddWithValue("@countryName", countryName);
                    cmd.Parameters.AddWithValue("@cityName", cityName);
                    cmd.Parameters.AddWithValue("@BranchCode", branchCode);
                    cmd.Parameters.AddWithValue("@comapnycode", companyCode);
                    cmd.Parameters.AddWithValue("@bankpassword", Convert.ToBase64String(salt) + ":" + hashedPassword);

                    cmd.ExecuteNonQuery();

                    query = "INSERT INTO SignUp (FullName, Email, Password,companycode,personRole, country, city) VALUES (@FullName, @Email, @Password, @companycode,'Bank',@country, @city)";
                    SqlCommand cmd1 = new SqlCommand(query, conn);
                    cmd1.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd1.Parameters.AddWithValue("@Email", email);
                    cmd1.Parameters.AddWithValue("@Password", Convert.ToBase64String(salt) + ":" + hashedPassword);
                    cmd1.Parameters.AddWithValue("@companycode", companyCode);
                    cmd1.Parameters.AddWithValue("@country", countryName);
                    cmd1.Parameters.AddWithValue("@city", cityName);

                    cmd1.ExecuteNonQuery();

                    // Redirect to signIn.aspx page
                    Response.Redirect("signIn.aspx", false);
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
        private int GetCompanyId()
        {
            int newId = 0;
            string email = txtEmail.Text.Trim();
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(comapnycode), 0) + 1 FROM BankRegistration";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                   

                    conn.Open();
                    newId = (int)cmd.ExecuteScalar();
                    conn.Close();
                }
            }

            return newId;
        }

    }
}