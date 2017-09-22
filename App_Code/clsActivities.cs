using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for clsActivities
/// </summary>
public class clsActivities
{
    dsMainTableAdapters.tblActivityTableAdapter tblActivity = new dsMainTableAdapters.tblActivityTableAdapter();
    public Boolean InsertActivity(string ActivityMsg)
	{
        tblActivity.InsertActivity(Convert.ToInt32(HttpContext.Current.Request.Cookies["CompanyId"].Value), Convert.ToInt32(HttpContext.Current.Request.Cookies["EmpID"].Value), ActivityMsg);
        return true;
	}

    public string PrettyDate(DateTime MyDate) {
 	TimeSpan T = DateTime.Now.Subtract(MyDate);
 	string StrReturn = null;

 	int S = T.Days * 24 * 60 * 60 + T.Hours * 60 * 60 + T.Minutes * 60 + T.Seconds;

 	if (S < 60) {
 		StrReturn = "Just Now";
 	} else if (S < 120) {
 		StrReturn = "1 minute ago";
 	} else if (S < 3600) {

 		StrReturn = System.Math.Floor(Convert.ToDecimal(S / 60)) + " minutes ago";
 	} else if (S < 86400) {
 		StrReturn = Math.Floor(Convert.ToDecimal(S / 3600)) + " hours ago";
 	} else if (T.Days == 1) {
 		StrReturn = "Yesterday";

 	} else if (T.Days < 7) {
 		StrReturn = T.Days + " days ago";
 	}
    else
    { 
 	StrReturn = "over " + Math.Ceiling(Convert.ToDecimal(T.Days / 7)) + " week(s) ago";
    }
    return StrReturn;
 
 }
}