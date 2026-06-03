using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class ReportStaffRegistered : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"];
            email = DecodeFromBase64(email);
            hdnmail.Value = email;
        }
        protected void btnShow_Click(object sender, EventArgs e)
        {
            LoadStaffData();
        }
        private void LoadStaffData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM StaffRegistration WHERE 1=1";

                if (!string.IsNullOrEmpty(txtFirstName.Text))
                {
                    query += " AND FirstName LIKE @FirstName";
                }

                if (!string.IsNullOrEmpty(txtLastName.Text))
                {
                    query += " AND LastName LIKE @LastName";
                }

                if (ddlDepartment.SelectedValue != "NULL")
                {
                    query += " AND Department = @Department";
                }

                if (ddlGender.SelectedValue != "NULL")
                {
                    query += " AND Gender = @Gender";
                }

                if (!string.IsNullOrEmpty(txtDateOfBirth.Text))
                {
                    query += " AND DateOfBirth = @DateOfBirth";
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (!string.IsNullOrEmpty(txtFirstName.Text))
                    {
                        command.Parameters.AddWithValue("@FirstName", "%" + txtFirstName.Text + "%");
                    }

                    if (!string.IsNullOrEmpty(txtLastName.Text))
                    {
                        command.Parameters.AddWithValue("@LastName", "%" + txtLastName.Text + "%");
                    }

                    if (ddlDepartment.SelectedValue != "NULL")
                    {
                        command.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                    }

                    if (ddlGender.SelectedValue != "NULL")
                    {
                        command.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                    }

                    if (!string.IsNullOrEmpty(txtDateOfBirth.Text))
                    {
                        command.Parameters.AddWithValue("@DateOfBirth", txtDateOfBirth.Text);
                    }

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
        private int GetCompanyId(string email)
        {
            int newId = 0;
            //string email = (string)Session["EmailAddress"];
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
        protected string ShowName()
        {
            int company_code = GetCompanyId(hdnmail.Value);
           // string email = Request.QueryString["email"];
            int personid = GetPersonId(hdnmail.Value);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string name = string.Empty;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT s.FullName
                         FROM CounterSelection cs
                         INNER JOIN SignUp s ON cs.PersonId = s.UserID
                         WHERE cs.Id = @personid and cs.company_code = @company_code";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@personid", personid);
                    command.Parameters.AddWithValue("@company_code", company_code);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        name = reader["FullName"].ToString();
                    }
                }
            }

            return name;
        }
        protected int GetPersonId(string email)
        {
            //email = DecodeFromBase64(email);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM SignUp WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", hdnmail.Value);

                try
                {
                    conn.Open();
                    int personId = (int)cmd.ExecuteScalar();


                    return personId;
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                    return 0;
                }
            }
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
    }
}