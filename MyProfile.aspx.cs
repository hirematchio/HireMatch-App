using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class MyProfile : System.Web.UI.Page
{
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    FileUpload ful = new FileUpload();
    Label lbl = new Label();
    Button btn = new Button();
    public Company c = new Company();
    DataTable dt = new DataTable();
    dsMainTableAdapters.tblOrderTableAdapter taOrder = new dsMainTableAdapters.tblOrderTableAdapter();
    dsMainTableAdapters.tblOrderStatusTableAdapter taOrderStatus = new dsMainTableAdapters.tblOrderStatusTableAdapter();

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        ful = fulAsset;
       // lbl = (Label)fvMain.FindControl("lblError");
        btn = (Button)fvMain.FindControl("btnUpload");

        if (ful.HasFile)
        {
            if (Directory.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/")))
            {
                if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png")))
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
                else
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
            }
            else
            {
                Directory.CreateDirectory(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/"));
                if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png")))
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
                else
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + Request["id"] + ".png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
            }
        }
        else
        {
            lbl.Text = "Select file to upload";
            lbl.Visible = true;
        }
       
    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
        fvMain.UpdateItem(true);
        clsAct.InsertActivity("updated his/her Profile.");
        clsmessage.SuccessMessage("Your Profile Has Been Updated.");
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }

    public string CheckProfileImage(string empID)
    {
        string assetFile = Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + empID + ".png");
        if (File.Exists(assetFile))
        {
            imgAsset.ImageUrl = "App_Files/Company/" + c.Id + "/ProfileImg/" + empID + ".png?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss");
        }
        else
        {
            imgAsset.ImageUrl = "assets/images/no-image.jpg";
        }
        return null;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CheckProfileImage(Convert.ToString(Request["id"]));
    }
    public string GetHeading(int orderId)
    {
        dt = taOrder.GetOrder(orderId);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Heading"].ToString() == string.Empty)
            {
                return "Order#" + dt.Rows[0]["Id"].ToString();
            }
            return dt.Rows[0]["Heading"].ToString();
        }
        else
        {
            return "Order#" + dt.Rows[0]["Id"].ToString();
        }
    }
    public string GetOrderStatus(int statusId)
    {
        if (statusId == null)
        {
            return "N/A";
        }
        else
        {
            return taOrderStatus.GetStatus(statusId);
        }
    }
}