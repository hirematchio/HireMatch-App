using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
public partial class Logout : System.Web.UI.Page
{
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] cookies = Request.Cookies.AllKeys;

        foreach (string cookie in cookies)
        {
            Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
        }
        FormsAuthentication.SignOut();
        Session.Abandon();
        Response.Redirect("~/Login.aspx", true);
        clsAct.InsertActivity("logged out of HireMatch.");
    }
}