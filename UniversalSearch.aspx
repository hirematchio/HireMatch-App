<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UniversalSearch.aspx.cs" Inherits="UniversalSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- start: PAGE TITLE -->
						<section id="page-title">
							<div class="row">
								<div class="col-sm-8">
									<h1 class="mainTitle">Search Results</h1>
									<span class="mainDescription">Results shown are from all areas: order, inventory, employees and customers.</span>
								</div>
						
							</div>
						</section>
						<!-- end: PAGE TITLE -->
						<!-- start: SEARCH RESULT -->
						<div class="container-fluid container-fullw bg-white">
							<div class="row">
								<div class="col-md-12">
									<div class="search-classic">

                                        <div class="input-group well">

                                            <span class="input-group-btn">

                                                <asp:TextBox ID="TextBox1" Width="90%" CssClass="form-control" placeholder="Search..." runat="server"></asp:TextBox>
                                                <asp:Button CssClass="btn btn-primary"  ID="Button1" runat="server" Text="Search" />
                                            </span>
                                        </div>

                                        <h3>Search results for '<%=TextBox1.Text %>'</h3>
									
                                        <asp:Repeater DataSourceID="SqlDataSource1" ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                                	<hr />
                                                   <div class="search-result">
											<h4>
											<i class="<%#Eval("icon") %> padding-right-15 padding-left-5"></i><a href="<%#Eval("link") %>">
												<%#Eval("itemname") %>
											</a></h4>
											<p class="padding-left-30 margin-left-10"><%#Eval("description") %></p>
										</div>

                                                </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT 'ti-briefcase' as icon,  description, name as itemname, 'AddInventory.aspx?mode=edit&item=' + cast(id as varchar) as link
FROM tblAsset a where (name like '%' + @searchTerm  + '%' ) AND CompanyID = @companyid
union all
SELECT  'ti-clipboard' as icon, description, heading + ': ' + orderaddress + ', ' + ordercity + ', '+ OrderZipCode as itemname, 'CreateOrder.aspx?mode=edit&order=' + cast(id as varchar)  as link
FROM tblOrder where (name like '%' + @searchTerm  + '%'  or orderaddress like '%' + @searchTerm  + '%' or ordercity like '%' + @searchTerm  + '%' or concat(orderaddress, ', ' ,ordercity) like '%' + @searchTerm  + '%' or  concat(ordercity, ' ' ,orderstate) like '%' + @searchTerm  + '%') AND CompanyID = @companyid
union all
SELECT 'ti-user' as icon,  Address + ',' + city + ' ' + state + ' ' + ZipCode + ': ' + description as description, FirstName + ' ' + LastName as itemname, 'CreateCustomer.aspx?mode=edit&customer=' + cast(id as varchar)  as link
FROM tblCustomer where (firstname like '%' + @searchTerm  + '%'  or lastname like '%' + @searchTerm  + '%'  or address like '%' + @searchTerm  + '%' or city like '%' + @searchTerm  + '%' or email like '%' + @searchTerm  + '%') AND CompanyID = @companyid
                                            union all
SELECT distinct 'ti-id-badge' as icon, email as description, FirstName + ' ' + LastName as itemname, 'MyProfile.aspx?id=' + cast(id as varchar)  as link
FROM tblEmployee where (firstname like '%' + @searchTerm  + '%' or concat(firstname, ' ' ,lastname) like '%' + @searchTerm  + '%'  or lastname like '%' + @searchTerm  + '%'  or email like '%' + @searchTerm  + '%' or phone like '%' + @searchTerm  + '%') AND CompanyID = @companyid">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="TextBox1" PropertyName="Text" Name="searchTerm"></asp:ControlParameter>
                                                <asp:CookieParameter CookieName="companyid" Name="companyid" ></asp:CookieParameter>
                                             
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                     
										<hr>
									
									
									</div>
								</div>
							</div>
						</div>
						<!-- end: SEARCH RESULT -->

</asp:Content>

