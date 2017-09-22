using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
public partial class MasterPage : System.Web.UI.MasterPage
{
    public event EventHandler contentCallEvent;
    string pageName;
    public Company c = new Company();
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        pageName = this.Page.ToString().ToLower().Substring(4, this.Page.ToString().Substring(4).Length - 5);
        SetButtons();
        CheckProfileImage();
        if (!IsPostBack)
        {
            if (Request.UrlReferrer != null)
            {
            ViewState.Add("ReferrerUrl", Request.UrlReferrer.ToString());
            }
            else
            {
            ViewState.Add("ReferrerUrl", "default.aspx");
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (contentCallEvent != null)
            contentCallEvent(this, EventArgs.Empty);
    }

    protected void SetButtons()
    {
       // string pageName = this.Page.ToString().ToLower().Substring(4, this.Page.ToString().Substring(4).Length - 5);
        if (pageName.Equals("createorder"))
        {
            btnSave.ValidationGroup = "order";
        }
        if (pageName.Equals("myprofile"))
        {
            btnSave.ValidationGroup = "emp";
        }
        if ((pageName.Equals("myprofile")) || (pageName.Equals("createorder")) || (pageName.Equals("addinventory")))
        {
            btnAddNew.Visible = false;
            //btnCancel.Visible = false;
            //btnPrint.Visible = false;
           // btnSave.Visible = false;
          //  btnSaveExtended.Visible = true;
        }
        else if ( (pageName.Equals("basicsettings"))  || (pageName.Equals("createcustomer")) || (pageName.Equals("createorder")))
        {
            btnAddNew.Visible = false;
           // btnCancel.Visible = false;
            btnPrint.Visible = false;
           // btnSave.Visible = false;
           btnSaveExtended.Visible = false;
        }
        else if (pageName.Equals("employees") || (pageName.Equals("orderlist")) || (pageName.Equals("inventory")) || (pageName.Equals("customerlist")))
        {
           // btnAddNew.Visible = false;
            btnCancel.Visible = false;
            btnPrint.Visible = false;
           btnSave.Visible = false;
           btnSaveExtended.Visible = false;
        }
        else
        {
            btnAddNew.Visible = false;
            btnCancel.Visible = false;
            btnPrint.Visible = false;
            btnSave.Visible = false;
            btnSaveExtended.Visible = false;
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
       // Uri myReferrer = Request.UrlReferrer;
      //  string actual = myReferrer.ToString();
        string myReferrer = (string)ViewState["ReferrerUrl"];
        Response.Redirect(myReferrer);
    }

    public string GetPageHeading()
    {
        dsMainTableAdapters.tblPageMappingsTableAdapter dsMappings = new dsMainTableAdapters.tblPageMappingsTableAdapter();
        return Convert.ToString(dsMappings.GetPageHeading(pageName));
    }

      public string GetPageSubTitle()
    {
        dsMainTableAdapters.tblPageMappingsTableAdapter dsMappings = new dsMainTableAdapters.tblPageMappingsTableAdapter();
        return Convert.ToString(dsMappings.GetPageSubtitle(pageName));
    }

      public string CheckProfileImage()
      {
          string assetFile = Server.MapPath("App_Files/Company/" + c.Id + "/ProfileImg/" + c.EmpId + ".png");
          if (File.Exists(assetFile))
          {
              imgAsset.ImageUrl = "App_Files/Company/" + c.Id + "/ProfileImg/" + c.EmpId + ".png?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss");
          }
          else
          {
              imgAsset.ImageUrl = "assets/images/no-image.jpg";
          }
          return null;
      }

      protected void btnAddNew_Click(object sender, EventArgs e)
      {
          if (contentCallEvent != null)
              contentCallEvent(this, EventArgs.Empty);
      }
}
