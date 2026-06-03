using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace QMS
{
    public partial class firstpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bankcode = Request.QueryString["bc"];
                hdnccode.Value = bankcode;
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtFirstName.Text) || string.IsNullOrEmpty(txtPhone.Text))
                {
                    // Display an error message to the user
                    lblError.Text = "Please fill in all required fields.";
                    return;
                }
                string connectionString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                int newId = GetNewIdForDate(currentDate, connectionString);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO registration (date, id, first_name, phone,company_code) VALUES (@date, @id, @first_name, @phone,@company_code)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@date", date);
                        cmd.Parameters.AddWithValue("@id", newId);
                        cmd.Parameters.AddWithValue("@first_name", txtFirstName.Text);
                        cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                        cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                // Redirect to another page
                string fullName = $"{txtFirstName.Text}";
                string bc = $"{hdnccode.Value}";
                Response.Redirect($"home.aspx?token={newId}&name={Server.UrlEncode(fullName)}&bc={Server.UrlEncode(bc)}");

            }
            catch(Exception ex)
            {
            }    
        }
        private int GetNewIdForDate(DateTime date, string connectionString)
        {
            int newId = 1;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT ISNULL(MAX(id), 0) + 1 FROM registration WHERE date = @date and company_code=@company_code";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@date", date.ToString("yyyy-MM-dd"));
                        cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);

                        conn.Open();
                        newId = (int)cmd.ExecuteScalar();
                        conn.Close();
                    }
                }
                return newId;
            }
            catch(Exception ex)
            {
                return newId;
            }
           
        }
        protected void btnSkip_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                int newId = GetNewIdForDate(currentDate, connectionString);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO registration (date, id, first_name, phone,company_code) VALUES (@date, @id, @first_name, @phone,@company_code)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@date", date);
                        cmd.Parameters.AddWithValue("@id", newId);
                        cmd.Parameters.AddWithValue("@first_name", DBNull.Value);
                        cmd.Parameters.AddWithValue("@phone", DBNull.Value);
                        cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                // Redirect to another page
                string fullName = $"{txtFirstName.Text}";
                string bc = $"{hdnccode.Value}";
                Response.Redirect($"home.aspx?token={newId}&name={Server.UrlEncode(fullName)}&bc={Server.UrlEncode(bc)}");

            }
            catch (Exception ex)
            {

            }
           
        }
    }
}
