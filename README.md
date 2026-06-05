# QMS (Quality/Queue Management System)

[![ASP.NET](https://img.shields.io/badge/ASP.NET-Web_Forms-blue.svg)](https://dotnet.microsoft.com/apps/aspnet/web-forms)
[![C#](https://img.shields.io/badge/C%23-Programming-green.svg)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-UI-purple.svg)](https://getbootstrap.com/)

## 📖 Overview
QMS is a comprehensive, web-based management application built with ASP.NET Web Forms and C#. It provides a centralized platform to manage staff registrations, track daily attendance, generate dynamic QR codes, and view detailed progress reports. The user interface is fully responsive, leveraging Bootstrap and jQuery to ensure a seamless experience across all devices.

## ✨ Key Features
* **Authentication & Authorization**: Secure `signIn`, `signUp`, and password recovery (`ForgetPassword`, `ResetPassword`) workflows.
* **Admin Dashboard**: A centralized `dashboard.aspx` for a high-level overview of system metrics.
* **Staff Management**: Tools to register new personnel (`Staffreg.aspx`) and view registered staff reports (`ReportStaffRegistered.aspx`).
* **Attendance Tracking**: Keep accurate records of staff attendance (`Attendance.aspx`) and generate comprehensive historical reports (`AttendanceReport.aspx`).
* **QR Code Generation**: Integrated QR code functionality (`QrCodeGenerator.aspx`) for quick scanning, identification, or data sharing[cite: 1].
* **Progress Reporting**: Dedicated modules for tracking performance and exporting analytical data (`ReportsMainPage.aspx`, `ProgressReport.aspx`)[cite: 1].

## 🛠️ Built With
* **Backend**: ASP.NET Web Forms, C#[cite: 1]
* **Frontend**: HTML5, CSS3, JavaScript[cite: 1]
* **UI Framework**: Bootstrap[cite: 1]
* **Libraries**: jQuery (v3.4.1), Modernizr (v2.8.3), Microsoft AJAX[cite: 1]

## 🚀 Getting Started

### Prerequisites
To run this project locally, ensure you have the following installed:
* [Visual Studio](https://visualstudio.microsoft.com/) (2019 or later recommended)
* .NET Framework (Compatible with the project specifications)
* SQL Server (if utilizing a local database for user and attendance records)

### Installation
1. **Clone the repository**:
```bash
   git clone [https://github.com/yourusername/QMS.git](https://github.com/yourusername/QMS.git)
