using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Confirm : System.Web.UI.Page
{
    Company c = new Company();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //confirm company owner (0)
            if (c.ConfirmEmployeeEmail(Convert.ToInt32(Request.QueryString["id"]), 0))
            {
                //redirect to login
                Response.Redirect("Login.aspx");
            }
        }
    }
}