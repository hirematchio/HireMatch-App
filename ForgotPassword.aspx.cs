using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ForgotPassword : System.Web.UI.Page
{
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();
    DataTable dt = new DataTable();
    clsMessaging message = new clsMessaging();
    clsEmail em = new clsEmail();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnGetPassword_Click(object sender, EventArgs e)
    {
        dt = taEmployee.CheckEmailExistsAll(txtEmail.Text);
        if (dt.Rows.Count > 0)
        {
            if (em.ForgotPassword(dt.Rows[0]["Email"].ToString(), dt.Rows[0]["FirstName"].ToString(), dt.Rows[0]["Password"].ToString()))
            {
                message.SuccessMessageRedirect("Email sent with password", "Login.aspx");
            }
            else
            {
                message.ErrorMessage(em.ErrorMessage);
            }
        }
        else
        {
            message.ErrorMessage("Email does not exist.");
        }

    }
}