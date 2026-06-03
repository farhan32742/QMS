using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QMS
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string email = Request.QueryString["email"];
                email = DecodeFromBase64(email);
                hdnmail.Value = email;
                LoadAttendanceData();
            }
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Retrieve form values
            string employeeId = txtEmployeeId.Text;
            string fullName = txtFullName.Text;
            string gender = ddlGender.SelectedValue;
            string date = txtDate.Text;
            string status = ddlStatus.SelectedValue;
            string department = ddlDepartment.SelectedValue;
            string checkInTime = txtCheckInTime.Text;
            int company_code = GetCompanyId(hdnmail.Value);

            // Connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Attendance (EmployeeId, FullName, Gender, Date, Status, Department, CheckInTime,company_code) " +
                               "VALUES (@EmployeeId, @FullName, @Gender, @Date, @Status, @Department, @CheckInTime, @company_code)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@EmployeeId", employeeId);
                    command.Parameters.AddWithValue("@FullName", fullName);
                    command.Parameters.AddWithValue("@Gender", gender);
                    command.Parameters.AddWithValue("@Date", date);
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@Department", department);
                    command.Parameters.AddWithValue("@CheckInTime", checkInTime);
                    command.Parameters.AddWithValue("@company_code", company_code);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        successLabel.Text = "Attendance saved successfully!";
                        successLabel.Visible = true;
                        errorLabel.Visible = false;

                        // After successful insertion, clear the form and reload attendance data
                        ClearForm();
                        LoadAttendanceData();
                    }
                    catch (Exception ex)
                    {
                        errorLabel.Text = "Error: " + ex.Message;
                        errorLabel.Visible = true;
                        successLabel.Visible = false;
                    }
                }
            }
        }

        private void LoadAttendanceData()
        {
            int company_code = GetCompanyId(hdnmail.Value);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Attendance where company_code=@company_code ORDER BY Id DESC"; // Adjust the number as needed

                using (SqlCommand command = new SqlCommand(query, connection))
                {
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
                }
            }
        }

        private void ClearForm()
        {
            // Clear TextBox controls
            txtEmployeeId.Text = "";
            txtFullName.Text = "";
            txtDate.Text = ""; // Assuming this is a TextBox
            txtCheckInTime.Text = "";

            // Clear DropDownList controls
            ddlGender.SelectedIndex = -1;
            ddlStatus.SelectedIndex = -1;
            ddlDepartment.SelectedIndex = -1;
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
    }
}
