using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderList : System.Web.UI.Page
{
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
       // clsAct.InsertActivity("created an order.");
        Response.Redirect("CreateOrder.aspx?new=1");
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
}