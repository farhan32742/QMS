using Azure.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TaskbarClock;
using System.Windows.Forms;
using System.Net.NetworkInformation;
using System.Diagnostics;
using System.Media;
using System.Collections.Concurrent;

namespace QMS
{
    public partial class home : System.Web.UI.Page
    {
        
        
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        string token = Request.QueryString["token"];
        //        getTokenforCounter();
        //        hdnyourtoken.Value = token;
        //        string counterNo = GetCounterNo(token);

        //        // Set the token value on the page
        //        lblTokenValue.Text = token;

        //        if (hdnyourtoken.Value == hdncountertoken.Value)
        //        {
        //            LabeelMessage.Text = $"Go to counter {counterNo}";
        //            messageDiv.Visible = true;
        //            tokenDiv.Visible = false;

        //            // Check if the token has already triggered the alarm
        //            if (!alarmTokens.ContainsKey(token))
        //            {
        //                using (SoundPlayer player = new SoundPlayer(Server.MapPath("~/LET2M79-intruder-alert.wav")))
        //                {
        //                    player.Play();
        //                    alarmTokens.TryAdd(token, true);
        //                }
        //            }
        //        }
        //        else
        //        {
        //            messageDiv.Visible = false;
        //            tokenDiv.Visible = true;
        //        }
        //    }
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                string token = Request.QueryString["token"];
                string bc = Request.QueryString["bc"];
                hdncode.Value = bc;
                getTokenforCounter();
               hdnyourtoken.Value = token;
                string counterNo = GetCounterNo(token);

                // Set the token value on the page
                lblTokenValue.Text = token;

                if (hdnyourtoken.Value == hdncountertoken.Value)
                {
                    LabeelMessage.Text = $"Go to counter {counterNo}";
                    messageDiv.Visible = true;
                    tokenDiv.Visible = false;

                    // Inject JavaScript to play the sound
                    if (!alarmTokens.ContainsKey(token))
                    {
                        string script = "playAlertSound();";
                        ClientScript.RegisterStartupScript(this.GetType(), "PlaySound", script, true);
                        alarmTokens.TryAdd(token, true);
                    }
                }
                else
                {
                    messageDiv.Visible = false;
                    tokenDiv.Visible = true;
                }
            }
        }

        private static readonly ConcurrentDictionary<string, bool> alarmTokens = new ConcurrentDictionary<string, bool>();
        private void PlayAlarmSound()
        {
            ClientScript.RegisterStartupScript(this.GetType(), "PlayAlarm", "playAlarm();", true);
        }
        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            try
            {
                string comment = txtbx.Text.Trim();
                if (!string.IsNullOrEmpty(comment))
                {
                    lblErrorMessage.Visible = false;
                    // Retrieve token and fullName from query string
                    string token = Request.QueryString["token"];
                    string fullName = Request.QueryString["name"];


                    SaveCommentToDatabase(comment, token, fullName, hdncode.Value);
                    txtbx.Text = string.Empty;
                }
                else
                {
                    // Display a message to the user
                    lblErrorMessage.Text = "Please write your comment first.";
                    lblErrorMessage.Visible = true;
                }

            }
            catch { 
            }
         
        }

        private void SaveCommentToDatabase(string comment, string token, string fullName , string company_code)
        {
            try
            {
                // Define your connection string (update with your actual database details)
                string connectionString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

                // SQL query to insert the comment into the feedback table
                string query = "INSERT INTO feedback (Comment, Token, FullName, company_code) VALUES (@Comment, @Token, @FullName , @company_code)";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Comment", comment);
                        command.Parameters.AddWithValue("@Token", token);
                        command.Parameters.AddWithValue("@FullName", fullName);
                        command.Parameters.AddWithValue("@company_code", hdncode.Value);

                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions (e.g., log them)
                            // For simplicity, just output the error message
                            Response.Write($"Error: {ex.Message}");
                        }
                    }
                }
            }
            catch { 
            }

           
        }


        protected string getAverageTime()
        {
            try
            {
                string countertoken1 = hdncountertoken.Value;
                int countertoken = int.Parse(hdncountertoken.Value);
                int yourtoken = int.Parse(hdnyourtoken.Value);
                string token = Request.QueryString["token"];
                string waitingtime = "";
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT
    AVG(DATEDIFF(SECOND, 0, CAST(RunningTime AS TIME))) AS average_waiting_time
FROM
    registration
WHERE
    date = @date
    AND status = 'closed' and company_code=@company_code";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@company_code", hdncode.Value);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        double averageSeconds = Convert.ToDouble(reader["average_waiting_time"]);
                        int count = yourtoken - countertoken; // replace with your token
                        double totalSeconds = averageSeconds * count;
                        TimeSpan timeSpan = TimeSpan.FromSeconds(totalSeconds);

                        // Formatting the time
                        if (timeSpan.TotalHours >= 1)
                        {
                            // If the total hours is 1 or more, format as "X hours Y minutes"
                            waitingtime = string.Format("{0} hour{1} {2} minute{3}",
                                (int)timeSpan.TotalHours,
                                timeSpan.TotalHours > 1 ? "s" : "",
                                timeSpan.Minutes,
                                timeSpan.Minutes != 1 ? "s" : "");
                        }
                        else
                        {
                            // If less than 1 hour, format as "X minutes"
                            waitingtime = string.Format("{0} minute{1}",
                                timeSpan.Minutes,
                                timeSpan.Minutes != 1 ? "s" : "");
                        }
                    }
                }
                return waitingtime;
            }
            catch (Exception ex)
            {
                // Handle exception (log error, display message, etc.)
                return "";
            }
        }

      






        protected string getTokenforCounter()
        {
            try
            {
                string servingToken = "";
                DateTime currentDate = DateTime.Now.Date;
                string date = currentDate.ToString("yyyy-MM-dd");
                string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT
   max(id)  as tokenfromcounter
FROM
    registration
WHERE
    date = @date
    AND status = 'Progress' and company_code=@company_code";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@company_code", hdncode.Value);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        servingToken = reader["tokenfromcounter"].ToString();

                        hdncountertoken.Value= servingToken;
                    }

                }
                return servingToken;
            }
            catch (Exception ex)
            {
                // Handle exception (log error, display message, etc.)
                return "";
            }
        }

        private string GetCounterNo(string token)
        {
            DateTime currentDate = DateTime.Now.Date;
            string date = currentDate.ToString("yyyy-MM-dd");
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            string query = "SELECT CounterNo FROM registration WHERE id = @id and date=@date and company_code=@company_code";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", token);
                command.Parameters.AddWithValue("@date", date);
                command.Parameters.AddWithValue("@company_code", hdncode.Value);

                object result = command.ExecuteScalar();

                return result != null ? result.ToString() : string.Empty;
            }
        }
  

    }

}





