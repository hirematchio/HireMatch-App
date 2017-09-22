<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Employees.aspx.cs" Inherits="Employees" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
    <!-- end: PAGE TITLE -->
    <!-- start: USER PROFILE -->
    <div class="container-fluid container-fullw bg-white">
        <div class="row padding-left-15">
        
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="col-sm-3">

                        <a href="MyProfile.aspx?id=<%#Eval("ID") %>">
                            <div class="user-image">
                                <div class="fileinput-new thumbnail">
                                    <img src="<%#GetProfileImage(Eval("ID").ToString())%>" alt="">
                                </div>
                                <h5 class="center"> <%# Eval("FirstName") %> <%# Eval("LastName") %> <i class="fa fa-edit"></i></h5>

                            </div>

                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
              <div class="col-sm-1">
                </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ZamvAppConnectionString %>" SelectCommand="SELECT * FROM [tblEmployee] WHERE ([CompanyId] = @CompanyId)">
        <SelectParameters>
            <asp:CookieParameter CookieName="CompanyID" Name="CompanyId" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
</asp:Content>

