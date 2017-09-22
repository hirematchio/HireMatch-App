using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data;

/// <summary>
/// Summary description for Company
/// </summary>
public class Company
{
    dsMainTableAdapters.tblEmployeeTableAdapter taEmployee = new dsMainTableAdapters.tblEmployeeTableAdapter();
    dsMainTableAdapters.tblCompanyTableAdapter taCompany = new dsMainTableAdapters.tblCompanyTableAdapter();
    DataTable dt = new DataTable();
    private int _id;
    private int _empid;
    private string _empName;
    private string _address;
    public int Id
    {
        get
        {
            _id = Convert.ToInt32(HttpContext.Current.Request.Cookies["CompanyId"].Value);
            return _id;
        }
        set { _id = Convert.ToInt32(HttpContext.Current.Request.Cookies["CompanyId"].Value); }
    }
    public int EmpId
    {
        get
        {
            _empid = Convert.ToInt32(HttpContext.Current.Request.Cookies["EmpId"].Value);
            return _empid;
        }
        set { _empid = Convert.ToInt32(HttpContext.Current.Request.Cookies["EmpId"].Value); }
    }
    public string EmpName
    {
        get
        {
            dt = taEmployee.GetEmployee(Convert.ToInt32(HttpContext.Current.Request.Cookies["EmpId"].Value));
            if (dt.Rows.Count > 0)
            {
                _empName = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                return _empName;
            }
            else
            {
                return string.Empty;
            }
        }
        set 
        { 
            dt = taEmployee.GetEmployee(Convert.ToInt32(HttpContext.Current.Request.Cookies["EmpId"].Value));
            if (dt.Rows.Count > 0)
            {
                _empName = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
            }
        }
    }
    public string GetEmpName(int empID)
    {
        dt = taEmployee.GetEmployee(empID);
        if (dt.Rows.Count > 0)
        {
            _empName = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
            return _empName;
        }
        else
        {
            return string.Empty;
        }
    }
    public string Address
    {
        get
        {
            dt = taCompany.GetCompany(Convert.ToInt32(HttpContext.Current.Request.Cookies["CompanyId"].Value));
            if (dt.Rows.Count > 0)
            {
                _address = dt.Rows[0]["Address"].ToString() + ", " + dt.Rows[0]["City"].ToString() + ", " + dt.Rows[0]["State"].ToString() + ", " + dt.Rows[0]["ZipCode"].ToString();
                return _address;
            }
            else
            {
                return string.Empty;
            }
        }
        set
        {
            dt = taCompany.GetCompany(Convert.ToInt32(HttpContext.Current.Request.Cookies["CompanyId"].Value));
            if (dt.Rows.Count > 0)
            {
                _address = dt.Rows[0]["Address"].ToString() + ", " + dt.Rows[0]["City"].ToString() + ", " + dt.Rows[0]["State"].ToString() + ", " + dt.Rows[0]["ZipCode"].ToString();
            }
        }
    }
    public string ErrorMessage { get; set; }
    public void CreateCompanyDirectory(int companyId)
    {
        string path = HttpContext.Current.Server.MapPath("~/App_Files");

        if (Directory.Exists(path))
        {
            Directory.CreateDirectory(path + "/Company/" + companyId);
            Directory.CreateDirectory(path + "/Company/" + companyId + "/Assets");
            Directory.CreateDirectory(path + "/Company/" + companyId + "/Customer");
            Directory.CreateDirectory(path + "/Company/" + companyId + "/Orders");
            Directory.CreateDirectory(path + "/Company/" + companyId + "/ProfileImg");
        }
        else
        {
            ErrorMessage = "Upload path could not be found";
        }
    }
    public void CreateCustomerDirectory(int companyId, int customerId)
    {
        string path = HttpContext.Current.Server.MapPath("~/App_Files");

        if (Directory.Exists(path))
        {
            Directory.CreateDirectory(path + "/Company/" + companyId + "/Customer/" + customerId);
        }
        else
        {
            ErrorMessage = "Upload path could not be found";
        }
    }
    public Boolean  checkCompanyimg(int Company)
	{
        string Path = HttpContext.Current.Server.MapPath("App_Files/Company/" + Id + "/logo.png");
        if (File.Exists(Path))
        {
            return true;
        }
        else
        {
            return false;
        }
	}
    public bool ConfirmEmployeeEmail(int companyId, int accessLevel)
    {
        try
        {
            taEmployee.ConfirmEmployee(companyId);
            return true;
        }
        catch (Exception ex)
        {
            ErrorMessage = ex.Message;
            return false;
        }
    }
}