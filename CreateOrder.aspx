<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CreateOrder.aspx.cs" Inherits="CreateOrder" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #ContentPlaceHolder1_fvOrder_gvAssetsCheckedOut td, #ContentPlaceHolder1_fvOrder_gvAssetsCheckedIn td {
            border: none;
            padding: 10px;
        }
    </style>
    <asp:FormView ID="fvOrder" Width="100%" runat="server" DataKeyNames="Id" DataSourceID="SqlOrder">
        <EditItemTemplate>
            <div class="container-fluid container-fullw">
                <div class="row">
                    <div class="panel panel-transparent">
                        <div class="panel-body">
                            <div class="col-sm-6">
                                <div class="form-group">
                                        <%--<div class="heading">
                                        <h3 class="title">Check In/Out Order
                                        </h3>
                                    </div>
                                    <br />--%>
                                        <asp:Button ID="btnCheckOut" runat="server" Text="Check Out Order" CssClass="btn btn-primary" OnClick="btnCheckOut_Click" Visible="false" /><asp:Button ID="btnCheckIn" runat="server" Text="Check In Order" CssClass="btn btn-primary" OnClick="btnCheckIn_Click" Visible="false" /><asp:Label ID="lblOrderClosed" runat="server" Visible="false"><h2>Order Is Closed</h2></asp:Label>
                                </div>
                                

                                <div class="row hidden-print">
                                    <div id="divNewOrder" runat="server" class="container-fluid container-fullw bg-white">
                                        <fieldset>
                                            <legend>Items</legend>

                                            <div class="col-xs-8">
                                                <label for="ddlItems">
                                                    Add Items
                                                </label>
                                                <div class="form-group">
                                                    <asp:DropDownList ID="ddlItems" runat="server" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlAssets" DataTextField="Name" DataValueField="Id">
                                                        <asp:ListItem Value="0">-- Select Item --</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource runat="server" ID="SqlAssets" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT [Id], [Name] + ', ' + [ModelNumber] AS [Name] FROM [tblAsset] WHERE (([CompanyId] = @CompanyId) AND ([IsDeleted] = @IsDeleted) AND ([IsRented] = @IsRented))">
                                                        <SelectParameters>
                                                            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
                                                            <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
                                                            <asp:Parameter DefaultValue="False" Name="IsRented" Type="Boolean"></asp:Parameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <br />
                                                    <asp:Button ID="btnAddItem" runat="server" Text="Add" CssClass="form-control underline" OnClick="btnAddItem_Click" />
                                                </div>
                                            </div>



                                            <div class="col-xs-8">
                                                <label for="ddlItemsOnOrder">
                                                    Remove Items
                                                </label>
                                                <div class="form-group">
                                                    <asp:DropDownList ID="ddlItemsOnOrder" runat="server" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlAssetsOnOrder" DataTextField="Name" DataValueField="Id">
                                                        <asp:ListItem Value="0">-- Select Item --</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource runat="server" ID="SqlAssetsOnOrder" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT tblAsset.Id, tblAsset.Name + ', ' + tblAsset.ModelNumber AS [Name] FROM tblAsset INNER JOIN tblAssetsOnOrder ON tblAsset.Id = tblAssetsOnOrder.AssetId INNER JOIN tblOrder ON tblAssetsOnOrder.OrderId = tblOrder.Id WHERE (tblAssetsOnOrder.CompanyId = @CompanyId) AND (tblAssetsOnOrder.OrderId = @OrderId) AND (tblAsset.IsRented = @IsRented)">
                                                        <SelectParameters>
                                                            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId"></asp:CookieParameter>
                                                            <asp:QueryStringParameter QueryStringField="order" Name="OrderId"></asp:QueryStringParameter>
                                                            <asp:Parameter DefaultValue="True" Name="IsRented" Type="Boolean"></asp:Parameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <br />
                                                    <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="form-control underline" OnClick="btnRemove_Click" />
                                                </div>
                                            </div>
                                        </fieldset>

                                    </div>

                                    <div id="divCheckedOut" runat="server" class="container-fluid container-fullw bg-white">
                                        <div class="form-group">
                                            <label for="gvAssetsCheckedOut">
                                                Items Checked Out
                                            </label>
                                            <asp:GridView ID="gvAssetsCheckedOut" runat="server" AutoGenerateColumns="False" DataSourceID="SqlAOOCheckedOut" AllowPaging="True" AllowSorting="True" EmptyDataText="No items checked out">
                                                <Columns>
                                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                                                    <asp:BoundField DataField="ModelNumber" HeaderText="Model#" SortExpression="ModelNumber"></asp:BoundField>
                                                    <asp:BoundField DataField="SerialNumber" HeaderText="Serial#" SortExpression="SerialNumber"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <asp:SqlDataSource runat="server" ID="SqlAOOCheckedOut" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT tblAsset.Name, tblAsset.ModelNumber, tblAsset.SerialNumber FROM tblOrder INNER JOIN tblAssetsOnOrder ON tblOrder.Id = tblAssetsOnOrder.OrderId INNER JOIN tblAsset ON tblAssetsOnOrder.AssetId = tblAsset.Id WHERE (tblAsset.IsRented = 'True') AND (tblOrder.Id = @OrderId) AND (tblOrder.IsCheckedOut = 'True')">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="order" Name="OrderId"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div id="divCheckedIn" runat="server" class="container-fluid container-fullw bg-white">
                                        <div class="form-group">
                                            <label for="gvAssetsCheckedIn">
                                                Items Checked In
                                            </label>
                                            <asp:GridView ID="gvAssetsCheckedIn" runat="server" AutoGenerateColumns="False" DataSourceID="SqlAOOCheckedIn" AllowPaging="True" AllowSorting="True" EmptyDataText="No items checked in">
                                                <Columns>
                                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                                                    <asp:BoundField DataField="ModelNumber" HeaderText="Model#" SortExpression="ModelNumber"></asp:BoundField>
                                                    <asp:BoundField DataField="SerialNumber" HeaderText="Serial#" SortExpression="SerialNumber"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <asp:SqlDataSource runat="server" ID="SqlAOOCheckedIn" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT tblAsset.Name, tblAsset.ModelNumber, tblAsset.SerialNumber FROM tblOrder INNER JOIN tblAssetsOnOrder ON tblOrder.Id = tblAssetsOnOrder.OrderId INNER JOIN tblAsset ON tblAssetsOnOrder.AssetId = tblAsset.Id WHERE (tblAsset.IsRented = 'False') AND (tblOrder.Id = @OrderId) AND (tblOrder.IsCheckedIn = 'True')">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="order" Name="OrderId"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>

                                </div>
                                
                                <div class="form-group">
                                    <label for="radPayTypes">
                                        Pay Type
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select pay type" ControlToValidate="radPayTypes" Text="*" Display="Dynamic" InitialValue="0" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <br>
                                    <label for="radPayTypes">
                                        Per:
                                    </label>
                                    <asp:RadioButtonList ID="radPayTypes" CssClass="clip-radio" runat="server" SelectedValue='<%# Bind("intPayType") %>' RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="radPayTypes_SelectedIndexChanged">
                                        <asp:ListItem Value="0">None</asp:ListItem>
                                        <asp:ListItem Value="1">Minute</asp:ListItem>
                                        <asp:ListItem Value="2">Hour</asp:ListItem>
                                        <asp:ListItem Value="3">Day</asp:ListItem>
                                        <asp:ListItem Value="4">Week</asp:ListItem>
                                        <asp:ListItem Value="5">Month</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="form-group">
                                    <label for="txtDiscount">
                                        Discount
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Discount") %>' runat="server" ID="txtDiscount" placeholder="Discount" CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="txtLateFee">
                                        Late Fee
                                    </label>
                                    <asp:TextBox Text='<%# Bind("decLateFee") %>' runat="server" ID="txtLateFee" placeholder="Late Fee" CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="txtRevenue">
                                        Revenue
                                    </label>
                                    <asp:TextBox Text='<%#Bind("Revenue") %>' runat="server" ID="txtRevenue" placeholder="Revenue" CssClass="form-control underline" Enabled="false" />
                                </div>
                                <div class="form-group">
                                    <label for="ddlCustomers">
                                        Customer
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select customer" Display="Dynamic" Text="*" ControlToValidate="ddlCustomers" InitialValue="0" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <!--dropdown that gets list of all customers for this company-->
                                    <asp:DropDownList ID="ddlCustomers" runat="server" SelectedValue='<%# Bind("CustomerId") %>' CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlCustomers" DataTextField="Text" DataValueField="Id">
                                        <asp:ListItem Value="0">-- Select Customer --</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="SqlCustomers" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT [Id], [LastName] + ', ' +  [FirstName] + ', ' + [Address] AS [Text] FROM [tblCustomer] WHERE (([CompanyId] = @CompanyId) AND ([IsDeleted] = @IsDeleted))">
                                        <SelectParameters>
                                            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
                                            <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <a role="menuitem" href="#" data-toggle="modal" data-target="#modalAddCustomer">Add Customer</a>
                                </div>
                                <div class="form-group">
                                    <br />
                                    <div class="form-group">
                                        <label for="ddlStatus">
                                            Status
                                        </label>
                                        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("StatusId") %>' CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlStatus" DataTextField="Status" DataValueField="Id">
                                            <asp:ListItem Value="0">--Select Status--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="SqlStatus" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT DISTINCT [Id], [Status] FROM [tblOrderStatus] WHERE ([CompanyId] = @CompanyId)">
                                            <SelectParameters>
                                                <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="form-group">
                                        <a role="menuitem" href="#" data-toggle="modal" data-target="#modalAddStatus">Add Status</a>
                                    </div>
                                    <label for="txtDateCreated">
                                        Date Created
                                    </label>
                                    <div class='input-group date' id='datetimepicker3'>
                                        <asp:TextBox Text='<%# Bind("CreatedDate") %>' runat="server" ID="txtDateCreated" CssClass="form-control underline" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                        <script type="text/javascript">
                                            $(function () {
                                                $('#datetimepicker3').datetimepicker();
                                            });
                                        </script>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtOutDate">
                                        Date Rented
                                    </label>
                                    <div class='input-group date' id='datetimepicker1'>
                                        <asp:TextBox Text='<%# Bind("RentalOutDate") %>' runat="server" ID="txtOutDate" CssClass="form-control underline" OnTextChanged="txtOutDate_TextChanged" AutoPostBack="true" onblur="DurationChanged()" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                        <script type="text/javascript">
                                            $(function () {
                                                $('#datetimepicker1').datetimepicker();
                                            });
                                        </script>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtReturnDate">
                                        Expected Date Returned
                                    </label>
                                    <div class='input-group date' id='datetimepicker2'>
                                        <asp:TextBox Text='<%# Bind("RentalReturnDate") %>' runat="server" ID="txtReturnDate" CssClass="form-control underline" OnTextChanged="txtReturnDate_TextChanged" AutoPostBack="true" onblur="DurationChanged()" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                        <script type="text/javascript">
                                            $(function () {
                                                $('#datetimepicker2').datetimepicker();
                                            });
                                            var errorMsg = ["Oh Snap", "Danggit", "Oh No", "Ooops", "Phew", "Darn", "Shucks", "Boo"];
                                            function DurationChanged() {
                                                var date1 = new Date($('#ContentPlaceHolder1_fvOrder_txtOutDate').val());
                                                var date2 = new Date($('#ContentPlaceHolder1_fvOrder_txtReturnDate').val());
                                                var diff = date2.getTime() - date1.getTime();
                                                var list = document.getElementById("ContentPlaceHolder1_fvOrder_radPayTypes");
                                                var inputs = list.getElementsByTagName("input");
                                                var selected;
                                                for (var i = 0; i < inputs.length; i++) {
                                                    if (inputs[i].checked) {
                                                        selected = inputs[i];
                                                        break;
                                                    } else {
                                                        selected = 0;
                                                    }
                                                }
                                                if ((selected.value == 1) || (selected.value == 2) || (selected.value == 3) || (selected.value == 4) || (selected.value == 5)) {
                                                    var mins = Math.floor(diff / (1000 * 60));
                                                    var hours = Math.floor(diff / (1000 * 60 * 60));
                                                    var days = Math.floor(diff / (1000 * 60 * 60 * 24));
                                                    switch (selected.value) {
                                                        case '1':
                                                            $('#ContentPlaceHolder1_fvOrder_txtOrderDuration').val(mins + " minutes");
                                                            break;
                                                        case '2':
                                                            $('#ContentPlaceHolder1_fvOrder_txtOrderDuration').val(hours + " hours");
                                                            break;
                                                        case '3':
                                                            $('#ContentPlaceHolder1_fvOrder_txtOrderDuration').val(days.toFixed(0) + " days");
                                                            break;
                                                        case '4':
                                                            var weeks = (days / 7);
                                                            $('#ContentPlaceHolder1_fvOrder_txtOrderDuration').val(weeks.toFixed(0) + " weeks");
                                                            break;
                                                        case '5':
                                                            var months = (days / 30);
                                                            $('#ContentPlaceHolder1_fvOrder_txtOrderDuration').val(months.toFixed(0) + " months");
                                                            break;
                                                        default:
                                                            var msg = errorMsg[Math.floor(Math.random() * errorMsg.length)];
                                                            swal(msg + "!", 'Please select pay type', 'error');
                                                            break;
                                                    }
                                                } else {
                                                    var msg = errorMsg[Math.floor(Math.random() * errorMsg.length)];
                                                    swal(msg + "!", 'Please select pay type', 'error');
                                                }
                                            }
                                        </script>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtDateCheckedIn">
                                        Date Checked In
                                    </label>
                                    <div class='input-group date' id='datetimepicker4'>
                                        <asp:TextBox Text='<%# Bind("DateCheckedIn") %>' runat="server" ID="txtDateCheckedIn" CssClass="form-control underline" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                        <script type="text/javascript">
                                            $(function () {
                                                $('#datetimepicker4').datetimepicker();
                                            });
                                        </script>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="txtOrderDuration">
                                        Order Duration
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Duration") %>' runat="server" ID="txtOrderDuration" placeholder="Order Duration" CssClass="form-control underline" Enabled="false" />
                                </div>
                                <div id="modalAddStatus" class="modal fade" role="dialog">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Add Status</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-xs-9">
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtNewStatus" runat="server" placeholder="Status" CssClass="form-control underline"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <div class="form-group">
                                                            <asp:Button ID="btnAddStatus" runat="server" Text="Add" CssClass="btn btn-default" Width="100%" OnClick="btnAddStatus_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="modalAddCustomer" class="modal fade" role="dialog">
                                    <div class="modal-dialog">
                                        <div class="modal-content  bg-white">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Add Customer</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-xs-9">
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtCustomerFName" runat="server" placeholder="First Name" CssClass="form-control underline"></asp:TextBox>
                                                            <asp:TextBox ID="txtCustomerLName" runat="server" placeholder="Last Name" CssClass="form-control underline"></asp:TextBox>
                                                            <asp:TextBox ID="txtCustomerAddress" runat="server" placeholder="Address" CssClass="form-control underline"></asp:TextBox>
                                                            <asp:TextBox ID="txtCustomerCity" runat="server" placeholder="City" CssClass="form-control underline"></asp:TextBox>
                                                            <asp:DropDownList ID="ddlCustomerState" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0">--Select State--</asp:ListItem>
                                                                <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                                                <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                                                <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                                                <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                                                <asp:ListItem Value="CA">California</asp:ListItem>
                                                                <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                                                <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                                                <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                                                <asp:ListItem Value="DC">District Of Columbia</asp:ListItem>
                                                                <asp:ListItem Value="FL">Florida</asp:ListItem>
                                                                <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                                                <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                                                <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                                                <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                                                <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                                                <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                                                <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                                                <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                                                <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                                                <asp:ListItem Value="ME">Maine</asp:ListItem>
                                                                <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                                                <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                                                <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                                                <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                                                <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                                                <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                                                <asp:ListItem Value="MT">Montana</asp:ListItem>
                                                                <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                                                <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                                                <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                                                <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                                                <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                                                <asp:ListItem Value="NY">New York</asp:ListItem>
                                                                <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                                                <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                                                <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                                                <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                                                <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                                                <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                                                <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                                                <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                                                <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                                                <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                                                <asp:ListItem Value="TX">Texas</asp:ListItem>
                                                                <asp:ListItem Value="UT">Utah</asp:ListItem>
                                                                <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                                                <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                                                <asp:ListItem Value="WA">Washington</asp:ListItem>
                                                                <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                                                <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                                                <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:TextBox ID="txtCustomerZipCode" runat="server" placeholder="Zip Code" CssClass="form-control underline"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <div class="form-group">
                                                            <br />
                                                            <br />
                                                            <asp:Button OnClick="btnAddCustomer_Click" ID="btnAddCustomer" runat="server" Text="Add" CssClass="btn btn-primary" Width="100%" CausesValidation="false" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>




                                <div class="row">
                                    <div class="col-xs-12">
                                        <form id="fileupload" action="//jquery-file-upload.appspot.com/" method="POST" enctype="multipart/form-data">
                                            <!-- Redirect browsers with JavaScript disabled to the origin page -->
                                            <noscript>
                                                <input type="hidden" name="redirect" value="http://blueimp.github.io/jQuery-File-Upload/">
                                            </noscript>
                                            <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
                                            <div class="row fileupload-buttonbar">
                                                <div class="col-lg-7">
                                                    <!-- The fileinput-button span is used to style the file input field as button -->


                                                    <!-- The loading indicator is shown during file processing -->
                                                    <span class="fileupload-loading"></span>
                                                </div>
                                                <!-- The global progress information -->
                                                <div class="col-lg-5 fileupload-progress fade">
                                                    <!-- The global progress bar -->
                                                    <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                                                    </div>
                                                    <!-- The extended global progress information -->
                                                    <div class="progress-extended">
                                                        &nbsp;
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- The table listing the files available for upload/download -->
                                            <table role="presentation" class="table table-striped">
                                                <tbody class="files"></tbody>
                                            </table>
                                        </form>
                                    </div>
                                </div>

                            </div>
                            <div class="col-sm-6">

                                <div class="form-group">
                                    <label for="txtAddress">
                                        Address
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter order address" Text="*" ControlToValidate="txtAddress" Display="Dynamic" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("OrderAddress") %>' runat="server" ID="txtAddress" placeholder="Address" CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="txtCity">
                                        City
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter order city" Display="Dynamic" Text="*" ControlToValidate="txtCity" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("OrderCity") %>' runat="server" ID="txtCity" placeholder="City" CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="ddlOrderState">
                                        State
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select order state" Display="Dynamic" Text="*" ControlToValidate="ddlOrderState" InitialValue="0" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:DropDownList ID="ddlOrderState" runat="server" SelectedValue='<%# Bind("OrderState") %>' CssClass="form-control">
                                        <asp:ListItem Value="0">--Select State--</asp:ListItem>
                                        <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                        <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                        <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                        <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                        <asp:ListItem Value="CA">California</asp:ListItem>
                                        <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                        <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                        <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                        <asp:ListItem Value="DC">District Of Columbia</asp:ListItem>
                                        <asp:ListItem Value="FL">Florida</asp:ListItem>
                                        <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                        <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                        <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                        <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                        <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                        <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                        <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                        <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                        <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                        <asp:ListItem Value="ME">Maine</asp:ListItem>
                                        <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                        <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                        <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                        <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                        <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                        <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                        <asp:ListItem Value="MT">Montana</asp:ListItem>
                                        <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                        <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                        <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                        <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                        <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                        <asp:ListItem Value="NY">New York</asp:ListItem>
                                        <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                        <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                        <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                        <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                        <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                        <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                        <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                        <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                        <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                        <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                        <asp:ListItem Value="TX">Texas</asp:ListItem>
                                        <asp:ListItem Value="UT">Utah</asp:ListItem>
                                        <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                        <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                        <asp:ListItem Value="WA">Washington</asp:ListItem>
                                        <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                        <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                        <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label for="txtZipCode">
                                        Zip Code
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter order zip code" Display="Dynamic" Text="*" ControlToValidate="txtZipCode" ForeColor="Red" ValidationGroup="order"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("OrderZipCode") %>' runat="server" ID="txtZipCode" placeholder="Zip Code" CssClass="form-control underline" />
                                </div>

                                <div class="form-group hidden">
                                    <label for="txtLatitude">
                                        Latitude
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Latitude") %>' runat="server" ID="txtLatitude" placeholder="Latitude" CssClass="form-control underline" />
                                </div>
                                <div class="form-group hidden">
                                    <label for="txtLongitude">
                                        Longitude
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Longitude") %>' runat="server" ID="txtLongitude" placeholder="Longitude" CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="txtHeading">
                                        Heading for Invoice
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Heading") %>' runat="server" ID="txtHeading" placeholder='<%# "Order #" + Request.QueryString["order"] %>' CssClass="form-control underline" />
                                </div>
                                <div class="form-group">
                                    <label for="ddlCreatedEmp">
                                        Created By
                                    </label>
                                    <asp:DropDownList ID="ddlCreatedEmp" runat="server" SelectedValue='<%# Bind("CreatedBy") %>' CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlEmployee" DataTextField="Name" DataValueField="Id">
                                        <asp:ListItem Value="0">-- Select Employee --</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="SqlEmployee" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT [Id], CASE WHEN [LastName] + ', ' + [FirstName] = ', ' THEN [Email] ELSE [LastName] + ', ' + [FirstName] END AS [Name] FROM [tblEmployee] WHERE (([CompanyId] = @CompanyId) AND ([IsDeleted] = @IsDeleted))">
                                        <SelectParameters>
                                            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
                                            <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <label for="ddlAssignedEmp">
                                        Assigned To
                                    </label>
                                    <asp:DropDownList ID="ddlAssignedEmp" runat="server" SelectedValue='<%# Bind("AssignedTo") %>' CssClass="form-control" AppendDataBoundItems="true" DataSourceID="SqlEmployee" DataTextField="Name" DataValueField="Id">
                                        <asp:ListItem Value="0">-- Select Employee --</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label for="txtDescription">
                                        Description
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="txtDescription" placeholder="Description" CssClass="form-control underline" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <label for="txtComments">
                                        Comments
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Comments") %>' runat="server" ID="txtComments" placeholder="Comments" CssClass="form-control underline" TextMode="MultiLine" />
                                </div>
                                <br />
                                <br />
                                <div class="row hidden-print">
                                    <fieldset>
                                        <legend>Attached Files</legend>

                                        <div class="col-xs-12">
                                            <div class="list-group">
                                                <ul id="FileList" class="list-group" runat="server">
                                                </ul>
                                            </div>
                                        </div>


                                    </fieldset>
                                </div>
                                <br />
                                <br />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="order" />
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource runat="server" ID="SqlOrder" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' DeleteCommand="UPDATE [tblOrder] SET IsDeleted = 'True' WHERE [Id] = @Id" InsertCommand="INSERT INTO tblOrder(CompanyId, CustomerId, Name, RentalOutDate, RentalReturnDate, Duration, OrderAddress, OrderCity, OrderState, OrderZipCode, Latitude, Longitude, StatusId, Discount, Revenue, Description, Heading, Comments, CreatedDate, CreatedBy, AssignedTo, IsDeleted, IsCheckedOut, IsCheckedIn, intPayType, DateCheckedIn, decLateFee) VALUES (@CompanyId, @CustomerId, @Name, @RentalOutDate, @RentalReturnDate, @Duration, @OrderAddress, @OrderCity, @OrderState, @OrderZipCode, @Latitude, @Longitude, @StatusId, @Discount, @Revenue, @Description, @Heading, @Comments, @CreatedDate, @CreatedBy, @AssignedTo, @IsDeleted, @IsCheckedOut, @IsCheckedIn, @intPayType, @DateCheckedIn, @decLateFee)" SelectCommand="SELECT * FROM [tblOrder] WHERE ([Id] = @Id)" UpdateCommand="UPDATE tblOrder SET CustomerId = @CustomerId, Name = @Name, RentalOutDate = @RentalOutDate, RentalReturnDate = @RentalReturnDate, Duration = @Duration, OrderAddress = @OrderAddress, OrderCity = @OrderCity, OrderState = @OrderState, OrderZipCode = @OrderZipCode, Latitude = @Latitude, Longitude = @Longitude, StatusId = @StatusId, Discount = @Discount, Revenue = @Revenue, Description = @Description, Heading = @Heading, Comments = @Comments, CreatedDate = @CreatedDate, CreatedBy = @CreatedBy, AssignedTo = @AssignedTo, intPayType = @intPayType, DateCheckedIn = @DateCheckedIn, decLateFee = @decLateFee WHERE (Id = @Id)">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:CookieParameter CookieName="CompanyId" Type="Int32" Name="CompanyId" />
            <asp:Parameter Name="CustomerId" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="RentalOutDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="RentalReturnDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="Duration" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderAddress" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderCity" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderState" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderZipCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="Latitude" Type="String"></asp:Parameter>
            <asp:Parameter Name="Longitude" Type="String"></asp:Parameter>
            <asp:Parameter Name="StatusId" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Discount" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Revenue" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="Heading" Type="String"></asp:Parameter>
            <asp:Parameter Name="Comments" Type="String"></asp:Parameter>
            <asp:Parameter Name="CreatedDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="CreatedBy" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="AssignedTo" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="IsDeleted" Type="Boolean" DefaultValue="False"></asp:Parameter>
            <asp:Parameter Name="IsCheckedOut" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="IsCheckedIn" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="intPayType" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="DateCheckedIn" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="decLateFee" Type="Decimal"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="order" Name="Id" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="RentalOutDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="RentalReturnDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="Duration" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderAddress" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderCity" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderState" Type="String"></asp:Parameter>
            <asp:Parameter Name="OrderZipCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="Latitude" Type="String"></asp:Parameter>
            <asp:Parameter Name="Longitude" Type="String"></asp:Parameter>
            <asp:Parameter Name="StatusId" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Discount" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Revenue" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="Heading" Type="String"></asp:Parameter>
            <asp:Parameter Name="Comments" Type="String"></asp:Parameter>
            <asp:Parameter Name="CreatedDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="CreatedBy" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="AssignedTo" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="intPayType" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="DateCheckedIn" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="decLateFee" Type="Decimal"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

