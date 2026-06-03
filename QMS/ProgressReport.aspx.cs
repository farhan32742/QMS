using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace QMS
{
    public partial class ProgressReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
            if (!IsPostBack)
            {
                string email = Request.QueryString["email"];
                email = DecodeFromBase64(email);
                hdnmail.Value = email;
                PopulateLoginIds();
                showprogressReport();
              
            }
        }

        public void show(object sender, EventArgs e)
        {
            showprogressReport();
        }

        private void showprogressReport()
        {
            int company_code = GetCompanyId(hdnmail.Value);
            string loginId = loginpersonid.SelectedValue;
            string fromdate = startDate.Text;
            string todate = endDate.Text;
            DateTime frmdate = DateTime.Now;
            DateTime tdate = DateTime.Now;

            if (fromdate != "" && todate != "")
            {
                frmdate = DateTime.Parse(fromdate).Date;
                tdate = DateTime.Parse(todate).Date;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "";
                if (loginpersonid.SelectedValue == "")
                {
                    query = @"SELECT 
                          r.LoginId, 
                          s.FullName, 
                          CONVERT(VARCHAR(10), r.date, 120) AS Date, 
                          COUNT(*) AS CountOfClosedStatus,
                          CONVERT(VARCHAR(8), 
                            DATEADD(SECOND, 
                              AVG(
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 3)) * 3600 +
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 2)) * 60 +
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 1))
                              ), 
                              0), 
                            108) AS AvgRunningTime
                        FROM 
                          registration r
                          INNER JOIN SignUp s ON r.LoginId = s.UserID
                        WHERE 
                          r.status = 'Closed' and r.company_code = @company_code
                          
                          AND r.date BETWEEN @fromdate AND @tdate
                        GROUP BY 
                          r.LoginId, s.FullName, CONVERT(VARCHAR(10), r.date, 120)
                        ORDER BY 
                          r.LoginId, CONVERT(VARCHAR(10), r.date, 120);";
                }
                else
                {
                    query = @"SELECT 
                          r.LoginId, 
                          s.FullName, 
                          CONVERT(VARCHAR(10), r.date, 120) AS Date, 
                          COUNT(*) AS CountOfClosedStatus,
                          CONVERT(VARCHAR(8), 
                            DATEADD(SECOND, 
                              AVG(
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 3)) * 3600 +
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 2)) * 60 +
                                CONVERT(INT, PARSENAME(REPLACE(r.RunningTime, ':', '.'), 1))
                              ), 
                              0), 
                            108) AS AvgRunningTime
                        FROM 
                          registration r
                          INNER JOIN SignUp s ON r.LoginId = s.UserID
                        WHERE 
                          r.status = 'Closed' and r.company_code = @company_code
                          AND r.loginid = @loginid
                          AND r.date BETWEEN @fromdate AND @tdate
                        GROUP BY 
                          r.LoginId, s.FullName, CONVERT(VARCHAR(10), r.date, 120)
                        ORDER BY 
                          r.LoginId, CONVERT(VARCHAR(10), r.date, 120);";

                }
                 

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@fromdate", frmdate);
                    command.Parameters.AddWithValue("@tdate", tdate.ToString());
                    command.Parameters.AddWithValue("@loginid", loginId);
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
            //string email = Request.QueryString["email"];
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
            int company_code = GetCompanyId(hdnmail.Value);
            // email = DecodeFromBase64(email);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
           
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM SignUp WHERE Email = @Email and company_code = @company_code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", hdnmail.Value);
                cmd.Parameters.AddWithValue("@company_code", company_code);
               
                // ...

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
        private void PopulateLoginIds()
        {
            int company_code = GetCompanyId(hdnmail.Value);
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, FullName FROM SignUp where companycode=@company_code";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@company_code", company_code);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    loginpersonid.Items.Clear();
                    loginpersonid.Items.Add(new ListItem("Select Login ID", ""));

                    while (reader.Read())
                    {
                        loginpersonid.Items.Add(new ListItem(reader["FullName"].ToString(), reader["UserID"].ToString()));
                    }
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