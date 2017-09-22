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

/// <summary>
/// Summary description for clsAuthNet
/// </summary>
public class clsAuthNet
{
    public class MerchantInfo
    {
        public string AuthNetVersion = "";//Contains CCV support
        public string MerchantEmail = "";
        public string AuthNetLoginId = "";//Set AuthNetLoginId here (or in the calling routine)
        public string AuthNetTransKey = "";//Get this from your authorize.net merchant interface (set it here or in the calling routine)
    }

    public class Output
    {
        public string AuthorizationCode;
        public string TransactionId;
        public bool HasError;
        public string ErrorMessage;
    }

    public class OrderInfo
    {
        public string FirstName;
        public string LastName;
        public string Phone;
        public string Address;
        public string City;
        public string State;
        public string ZipCode;
        public string Email;
        public string Country;
        public double Amount;
        public string Description;
        public string IPNumber;
        public string CreditCardNumber;
        public string ExpireDate;
        public string SecurityCode;
    }

    public static Output ProcessPayment(MerchantInfo Merchant, OrderInfo Order)
    {
        Output rv = new Output();

        WebClient webClientRequest = new WebClient();
        NameValueCollection InputObject = new NameValueCollection(30);
        NameValueCollection ReturnObject = new NameValueCollection(30);

        byte[] ReturnBytes;
        string[] ReturnValues;

        InputObject.Add("x_version", Merchant.AuthNetVersion);
        InputObject.Add("x_delim_data", "True");
        InputObject.Add("x_login", Merchant.AuthNetLoginId);
        InputObject.Add("x_tran_key", Merchant.AuthNetTransKey);
        InputObject.Add("x_relay_response", "False");

        //Set this to false to go live
        InputObject.Add("x_test_request", "True");

        InputObject.Add("x_delim_char", ",");
        InputObject.Add("x_encap_char", "|");

        //Billing Address
        InputObject.Add("x_first_name", Order.FirstName);
        InputObject.Add("x_last_name", Order.LastName);
        InputObject.Add("x_phone", Order.Phone);
        InputObject.Add("x_address", Order.Address);
        InputObject.Add("x_city", Order.City);
        InputObject.Add("x_state", Order.State);
        InputObject.Add("x_zip", Order.ZipCode);
        InputObject.Add("x_email", Order.Email);
        InputObject.Add("x_email_customer", "TRUE");                   //Emails Customer
        InputObject.Add("x_merchant_email", Merchant.MerchantEmail); //Emails Merchant
        InputObject.Add("x_country", Order.Country);
        InputObject.Add("x_customer_ip", Order.IPNumber);

        //Amount
        InputObject.Add("x_description", Order.Description + ": " + String.Format("{0:c2}", Order.Amount)); //Description of Purchase

        //Card Details
        InputObject.Add("x_card_num", Order.CreditCardNumber);
        InputObject.Add("x_exp_date", Order.ExpireDate); //MM/DD
        InputObject.Add("x_card_code", Order.SecurityCode);

        InputObject.Add("x_method", "CC");
        InputObject.Add("x_type", "AUTH_CAPTURE");
        InputObject.Add("x_amount", String.Format("{0:c2}", Order.Amount));

        //Currency setting. Check the guide for other supported currencies
        InputObject.Add("x_currency_code", "USD");

        try
        {
            //Actual Server
            //Set above Testmode=off to go live
            webClientRequest.BaseAddress = "https://secure.authorize.net/gateway/transact.dll";

            ReturnBytes = webClientRequest.UploadValues(webClientRequest.BaseAddress, "POST", InputObject);
            ReturnValues = System.Text.Encoding.ASCII.GetString(ReturnBytes).Split(",".ToCharArray());

            if (ReturnValues[0].Trim(Char.Parse("|")) == "1")
            {
                rv.AuthorizationCode = ReturnValues[4].Trim(Char.Parse("|"));
                rv.TransactionId = ReturnValues[6].Trim(Char.Parse("|"));
                return rv;
            }
            else
            {
                //Error!
                rv.HasError = true;
                rv.ErrorMessage = ReturnValues[3].Trim(Char.Parse("|")) + " (" + ReturnValues[2].Trim(Char.Parse("|")) + ")";
                if (ReturnValues[2].Trim(Char.Parse("|")) == "44")
                {
                    rv.ErrorMessage += "Credit Card Code Verification (CCV) returned the following error: ";
                    switch (ReturnValues[38].Trim(Char.Parse("|")))
                    {
                        case "N":
                            rv.ErrorMessage += " Card Code does not match.";
                            break;
                        case "P":
                            rv.ErrorMessage += " Card Code was not processed.";
                            break;
                        case "S":
                            rv.ErrorMessage = " Card Code should be on card but was not indicated.";
                            break;
                        case "U":
                            rv.ErrorMessage = " Issuer was not certified for Card Code.";
                            break;
                    }
                }
            }

            if (ReturnValues[2].Trim(Char.Parse("|")) == "45")
            {
                rv.ErrorMessage += "<br/>n";

                //AVS transaction decline
                rv.ErrorMessage += "Address Verification System (AVS) returned the following error:";

                switch (ReturnValues[5].Trim(Char.Parse("|")))
                {
                    case "A":
                        rv.ErrorMessage += " the zip code entered does not match the billing address.";
                        break;
                    case "B":
                        rv.ErrorMessage += " no information was provided for the AVS check.";
                        break;
                    case "E":
                        rv.ErrorMessage += " a general error occurred in the AVS system.";
                        break;
                    case "G":
                        rv.ErrorMessage += " the credit card was issued by a non-US bank.";
                        break;
                    case "N":
                        rv.ErrorMessage += " neither the entered street address nor zip code matches the billing address.";
                        break;
                    case "P":
                        rv.ErrorMessage += " AVS is not applicable for this transaction.";
                        break;
                    case "R":
                        rv.ErrorMessage += " please retry the transaction; the AVS system was unavailable or timed out.";
                        break;
                    case "S":
                        rv.ErrorMessage += " the AVS service is not supported by your credit card issuer.";
                        break;
                    case "U":
                        rv.ErrorMessage += " address information is unavailable for the credit card.";
                        break;
                    case "W":
                        rv.ErrorMessage += " the 9 digit zip code matches, but the street address does not.";
                        break;
                    case "Z":
                        rv.ErrorMessage += " the zip code matches, but the address does not.";
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            rv.HasError = true;
            rv.ErrorMessage = ex.Message;
        }

        return rv;
    }
}