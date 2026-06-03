using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using System.Xml.Schema;
using System.Diagnostics.Metrics;
using static QMS.dashboard;
using Newtonsoft.Json;

using System.Runtime.InteropServices;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Controls;
using System.Windows.Forms;


namespace QMS
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string email = Request.QueryString["email"];
                email = DecodeFromBase64(email);
                hdnmail.Value = email;
                int ccode = GetCompanyId(email);
                hdnccode.Value = ccode.ToString();
                int personId = GetPersonId(email); /* get the person ID from the session or database */
                int counterNo = GetCounterNo(personId);
                lblCounterNo.Text = "Counter No: " + counterNo.ToString();
                ClosePreviousDayRecords(personId);
                GetTotalWaitingRecords();
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                var statusCounts = new Dictionary<string, int>();
                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var command = new SqlCommand("SELECT Status, COUNT(*) AS Count FROM Attendance where date=@date and company_code=@company_code GROUP BY Status", connection);
                    command.Parameters.AddWithValue("@company_code", hdnccode.Value);
                    command.Parameters.AddWithValue("@date", date);
                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        statusCounts[reader["Status"].ToString()] = int.Parse(reader["Count"].ToString());
                    }
                }
                string loginId = hdnofpersonid.Value; // Replace with the actual login ID
                string companyCode = hdnccode.Value; // Replace with the actual company code

                BarChartCalculator calculator = new BarChartCalculator();
                string chartData = calculator.GetChartData(loginId, companyCode);

                ChartDataHiddenField.Value = chartData;
                BindFeedbackData();
                // Convert the dictionary to a JSON string to be used in JavaScript
                var statusCountsJson = Newtonsoft.Json.JsonConvert.SerializeObject(statusCounts);
                StatusCountsHiddenField.Value = statusCountsJson;

                // next line chart graph
                var counterData = new List<CounterData>();

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var command = new SqlCommand(
                        "SELECT CounterId, COUNT(CASE WHEN Status = 'Closed' THEN 1 END) AS Count FROM CounterSelection GROUP BY CounterId",
                        connection
                    );
                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        counterData.Add(new CounterData
                        {
                            CounterId = reader["CounterId"].ToString(),
                            Count = int.Parse(reader["Count"].ToString())
                        });
                    }
                }

                var counterDataJson = JsonConvert.SerializeObject(counterData);
                CounterDataHiddenField.Value = counterDataJson;


                // Check if the person has already started their day
                bool hasStartedDay = HasStartedDay(personId);

                if (!hasStartedDay)
                {
                    myModal.Visible = true; // Show the modal if the user hasn't started the day
                }



            }

        }
        public class CounterData
        {
            public string CounterId { get; set; }
            public int Count { get; set; }
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            // Trigger the UpdatePanel to refresh
            refreshdiv.Update();
        }
        private string DecodeFromBase64(string encodedText)
        {
            byte[] data = Convert.FromBase64String(encodedText);
            return System.Text.Encoding.UTF8.GetString(data);
        }
        private bool HasStartedDay(int personId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT counterid FROM CounterSelection WHERE PersonId = @PersonId AND Status = 'Progress' and company_code=@company_code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PersonId", personId);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string counterid = reader["counterid"].ToString();
                        hdnCounterName.Value = counterid;
                        return true;
                    }
                    else { return false; }

                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                    return false;
                }
            }
        }

        protected void btnStartDay_Click(object sender, EventArgs e)
        {

            int personId = GetPersonId(hdnmail.Value);

            int counterId = int.Parse(ddlCabin.SelectedValue);
            if (counterId == 0)
            {
                // Register a startup script to call the JavaScript function
                string script = "showAlert('Please select your counter');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
                return; // Exit the method to prevent further processing
            }
            bool isCounterInProgress = IsCounterInProgress(counterId);
            if (isCounterInProgress)
            {
                // Register a startup script to call the JavaScript function
                string script = "showAlert('This counter is already in progress. Please select another counter.');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
                return; // Exit the method to prevent further processing
            }

            // Store the counter selection and start time in the database
            StoreCounterSelectionInDatabase(personId, counterId);

            // Close the popup modal
            myModal.Visible = false; // Hide the modal after saving
            getlatestToken();
            // Redirect to the dashboard page (optional)
            // Response.Redirect("dashboard.aspx");
        }
        private bool IsCounterInProgress(int counterId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM CounterSelection WHERE  Status = 'Progress' and company_code=@company_code and CounterId=@cocounterId", conn);
                cmd.Parameters.AddWithValue("@PersonId", hdnofpersonid.Value);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                cmd.Parameters.AddWithValue("@cocounterId", counterId);
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
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
        private void StoreCounterSelectionInDatabase(int personId, int counterId)
        {

            int company_code = GetCompanyId(hdnmail.Value);
            hdnCounterName.Value = counterId.ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO CounterSelection (PersonId, CounterId, StartDate, StartTime, Status,company_code) VALUES (@PersonId, @CounterId, @StartDate, @StartTime, 'Progress',@company_code)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PersonId", personId);
                cmd.Parameters.AddWithValue("@CounterId", counterId);
                cmd.Parameters.AddWithValue("@StartDate", DateTime.Now.Date); // Get the current date
                cmd.Parameters.AddWithValue("@StartTime", DateTime.Now.ToString("HH:mm")); // Format the time as HH:mm
                cmd.Parameters.AddWithValue("@company_code", company_code);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    // Modal should be closed here after successful insert.
                    myModal.Visible = false;
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }

        protected void EndDayButton_Click(object sender, EventArgs e)
        {


            int personId = GetPersonId(hdnmail.Value);
            ClosePreviousDayRecords(personId);
            // Update the end time, end date, and status
            UpdateCounterSelectionEndDetails(personId);
        }
        protected void Next_token(object sender, EventArgs e)
        {

            updateregistrationNSTATUS(hdntokennumber.Value);
            getlatestToken();
            //  string servedtoken = hdntokennumber.Value;
            // Session["CurrentToken"] = servedtoken;

        }
        protected void stop_token(object sender, EventArgs e)
        {

            updateregistrationNSTATUS(hdntokennumber.Value);
            //  string servedtoken = hdntokennumber.Value;
            // Session["CurrentToken"] = servedtoken;

        }

        private void UpdateCounterSelectionEndDetails(int personId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE CounterSelection SET EndDate = @EndDate, EndTime = @EndTime, Status = 'Closed' WHERE PersonId = @PersonId AND Status = 'Progress' and company_code=@company_code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PersonId", personId);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                cmd.Parameters.AddWithValue("@EndDate", DateTime.Now.Date); // Get the current date
                cmd.Parameters.AddWithValue("@EndTime", DateTime.Now.ToString("HH:mm")); // Format the time as HH:mm

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    // Optionally, show a message to the user or refresh the page
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }

        private int GetPersonId(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID FROM SignUp WHERE Email = @Email and companycode=@company_code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);

                try
                {
                    conn.Open();
                    int personId = (int)cmd.ExecuteScalar();

                    hdnofpersonid.Value = personId.ToString();
                    return personId;
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                    return 0;
                }
            }
        }
        private void getlatestToken()
        {
            try
            {
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"WITH MinIdCTE AS (
                SELECT MIN(id) AS min_id
                FROM registration
                WHERE date = @today AND status = 'Waiting'
            )
            SELECT r.first_name, r.id, r.status
            FROM registration r
            JOIN MinIdCTE cte ON r.id = cte.min_id
            WHERE r.date = @today AND r.status = 'Waiting' and r.company_code=@company_code;";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@today", date);
                    cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string token = reader["id"].ToString();
                        string firstname = reader["first_name"].ToString();
                        string Status = reader["status"].ToString();

                        if (Status == "Progress")
                        {
                            // No action needed, as the status is already in progress
                        }
                        else if (token == "")
                        {
                            token = "0";
                            lblMessage.Text = "There are no waiting persons in the Queue.";
                            lblMessage.Visible = true;
                            hdntimerstatus.Value = "stop";
                        }
                        else
                        {
                            updATETOKENSTATUS(token);
                            lblMessage.Visible = false;
                            hdntimerstatus.Value = "start";
                        }

                        currentserving.InnerText = token.ToString();
                        hdntokennumber.Value = token;
                        name.InnerText = firstname;
                    }
                    else
                    {
                        // lblMessage.Text = "There are no waiting persons in the Queue.";
                        // lblMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception (log error, display message, etc.)
            }
        }
        private void updATETOKENSTATUS(string token)
        {
            DateTime currentDate = DateTime.Now.Date;
            string date = currentDate.ToString("yyyy-MM-dd");
            string CounterNo = hdnCounterName.Value;

            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query1 = "Update registration set status='Progress',CounterNo=@CounterNo where date =@today  and status = 'Waiting' and id=@token";

                SqlCommand cmd = new SqlCommand(query1, conn);

                cmd.Parameters.AddWithValue("@token", token);
                cmd.Parameters.AddWithValue("@today", date);
                cmd.Parameters.AddWithValue("@CounterNo", CounterNo);



                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    // Optionally, show a message to the user or refresh the page
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }
        private void ClosePreviousDayRecords(int personId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE CounterSelection SET EndDate = @EndDate, EndTime = @EndTime, Status = 'Closed' WHERE PersonId = @PersonId AND Status = 'Progress' AND startdate = @enddate company_code=@company_code";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PersonId", personId);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                cmd.Parameters.AddWithValue("@EndDate", DateTime.Now.Date.AddDays(-1)); // Get the previous day's date
                cmd.Parameters.AddWithValue("@EndTime", "23:59"); // Set the end time to 11:59 PM

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
        public int GetTotalWaitingRecords()
        {
            DateTime currentDate = DateTime.Now.Date;
            string date = currentDate.ToString("yyyy-MM-dd");
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM registration WHERE status = 'Waiting' and date = @date and company_code=@company_code";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@company_code", hdnccode.Value);
                int totalRecords = (int)command.ExecuteScalar();

                return totalRecords;
            }
        }
        private void updateregistrationNSTATUS(string token)
        {
            DateTime currentDate = DateTime.Now.Date;
            string date = currentDate.ToString("yyyy-MM-dd");
            string timerValue = hiddenTimer.Value;
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query1 = "Update registration set status='closed', LoginId = @userid ,RunningTime=@runningtime where date =@today  and status = 'Progress' and id=@token and company_code = @company_code";

                SqlCommand cmd = new SqlCommand(query1, conn);

                cmd.Parameters.AddWithValue("@token", token);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);
                cmd.Parameters.AddWithValue("@userid", hdnofpersonid.Value);
                cmd.Parameters.AddWithValue("@today", date); // Get the current date
                cmd.Parameters.AddWithValue("@RunningTime", hiddenTimer.Value); // Get the current date


                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    // Optionally, show a message to the user or refresh the page
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                }
            }
        }
        public int GetTotalSeervedRecords()
        {

            DateTime currentDate = DateTime.Now.Date;
            string date = currentDate.ToString("yyyy-MM-dd");

            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM registration WHERE Status = 'closed' and LoginId = @personId and date = @date and company_code = @company_code";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@company_code", hdnccode.Value);
                command.Parameters.AddWithValue("@personId", hdnofpersonid.Value);
                int totalServedRecords = (int)command.ExecuteScalar();

                return totalServedRecords;
            }
        }

        public int GetTotalSeervedYesterdayRecords()
        {

            DateTime currentDate = DateTime.Now.Date.AddDays(-1);
            string date = currentDate.ToString("yyyy-MM-dd");

            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM registration WHERE Status = 'closed' and LoginId = @personId and date = @date and company_code=@company_code";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@company_code", hdnccode.Value);
                command.Parameters.AddWithValue("@personId", hdnofpersonid.Value);
                int totalYesterdayServedRecords = (int)command.ExecuteScalar();

                return totalYesterdayServedRecords;
            }
        }
        private int GetCounterNo(int pid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "select CounterId from CounterSelection where PersonId = @pid and company_code=@company_code ;";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@pid", pid);
                cmd.Parameters.AddWithValue("@company_code", hdnccode.Value);


                try
                {
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        return (int)result;
                    }
                    return 0; // Or handle the case where no data is found
                }
                catch (Exception ex)
                {
                    // Handle exception (log error, display message, etc.)
                    return 0;
                }
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear the session
            Session.Abandon();

            // Redirect to the sign in page
            Response.Redirect("~/SignIn.aspx");
        }
        private void BindFeedbackData()
        {
            string company_code = hdnccode.Value;
            // Connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string query = "SELECT TOP 5 Comment, FullName FROM Feedback WHERE company_code = @company_code ORDER BY Id DESC";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))

                {
                    command.Parameters.AddWithValue("@company_code", hdnccode.Value);
                    try
                    {
                        connection.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        rptFeedback.DataSource = dt;
                        rptFeedback.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        Console.WriteLine(ex.Message);
                    }
                }
            }

        }
        public double CalculateServiceScore()
        {
            string companyCode= hdnccode.Value;
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            double serviceScore = 0;

            string query = @"
        SELECT
            SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) AS TotalClosed,
            AVG(CAST(RunningTime AS FLOAT)) AS AvgRunningTime
        FROM Registration
        WHERE company_code = @CompanyCode and LoginId = @personId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CompanyCode", companyCode);
                command.Parameters.AddWithValue("@personId", hdnofpersonid.Value);

                try
                {
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int totalClosed = reader.IsDBNull(reader.GetOrdinal("TotalClosed")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalClosed"));
                            double avgRunningTime = reader.IsDBNull(reader.GetOrdinal("AvgRunningTime")) ? 0 : reader.GetDouble(reader.GetOrdinal("AvgRunningTime"));

                            // Calculate the service score: (TotalClosed / AvgRunningTime)
                            serviceScore = avgRunningTime > 0 ? totalClosed / avgRunningTime : 0;
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions (e.g., logging)
                    Console.WriteLine("An error occurred: " + ex.Message);
                }
            }

            return serviceScore;
        }
        public class BarChartCalculator
        {
            public string GetChartData(string loginId, string companyCode)
            {
                Dictionary<string, int> monthlyCounts = new Dictionary<string, int>();

                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var command = new SqlCommand("SELECT DATENAME(month, date) AS MonthName, COUNT(*) AS Count FROM Registration WHERE status = 'closed' AND LoginId = @loginId AND company_code = @companyCode GROUP BY DATENAME(month, date), DATEPART(month, date), DATEPART(year, date)", connection);
                    command.Parameters.AddWithValue("@loginId", loginId);
                    command.Parameters.AddWithValue("@companyCode", companyCode);
                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string monthName = reader["MonthName"].ToString();
                        int count = int.Parse(reader["Count"].ToString());

                        if (monthlyCounts.ContainsKey(monthName))
                        {
                            monthlyCounts[monthName] += count;
                        }
                        else
                        {
                            monthlyCounts[monthName] = count;
                        }
                    }
                }

                // Add all 12 months to the dictionary, even if there is no data
                string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
                foreach (string month in months)
                {
                    if (!monthlyCounts.ContainsKey(month))
                    {
                        monthlyCounts[month] = 0;
                    }
                }

                // Convert dictionary to JSON string
                var json = JsonConvert.SerializeObject(monthlyCounts);
                return json;
            }
        }
   
      
    }
}
