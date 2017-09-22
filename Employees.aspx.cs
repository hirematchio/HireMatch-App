using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Employees : System.Web.UI.Page
{
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    FileUpload ful = new FileUpload();
    Label lbl = new Label();
    Button btn = new Button();
    public Company c = new Company();
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetProfileImage(string empID)
    {
        string assetFile = Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + empID + ".png");
        string strReturn;
        if (File.Exists(assetFile))
        {
            strReturn = "App_Files/Company/" + c.Id + "/ProfileImg/" + empID + ".png?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss");
        }
        else
        {
            strReturn = "assets/images/no-image.jpg";
        }
        return strReturn;
    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
        int accountLevel = Convert.ToInt32(taCompany.GetAccountLevel(c.Id));
        int empCount = Convert.ToInt32(taEmployee.GetEmployeeCount(c.Id));
        switch (accountLevel)
        {
            case 0:
                if (empCount < 1)
                {
                    int empid = Convert.ToInt32(taEmployee.InsertEmployee(c.Id, "", "", "", "", "", 1, false));
                    clsAct.InsertActivity("created a new employee/user profile.");
                    Response.Redirect("MyProfile.aspx?id=" + Convert.ToString(empid));
                }
                else
                {
                    clsmessage.ErrorMessage("Employee limit reached! It is time for an upgrade!");
                }
                break;
            case 1:
                if ((empCount < 2))
                {
                    int empid = Convert.ToInt32(taEmployee.InsertEmployee(c.Id, "", "", "", "", "", 1, false));
                    clsAct.InsertActivity("created a new employee/user profile.");
                    Response.Redirect("MyProfile.aspx?id=" + Convert.ToString(empid));
                }
                else
                {
                    clsmessage.ErrorMessage("Employee limit reached! It is time for an upgrade!");
                }
                break;
            case 2:
                if ((empCount < 100))
                {
                    int empid = Convert.ToInt32(taEmployee.InsertEmployee(c.Id, "", "", "", "", "", 1, false));
                    clsAct.InsertActivity("created a new employee/user profile.");
                    Response.Redirect("MyProfile.aspx?id=" + Convert.ToString(empid));
                }
                else
                {
                    clsmessage.ErrorMessage("Employee limit reached! Lets talk about expanding your inventory!");
                }
                break;
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
}