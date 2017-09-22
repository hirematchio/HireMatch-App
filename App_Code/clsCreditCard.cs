
using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Net.Mail;

namespace C2IT.PaymentProcessors
{

    public class AuthorizeDotNet
    {

        public class MerchantInfo
        {
            //Contains CCV support
            public string AuthNetVersion = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetVersion"];
            public string MerchantEmail = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthMerchantEmail"];
            //Set AuthNetLoginId here (or in the calling routine)
            public string AuthNetLoginId = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetLoginId"];
            // Get this from your authorize.net merchant interface (set it here or in the calling routine)
            public string AuthNetTransKey = System.Web.Configuration.WebConfigurationManager.AppSettings["AuthNetTransKey"];

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
            System.Collections.Specialized.NameValueCollection InputObject = new System.Collections.Specialized.NameValueCollection(30);
            System.Collections.Specialized.NameValueCollection ReturnObject = new System.Collections.Specialized.NameValueCollection(30);
     
            byte[] ReturnBytes = null;
            string[] ReturnValues = null;

            InputObject.Add("x_version", Merchant.AuthNetVersion);
            InputObject.Add("x_delim_data", "True");
            InputObject.Add("x_login", Merchant.AuthNetLoginId);
            InputObject.Add("x_tran_key", Merchant.AuthNetTransKey);
            InputObject.Add("x_relay_response", "False");

           
            InputObject.Add("x_recurring_billing", "TRUE");
            InputObject.Add("x_subscription_name", "HireMatch.com Subscription");
            InputObject.Add("x_interval_length", "1");
            InputObject.Add("x_interval_unit", "days");
            InputObject.Add("x_interval_startDate", "days");
            InputObject.Add("x_interval_totalOccurrences", "9999");
            try
            {
                //Actual Server
                //Set above Testmode=off to go live
                webClientRequest.BaseAddress = "https://api.authorize.net/xml/v1/request.api";

                ReturnBytes = webClientRequest.UploadValues(webClientRequest.BaseAddress, "POST", InputObject);
                ReturnValues = System.Text.Encoding.ASCII.GetString(ReturnBytes).Split(",".ToCharArray());

                if (ReturnValues[0].Trim(char.Parse("|")) == "1")
                {
                    rv.AuthorizationCode = ReturnValues[4].Trim(char.Parse("|"));
                    rv.TransactionId = ReturnValues[6].Trim(char.Parse("|"));
                    return rv;
                }
                else
                {
                    //Error!
                    rv.HasError = true;
                    rv.ErrorMessage = ReturnValues[3].Trim(char.Parse("|")) + " (" + ReturnValues[2].Trim(char.Parse("|")) + ")";
                    if (ReturnValues[2].Trim(char.Parse("|")) == "44")
                    {
                        rv.ErrorMessage += "Credit Card Code Verification (CCV) returned the following error: ";
                        switch (ReturnValues[38].Trim(char.Parse("|")))
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
                    if (ReturnValues[2].Trim(char.Parse("|")) == "45")
                    {
                        rv.ErrorMessage += "<br/>n";

                        //AVS transaction decline
                        rv.ErrorMessage += "Address Verification System (AVS) returned the following error:";

                        switch (ReturnValues[5].Trim(char.Parse("|")))
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
            }
            catch (Exception ex)
            {
                rv.HasError = true;
                rv.ErrorMessage = ex.Message;
            }

            return rv;

        }

    }


}

