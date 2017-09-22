<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddInventory.aspx.cs" Inherits="AddInventory" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .btn-file {
            position: relative;
            overflow: hidden;
        }

            .btn-file input[type=file] {
                position: absolute;
                top: 0;
                right: 0;
                min-width: 100%;
                min-height: 100%;
                font-size: 100px;
                text-align: right;
                filter: alpha(opacity=0);
                opacity: 0;
                outline: none;
                background: white;
                cursor: inherit;
                display: block;
            }
    </style>

    <asp:FormView ID="fvInventory" runat="server" DataKeyNames="Id" DataSourceID="SqlInventory" Width="100%">
        <EditItemTemplate>
            <div class="container-fluid container-fullw">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="fulItem">
                                        Item Image
                                    </label>
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-preview thumbnail" data-provides="fileinput" data-trigger="fileinput" style="width: 100%; height: auto;">
                                            <asp:Image ID="imgAsset" runat="server" ImageUrl='<%# CheckAssetImage("App_Files/Company/" + c.Id + "/Assets/" + Eval("ID").ToString() + ".png") + "?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss")%>' CssClass="img-responsive" />
                                        </div>
                                    </div>
                                    <span class="btn btn-default btn-file">Browse
                                                <asp:FileUpload ID="fulAsset" runat="server" />
                                    </span>

                                    <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" OnClick="btnUpload_Click" CommandArgument='<%# Eval("ID") %>' CausesValidation="false" />
                                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                                <div class="form-group">
                                    <label for="txtItemName">
                                        Job Title <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Job Title" Display="Dynamic" Text="*" ControlToValidate="txtItemName" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtItemName" CssClass="form-control underline" placeholder="Job Title" />
                                </div>
                                <div class="form-group">
                                    <label for="txtItemDescription">
                                        Job Description
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtItemDescription" CssClass="form-control underline" placeholder="Item Description" TextMode="MultiLine" />
                                </div>

                                <input id="ex1" data-slider-id='ex1Slider' type="text" data-slider-min="0" data-slider-max="20" data-slider-step="1" data-slider-value="14"/>
                                <div class="form-group">
                                    <label for="txtModelNumber">
                                        Model Number <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter model number" Text="*" ControlToValidate="txtModelNumber" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtModelNumber" CssClass="form-control underline" placeholder="Model Number" />
                                </div>
                                <div class="form-group">
                                    <label for="txtSerialNumber">
                                        Serial Number <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter serial number" Text="*" ControlToValidate="txtSerialNumber" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtSerialNumber" CssClass="form-control underline" placeholder="Serial Number" />
                                </div>

                                <div class="form-group">
                                    <label for="txtItemGroup">
                                        Item Group
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Group") %>' runat="server" ID="txtItemGroup" CssClass="form-control underline" placeholder="Item Group" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Educational Requirements</h5>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="txtPerMinute">
                                        Per Minute <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter price per minute.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerMinute" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerMinute") %>' runat="server" ID="txtPerMinute" CssClass="form-control underline" placeholder="(Rate Per Min.)" />
                                </div>
                                <div class="form-group">
                                    <label for="txtPerHour">
                                        Per Hour <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter price per hour.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerHour" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerHour") %>' runat="server" ID="txtPerHour" CssClass="form-control underline" placeholder="(Hourly Rate)" />
                                </div>
                                <div class="form-group">
                                    <label for="txtPerDay">
                                        Per Day <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter price per day.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerDay" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerDay") %>' runat="server" ID="txtPerDay" CssClass="form-control underline" placeholder="(Daily Rate)" />
                                </div>
                                <div class="form-group">
                                    <label for="txtPerWeek">
                                        Per Week <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please enter price per week.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerWeek" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerWeek") %>' runat="server" ID="txtPerWeek" CssClass="form-control underline" placeholder="(Weekly Rate)" />
                                </div>
                                <div class="form-group">
                                    <label for="txtPerMonth">
                                        Per Month <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please enter price per month.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerMonth" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerMonth") %>' runat="server" ID="txtPerMonth" CssClass="form-control underline" placeholder="(Monthly Rate)" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <hr />
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Extended Information</h5>
                            </div>
                            <div class="panel-body">

                                <div class="form-group">
                                    <label for="txtItemCost">
                                        Item Cost
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Cost") %>' runat="server" ID="txtItemCost" CssClass="form-control underline" placeholder="Item Cost" />
                                </div>
                                <div class="form-group">
                                    <label for="txtDatePurchased">
                                        Purchased On
                                    </label>
                                    <div class='input-group date' id='datetimepicker1'>
                                        <asp:TextBox Text='' runat="server" ID="txtDatePurchased" CssClass="form-control underline" placeholder="Purchased On" />
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
                                    <label for="txtVendorName">
                                        Vendor Name
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorName") %>' runat="server" ID="VendorNameTextBox" CssClass="form-control underline" placeholder="Vendor Name" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorEmail">
                                        Vendor Email
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorEmail") %>' runat="server" ID="VendorEmailTextBox" CssClass="form-control underline" placeholder="Vendor Email" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter valid vendor email address" ForeColor="Red" Text="*" ControlToValidate="VendorEmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorPhone">
                                        Vendor Phone
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorPhone") %>' runat="server" ID="VendorPhoneTextBox" CssClass="form-control underline" placeholder="Vendor Phone" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Recruitment Information</h5>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="txtVendorAddress">
                                        Vendor Address
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorAddress") %>' runat="server" ID="VendorAddressTextBox" CssClass="form-control underline" placeholder="Vendor Address" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorCity">
                                        Vendor City
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorCity") %>' runat="server" ID="VendorCityTextBox" CssClass="form-control underline" placeholder="Vendor City" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorState">
                                        Vendor State
                                    </label>
                                    <asp:DropDownList ID="ddlVendorState" runat="server" SelectedValue='<%# Bind("VendorState") %>' CssClass="form-control">
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
                                    <label for="txtVendorZip">
                                        Vendor Zip Code
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorZipCode") %>' runat="server" ID="VendorZipCodeTextBox" CssClass="form-control underline" placeholder="Vendor Zip Code" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="asset" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="container-fluid container-fullw">
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-transparent">

                            <div class="panel-body">
                                <div class="form-group">

                                    <div class="fileinput-preview thumbnail " data-trigger="fileinput" style="width: 100%; height: auto;">
                                        <asp:Image ID="imgAsset" runat="server" ImageUrl='<%# CheckAssetImage("App_Files/Company/" + c.Id + "/Assets/new.png") + "?dt=" + DateTime.Now.ToString("yyyyMMddhhmmss")%>' CssClass="img-responsive" />
                                    </div>

                                    <span class="btn btn-default btn-file">Browse
                                                <asp:FileUpload ID="fulAsset" runat="server" />
                                    </span>

                                    <asp:Button ID="btnUpload" runat="server" Text="Upload Logo" CssClass="btn btn-success" OnClick="btnUpload_Click" CommandArgument='<%# Eval("ID") %>' />
                                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                                <div class="form-group">
                                    <label for="txtItemName">
                                        Job Title <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Job Title" Display="Dynamic" Text="*" ControlToValidate="txtItemName" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="txtItemName" CssClass="form-control underline" placeholder="Job Title" />
                                </div>
                                 <div class="form-group">
                                    <label for="radPayTypes">
                                       Job Type
                                    </label>
                                    <asp:RadioButtonList ID="radPayTypes" CssClass="clip-radio" runat="server"  RepeatDirection="Horizontal" AutoPostBack="true">
                                        <asp:ListItem Value="0" Selected="True">Part-Time</asp:ListItem>
                                        <asp:ListItem Value="1">Contact</asp:ListItem>
                                        <asp:ListItem Value="2">Full-Time</asp:ListItem>
                                        <asp:ListItem Value="1">Project</asp:ListItem>
                                        <asp:ListItem Value="2">One Time</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="form-group">
                                    <label for="txtItemDescription">
                                        Job Description
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtItemDescription" CssClass="form-control underline" placeholder="Item Description" TextMode="MultiLine" />
                                </div>

                                    <div class="form-group">
                                    <label for="txtItemGroup">
                                        Token Allotment (<span id="tokencount"></span>)
                                    </label>
                                    <div id="slidecontainer">
                                        <input type="range" min="1" max="50000" value="1000" onchange="$('#tokencount').text($(this).val())" class="slider" id="storlek_testet"">
                                     </div>
                                    </div>

                               <div class="form-group">
                                    <label for="txtItemGroup">
                                        Job Category
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtItemGroup" CssClass="form-control underline" placeholder="Industry" />
                                </div>
                                <div class="form-group">
                                    <label for="txtModelNumber">
                                        Country <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Country" Text="*" ControlToValidate="txtModelNumber" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtModelNumber" CssClass="form-control underline" placeholder="Country" />
                                </div>
                                <div class="form-group">
                                    <label for="txtSerialNumber">
                                        City <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter city" Text="*" ControlToValidate="txtSerialNumber" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='' runat="server" ID="txtSerialNumber" CssClass="form-control underline" placeholder="City" />
                                </div>


                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Candidate Education</h5>
                            </div>
                            <div class="panel-body">

                                        <div class="form-group">
                                    <label for="radPayTypes">
                                       Minimum Education
                                    </label>
                                    <asp:RadioButtonList ID="RadioButtonList1" CssClass="clip-radio" runat="server"  RepeatDirection="Horizontal" AutoPostBack="true">
                                        <asp:ListItem Value="0" Selected="True">GED</asp:ListItem>
                                        <asp:ListItem Value="1">High School</asp:ListItem>
                                        <asp:ListItem Value="2">Bachelors</asp:ListItem>
                                        <asp:ListItem Value="1">Masters</asp:ListItem>
                                        <asp:ListItem Value="2">P.H.D</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="form-group">
                                    <label for="txtPerMinute">
                                        Degree Specialty <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please enter price per minute.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerMinute" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerMinute") %>' runat="server" ID="txtPerMinute" CssClass="form-control underline" placeholder="Specialization" />
                                </div>
                                <div class="form-group">
                                    <label for="txtPerHour">
                                        Other Skills <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Please enter price per hour.  If none, enter 0." Display="Dynamic" Text="*" ControlToValidate="txtPerHour" ForeColor="Red" ValidationGroup="asset"></asp:RequiredFieldValidator>
                                    </label>
                                    <asp:TextBox Text='<%# Bind("PricePerHour") %>' runat="server" ID="txtPerHour" CssClass="form-control underline" placeholder="Other Skills (Word, Excel, etc.)" />
                                </div>
                            
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <hr />
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Extended Information</h5>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="txtItemCost">
                                        Salary
                                    </label>
                                    <asp:TextBox Text='<%# Bind("Cost") %>' runat="server" ID="txtItemCost" CssClass="form-control underline" placeholder="Job Salary" />
                                </div>
                                <div class="form-group">
                                    <label for="txtDatePurchased">
                                        Job Start Date
                                    </label>
                                    <div class='input-group date' id='datetimepicker1'>
                                        <asp:TextBox Text='' runat="server" ID="txtDatePurchased" CssClass="form-control underline" placeholder="Candidate Start Date" />
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
                                    <label for="txtVendorName">
                                        Vendor Name
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorName") %>' runat="server" ID="VendorNameTextBox" CssClass="form-control underline" placeholder="Vendor Name" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorEmail">
                                        Vendor Email
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorEmail") %>' runat="server" ID="VendorEmailTextBox" CssClass="form-control underline" placeholder="Vendor Email" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorPhone">
                                        Vendor Phone
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorPhone") %>' runat="server" ID="VendorPhoneTextBox" CssClass="form-control underline" placeholder="Vendor Phone" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-transparent">
                            <div class="panel-heading">
                                <h5 class="panel-title">Recruitment Information</h5>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="txtVendorAddress">
                                        Vendor Address
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorAddress") %>' runat="server" ID="VendorAddressTextBox" CssClass="form-control underline" placeholder="Vendor Address" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorCity">
                                        Vendor City
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorCity") %>' runat="server" ID="VendorCityTextBox" CssClass="form-control underline" placeholder="Vendor City" />
                                </div>
                                <div class="form-group">
                                    <label for="txtVendorState">
                                        Vendor State
                                    </label>
                                    <asp:DropDownList ID="ddlVendorState" runat="server" SelectedValue='<%# Bind("VendorState") %>' CssClass="form-control">
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
                                    <label for="txtVendorZip">
                                        Vendor Zip Code
                                    </label>
                                    <asp:TextBox Text='<%# Bind("VendorZipCode") %>' runat="server" ID="VendorZipCodeTextBox" CssClass="form-control underline" placeholder="Vendor Zip Code" />
                                </div>
                            </div>
                        </div>
                    </div>
    
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="asset" />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource runat="server" ID="SqlInventory" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' DeleteCommand="DELETE FROM [tblAsset] WHERE [Id] = @Id" InsertCommand="INSERT INTO [tblAsset] ([CompanyId], [Name], [ModelNumber], [SerialNumber], [Group], [Description], [Cost], [VendorName], [VendorAddress], [VendorCity], [VendorState], [VendorZipCode], [VendorPhone], [VendorEmail], [PurchaseDate], [PricePerMinute], [PricePerHour], [PricePerDay], [PricePerWeek], [PricePerMonth], [IsDeleted], [IsRented]) VALUES (@CompanyId, @Name, @ModelNumber, @SerialNumber, @Group, @Description, @Cost, @VendorName, @VendorAddress, @VendorCity, @VendorState, @VendorZipCode, @VendorPhone, @VendorEmail, @PurchaseDate, @PricePerMinute, @PricePerHour, @PricePerDay, @PricePerWeek, @PricePerMonth, @IsDeleted, @IsRented); SELECT @Id=SCOPE_IDENTITY()" SelectCommand="SELECT * FROM [tblAsset] WHERE (([CompanyId] = @CompanyId) AND ([IsDeleted] = @IsDeleted) AND ([Id] = @Id))" UpdateCommand="UPDATE [tblAsset] SET [Name] = @Name, [ModelNumber] = @ModelNumber, [SerialNumber] = @SerialNumber, [Group] = @Group, [Description] = @Description, [Cost] = @Cost, [VendorName] = @VendorName, [VendorAddress] = @VendorAddress, [VendorCity] = @VendorCity, [VendorState] = @VendorState, [VendorZipCode] = @VendorZipCode, [VendorPhone] = @VendorPhone, [VendorEmail] = @VendorEmail, [PurchaseDate] = @PurchaseDate, [PricePerMinute] = @PricePerMinute, [PricePerHour] = @PricePerHour, [PricePerDay] = @PricePerDay, [PricePerWeek] = @PricePerWeek, [PricePerMonth] = @PricePerMonth WHERE [Id] = @Id" OnInserted="SqlInventory_Inserted" OnUpdated="SqlInventory_Updated">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="ModelNumber" Type="String"></asp:Parameter>
            <asp:Parameter Name="SerialNumber" Type="String"></asp:Parameter>
            <asp:Parameter Name="Group" Type="String"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="Cost" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="VendorName" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorAddress" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorCity" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorState" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorZipCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorPhone" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorEmail" Type="String"></asp:Parameter>
            <asp:Parameter Name="PurchaseDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="PricePerMinute" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerHour" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerDay" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerWeek" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerMonth" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="IsDeleted" Type="Boolean" DefaultValue="False"></asp:Parameter>
            <asp:Parameter Name="IsRented" Type="Boolean" DefaultValue="False"></asp:Parameter>
            <asp:Parameter Direction="Output" Name="Id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:CookieParameter CookieName="CompanyId" Name="CompanyId" Type="Int32"></asp:CookieParameter>
            <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean"></asp:Parameter>
            <asp:QueryStringParameter Name="Id" Type="String" QueryStringField="item" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="ModelNumber" Type="String"></asp:Parameter>
            <asp:Parameter Name="SerialNumber" Type="String"></asp:Parameter>
            <asp:Parameter Name="Group" Type="String"></asp:Parameter>
            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
            <asp:Parameter Name="Cost" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="VendorName" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorAddress" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorCity" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorState" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorZipCode" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorPhone" Type="String"></asp:Parameter>
            <asp:Parameter Name="VendorEmail" Type="String"></asp:Parameter>
            <asp:Parameter Name="PurchaseDate" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="PricePerMinute" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerHour" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerDay" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerWeek" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PricePerMonth" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

