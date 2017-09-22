using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ctrlPayment : System.Web.UI.UserControl
{
    clsMessaging clsmessage = new clsMessaging();
    clsPayments clsPay = new clsPayments();
    Company c = new Company();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    dsMainTableAdapters.tblOrderTableAdapter taOrder = new dsMainTableAdapters.tblOrderTableAdapter();
    private string _hidCost;
    private int _hidAcctLevel;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnPay_Click(object sender, EventArgs e)
    {
        string paymentResult;
        if ((hidAcctLevel.Value != null) && (hidAcctLevel.Value != string.Empty))
        {
            paymentResult = clsPay.RunPayment(txtCreditNum.Text, ddlmonth.Value + ddlyear.Value, txtFirst.Text, txtLast.Text, Convert.ToDecimal(UpgradeCost));
            int acctLevel = AccountLevel;
            if (paymentResult == "1")
            {
                taCompany.UpdateAccountLevel(acctLevel, c.Id);
                clsmessage.SuccessMessageRedirect("The Card was processed successfully.", Request.Url.PathAndQuery);
            }
            else
            {
                clsmessage.ErrorMessage(paymentResult);
            }
        }
        else
        {
            int orderId = Convert.ToInt32(taOrder.GetCleanOrderID(Request.QueryString["order"]));
            paymentResult = clsPay.RunClientPayment(txtCreditNum.Text, ddlmonth.Value + ddlyear.Value, securitycode.Value, Convert.ToDecimal(UpgradeCost), "", Convert.ToInt32(taOrder.GetCustomerId(orderId)), orderId);
            if (paymentResult == "1")
            {
                taOrder.SetOrderAsPaid(orderId);
                clsmessage.SuccessMessageRedirect("The Card was processed successfully.", Request.Url.PathAndQuery);
            }
            else
            {
                clsmessage.ErrorMessage(paymentResult);
            }
        }
    }
    public string UpgradeCost
    {
        get
        {
            _hidCost = hidCost.Value;
            return _hidCost;
        }
        set
        {
            hidCost.Value = _hidCost;
        }
    }
    public int AccountLevel
    {
        get
        {
            _hidAcctLevel = Convert.ToInt32(hidAcctLevel.Value);
            return _hidAcctLevel;
        }
        set
        {
            hidAcctLevel.Value = _hidAcctLevel.ToString();
        }
    }
}