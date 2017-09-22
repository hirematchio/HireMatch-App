using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class BasicSettings : System.Web.UI.Page
{
    clsActivities clsAct = new clsActivities();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    public Company c = new Company();
    clsMessaging clsmessage = new clsMessaging();
    public string acctLevel0;
    public string acctLevel1;
    public string acctLevel2;
    Label lbl = new Label();
    UserControl uc = new UserControl();
    FileUpload ful = new FileUpload();
    Button btn = new Button();
    DataTable dt = new DataTable();
    Image img = new Image();

    protected void Page_Load(object sender, EventArgs e)
    {
        int accountLevel = Convert.ToInt32(taCompany.GetAccountLevel(c.Id));

        switch (accountLevel)
        {
            case 0:
                acctLevel0 = "active";
                acctLevel1 = "";
                acctLevel2 = "";
                break;
            case 1:
                acctLevel0 = "";
                acctLevel1 = "active hide-link";
                acctLevel2 = "";
                break;
            case 2:
                acctLevel0 = "";
                acctLevel1 = "hide-link";
                acctLevel2 = "active hide-link";
                break;
        }
        GetLogo();
        CheckPayPal();
        CheckAuthorize();
    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
        fvCompany.UpdateItem(true);
        fvMain.UpdateItem(true);
        EmailsVw.UpdateItem(true);
        clsAct.InsertActivity("has updated Settings.");
        clsmessage.SuccessMessage("Updated Settings.");
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
    protected void CheckAuthorize()
    {
        CheckBox box = new CheckBox();
        box = (CheckBox)fvMain.FindControl("chkAuthorize");
        HtmlGenericControl pnl = new HtmlGenericControl();
        pnl = (HtmlGenericControl)fvMain.FindControl("AuthorizeDetails");
        if (box.Checked)
        {
            pnl.Visible = true;
        }
        else
        {
            pnl.Visible = false;
        }
    }
    protected void CheckPayPal()
    {
        CheckBox box = new CheckBox();
        box = (CheckBox)fvMain.FindControl("chkPaypal");
        HtmlGenericControl pnl = new HtmlGenericControl();
        pnl = (HtmlGenericControl)fvMain.FindControl("paypalpanel");
        if (box.Checked)
        {
            pnl.Visible = true;
        }
        else
        {
            pnl.Visible = false;
        }
    }
    protected void chkAuthorizeChanged(object sender, EventArgs e)
    {
        CheckAuthorize();
    }
    protected void chkPayPalChanged(object sender, EventArgs e)
    {
        CheckPayPal();
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        ful = (FileUpload)fvCompany.FindControl("fulLogo");
        btn = (Button)fvMain.FindControl("btnUpload");

        if (ful.HasFile)
        {
            if (Directory.Exists(Server.MapPath("App_Files/Company/" + c.Id)))
            {
                if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png")))
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
                else
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
            }
            else
            {
                Directory.CreateDirectory(Server.MapPath("App_Files/Company/" + c.Id));
                if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png")))
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png"));
                    Response.Redirect(Request.Url.PathAndQuery);
                }
                else
                {
                    ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/logo.png"));
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
    protected void GetLogo()
    {
        img = (Image)fvCompany.FindControl("imgLogo");
        string logoFile = Server.MapPath("App_Files/Company/" + c.Id + "/logo.png");
        if (File.Exists(logoFile))
        {
            img.ImageUrl = "App_Files/Company/" + c.Id + "/logo.png?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss");
        }
        else
        {
            img.ImageUrl = "assets/images/your-logo-here.png";
        }
    }
}