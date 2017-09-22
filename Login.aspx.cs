using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
public partial class Login : System.Web.UI.Page
{
    dsMainTableAdapters.tblEmployeeTableAdapter tbluser = new dsMainTableAdapters.tblEmployeeTableAdapter();
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    bool ValidateUser(string user, string pass)
    {
        string connStr = ConfigurationManager.ConnectionStrings["ZamvAppConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string sql = "select * from tblemployee where email = @email and password = @password";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dataTable = new DataTable();
            cmd.Parameters.AddWithValue("@email", user);
            cmd.Parameters.AddWithValue("@password", pass);

            da.Fill(dataTable);

            if (dataTable.Rows.Count > 0)
            {
                if (Convert.ToBoolean(dataTable.Rows[0]["IsConfirmed"]) == true)
                {
                    if (chkStayLoggedIn.Checked == true)
                    {
                        Response.Cookies["EmpID"].Value = Convert.ToString(dataTable.Rows[0]["Id"]);
                        Response.Cookies["EmpID"].Expires = DateTime.Now.AddDays(1);
                        Response.Cookies["CompanyID"].Value = Convert.ToString(dataTable.Rows[0]["CompanyId"]);
                        Response.Cookies["CompanyID"].Expires = DateTime.Now.AddDays(1);
                        Response.Cookies["AccessLevel"].Value = Convert.ToString(dataTable.Rows[0]["AccessLevel"]);
                        Response.Cookies["AccessLevel"].Expires = DateTime.Now.AddDays(1);
                        return dataTable.Rows.Count > 0;
                    }
                    else
                    {
                        Response.Cookies["EmpID"].Value = Convert.ToString(dataTable.Rows[0]["Id"]);
                        Response.Cookies["CompanyID"].Value = Convert.ToString(dataTable.Rows[0]["CompanyId"]);
                        Response.Cookies["AccessLevel"].Value = Convert.ToString(dataTable.Rows[0]["AccessLevel"]);
                        return dataTable.Rows.Count > 0;
                    }
                }
                else
                {
                    lblErr.Text = "Email address not confirmed.";
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
    }
    protected void btnRegister_Click1(object sender, EventArgs e)
    {
        if (ValidateUser(txtEmail.Text, txtPassword.Text))
        {
            FormsAuthentication.SetAuthCookie(txtEmail.Text, true);
            clsAct.InsertActivity("logged in to HireMatch.");
            Response.Redirect("Default.aspx");
        }
        else
        {
            lblErr.Visible = true;
        }
    }
}