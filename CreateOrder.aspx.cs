using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class CreateOrder : System.Web.UI.Page
{
    public Company c = new Company();
    dsMainTableAdapters.tblOrderTableAdapter taOrder = new dsMainTableAdapters.tblOrderTableAdapter();
    dsMainTableAdapters.tblAssetsOnOrderTableAdapter taAssetOnOrder = new dsMainTableAdapters.tblAssetsOnOrderTableAdapter();
    dsMainTableAdapters.tblAssetTableAdapter taAsset = new dsMainTableAdapters.tblAssetTableAdapter();
    dsMainTableAdapters.tblOrderStatusTableAdapter taStatus = new dsMainTableAdapters.tblOrderStatusTableAdapter();
    dsMainTableAdapters.tblCustomerTableAdapter taCustomer = new dsMainTableAdapters.tblCustomerTableAdapter();
    DataTable dt = new DataTable();
    DropDownList ddl = new DropDownList();
    FileUpload ful = new FileUpload();
    Label lbl = new Label();
    Button btn = new Button();
    TextBox txt = new TextBox();
    SqlDataSource sql = new SqlDataSource();
    clsMessaging clsmessage = new clsMessaging();
    clsActivities clsAct = new clsActivities();
    bool customerAdded = false;//flag

    public RadioButtonList radList = new RadioButtonList();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetFormViewMode();
        }
    }
    protected void SetFormViewMode()
    {
        if (Request.QueryString["mode"] != null)
        {
            if (Request.QueryString["mode"] == "edit")
            {
                fvOrder.DefaultMode = FormViewMode.Edit;
                GetOrderStatus();
                GetFiles();
                //txtCustomerFName
                txt = (TextBox)fvOrder.FindControl("txtCustomerFName");
              //  txt.Focus();
            }
            else if (Request.QueryString["mode"] == "delete")
            {
                if (Request.QueryString["order"] != null)
                {
                    taOrder.DeleteOrder(Convert.ToInt32(Request.QueryString["order"]));
                    clsmessage.SuccessMessageRedirect("Order Removed Successfully!", "OrderList.aspx");
                }
            }
        }
        if (Request.QueryString["new"] != null)
        {
            int customerCount = Convert.ToInt32(taCustomer.GetCustomerCount(c.Id));
            if (customerCount > 0)
            {
                int id = Convert.ToInt32(taOrder.InsertOrder(c.Id, 0, "", DateTime.Now, DateTime.Now.AddDays(1), "", "", "", "0", "", "", "", 0, 0, "", "", "", DateTime.Now, 0, 0, 0, false, false, 0, null, 0));
                Response.Redirect("CreateOrder.aspx?mode=edit&order=" + id);
            }
            else
            {
                clsmessage.ErrorMessageRedirect("Please add a customer first.", "CreateCustomer.aspx?mode=insert");
            }
        }
    }
    protected void GetOrderStatus()
    {
        Button btnIn = new Button();
        Button btnOut = new Button();
        Label lbl = new Label();
        HtmlGenericControl divNew = new HtmlGenericControl();
        HtmlGenericControl divOut = new HtmlGenericControl();
        HtmlGenericControl divIn = new HtmlGenericControl();
        divNew = (HtmlGenericControl)fvOrder.FindControl("divNewOrder");
        divOut = (HtmlGenericControl)fvOrder.FindControl("divCheckedOut");
        divIn = (HtmlGenericControl)fvOrder.FindControl("divCheckedIn");
        btnIn = (Button)fvOrder.FindControl("btnCheckIn");
        btnOut = (Button)fvOrder.FindControl("btnCheckOut");
        lbl = (Label)fvOrder.FindControl("lblOrderClosed");

        dt = taOrder.GetOrderStatus(Convert.ToInt32(Request.QueryString["order"]));
        if (dt.Rows.Count > 0)
        {
            bool checkedin;
            bool checkedout;

            if (dt.Rows[0]["IsCheckedIn"] == DBNull.Value)
            {
                checkedin = false;
            }
            else
            {
                checkedin = Convert.ToBoolean(dt.Rows[0]["IsCheckedIn"]);
            }

            if (dt.Rows[0]["IsCheckedOut"] == DBNull.Value)
            {
                checkedout = false;
            }
            else
            {
                checkedout = Convert.ToBoolean(dt.Rows[0]["IsCheckedOut"]);
            }

            if ((checkedin == false) && (checkedout == false))
            {
                divNew.Visible = true;
                divIn.Visible = false;
                divOut.Visible = false;
                btnOut.Visible = true;
            }
            else if ((checkedin == false) && (checkedout == true))
            {
                divNew.Visible = false;
                divIn.Visible = false;
                divOut.Visible = true;
                btnIn.Visible = true;
            }
            else if ((checkedin == true) && (checkedout == false))
            {
                divNew.Visible = false;
                divIn.Visible = true;
                divOut.Visible = false;
                lbl.Visible = true;
            }
        }
    }
    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        ddl = (DropDownList)fvOrder.FindControl("ddlItems");
        taAssetOnOrder.InsertAssetOnOrder(c.Id, Convert.ToInt32(Request.QueryString["order"]), Convert.ToInt32(ddl.SelectedValue));
        taAsset.AssetIsRented(Convert.ToInt32(ddl.SelectedValue));
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void GetFiles()
    {
        string filepath = "App_Files/Company/" + c.Id + "/orders/" + Request["order"] + "/";
        string fildir = Server.MapPath(filepath);

        if (System.IO.Directory.Exists(fildir))
        {
            string[] fileEntries = System.IO.Directory.GetFiles(fildir);

            foreach (string fileName in fileEntries)
            {
                var bl = (HtmlGenericControl)fvOrder.FindControl("FileList");
                bl.InnerHtml += "<a target='_blank' class='list-group-item' href='" + filepath + System.IO.Path.GetFileName(fileName) + "'>" + System.IO.Path.GetFileName(fileName) + "</a>";
            }
        }
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        ddl = (DropDownList)fvOrder.FindControl("ddlItemsOnOrder");
        taAssetOnOrder.RemoveAssetFromOrder(c.Id, Convert.ToInt32(Request.QueryString["order"]), Convert.ToInt32(ddl.SelectedValue));
        taAsset.AssetIsBack(Convert.ToInt32(ddl.SelectedValue));
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void btnAddStatus_Click(object sender, EventArgs e)
    {
        sql = (SqlDataSource)Page.FindControl("SqlOrder");
        ddl = (DropDownList)fvOrder.FindControl("ddlStatus");
        txt = (TextBox)fvOrder.FindControl("txtNewStatus");
        int statusId = Convert.ToInt32(taStatus.InsertStatus(c.Id, txt.Text));
        ddl.Items.Add(new ListItem(txt.Text, statusId.ToString()));
        ddl.SelectedValue = statusId.ToString();
    }

    protected void btnAddCustomer_Click(object sender, EventArgs e)
    {
        TextBox txtfirst = new TextBox();
        TextBox txtlast = new TextBox();
        TextBox txtAddress = new TextBox();
        TextBox txtCity = new TextBox();
        DropDownList ddlState = new DropDownList();
        TextBox txtZipCode = new TextBox();

        txtlast = (TextBox)fvOrder.FindControl("txtCustomerLName");
        txtfirst = (TextBox)fvOrder.FindControl("txtCustomerFName");
        txtAddress = (TextBox)fvOrder.FindControl("txtCustomerAddress");
        txtCity = (TextBox)fvOrder.FindControl("txtCustomerCity");
        ddlState = (DropDownList)fvOrder.FindControl("ddlCustomerState");
        txtZipCode = (TextBox)fvOrder.FindControl("txtCustomerZipCode");

        taCustomer.InsertCustomer(c.Id, txtfirst.Text, txtlast.Text, txtAddress.Text, txtCity.Text, ddlState.SelectedValue, txtZipCode.Text);
        customerAdded = true;
        clsmessage.SuccessMessageRedirect("Customer Added", Request.Url.PathAndQuery);
    }
    private void Master_ButtonClick(object sender, EventArgs e)
    {
        if (fvOrder.CurrentMode == FormViewMode.Insert)
        {
            fvOrder.InsertItem(true);
            clsmessage.SuccessMessageRedirect("Order Created", "OrderList.aspx");
        }
        else
        {
            TextBox txt = new TextBox();
            txt = (TextBox)fvOrder.FindControl("txtRevenue");
            txt.Text = CalculateRevenue(Convert.ToInt32(Request.QueryString["order"])).ToString();
            fvOrder.UpdateItem(true);
            TextBox txt2 = new TextBox();
            txt2 = (TextBox)fvOrder.FindControl("txtHeading");
            clsAct.InsertActivity("updated <a href='CreateOrder.aspx?mode=edit&order=" + Request.QueryString["order"] + "'>an order (" + txt2.Text + ") </a>");
            clsmessage.SuccessMessageRedirect("Order Updated", "OrderList.aspx");
        }
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        // Create an event handler for the master page's contentCallEvent event
        Master.contentCallEvent += new EventHandler(Master_ButtonClick);
    }
    public string GetOrderDuration(string duration, string outDate, string returnDate)
    {
        TimeSpan ts = new TimeSpan();
        DateTime od = new DateTime();
        od = Convert.ToDateTime(outDate);
        DateTime rd = new DateTime();
        rd = Convert.ToDateTime(returnDate);
        ts = rd - od;

        int payType = GetPayType();

        if (duration != string.Empty)
        {
            return duration;
        }
        else
        {
            switch (payType)
            {
                case 1:
                    return ts.TotalMinutes.ToString() + " minutes";
                case 2:
                    return ts.TotalHours.ToString() + " hours";
                case 3:
                    return Convert.ToInt32(ts.TotalDays).ToString() + " days";
                case 4:
                    int weeks = Convert.ToInt32(ts.TotalDays / 7);
                    return weeks.ToString() + " weeks";
                case 5:
                    int months = Convert.ToInt32(ts.TotalDays / 30);
                    return months.ToString() + " months";
                case 0:
                    clsmessage.ErrorMessage("Please select pay type.");
                    break;
            }
            return string.Empty;
        }
    }
    protected int GetPayType()
    {
        radList = (RadioButtonList)fvOrder.FindControl("radPayTypes");
        if (radList.SelectedValue == string.Empty)
        {
            return 0;
        }
        else
        {
            return Convert.ToInt32(radList.SelectedValue);
        }
    }
    protected void radPayTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (customerAdded)
        {
            clsmessage.SuccessMessageRedirect("Customer Added", Request.Url.PathAndQuery);
        }
        else
        {
            OrderDurationChanged();
        }
    }
    public void OrderDurationChanged()
    {
        TextBox duration = new TextBox();
        TextBox revenue = new TextBox();
        TextBox od = new TextBox();
        TextBox rd = new TextBox();

        duration = (TextBox)fvOrder.FindControl("txtOrderDuration");
        od = (TextBox)fvOrder.FindControl("txtOutDate");
        rd = (TextBox)fvOrder.FindControl("txtReturnDate");
        revenue = (TextBox)fvOrder.FindControl("txtRevenue");

        duration.Text = GetOrderDuration(string.Empty, od.Text, rd.Text);
        revenue.Text = CalculateRevenue(Convert.ToInt32(Request.QueryString["order"])).ToString();
    }
    protected void txtOutDate_TextChanged(object sender, EventArgs e)
    {
        if (customerAdded)
        {
            clsmessage.SuccessMessageRedirect("Customer Added", Request.Url.PathAndQuery);
        }
        else
        {
            OrderDurationChanged();
        }
    }
    protected void txtReturnDate_TextChanged(object sender, EventArgs e)
    {
        if (customerAdded)
        {
            clsmessage.SuccessMessageRedirect("Customer Added", Request.Url.PathAndQuery);
        }
        else
        {
            OrderDurationChanged();
        }
    }
    public decimal CalculateRevenue(int orderId)
    {
        TextBox txt = new TextBox();
        txt = (TextBox)fvOrder.FindControl("txtOrderDuration");
        decimal totalRevenue = 0;
        if (txt.Text != string.Empty)
        {
            int payType = GetPayType();
            dt = taAssetOnOrder.GetAssetsOnOrderForRevenue(orderId);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    switch (payType)
                    {
                        case 1:
                            totalRevenue += Convert.ToDecimal(row["PricePerMinute"]) * Convert.ToDecimal(txt.Text.Replace(" minutes", "").Replace(" hours", "").Replace(" days", "").Replace(" weeks", "").Replace(" months", ""));
                            break;
                        case 2:
                            totalRevenue += Convert.ToDecimal(row["PricePerHour"]) * Convert.ToDecimal(txt.Text.Replace(" minutes", "").Replace(" hours", "").Replace(" days", "").Replace(" weeks", "").Replace(" months", ""));
                            break;
                        case 3:
                            totalRevenue += Convert.ToDecimal(row["PricePerDay"]) * Convert.ToDecimal(txt.Text.Replace(" minutes", "").Replace(" hours", "").Replace(" days", "").Replace(" weeks", "").Replace(" months", ""));
                            break;
                        case 4:
                            totalRevenue += Convert.ToDecimal(row["PricePerWeek"]) * Convert.ToDecimal(txt.Text.Replace(" minutes", "").Replace(" hours", "").Replace(" days", "").Replace(" weeks", "").Replace(" months", ""));
                            break;
                        case 5:
                            totalRevenue += Convert.ToDecimal(row["PricePerMonth"]) * Convert.ToDecimal(txt.Text.Replace(" minutes", "").Replace(" hours", "").Replace(" days", "").Replace(" weeks", "").Replace(" months", ""));
                            break;
                        case 0:
                            clsmessage.ErrorMessage("Please select pay type.");
                            break;
                    }
                }
                if (dt.Rows[0]["DateCheckedIn"] != DBNull.Value)
                {
                    DateTime dtExpected = new DateTime();
                    DateTime dtActual = new DateTime();
                    dtExpected = Convert.ToDateTime(dt.Rows[0]["RentalReturnDate"]);
                    dtActual = Convert.ToDateTime(dt.Rows[0]["DateCheckedIn"]);
                    if (dtActual > dtExpected)
                    {
                        totalRevenue = totalRevenue + Convert.ToDecimal(dt.Rows[0]["decLateFee"]) - Convert.ToDecimal(dt.Rows[0]["Discount"]);
                    }
                    else
                    {
                        totalRevenue = totalRevenue - Convert.ToDecimal(dt.Rows[0]["Discount"]);
                    }
                }
                else
                {
                    totalRevenue = totalRevenue - Convert.ToDecimal(dt.Rows[0]["Discount"]);
                }
                if (dt.Rows[0]["TaxRate"] != DBNull.Value)
                {
                    decimal taxRate = Convert.ToDecimal(dt.Rows[0]["TaxRate"]);
                    decimal tax = ((taxRate / Convert.ToDecimal(100)) * totalRevenue);
                    totalRevenue = totalRevenue + tax;
                }
            }
            else
            {
                ddl = (DropDownList)fvOrder.FindControl("ddlItems");
                ddl.Focus();
                clsmessage.ErrorMessage("Please add item to order.");
            }
        }
        return totalRevenue;
    }
    protected void btnCheckOut_Click(object sender, EventArgs e)
    {
        //set order ischeckedout to true, order is changed from new/incomplete to open
        taOrder.CheckOutOrder(Convert.ToInt32(Request.QueryString["order"]));
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void btnCheckIn_Click(object sender, EventArgs e)
    {
        //set order ischeckedin to true, ischeckedout to false, set checkedin date, 
        taOrder.CheckInOrder(DateTime.Now, Convert.ToInt32(Request.QueryString["order"]));

        //and all assets on order to isrented = false, order is changed from open to closed
        dt = taAssetOnOrder.GetAssetIdsOnOrder(Convert.ToInt32(Request.QueryString["order"]));
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow r in dt.Rows)
            {
                taAsset.AssetIsBack(Convert.ToInt32(r["Id"]));
            }
        }

        Response.Redirect(Request.Url.PathAndQuery);
    }
}