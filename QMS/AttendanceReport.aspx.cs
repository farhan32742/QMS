using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS
{
    public partial class AttendanceReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string email = Request.QueryString["email"];
                email = DecodeFromBase64(email);
                hdnmail.Value = email;
            }
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {

            LoadAttendanceData(txtFullName.Text, ddlDepartment.SelectedValue);
        }

        private void LoadAttendanceData(string fullName, string department)
        {
            int company_code = GetCompanyId(hdnmail.Value);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                string query;
                if (string.IsNullOrEmpty(fullName))
                {
                    query = "SELECT * FROM Attendance WHERE Department = @Department and company_code=@company_code";
                }
                else
                {
                    query = "SELECT * FROM Attendance WHERE FullName LIKE @FullName AND Department = @Department and company_code=@company_code";
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FullName", "%" + fullName + "%");
                    command.Parameters.AddWithValue("@Department", department);
                    command.Parameters.AddWithValue("@company_code", company_code);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        DataTable dataTable = new DataTable();
                        dataTable.Load(reader);
                        rptAttendance.DataSource = dataTable;
                        rptAttendance.DataBind();
                    }
                    else
                    {
                        rptAttendance.DataSource = null;
                        rptAttendance.DataBind();
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
                         WHERE cs.Id = @personid and company_code=@company_code";

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
            int companycode = GetCompanyId(hdnmail.Value);
           // email = DecodeFromBase64(email);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM SignUp WHERE Email = @Email and companycode = @cpmapnycode";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", hdnmail.Value);
                cmd.Parameters.AddWithValue("@companycode", companycode);

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