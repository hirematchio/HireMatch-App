using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class AddInventory : System.Web.UI.Page
{
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    dsMainTableAdapters.tblAssetTableAdapter taAsset = new dsMainTableAdapters.tblAssetTableAdapter();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    FileUpload ful = new FileUpload();
    Label lbl = new Label();
    Button btn = new Button();
    public Company c = new Company();
    DataTable dt = new DataTable();
    bool picUpdated = false;//flag

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetFormViewMode();
        }
    }
    protected void SetFormViewMode()
    {

     
     
                int accountLevel = Convert.ToInt32(taCompany.GetAccountLevel(c.Id));
                int assetCount = Convert.ToInt32(taAsset.GetAssetCount(accountLevel, c.Id));
                switch (accountLevel)
                {
                    case 0:
                        if (assetCount < 10)
                        {
                            fvInventory.DefaultMode = FormViewMode.Insert;
                        }
                        else
                        {
                            clsmessage.ErrorMessage("Asset limit reached! It is time for an upgrade!");
                        }
                        break;
                    case 1:
                        if ((assetCount < 50))
                        {
                            fvInventory.DefaultMode = FormViewMode.Insert;
                        }
                        else
                        {
                            clsmessage.ErrorMessage("Asset limit reached! It is time for an upgrade!");
                        }
                        break;
                    case 2:
                        if ((assetCount < 200))
                        {
                            fvInventory.DefaultMode = FormViewMode.Insert;
                        }
                        else
                        {
                            clsmessage.ErrorMessage("Asset limit reached! Lets talk about expanding your rental asset limit!");
                        }
                        break;
                }
           
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        ful = (FileUpload)fvInventory.FindControl("fulAsset");
        lbl = (Label)fvInventory.FindControl("lblError");
        btn = (Button)fvInventory.FindControl("btnUpload");

        if (ful.HasFile)
        {
            if (Request.QueryString["item"] != null)
            {
                string assetId = Request["item"];
                if (Directory.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/")))
                {
                    if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + assetId + ".png")))
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + assetId + ".png"));
                    }
                    else
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + assetId + ".png"));
                    }
                }
                else
                {
                    Directory.CreateDirectory(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/"));
                    if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + assetId + ".png")))
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + assetId + ".png"));
                    }
                    else
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"));
                    }
                }
            }
            else
            {
                if (Directory.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/")))
                {
                    if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png")))
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"));
                    }
                    else
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"));
                    }
                }
                else
                {
                    Directory.CreateDirectory(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/"));
                    if (File.Exists(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png")))
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"));
                    }
                    else
                    {
                        ful.SaveAs(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"));
                    }
                }
            }
            picUpdated = true;
            if (Request.QueryString["mode"] == "insert")
            {
                fvInventory.InsertItem(true);
            }
            else if (Request.QueryString["mode"] == "edit")
            {
                fvInventory.UpdateItem(true);
            }
        }
        else
        {
            lbl.Text = "Select file to upload";
            lbl.Visible = true;
        }
    }
    public string CheckAssetImage(string path)
    {
        string assetFile = Server.MapPath(path);
        if (File.Exists(assetFile))
        {
            return path;
        }
        else
        {
            Image img = new Image();
            img = (Image)fvInventory.FindControl("imgAsset");
            img.ImageUrl = "assets/images/no-image-asset.png";
            return "assets/images/no-image-asset.png";
        }
    }
    public void CopyFile(string oldFile, string newFile)
    {
        if (File.Exists(oldFile))
        {
            File.Copy(oldFile, newFile, true);
            if (oldFile.Contains("new"))
            {
                File.Delete(oldFile);
            }
        }
    }
    protected void SqlInventory_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        int id = Convert.ToInt32(e.Command.Parameters["@Id"].Value);
        CopyFile(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"), Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + id + ".png"));
        if (picUpdated)
        {
            clsmessage.SuccessMessageRedirect("Rental Asset Image Updated", "AddInventory.aspx?mode=edit&item=" + id);
        }
        else
        {
            clsmessage.SuccessMessageRedirect("Rental Asset Created", "Inventory.aspx");
        }
    }
    protected void SqlInventory_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        int id = Convert.ToInt32(e.Command.Parameters["@Id"].Value);
        CopyFile(Server.MapPath("App_Files/Company/" + c.Id + "/Assets/new.png"), Server.MapPath("App_Files/Company/" + c.Id + "/Assets/" + id + ".png"));
        if (picUpdated)
        {
            clsmessage.SuccessMessageRedirect("Rental Asset Image Updated", "AddInventory.aspx?mode=edit&item=" + id);
        }
        else
        {
            clsmessage.SuccessMessageRedirect("Rental Asset Updated", "Inventory.aspx");
        }
    }

    private void Master_ButtonClick(object sender, EventArgs e)
    {
        TextBox txtMinute = new TextBox();
        TextBox txtHour = new TextBox();
        TextBox txtDay = new TextBox();
        TextBox txtWeek = new TextBox();
        TextBox txtMonth = new TextBox();
        TextBox txt = new TextBox();

        txtMinute = (TextBox)fvInventory.FindControl("txtPerMinute");
        txtHour = (TextBox)fvInventory.FindControl("txtPerHour");
        txtDay = (TextBox)fvInventory.FindControl("txtPerDay");
        txtWeek = (TextBox)fvInventory.FindControl("txtPerWeek");
        txtMonth = (TextBox)fvInventory.FindControl("txtPerMonth");

        decimal mi, h, d, w, mo;

        if ((!Decimal.TryParse(txtMinute.Text, out mi)) || !Decimal.TryParse(txtHour.Text, out h) || !Decimal.TryParse(txtDay.Text, out d) || !Decimal.TryParse(txtWeek.Text, out w) || !Decimal.TryParse(txtMonth.Text, out mo))
        {
            clsmessage.ErrorMessage("Prices must be numeric only.");
        }
        else
        {
            txt = (TextBox)fvInventory.FindControl("txtItemName");
            if (fvInventory.CurrentMode == FormViewMode.Insert)
            {
                clsAct.InsertActivity("added <a href='AddInventory.aspx?mode=edit&item=" + Request.QueryString["item"] + "'>a rental asset item (" + txt.Text + ") </a>");
                fvInventory.InsertItem(true);
            }
            else
            {
                clsAct.InsertActivity("updated <a href='AddInventory.aspx?mode=edit&item=" + Request.QueryString["item"] + "'>a rental asset item (" + txt.Text + ") </a>");
                fvInventory.UpdateItem(true);
            }
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
}