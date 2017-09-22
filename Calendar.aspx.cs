using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;
using System.Globalization;
using System.Threading;
public partial class Calendar : System.Web.UI.Page
{
    public Company c = new Company();
    public string reservations;
    dsMainTableAdapters.tblCustomerCategoryTableAdapter taCategory = new dsMainTableAdapters.tblCustomerCategoryTableAdapter();
    dsMainTableAdapters.tblCustomerStatusTableAdapter taStatus = new dsMainTableAdapters.tblCustomerStatusTableAdapter();
    dsMainTableAdapters.tblAssetTableAdapter taAsset = new dsMainTableAdapters.tblAssetTableAdapter();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    protected void Page_Load(object sender, EventArgs e)
    {
        dsMainTableAdapters.tblReservationTableAdapter tblReservation = new dsMainTableAdapters.tblReservationTableAdapter();
      
        DataTable dt  = tblReservation.GetReservationByCompany(c.Id);
        int i = 0;
        reservations = "[ " + Environment.NewLine;
        CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
        TextInfo textInfo = cultureInfo.TextInfo;

        foreach (DataRow rw in dt.Rows)
        {

            reservations += "{ " + Environment.NewLine;
            reservations += "id: '" + rw["id"].ToString() + "', " + Environment.NewLine;
            reservations += "title: '" + textInfo.ToTitleCase(rw["LastName"].ToString()) + ", " + textInfo.ToTitleCase(rw["FirstName"].ToString()) + "'," + Environment.NewLine;
            reservations += "url : 'devplace.aspx?reservation=" + rw["id"].ToString() + "',";
        


             i = i + 1;

            if ((i == dt.Rows.Count) || (i > dt.Rows.Count))
            {
                 reservations += "}" + Environment.NewLine;
                 reservations += "]" + Environment.NewLine;
                 return;
            }

             reservations += "}," + Environment.NewLine;
            
        }
        
       
    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
        //check if inventory exists before adding customer

          //  Response.Redirect("#");

    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
}