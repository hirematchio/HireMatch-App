using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Register : System.Web.UI.Page
{

    dsMainTableAdapters.tblEmployeeTableAdapter tbluser = new dsMainTableAdapters.tblEmployeeTableAdapter();
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    dsMainTableAdapters.tblAppSettingsTableAdapter taAppSettings = new dsMainTableAdapters.tblAppSettingsTableAdapter();
    dsMainTableAdapters.tblEmailSettingsTableAdapter taEmailSettings = new dsMainTableAdapters.tblEmailSettingsTableAdapter();
    Company clsCompany = new Company();
    clsMessaging clsmessage = new clsMessaging();
    DataTable dt = new DataTable();
    clsEmail clEmail = new clsEmail();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (chkAgree.Checked == true)
        {
            dt = taEmployee.CheckEmailExists(txtEmail.Text);
            if (dt.Rows.Count > 0)
            {
                clsmessage.ErrorMessage("Email already exists.");
            }
            else
            {
                int coID = Convert.ToInt32(taCompany.InsertCompany(txtCompanyName.Text, "", "", "0", "", "", "", 0));
                clsCompany.CreateCompanyDirectory(coID);
                taEmployee.InsertEmployee(coID, "", "", txtEmail.Text, txtPassword.Text, "", 0, false);
                taAppSettings.InsertAppSettings(0.0, false, "", false, "", "", "", "", coID);
                taEmailSettings.InsertEmailSettings("1", "", coID, "");
                clEmail.ConfirmUserEmailAddress(txtEmail.Text, txtCompanyName.Text, coID);
                clsmessage.SuccessMessageRedirect("Check your email and confirm your account.", "Login.aspx");
            }
        }
        else
        {
            lblError.Visible = true;
        }
    }
}