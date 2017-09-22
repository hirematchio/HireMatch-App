using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    public clsActivities clsAct = new clsActivities();
    clsMessaging clsmessage = new clsMessaging();
    dsMainTableAdapters.tblOrderTableAdapter taOrder = new dsMainTableAdapters.tblOrderTableAdapter();
    DataTable dt = new DataTable();
    public int outCount;
    public int dueCount;
    public int overdueCount;
    public int totalOutOrderCount;
    public int allOrdersForWeekCount;
    public decimal totalRevenue;
    Company c = new Company();

    protected void Page_Load(object sender, EventArgs e)
    {
      //  clsmessage.HTML5notification("test");
        outCount = Convert.ToInt32(taOrder.CountCurrentOutOrders(c.Id, DateTime.Now));
        dueCount = Convert.ToInt32(taOrder.CountDueTodayOrders(c.Id, DateTime.Now));
        overdueCount = Convert.ToInt32(taOrder.CountOverDueOrders(c.Id, DateTime.Now));
        totalRevenue = Convert.ToDecimal(taOrder.RevenueForCurrentWeek(c.Id, DateTime.Now.AddDays(Convert.ToDouble(-7))));
        totalOutOrderCount = outCount + dueCount + overdueCount;

        allOrdersForWeekCount = Convert.ToInt32(taOrder.TotalOrderCountForCurrentWeek(c.Id, DateTime.Now.AddDays(Convert.ToDouble(-7))));
    }


    private void Master_ButtonClick(object sender, EventArgs e)
    {

            Response.Redirect("AddInventory.aspx?mode=insert");
        

    }

    
}