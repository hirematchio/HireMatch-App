using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for clsAppSettings
/// </summary>
public class clsAppSettings
{
    public string version { get; set; }
    public string email { get; set; }
    public string login { get; set; }
    public string key { get; set; }
    dsMainTableAdapters.tblAppSettingsTableAdapter taAppSettings = new dsMainTableAdapters.tblAppSettingsTableAdapter();
    DataTable dt = new DataTable();

    public void GetAuthNetSettings(int companyId)
    {
        dt = taAppSettings.GetAppSettings(companyId);
        if (dt.Rows.Count > 0)
        {
            version = dt.Rows[0]["AuthNetVersion"].ToString();
            email = dt.Rows[0]["AuthMerchantEmail"].ToString();
            login = dt.Rows[0]["AuthNetLoginId"].ToString();
            key = dt.Rows[0]["AuthNetTransKey"].ToString();
        }
    }
}