using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UniversalSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.HasKeys())
        {
            if (!string.IsNullOrEmpty(Request.QueryString["term"]))
            {
                if (!IsPostBack)
                {
                TextBox1.Text = Request.QueryString["term"];
                }
            }

        }

    }
}