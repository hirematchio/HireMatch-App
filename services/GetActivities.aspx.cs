using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class services_GetActivities : System.Web.UI.Page
{
    dsMainTableAdapters.tblActivityTableAdapter tblact = new dsMainTableAdapters.tblActivityTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        Activate();
    }

    public void Activate()
    {
        DataTable dt = default(DataTable);
        try
        {
            dt = tblact.GetActivitiesByCompanyID(Convert.ToInt32(Request.QueryString["ID"]));

            Response.Write("{");
            Response.Write("" + '\u0022' + "ID" + '\u0022' + ": " + '\u0022' + dt.Rows[0][0] + '\u0022' + ",");
            Response.Write("" + '\u0022' + "UserID" + '\u0022' + ": " + '\u0022' + dt.Rows[0][2]  + '\u0022' + ",");
            Response.Write("" + '\u0022' + "Activity" + '\u0022' + ": " + '\u0022' + dt.Rows[0]["mytask"] + '\u0022' + "");
            // Response.Write(String.Format("" & Chr(34) & "alertid" & Chr(34) & ": " & Chr(34) & "{0}" & Chr(34) & "", dt2.Rows(0)(0)))
            Response.Write("}");

        }
        catch (Exception ex)
        {
            Response.Write("{");
            Response.Write("" + '\u0022' + "isSuccess" + '\u0022' + ": " + '\u0022' + "0" + '\u0022' + ",");
            Response.Write(string.Format("" + '\u0022' + "errMsg" + '\u0022' + ": " + '\u0022' + "{0}" + '\u0022' + "", ex.Message));
            Response.Write("}");
        }



    }

}