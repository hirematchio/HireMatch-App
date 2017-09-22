using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class ucActivities : System.Web.UI.UserControl
{
    public clsActivities clsAct = new clsActivities();
    public Company c = new Company();
    dsMainTableAdapters.tblActivityTableAdapter taActivities = new dsMainTableAdapters.tblActivityTableAdapter();
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Url.AbsolutePath.ToLower();
        if (url.Contains("allactivities"))
        {
            GetAllActivities();
        }
        else
        {
            GetTop10Activities();
        }
    }
    protected void GetTop10Activities()
    {
        liViewMore.Visible = true;
        pagerNav.Visible = false;
        Repeater1.DataSource = SqlDataSource1;
        Repeater1.DataBind();
    }
    protected void GetAllActivities()
    {
        liViewMore.Visible = false;
        pagerNav.Visible = true;
        dt = taActivities.GetAllActivities(c.Id, c.EmpId);
        if (dt.Rows.Count > 0)
        {
            //get data
            DataTable postData = dt;
            PagedDataSource pds = new PagedDataSource();
            pds.DataSource = postData.DefaultView;
            //allow paging, set page size, and current page
            pds.AllowPaging = true;
            pds.PageSize = 10;
            pds.CurrentPageIndex = PostListCurrentPage;
            //show # of current page in label
            lblCurrentPage.Text = ((PostListCurrentPage + 1).ToString() + (" of " + pds.PageCount.ToString()));
            //disable prev/next buttons on the first/last pages
            lnkPrevAll.Enabled = !pds.IsFirstPage;
            lnkNextAll.Enabled = !pds.IsLastPage;
            //bind data
            Repeater1.DataSource = pds;
            Repeater1.DataBind();
        }
    }
    public int PostListCurrentPage
    {
        get
        {
            if (ViewState["_currentPage"] == null)
            {
                return 0;
            }
            else
            {
                return (int)ViewState["_currentPage"];
            }
        }
        set
        {
            ViewState["_currentPage"] = value;
        }
    }
    protected void lnkPrevAll_Click(object sender, EventArgs e)
    {
        PostListCurrentPage = (PostListCurrentPage - 1);
        GetAllActivities();
    }
    protected void lnkNextAll_Click(object sender, EventArgs e)
    {
        PostListCurrentPage = (PostListCurrentPage + 1);
        GetAllActivities();
    }
    public string CheckProfileImage(string path)
    {
        string empFile = Server.MapPath(path);
        if (File.Exists(empFile))
        {
            return path;
        }
        else
        {
            return "assets/images/no-image.jpg";
        }
    }
}