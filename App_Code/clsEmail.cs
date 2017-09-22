﻿
using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Net.Mail;
using System.Configuration;
using System.Web;

public class clsEmail
{
    public string ErrorMessage { get; set; }
    public dsMainTableAdapters.tblEmailSettingsTableAdapter tblEmail = new dsMainTableAdapters.tblEmailSettingsTableAdapter();
    Encrypt clsEncrypt = new Encrypt();

    public SmtpClient GetSmtpInfo()
    {
        SmtpClient smtp = new SmtpClient();
        string SenderEmailId = "robot@HireMatch.com";
        string Password = "Hill90210!";
        smtp.Host = "smtpout.secureserver.net";
        smtp.Port = 3535;
        smtp.EnableSsl = false;
        smtp.Credentials = new System.Net.NetworkCredential(SenderEmailId, Password);
        return smtp;
    }

    public bool ConfirmUserEmailAddress(string emailUser, string firstNameUser, int companyId)
    {
        try
        {
            string body = null;
            body = getEmailTemplate(firstNameUser, "Please confirm your email address", "Thanks for registering with the HireMatch Rental Software! To complete your registration, click " + "<a href='http://HireMatch.azurewebsites.net/Confirm.aspx?id=" + companyId + "'>here</a> to confirm your email address. Your account cannot be verified until you complete this step.");

            MailMessage myMessage = new MailMessage();
            myMessage.Subject = "Please confirm your email address";
            myMessage.Body = body;
            myMessage.IsBodyHtml = true;
            myMessage.To.Add(new MailAddress(emailUser, firstNameUser));
            myMessage.From = new MailAddress("robot@HireMatch.com", "HireMatch Email Confirmation");
            SmtpClient smtp = GetSmtpInfo();

            smtp.Send(myMessage);
            return true;
        }
        catch (Exception ex)
        {
            ErrorMessage = ex.Message;
            return false;
        }
    }

    public bool ForgotPassword(string emailUser, string firstNameUser, string password)
    {
        dsMainTableAdapters.tblEmailSettingsTableAdapter tblEmail = new dsMainTableAdapters.tblEmailSettingsTableAdapter();
        try
        {
            string body = null;
            body = getEmailTemplate(firstNameUser, "Did you forget your password?", "Don't worry, we've got it! Your password is <strong>" + password + "</strong>.  Be sure to keep it in a safe place, and change it often.");

            MailMessage myMessage = new MailMessage();
            myMessage.Subject = "Did you forget your password?";
            myMessage.Body = body;
            myMessage.IsBodyHtml = true;
            myMessage.To.Add(new MailAddress(emailUser, firstNameUser));
            myMessage.From = new MailAddress("robot@HireMatch.com", "Forgot My HireMatch Password");
            SmtpClient smtp = GetSmtpInfo();

            smtp.Send(myMessage);
            return true;
        }
        catch (Exception ex)
        {
            ErrorMessage = ex.Message;
            return false;
        }
    }

    public bool SendInvoice(string emailUser, string firstNameUser, int CompanyID, int InvoiceID)
    {
        try
        {
            string body = null;
            string invoiceHash = clsEncrypt.CreateHash(Convert.ToString(InvoiceID));

            string link = "<br><br><center><a style='background-color: #007AFF !important;color: #ffffff;height:75px;width:100px;padding: 20px;border-radius:3px;' href='http://HireMatch.azurewebsites.net/viewinvoice.aspx?order=" + invoiceHash + "&customerview=1'>View Invoice</a></center><br><br>";
            body = getEmailTemplate(firstNameUser, "New Invoice Generated", tblEmail.GetEmailTextByType(CompanyID) + link);

            MailMessage myMessage = new MailMessage();
            myMessage.Subject = tblEmail.GetEmailSubject(CompanyID,"1");
            myMessage.Body = body;
            myMessage.IsBodyHtml = true;
            myMessage.To.Add(new MailAddress(emailUser, firstNameUser));
            myMessage.From = new MailAddress("robot@HireMatch.com", "New Invoice");
            SmtpClient smtp = GetSmtpInfo();

            smtp.Send(myMessage);
            return true;
        }
        catch (Exception ex)
        {
            ErrorMessage = ex.Message;
            return false;
        }
    }
   

    public string getEmailTemplate(string firstname, string msgTitle, string MsgContent)
    {
        string body;
        
        body = "<table style='border-spacing: 0px; border-collapse: collapse; width: 574px;'>";
        body += "<tr>";
        body += "<td align='left' style='font-family: 'Segoe UI Light', 'Segoe UI', Arial, sans-serif; margin: 0px; vertical-align: top; text-align: left; ";
        body += "color: rgb(0, 0, 0); font-weight: normal; font-size: 30px; line-height: 60px; padding: 0px; border-collapse: collapse !important;' ";
        body += "valign='top'>";
        body += "<center> <img src='http://HireMatch.azurewebsites.net/assets/images/logo.png' width='50%' style='padding-bottom:15px'/></center>";
        body += "<strong>Hi, {0}</strong><br>";
        body += "{1}";
        body += "</td>";
        body += "</tr>";
        body += "<tr>";
        body += "<td align='left' style='font-family: 'Segoe UI Semilight', 'Segoe UI', Arial, sans-serif; margin: 0px; ";
        body += "vertical-align: top; text-align: left; color: rgb(0, 0, 0); font-weight: normal; font-size: 16px; line-height: 30px; padding: 0px; border-collapse: collapse !important;' valign='top'>";
        body += "<br />";
        body += "{2}<br />";
        body += "<br />";
        body += "Sincerely, HireMatch.com";
        body += "</td>";
        body += "</tr>";
        body += "</table>";

        body = string.Format(body, firstname, msgTitle, MsgContent);

        return body;
    }
}