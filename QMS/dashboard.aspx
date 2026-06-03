<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="QMS.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      

 
    <style>
   
#EndDayButton {
  background-color: #6c757d; /* Gray color for end day */
  color: white;
  padding: 10px 20px;
border: none;
border-radius: 5px;
margin-right: 10px;
}

#EndDayButton:hover {
   background-color: #9f1e1e; /* Darker button color on hover */
  color: #e0e0e0; /* Lighter text color on hover */
  border-color: #adea49; /* Border color on hover */
  cursor:pointer; /* Darker gray on hover */
}
#EndDayButton:focus {
    outline: none; /* Remove default focus outline */
    box-shadow: 0 0 0 2px rgba(38, 143, 255, 0.5); /* Add a custom focus outline */
}

.modal {
    display: block;
    position: fixed;
    z-index: 1;
  left:30%;
    width: 30%;
    height: 40%;
    overflow: auto;
  
}

.modal-content {
    background-color: #fefefe;
    //margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
 
}

.close {
    color: #aaa;
    float: right;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    padding: 5px 10px;
    background-color: #f44336; /* Red background color */
    color: white; /* White text */
    cursor: pointer; /* Make the cursor a pointer */
    transition: background-color 0.3s ease; /* Smooth transition */
    width:20%
}

.close:hover,
.close:focus {
    background-color: #d9534f; /* Darker red on hover */
}

.cabin-dropdown {
   width: 50%;
    border: none;
    border-radius: 5px;
    padding: 10px;
    font-size: 18px;
    margin-right:5px;
}

.btn-start-day {
    width: 50%;
    
    border: none;
    border-radius: 5px;
    padding: 10px;
    font-size: 18px;
    background-color: #007bff;
    color: white;
    cursor: pointer;
}

.btn-start-day:hover {
    background-color: #0056b3;
}
#lblMessage{
    font-weight:bold;
}
.custom-margin-right {
    margin-right: 10px; /* Adjust the value as needed */
}
@media (max-width: 768px) {
    .d-flex {
        flex-direction: column;
        align-items: flex-start;
    }
    .d-flex > div {
        margin-top: 10px;
    }
    .navbar-toggler {
        margin-bottom: 10px;
    }
    b {
        font-size: 20px;
        margin-left: 0;
    }
    img {
        width: 35px;
        height: 35px;
    }
}
  #lineChart {
            max-width: 600px; /* Set maximum width */
            margin: auto; /* Center the chart */
        }
              .card {
  margin-bottom: 30px;
  border: none;
  border-radius: 5px;
  box-shadow: 0px 0 30px rgba(1, 41, 112, 0.1);
}
.card-title {
  padding: 20px 0 15px 0;
  font-size: 18px;
  font-weight: 500;
  color: #012970;
  font-family: "Poppins", sans-serif;
}
.card-body {
  padding: 0 20px 20px 20px;
}

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 11px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
        .fixed-size-table {
  height: 400px;

  overflow-y: auto;
}
          .chart-container {
        position: relative;
        height: 400px; /* Adjust the height as needed */
        width: 100%;
    }
    #barChart {
        width: 100% !important;
        height: 100% !important;
    }
  
    </style>
      
    <!-- Full screen modal -->
<div id="myModal" class="modal" runat="server" visible="false" >
    <div class="modal-content">

        
        <h3>Select Counter and start your Day
        </h3>
        <div class="col-12 d-flex align-items-center">
            <asp:DropDownList ID="ddlCabin" runat="server" CssClass="form-control cabin-dropdown">
                <asp:ListItem Text="Select Counter" Value="0" />
                <asp:ListItem Text="Counter 1" Value="1"/>
                <asp:ListItem Text="Counter 2" Value="2" />
                <asp:ListItem Text="Counter 3" Value="3" />
                <asp:ListItem Text="Counter 4" Value="4" />
                <asp:ListItem Text="Counter 5" Value="5" />
                <asp:ListItem Text="Counter 6" Value="6" />
                <asp:ListItem Text="Counter 7" Value="7" />
                <asp:ListItem Text="Counter 8" Value="8" />
                <asp:ListItem Text="Counter 9" Value="9" />
                <asp:ListItem Text="Counter 10" Value="10" />
            </asp:DropDownList>
            <asp:Button ID="btnStartDay" runat="server" Text="Start Day" CssClass="start-day btn-start-day" OnClick="btnStartDay_Click"/>
            <asp:HiddenField id="hdnCounterName" runat="server"/>
             <asp:HiddenField id="hdnmail" runat="server"/>
        </div>
    </div>
</div>
    <!-- close button modal -->
   
   
    
        <div class="d-flex justify-content-between  align-items-center p-3" style="background-color: #dbe2f0; ">
       
   <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target=".sidebar" aria-controls="collapsibleNavId" aria-expanded="false" aria-label="Toggle navigation">
     &#9776;
 </button>
           
            <b style="font-size: 25px;margin-left: 35px;" class="text-center">  Dashboard</b>
     <div class="d-flex align-items-center">
        
     <%--     <p style="border:1px solid black; margin-right:6px; background-color:#efece6; margin-top:13px; font-size:18px; border-radius:3px;">
    <asp:Label ID="lblCounterNo" runat="server" Text="Counter No:"></asp:Label>
</p>--%>
         <asp:Label ID="lblCounterNo" runat="server" Text="Counter No:" CssClass="btn btn-info custom-margin-right"></asp:Label>
            <asp:LinkButton ID="EndDayButton" runat="server" CssClass="btn btn-outline-success custom-margin-right" OnClientClick="return confirm('Are you sure you want to close the session?');" OnClick="EndDayButton_Click"  >
    End Day     
</asp:LinkButton>
    <%--<asp:Button ID="EndDayButton" runat="server" CssClass="end-day" Text="End Day" OnClientClick="return confirm('Are you sure you want to close the session?');" OnClick="EndDayButton_Click" />--%>
    <asp:LinkButton runat="server" CssClass="btn btn-outline-danger custom-margin-right" OnClick="Logout_Click" >
     Log Out     
 </asp:LinkButton>
</div>
                 

     </div>
   <asp:HiddenField  ID="hdnccode" runat="server"/>
      <div class="row mt-2" style="padding: 10px;" >
            <div class="col-md-3 col-12" >
              <div class="d-flex flex-column align-items-center bgwhite  "
                style="border-radius: 12px;padding-bottom: 46px;">
                <div style="padding: 10px 20px; background-color: #ff9000;  width: 100%;border-radius:12px 12px 0px 0px; text-align:center; ">
                  Now Serve
                </div>

                <p style=" border: none;  font-size: 15px; text-align: center;margin:0px;padding:0px;margin-top:5px;  ">Current Serving</p>
                <p style=" border: none;  font-size: 25px; text-align: center;margin:0px;padding:0px; "><b>Token Number</b></p>
                <b style="font-size: 50px;  width: 100%; text-align: center;margin:0px;padding:0px; color: green;font-size: 80px;" runat="server" id="currentserving">0</b>
                 <asp:HiddenField ID="hdntokennumber" runat="server"  />
                <p style="  width: 100%; text-align: center;margin:0px;padding:0px;font-size: 20px;">Serving Time</p>
                <b id="timer" style="font-size: 45px;  width: 100%; text-align: center;">00:00:00</b>
                  <asp:HiddenField ID="hiddenTimer" runat="server" />
                <p style=" background-color: #ea8d00;
                width: 100%;
                padding: 10px;color: white;font-size: 20px;
                text-align: center;" runat="server" id="name">Null</p>
    <div class="d-flex justify-content-around mt-4">
    <asp:LinkButton runat="server" CssClass="btn btn-outline-danger custom-margin-right" OnClick="stop_token" >
        STOP     
        <img src="icons8-pause-button-16.png" alt="" style="padding:10px;width:40px;height:40px;">
    </asp:LinkButton>
    <asp:LinkButton runat="server" CssClass="btn btn-outline-success" OnClick="Next_token">
        NEXT 
        <img src="resume.png" alt="" style="padding:10px;width:40px;height:40px;">
    </asp:LinkButton>
</div>
<asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="lblMessage" runat="server" Text="" Visible="false"></asp:Label>
              </div>
            </div>
            <div class="col-md-6 col-12 mt-md-0 mt-3">
              <div class="row">
                <div class="col-6 ">
                                           <div class="stat-box bgwhite text-center" style="border-radius: 10px;">
  <p style="padding: 10px 20px; background-color: #ff9000; width: 100%; border-radius: 12px 12px 0px 0px;">Total serves</p>
  <div class="d-flex align-items-center" style="justify-content: center; position: relative;">
    <img src="icons8-checked-user-female-48.png" width="60px" height="60px" style="position: absolute; left: 15px;"/>
    <b style="font-size: 80px; color: green; margin-left: 15px;"> <%= GetTotalSeervedRecords() %></b>
  </div>
</div>

               <%--  <div class="stat-box text-center bgwhite" style="  border-radius: 10px;">
                    <p style="padding: 10px 20px; background-color: #ff9000;  width: 100%;border-radius:12px 12px 0px 0px;">Total serves</p>
                  
                    <b style="font-size: 80px; color: green;"><%= GetTotalSeervedRecords() %></b>
                  </div> --%>

                    <asp:ScriptManager runat="server" />
                    <asp:Timer ID="Timer1" runat="server" Interval="30000" OnTick="Timer1_Tick" />
                    <asp:UpdatePanel  ID="refreshdiv" runat ="server" UpdateMode="Conditional">
                        <ContentTemplate>
   <div class="stat-box mt-4 bgwhite text-center" style="border-radius: 10px;">
  <p style="padding: 10px 20px; background-color: #ff9000; width: 100%; border-radius: 12px 12px 0px 0px;">Total Queue</p>
  <div class="d-flex align-items-center" style="justify-content: center; position: relative;">
    <img src="icons8-joining-queue-48.png" width="60px" height="60px" style="position: absolute; left: 15px;"/>
    <b style="font-size: 80px; color: green; margin-left: 15px;"> <%= GetTotalWaitingRecords() %></b>
  </div>
</div>
                            </ContentTemplate>
                           <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
    </Triggers>
                        </asp:UpdatePanel>
                      

                </div>
                <div class="col-6">
                       <div class="stat-box bgwhite text-center" style="border-radius: 10px;">
  <p style="padding: 10px 20px; background-color: #ff9000; width: 100%; border-radius: 12px 12px 0px 0px;">Yesterday</p>
  <div class="d-flex align-items-center" style="justify-content: center; position: relative;">
    <img src="icons8-yesterday-64.png" width="60px" height="60px" style="position: absolute; left: 15px;"/>
    <b style="font-size: 80px; color: green; margin-left: 15px;"> <%= GetTotalSeervedYesterdayRecords() %></b>
  </div>
</div>
               <!--   <div class="stat-box text-center bgwhite" style="  border-radius: 10px;">
                    <p style="padding: 10px 20px; background-color: #ff9000;  width: 100%;border-radius:12px 12px 0px 0px;">Yesterday</p>
                   
                    <b style="font-size: 80px; color: green;"><%= GetTotalSeervedYesterdayRecords() %></b>
                  </div>
                   -->
                   <div class="stat-box mt-4 bgwhite text-center" style="border-radius: 10px;">
  <p style="padding: 10px 20px; background-color: #ff9000; width: 100%; border-radius: 12px 12px 0px 0px;">Service Score</p>
  <div class="d-flex align-items-center" style="justify-content: center; position: relative;">
    <img src="icons8-personal-growth-64.png" width="60px" height="60px" style="position: absolute; left: 15px;"/>
    <b style="font-size: 80px; color: green; margin-left: 15px;"> <%= CalculateServiceScore() %></b>
  </div>
</div>
                </div>
                <div class="col-12 text-center">
                  <div class="stat-box mt-4 bgwhite" style="  border-radius: 10px;">
                    <p style="padding: 10px 20px; background-color: #ff9000;  width: 100%;border-radius:12px 12px 0px 0px;">Busy Hours</p>
                   
                    <b style="font-size: 30px; color: green;">11:54-02:45</b>
                  </div>
                </div>
              </div>
            </div>
           
            <div class="col-md-3 col-12 d-md-block d-none p-0">
              <div class="calendar">
                <div class="calendar-header" style="color:black; padding-top:6px; text-align:center;flex-direction: column;">
                  Calendar
                </div>
                <div class="calendar-body">
                  <div class="time-display" id="currentTime"></div>
                  <div class="month-navigation">
                    <button id="prevMonth" class="btn btn-link">&lt;</button>
                    <span id="monthYear" class="font-weight-bold"></span>
                    <button id="nextMonth" class="btn btn-link">&gt;</button>
                  </div>
                  <div class="date-display" id="currentDate"></div>
                  <div id="calendar"></div>
                </div>
              
              </div>
            </div>
          
          </div>
          <div class="row" style="padding: 10px;margin-top:20px;">
           <div class="col-12">

         <!--   <div class="stat-box text-center bgwhite justify-content-between" style="border-radius: 10px;">
              <div class="input-group" style=" align-items: center;" >
                
              <input class="form-control" type="text" placeholder="Send detail on phone" style="font-size: 20px; color: green;">
              <img src="resume.png" alt="" width="25px" height="25px" style="margin-right: 10px;" >
            </div>
            </div>-->
            <asp:HiddenField runat="server" ID="hdnofpersonid"/>
               <asp:HiddenField ID="hdntimerstatus" runat="server" />
           </div>
     
   <%--<div class="col-lg-6">
 
          <div class="card">
               <div class="fixed-size-table">
            <div class="card-body">
              <h5 class="card-title">Bar CHart</h5>

              <!-- Bar Chart -->
                  <div class="chart-container">
                <canvas id="barChart"></canvas>
               
<%--              <canvas id="barChart" style="max-height: 400px;"></canvas>--%>
          <%--    <script>
                  document.addEventListener("DOMContentLoaded", () => {
                      new Chart(document.querySelector('#barChart'), {
                          type: 'bar',
                          data: {
                              labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                              datasets: [{
                                  label: 'Bar Chart',
                                  data: [65, 59, 80, 81, 56, 55, 40],
                                  backgroundColor: [
                                      'rgba(255, 99, 132, 0.2)',
                                      'rgba(255, 159, 64, 0.2)',
                                      'rgba(255, 205, 86, 0.2)',
                                      'rgba(75, 192, 192, 0.2)',
                                      'rgba(54, 162, 235, 0.2)',
                                      'rgba(153, 102, 255, 0.2)',
                                      'rgba(201, 203, 207, 0.2)'
                                  ],
                                  borderColor: [
                                      'rgb(255, 99, 132)',
                                      'rgb(255, 159, 64)',
                                      'rgb(255, 205, 86)',
                                      'rgb(75, 192, 192)',
                                      'rgb(54, 162, 235)',
                                      'rgb(153, 102, 255)',
                                      'rgb(201, 203, 207)'
                                  ],
                                  borderWidth: 1
                              }]
                          },
                          options: {
                              scales: {
                                  y: {
                                      beginAtZero: true
                                  }
                              }
                          }
                      });
                  });
              </script>--%>
              <!-- End Bar CHart -->

         <%--   </div>
          </div>
          </div>
        </div>
        </div>--%>
              <div class="col-lg-6">
    <div class="card">
        <div class="fixed-size-table">
            <div class="card-body">
                <h5 class="card-title">Bar Chart</h5>

                <!-- Bar Chart -->
              
                    <canvas id="barChart"></canvas>
                

                <asp:HiddenField ID="ChartDataHiddenField" runat="server" />

              <script>
                  document.addEventListener("DOMContentLoaded", () => {
                      var data = JSON.parse(document.getElementById('<%= ChartDataHiddenField.ClientID %>').value);

        new Chart(document.querySelector('#barChart'), {
            type: 'bar',
            data: {
                labels: Object.keys(data), // Use month names directly from the data
                datasets: [{
                    label: 'Closed Status Count',
                    data: Object.values(data), // Use counts directly from the data
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 205, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(201, 203, 207, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 205, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgb(255, 99, 132)',
                        'rgb(255, 159, 64)',
                        'rgb(255, 205, 86)',
                        'rgb(75, 192, 192)',
                        'rgb(54, 162, 235)',
                        'rgb(153, 102, 255)',
                        'rgb(201, 203, 207)',
                        'rgb(255, 99, 132)',
                        'rgb(255, 159, 64)',
                        'rgb(255, 205, 86)',
                        'rgb(75, 192, 192)',
                        'rgb(54, 162, 235)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Month'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Count'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true
                    }
                }
            }
        });
    });
              </script>

            </div>
        </div>
    </div>
</div>

                <%--<div class="col-lg-6">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Double Line Chart</h5>
                <!-- Line Chart -->
                <canvas id="lineChart" style="max-height: 400px;"></canvas>
            </div>
        </div>
    </div>--%>

  <%--  <script>
        document.addEventListener("DOMContentLoaded", () => {
            new Chart(document.querySelector('#lineChart'), {
                type: 'line',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                    datasets: [
                        {
                            label: 'Line 1',
                            data: [65, 59, 80, 81, 56, 55, 40],
                            borderColor: 'rgb(75, 192, 192)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            fill: false,
                            tension: 0.1
                        },
                        {
                            label: 'Line 2',
                            data: [28, 48, 40, 19, 86, 27, 90],
                            borderColor: 'rgb(153, 102, 255)',
                            backgroundColor: 'rgba(153, 102, 255, 0.2)',
                            fill: false,
                            tension: 0.1
                        }
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                //    }
                //}
            });
        });
    </script>--%>

              
              <div class="col-lg-6">
            <div class="card">
                   <div class="fixed-size-table">
                <div class="card-body">
           <%--         <h5 class="card-title">Line Chart</h5>--%>
                     <h5 class="card-title">Line Chart</h5>
                    <!-- Line Chart -->
                 
                    <div id="lineChart"></div>

                    <asp:HiddenField ID="CounterDataHiddenField" runat="server" />

                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            var data = JSON.parse(document.getElementById('<%= CounterDataHiddenField.ClientID %>').value);

                            var series = [{
                                name: 'Count',
                                data: data.map(item => item.Count)
                            }];
                            var categories = data.map(item => item.CounterId);

                            new ApexCharts(document.querySelector("#lineChart"), {
                                series: series,
                                chart: {
                                    height: 350,
                                    type: 'line'
                                },
                                xaxis: {
                                    categories: categories,
                                    title: {
                                        text: 'Days of the Month'
                                    }
                                },
                                yaxis: {
                                    title: {
                                        text: 'Count'
                                    },
                                    min: 0,
                                    max: 300,
                                    tickAmount: 10, // Adjust the number of ticks on the y-axis
                                    labels: {
                                        formatter: function (value) {
                                            return value.toFixed(0);
                                        }
                                    }
                                },
                                title: {
                                    text: 'Count by Counter ID',
                                    align: 'left'
                                    
                                }
                            }).render();
                        });
                    </script>
                </div>
            </div>
            </div>
        </div>

        

                                         <div class="col-lg-6">
            <div class="card">
                   <div class="fixed-size-table">
                <div class="card-body">
                    <h5 class="card-title">Pie Chart</h5>

                    <!-- Pie Chart -->
                    <div id="pieChart"></div>

                    <asp:HiddenField ID="StatusCountsHiddenField" runat="server" />

                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            var data = JSON.parse(document.getElementById('<%= StatusCountsHiddenField.ClientID %>').value);

                            var series = [];
                            var labels = [];
                            $.each(data, function (key, value) {
                                series.push(value);
                                labels.push(key);
                            });

                            new ApexCharts(document.querySelector("#pieChart"), {
                                series: series,
                                chart: {
                                    height: 300,
                                    type: 'pie',
                                    toolbar: {
                                        show: true
                                    }
                                },
                                labels: labels
                            }).render();
                        });
                    </script>
                </div>
            </div>
        </div>
        </div>
    <div class="col-lg-6">
     
  <div class="card">
         <div class="fixed-size-table">
      <div class="card-body">
        <h5 class="card-title">User Remarks</h5>
        <!-- Table -->
           
     <asp:Repeater ID="rptFeedback" runat="server">
    <HeaderTemplate>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>SR No</th>
                    <th>Name</th>
                    <th>Feedback</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Container.ItemIndex + 1 %></td> <!-- Displays serial number starting from 1 -->
            <td><%# Eval("FullName") %></td>
            <td><%# Eval("Comment") %></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>
    </div>
    </div>
  </div>
</div>
        </div>
      <script type="text/javascript">
          function showModal() {
              var modal = document.getElementById("myModal");
              modal.style.display = "block";
          }
          function showAlert(message) {
              alert(message);
          }

          // Initialize startTime and timerValue
          let startTime = null; // Initialize start time to null
          let timerValue = '00:00:00'; // Initialize the timer value
          let timerInterval = null; // Initialize timer interval to null

          function startTimer() {
              startTime = Date.now(); // Start the timer
              timerInterval = setInterval(updateTimer, 1000); // Update the timer every second
          }

          function stopTimer() {
              clearInterval(timerInterval); // Stop the timer
          }

          function updateTimer() {
              const timerElement = document.getElementById('timer');
              const elapsed = Date.now() - startTime; // Time elapsed in milliseconds

              // Calculate hours, minutes, and seconds
              const hours = Math.floor(elapsed / (1000 * 60 * 60)).toString().padStart(2, '0');
              const minutes = Math.floor((elapsed % (1000 * 60 * 60)) / (1000 * 60)).toString().padStart(2, '0');
              const seconds = Math.floor((elapsed % (1000 * 60)) / 1000).toString().padStart(2, '0');

              timerValue = `${hours}:${minutes}:${seconds}`; // Update the global variable
              timerElement.textContent = timerValue; // Update the timer display

              // Update the hidden field value
              document.getElementById('<%= hiddenTimer.ClientID %>').value = timerValue;
}

// Check the status of the timer on page load
          const timerStatus = document.getElementById('<%= hdntimerstatus.ClientID %>').value;
          if (timerStatus === 'start') {
              startTimer();
          } else {
              stopTimer();
          }

      </script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

  
</asp:Content>
