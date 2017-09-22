using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using C2IT.PaymentProcessors;
using System.Configuration;
using System.Text;
using System.Threading.Tasks;
using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Net.Mail;

public class clsPayments
{
    public string RunPayment(string CardNum, string expirationDate, string fname, string lname, decimal decamt)
    {
        String ApiLoginID, ApiTransactionKey;

        // ApiLoginID = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetVersion"];
        // ApiLoginID= System.Web.Configuration.WebConfigurationManager.AppSettings["AuthMerchantEmail"];
        ApiLoginID = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetLoginId"];
        ApiTransactionKey = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetTransKey"];

        Console.WriteLine("Create Subscription Sample");

        ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.PRODUCTION;

        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            name = ApiLoginID,
            ItemElementName = ItemChoiceType.transactionKey,
            Item = ApiTransactionKey,
        };

        paymentScheduleTypeInterval interval = new paymentScheduleTypeInterval();

        interval.length = 1;                        // months can be indicated between 1 and 12
        interval.unit = ARBSubscriptionUnitEnum.months;

        paymentScheduleType schedule = new paymentScheduleType
        {
            interval = interval,
            startDate = DateTime.Now.AddDays(1),      // start date should be tomorrow
            totalOccurrences = 9999,                          // 999 indicates no end date
            trialOccurrences = 3
        };

        #region Payment Information
        var creditCard = new creditCardType
        {
            cardNumber = CardNum,
            expirationDate = expirationDate
        };

        //standard api call to retrieve response
        paymentType cc = new paymentType { Item = creditCard };
        #endregion

        nameAndAddressType addressInfo = new nameAndAddressType()
        {
            firstName = fname,
            lastName = lname
        };

        ARBSubscriptionType subscriptionType = new ARBSubscriptionType()
        {
            amount = decamt,
            trialAmount = 0.00m,
            paymentSchedule = schedule,
            billTo = addressInfo,
            payment = cc
        };

        var request = new ARBCreateSubscriptionRequest { subscription = subscriptionType };

        var controller = new ARBCreateSubscriptionController(request);          // instantiate the contoller that will call the service
        controller.Execute();

        ARBCreateSubscriptionResponse response = controller.GetApiResponse();   // get the response from the service (errors contained if any)

        //validate
        if (response != null && response.messages.resultCode == messageTypeEnum.Ok)
        {
            if (response != null && response.messages.message != null)
            {
                Console.WriteLine("Success, Subscription ID : " + response.subscriptionId.ToString());
                return "1";
            }
            else
            {
                //Console.WriteLine("Error: " + response.messages.message[0].code + "  " + response.messages.message[0].text);
                return "Error: " + response.messages.message[0].code + "  " + response.messages.message[0].text;
            }
        }
        else
        {
            //Console.WriteLine("Error: " + response.messages.message[0].code + "  " + response.messages.message[0].text);
            return "Error: " + response.messages.message[0].code + "  " + response.messages.message[0].text;
        }

    }

    public string RunClientPayment(string CardNum, string expirationDate, string ccVerification, decimal decamt, string msg, int customerId, int orderId)
    {
        if (decamt == 0)
        {
            return "1";
        }

        clsAuthNet.MerchantInfo MerchantInfo = new clsAuthNet.MerchantInfo();
        clsAuthNet.OrderInfo OrderInfo = new clsAuthNet.OrderInfo();
        clsAuthNet.Output Results = new clsAuthNet.Output();

        Company c = new Company();
        clsAppSettings app = new clsAppSettings();
        app.GetAuthNetSettings(c.Id);

        MerchantInfo.AuthNetVersion = app.version;
        MerchantInfo.MerchantEmail = app.email;
        MerchantInfo.AuthNetLoginId = app.login;
        MerchantInfo.AuthNetTransKey = app.key;

        OrderInfo.Amount = Convert.ToDouble(decamt);
        OrderInfo.CreditCardNumber = CardNum;
        OrderInfo.ExpireDate = expirationDate;
        OrderInfo.IPNumber = HttpContext.Current.Request.UserHostAddress;
        OrderInfo.SecurityCode = ccVerification;

        Results = clsAuthNet.ProcessPayment(MerchantInfo, OrderInfo);

        if (Results.HasError == true)
        {
            msg = Results.ErrorMessage;
            return msg;
        }
        else
        {
            //msg = DateTime.Now.ToString() + ": SUCCESS!<br/>Auth:" + Results.AuthorizationCode + "<BR/>ID:" + Results.TransactionId;

            //insert into tblPayment?
            dsMainTableAdapters.tblPaymentTableAdapter taPay = new dsMainTableAdapters.tblPaymentTableAdapter();
            taPay.InsertPayment(c.Id, customerId, orderId, "AuthorizeNet", decamt, Results.TransactionId);
            
            return "1";
        }
    }
}