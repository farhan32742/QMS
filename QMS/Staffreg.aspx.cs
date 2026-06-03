using System;

using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace QMS
{
    public partial class Staffreg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string email = Request.QueryString["email"];
                email = DecodeFromBase64(email);
                hdnmail.Value = email;
                LoadLatestStaffData();
            }
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Retrieve form values
            string firstName =txtFirstName.Text;
            string lastName = txtLastName.Text;
            string gender = ddlGender.Text;
            string dateOfBirth = txtDateOfBirth.Text;
            string address = txtAddress.Text;
            string phone = txtPhone.Text;
            string email = txtEmail.Text;
            string country = countryDropDown.Text;
            string city = txtCity.Text;
            string department = ddlDepartment.Text;
            string jobTitle = txtJobTitle.Text;
            int company_code = GetCompanyId(hdnmail.Value);

            // Connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO StaffRegistration (FirstName, LastName, Gender, DateOfBirth, Address, Phone, Email, Country, City, Department, JobTitle ,company_code) " +
                               "VALUES (@FirstName, @LastName, @Gender, @DateOfBirth, @Address, @Phone, @Email, @Country, @City, @Department, @JobTitle, @company_code)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FirstName", firstName);
                    command.Parameters.AddWithValue("@LastName", lastName);
                    command.Parameters.AddWithValue("@Gender", gender);
                    command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                    command.Parameters.AddWithValue("@Address", address);
                    command.Parameters.AddWithValue("@Phone", phone);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Country", country);
                    command.Parameters.AddWithValue("@City", city);
                    command.Parameters.AddWithValue("@Department", department);
                    command.Parameters.AddWithValue("@JobTitle", jobTitle);
                    command.Parameters.AddWithValue("@company_code", company_code);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        Response.Write("<script>alert('Registration Successful!');</script>");

                        // After successful insertion, clear the form and reload the latest staff data
                        ClearForm();
                        LoadLatestStaffData();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                    }
                }
            }
        }
        private int GetCompanyId(string email)
        {
            int newId = 0;
           // string email = (string)Session["EmailAddress"];
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT companycode FROM SignUp WHERE email = @email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", hdnmail.Value);

                    conn.Open();
                    newId = (int)cmd.ExecuteScalar();
                    conn.Close();
                }
            }

            return newId;
        }
        private void LoadLatestStaffData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM StaffRegistration ORDER BY Id DESC"; // Adjust the number as needed

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        DataTable dataTable = new DataTable();
                        dataTable.Load(reader);
                        staffRepeater.DataSource = dataTable;
                        staffRepeater.DataBind();
                    }
                }
            }
        }

        private void ClearForm()
        {
            // Clear TextBox controls
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtDateOfBirth.Text = ""; // Assuming this is a TextBox
            txtAddress.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtCity.Text = "";
            txtJobTitle.Text = "";

            // Clear DropDownList controls
            ddlGender.SelectedIndex = -1;
            countryDropDown.SelectedIndex = -1;
            ddlDepartment.SelectedIndex = -1;
        }

    }
}
