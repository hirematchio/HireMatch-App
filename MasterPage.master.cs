using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Globalization;
public partial class MasterPage : System.Web.UI.MasterPage
{
    public event EventHandler contentCallEvent;
    string pageName;
    public Company c = new Company();
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        SetAccessLevel();

        if (Request.QueryString.HasKeys())
        {
            if (!string.IsNullOrEmpty(Request.QueryString["term"]))
            {
                TextBox1.Text = Request.QueryString["term"];
            }

        }

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
    protected void SetAccessLevel()
    {
        if (Request.Cookies["AccessLevel"].Value == "1")
        {
            liEmployees.Visible = false;
            liSettings.Visible = false;
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("universalsearch.aspx");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        UploadFiles();
        if (contentCallEvent != null)
            contentCallEvent(this, EventArgs.Empty);
    }

    protected void UploadFiles()
    {
        string fildir = Server.MapPath("App_Files/Company/" + c.Id + "/orders/" + Request["order"] + "//");
        if (FileUpload1.HasFile)
        {
            if (Directory.Exists(fildir))
            {
                
                FileUpload1.SaveAs(fildir + FileUpload1.FileName);
            }
            else
            {
                System.IO.Directory.CreateDirectory(fildir);
                FileUpload1.SaveAs(fildir + FileUpload1.FileName);
            }
            Response.Redirect("CreateOrder.aspx?mode=edit&order=" + Request["order"]);
        }
           
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
        if (pageName.Equals("createcustomer"))
        {
            btnSave.ValidationGroup = "customer";
        }
        if (pageName.Equals("addinventory"))
        {
            btnSave.ValidationGroup = "asset";
        }
        if (pageName.Equals("createreservation"))
        {
            btnSave.ValidationGroup = "reserve";
        }
        if ((pageName.Equals("myprofile")) || (pageName.Equals("addinventory")))
        {
            btnAddNew.Visible = false;

            //btnCancel.Visible = false;
            //btnPrint.Visible = false;
            //btnSave.Visible = false;
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
        }
            else if (pageName.Equals("createorder"))
        {
            btnAddNew.Visible = false;
           // btnCancel.Visible = false;
            //btnPrint.Visible = false;
            //btnSave.Visible = false;
           
           //btnSaveExtended.Visible = false;
       
            }
        else if (pageName.Equals("invoice"))
        {
            btnAddNew.Visible = false;
             btnCancel.Visible = false;
            //btnPrint.Visible = false;
            //btnSave.Visible = false;
            btnSave.Text = "Send";
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
        }
        else if ( (pageName.Equals("basicsettings"))  || (pageName.Equals("createcustomer")) )
        {
            btnAddNew.Visible = false;
           // btnCancel.Visible = false;
            btnPrint.Visible = false;
            //btnSave.Visible = false;
           btnSaveExtended.Visible = false;
           btnFileUpload.Visible = false;
        }
        else if (pageName.Equals("employees") || (pageName.Equals("orderlist")) || (pageName.Equals("inventory")) || (pageName.Equals("customerlist")) || (pageName.Equals("calendar")))
        {
           // btnAddNew.Visible = false;
            btnCancel.Visible = false;
            btnPrint.Visible = false;
           btnSave.Visible = false;
           btnSaveExtended.Visible = false;
           divextended.Visible = false;
           btnFileUpload.Visible = false;
        }
        else if (pageName.Equals("allactivities"))
        {
            //btnAddNew.Visible = false;
            //btnCancel.Visible = false;
            //btnPrint.Visible = false;
            //btnSave.Visible = false;
            //btnSave.Text = "Send";
            //btnSaveExtended.Visible = false;
            //btnFileUpload.Visible = false;
        }
        else if (pageName.Equals("createreservation"))
        {
            btnAddNew.Visible = false;
            //btnCancel.Visible = false;
            btnPrint.Visible = false;
            //btnSave.Visible = false;
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
            
        }
        else if (pageName.Equals("reservationlist"))
        {
            //btnAddNew.Visible = false;
            btnCancel.Visible = false;
            btnPrint.Visible = false;
            btnSave.Visible = false;
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
        }
        else if (pageName.Equals("default"))
        {
            //btnAddNew.Visible = false;
            btnAddNew.Text = "+ New Job Offer";
            btnCancel.Visible = false;
            btnPrint.Visible = false;
            btnSave.Visible = false;
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
        }
        else
        {
            btnAddNew.Visible = false;
            btnCancel.Visible = false;
            btnPrint.Visible = false;
            btnSave.Visible = false;
            btnSaveExtended.Visible = false;
            btnFileUpload.Visible = false;
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
        TextInfo myTI = new CultureInfo("en-US", false).TextInfo;
        dsMainTableAdapters.tblPageMappingsTableAdapter dsMappings = new dsMainTableAdapters.tblPageMappingsTableAdapter();
        return myTI.ToTitleCase(Convert.ToString(dsMappings.GetPageSubtitle(pageName)));
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
