<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="OrderList" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid container-fullw bg-white">
        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlOrders" AllowPaging="True" AllowSorting="True" CssClass="table table-hover table-bordered" HeaderStyle-Font-Underline="true" EmptyDataRowStyle-ForeColor="Red" EmptyDataText="There are no Orders, <a href='CreateOrder.aspx?new=1'>Add One Here</a>">
                    <Columns>
                        <asp:BoundField DataField="Heading" HeaderText="Heading" SortExpression="Heading"></asp:BoundField>
                        <asp:BoundField DataField="strname" HeaderText="Customer" SortExpression="strname"></asp:BoundField>
                        <%--<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="RentalOutDate" HeaderText="RentalOutDate" SortExpression="RentalOutDate"></asp:BoundField>--%>
                        <asp:BoundField DataField="RentalReturnDate" HeaderText="Rental Return Date" SortExpression="RentalReturnDate"></asp:BoundField>
                        <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration"></asp:BoundField>
                        <%--<asp:BoundField DataField="OrderAddress" HeaderText="OrderAddress" SortExpression="OrderAddress"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="OrderCity" HeaderText="OrderCity" SortExpression="OrderCity"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="OrderState" HeaderText="OrderState" SortExpression="OrderState"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="OrderZipCode" HeaderText="OrderZipCode" SortExpression="OrderZipCode"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Latitude" HeaderText="Latitude" SortExpression="Latitude"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Longitude" HeaderText="Longitude" SortExpression="Longitude"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Revenue" HeaderText="Revenue" SortExpression="Revenue"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>--%>
                        
                        <%--<asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="CreatedDate" HeaderText="CreatedDate" SortExpression="CreatedDate"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy"></asp:BoundField>--%>
                        <%--<asp:BoundField DataField="AssignedTo" HeaderText="AssignedTo" SortExpression="AssignedTo"></asp:BoundField>--%>
                        <asp:TemplateField HeaderStyle-CssClass="tblheaderstyle" HeaderText="Items On Order" >
                            <ItemTemplate>
                                <asp:Label ID="lblOrderId" runat="server" Text='<%# Eval("ID") %>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="ddlItems" runat="server" CssClass="form-control" DataSourceID="SqlItemsOnOrder" DataTextField="Text" DataValueField="Id"></asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="SqlItemsOnOrder" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT tblAsset.Id, tblAsset.Name + ', ' + tblAsset.ModelNumber AS [Text] FROM tblOrder INNER JOIN tblAssetsOnOrder ON tblOrder.Id = tblAssetsOnOrder.OrderId INNER JOIN tblAsset ON tblAssetsOnOrder.AssetId = tblAsset.Id WHERE (tblAssetsOnOrder.CompanyId = @CompanyId) AND (tblAssetsOnOrder.OrderId = @OrderId)">
                                    <SelectParameters>
                                        <asp:CookieParameter CookieName="CompanyId" Name="CompanyId"></asp:CookieParameter>
                                        <asp:ControlParameter ControlID="lblOrderId" PropertyName="Text" Type="Int32" Name="OrderId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="visible-md visible-lg visible-sm hidden-xs">
                                    <a href="CreateOrder.aspx?mode=edit&order=<%# Eval("ID") %>" class="btn btn-transparent btn-xs" title="Edit"><i class="fa fa-pencil"></i></a>
                                    <a href="CreateOrder.aspx?mode=delete&order=<%# Eval("ID") %>" class="btn btn-transparent btn-xs tooltips" title="Remove" onclick="return confirm('Are you sure you want to remove this order?');"><i class="fa fa-times fa-white"></i></a>
                                </div>
                                <div class="visible-xs hidden-sm hidden-md hidden-lg">
                                    <div class="btn-group dropdown">
                                        <button type="button" class="btn btn-primary btn-o btn-sm dropdown-toggle" data-toggle="dropdown">
                                            <i class="fa fa-cog"></i>&nbsp;<span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu pull-right dropdown-light">
                                            <li><a href="CreateOrder.aspx?mode=edit&order=<%# Eval("ID") %>">Edit</a></li>
                                            <li><a href="CreateOrder.aspx?mode=delete&order=<%# Eval("ID") %>">Remove</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource runat="server" ID="SqlOrders" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT c.firstname + ' ' + c.lastname as strname, * FROM [tblOrder] o, [tblCustomer] c WHERE ((o.CompanyId = @CompanyId) AND (o.IsDeleted = @IsDeleted)) AND c.companyid = o.companyid AND o.customerid = c.id">
                    <SelectParameters>
                        <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
                        <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <%--<table class="table table-hover" id="sample-table-1">
                    <thead>
                        <tr>
                            <th class="center">ID</th>
                            <th class="hidden-xs">Customer ID</th>
                            <th>Duration</th>
                            <th>Due Date</th>
                            <th>Items Rented</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="center">1</td>
                            <td class="hidden-xs">C12345</td>
                            <td>4 days</td>
                            <td><%=DateTime.Now.ToString("yyyy-MM-dd hh:mm tt")%></td>
                            <td><a href="#">Items</a></td>
                            <td class="center">
                                <div class="visible-md visible-lg visible-sm hidden-xs">
                                    <a href="CreateOrder.aspx?mode=edit" class="btn btn-transparent btn-xs" title="Edit"><i class="fa fa-pencil"></i></a>
                                    <a href="#" class="btn btn-transparent btn-xs tooltips" title="Share"><i class="fa fa-share"></i></a>
                                    <a href="#" class="btn btn-transparent btn-xs tooltips" title="Remove"><i class="fa fa-times fa-white"></i></a>
                                </div>
                                <div class="visible-xs hidden-sm hidden-md hidden-lg">
                                    <div class="btn-group dropdown">
                                        <button type="button" class="btn btn-primary btn-o btn-sm dropdown-toggle" data-toggle="dropdown">
                                            <i class="fa fa-cog"></i>&nbsp;<span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu pull-right dropdown-light">
                                            <li><a href="CreateOrder.aspx?mode=edit">Edit</a></li>
                                            <li><a href="#">Share</a></li>
                                            <li><a href="#">Remove</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>

                    </tbody>
                </table>--%>
            </div>
        </div>
    </div>
</asp:Content>

