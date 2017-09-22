<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="MyProfile" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Src="~/ucActivities.ascx" TagPrefix="uc1" TagName="ucActivities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #projects td{
            border:none;
        }
    </style>
    <div class="container-fluid container-fullw bg-white">
        <div class="row">
            <div class="col-md-12">
                <div class="tabbable">
                    <ul class="nav nav-tabs tab-padding tab-space-3 tab-blue" id="myTab4">
                        <li class="active">
                            <a data-toggle="tab" href="#panel_overview">Overview
                            </a>
                        </li>


                    </ul>
                    <div class="tab-content">
                        <div id="panel_overview" class="tab-pane fade in active">
                            <div class="row">
                                <div class="col-sm-5 col-md-4">
                                    <div class="user-left">
                                        <div class="form-group">
                                            <label>
                                                Image Upload
                                            </label>
                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;">
                                                    <asp:Image ID="imgAsset" runat="server" CssClass="img-responsive" />
                                                </div>
                                                <br />
                                                <span class="btn btn-default btn-file">Browse
                                                <asp:FileUpload ID="fulAsset" runat="server" />
                                                </span>

                                                <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" OnClick="btnUpload_Click" CommandArgument='<%=request("ID") %>' />
                                            </div>
                                        </div>
                                        <asp:FormView ID="fvMain" runat="server" DataKeyNames="id" DataSourceID="SqlDataSource1" DefaultMode="Edit" Width="100%">
                                            <EditItemTemplate>

                                                <div class="form-group">
                                                    <label class="control-label">
                                                        First Name<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter first name" Text="*" ControlToValidate="txtFirstName" Display="Dynamic" ForeColor="Red" ValidationGroup="emp"></asp:RequiredFieldValidator>
                                                    </label>
                                                    <asp:TextBox ID="txtFirstName" CssClass="form-control" Text='<%#Bind("FirstName") %>' runat="server" placeholder="First Name"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Last Name<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter last name" Text="*" ControlToValidate="txtLastName" Display="Dynamic" ForeColor="Red" ValidationGroup="emp"></asp:RequiredFieldValidator>
                                                    </label>
                                                    <asp:TextBox ID="txtLastName" CssClass="form-control" Text='<%#Bind("LastName") %>' runat="server" placeholder="Last Name"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Email Address<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter email address" Text="*" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationGroup="emp"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter valid email address" Text="*" Display="Dynamic" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="emp"></asp:RegularExpressionValidator>
                                                    </label>
                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" Text='<%#Bind("Email") %>' runat="server" placeholder="Email Address"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Phone
                                                    </label>
                                                    <asp:TextBox ID="txtPhone" CssClass="form-control" Text='<%#Bind("Phone") %>' runat="server" placeholder="Phone Number"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Password<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter password" Text="*" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" ValidationGroup="emp"></asp:RequiredFieldValidator>
                                                    </label>
                                                    <asp:TextBox ID="txtPassword" Text='<%#Eval("Password") %>' CssClass="form-control" runat="server" placeholder="Password"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Confirm Password<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please re-enter password" Text="*" ControlToValidate="txtPassword2" Display="Dynamic" ForeColor="Red" ValidationGroup="emp"></asp:RequiredFieldValidator><asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match" Text="*" ControlToCompare="txtPassword" ControlToValidate="txtPassword2" Display="Dynamic" ValidationGroup="emp"></asp:CompareValidator>
                                                    </label>
                                                    <asp:TextBox ID="txtPassword2" Text='<%#Bind("Password") %>' CssClass="form-control" runat="server" placeholder="Confirm Password"></asp:TextBox>
                                                </div>
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="emp" />
                                            </EditItemTemplate>
                                        </asp:FormView>

                                    </div>
                                </div>
                                <div class="col-sm-7 col-md-8">
                                    <uc1:ucActivities runat="server" ID="ucActivities" />
                                </div>
                            </div>
                        </div>
                        <div id="panel_projects" class="tab-pane fade">
                            <asp:GridView ID="gvOrders" runat="server" DataSourceID="SqlOrders" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-hover table-bordered" EmptyDataRowStyle-ForeColor="Red" EmptyDataText="No orders assigned">
                                <Columns>
                                    <asp:TemplateField HeaderText="Heading" SortExpression="Heading">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# GetHeading(Convert.ToInt32(Eval("Id"))) %>' ID="Label1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created By" SortExpression="CreatedBy">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# c.GetEmpName(Convert.ToInt32(Eval("CreatedBy"))) %>' ID="Label2"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate"></asp:BoundField>
                                    <asp:BoundField DataField="RentalReturnDate" HeaderText="Rental Due Date" SortExpression="RentalReturnDate"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Status" SortExpression="StatusId">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# GetOrderStatus(Convert.ToInt32(Eval("StatusId"))) %>' ID="Label2"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <a href="CreateOrder.aspx?mode=edit&order=<%# Eval("Id") %>" class="btn btn-transparent btn-xs" title="Edit"><i class="fa fa-pencil"></i></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <asp:SqlDataSource runat="server" ID="SqlOrders" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT * FROM [tblOrder] WHERE (([CompanyId] = @CompanyId) AND ([IsDeleted] = @IsDeleted) AND ([AssignedTo] = @AssignedTo))">
                            <SelectParameters>
                                <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32" />
                                <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
                                <asp:QueryStringParameter QueryStringField="id" Name="AssignedTo" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ZamvAppConnectionString %>" SelectCommand="SELECT * FROM [tblEmployee] WHERE ([Id] = @Id)" UpdateCommand="UPDATE [tblEmployee] SET [FirstName] = @FirstName, [LastName] = @LastName, [Email] = @Email, [Password] = @Password, [Phone] = @Phone WHERE [Id] = @Id">

        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
            <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Email" Type="String"></asp:Parameter>
            <asp:Parameter Name="Password" Type="String"></asp:Parameter>
            <asp:Parameter Name="Phone" Type="String"></asp:Parameter>
            <asp:Parameter Name="AccessLevel" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="IsConfirmed" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="IsDeleted" Type="Boolean"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="id" Name="Id" Type="Int32"></asp:QueryStringParameter>

        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
            <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
            <asp:Parameter Name="Email" Type="String"></asp:Parameter>
            <asp:Parameter Name="Password" Type="String"></asp:Parameter>
            <asp:Parameter Name="Phone" Type="String"></asp:Parameter>
            <%--<asp:QueryStringParameter QueryStringField="id" Name="id"  Type="Int32"></asp:QueryStringParameter>--%>
        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>

