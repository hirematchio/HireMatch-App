<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BasicSettings.aspx.cs" Inherits="BasicSettings" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function setUpgradeCostAdv() {
            $('span#ctrlPayment1_lblCost').text('<%=System.Web.Configuration.WebConfigurationManager.AppSettings["AdvancedCost"]%>');
            $('input#ctrlPayment1_hidCost').val('<%=System.Web.Configuration.WebConfigurationManager.AppSettings["AdvancedCost"]%>');
            $('input#ctrlPayment1_hidAcctLevel').val(1);
        }
        function setUpgradeCostPro() {
            $('span#ctrlPayment1_lblCost').text('<%=System.Web.Configuration.WebConfigurationManager.AppSettings["ProCost"]%>');
            $('input#ctrlPayment1_hidCost').val('<%=System.Web.Configuration.WebConfigurationManager.AppSettings["ProCost"]%>');
            $('input#ctrlPayment1_hidAcctLevel').val(2);
        }
    </script>
    <div class="container-fluid container-fullw bg-white">
        <div class="row">
            <div class="col-md-12">

                <div class="tabbable">
                    <ul id="myTab1" class="nav nav-tabs">
                        <li class="active">
                            <a href="#tab1" data-toggle="tab">Details & Settings
                            </a>
                        </li>
                      
                        <li>
                            <a href="#tab3" data-toggle="tab">Emails
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ZamvAppConnectionString %>"
                            SelectCommand="SELECT * FROM [tblCompany] WHERE ([Id] = @Id)"
                            UpdateCommand="UPDATE [tblCompany] SET [Name] = @Name, [Address] = @Address, [City] = @City, [State] = @State, [ZipCode] = 
                            @ZipCode, [Phone] = @Phone, [Fax] = @Fax, [PrimaryColor] = @PrimaryColor, [SecondaryColor] = @SecondaryColor WHERE [Id] = @Id">
                            <SelectParameters>
                                <asp:CookieParameter CookieName="CompanyID" Name="Id" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Address" Type="String"></asp:Parameter>
                                <asp:Parameter Name="City" Type="String"></asp:Parameter>
                                <asp:Parameter Name="State" Type="String"></asp:Parameter>
                                <asp:Parameter Name="ZipCode" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Phone" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Fax" Type="String"></asp:Parameter>
                                <asp:Parameter Name="AccountLevel" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="PrimaryColor" Type="String"></asp:Parameter>
                                <asp:Parameter Name="SecondaryColor" Type="String"></asp:Parameter>
                                <asp:CookieParameter CookieName="CompanyID" Name="Id" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ZamvAppConnectionString %>" SelectCommand="SELECT * FROM [tblAppSettings]" UpdateCommand="UPDATE [tblAppSettings] SET [TaxRate] = @TaxRate, [AcceptPaypal] = @AcceptPaypal, [PaypalEmailAddr] = @PaypalEmailAddr, [AcceptAuthorize] = @AcceptAuthorize, [AuthNetVersion] = @AuthNetVersion, [AuthMerchantEmail] = @AuthMerchantEmail, [AuthNetLoginId] = @AuthNetLoginId, [AuthNetTransKey] = @AuthNetTransKey">
                            <SelectParameters>
                                <asp:CookieParameter CookieName="CompanyID" DefaultValue="" Name="Id" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="TaxRate" Type="Decimal" />
                                <asp:Parameter Name="AcceptPaypal" Type="Boolean" />
                                <asp:Parameter Name="PaypalEmailAddr" Type="String" />
                                <asp:Parameter Name="AcceptAuthorize" Type="Boolean" />
                                <asp:Parameter Name="AuthNetVersion" Type="String" />
                                <asp:Parameter Name="AuthMerchantEmail" Type="String" />
                                <asp:Parameter Name="AuthNetLoginId" Type="String" />
                                <asp:Parameter Name="AuthNetTransKey" Type="String" />
                                <asp:CookieParameter CookieName="CompanyID" DefaultValue="" Name="Id" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <div class="tab-pane fade in active" id="tab1">
                            <div class="row">
                                <div class="col-xs-8">
                                    <asp:FormView ID="fvCompany" runat="server" DataKeyNames="id" DataSourceID="SqlDataSource3" DefaultMode="Edit" Width="100%">
                                        <EditItemTemplate>
                                            <fieldset class="margin-top-30">
                                                <legend>Company Information
                                                </legend>
                                                <div class="form-group">
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox3" CssClass="form-control" Text='<%#Bind("Name") %>' runat="server" placeholder="Company Name"></asp:TextBox>
                                                        <i class="fa fa-building-o"></i>
                                                    </span>
                                                </div>

                                                <div class="form-group">
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox6" CssClass="form-control" Text='<%#Bind("Address") %>' runat="server" placeholder="Company Addres"></asp:TextBox>
                                                        <i class="fa fa-building"></i>
                                                    </span>
                                                </div>

                                                <div class="form-group">
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox7" CssClass="form-control" Text='<%#Bind("City") %>' runat="server" placeholder="City"></asp:TextBox>
                                                        <i class="fa fa-compass"></i>
                                                    </span>
                                                </div>

                                                <div class="form-group">
                                                    State
                                                        <asp:DropDownList ID="ddlState" CssClass="form-control" runat="server" SelectedValue='<%#Bind("State") %>'>
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
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox9" CssClass="form-control" Text='<%#Bind("ZipCode") %>' runat="server" placeholder="Zip Code"></asp:TextBox>
                                                        <i class="fa fa-location-arrow"></i>
                                                    </span>
                                                </div>
                                                <div class="form-group">
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox10" CssClass="form-control" Text='<%#Bind("Phone") %>' runat="server" placeholder="Company Phone"></asp:TextBox>
                                                        <i class="fa fa-phone"></i>
                                                    </span>
                                                </div>

                                                <hr />
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>
                                                                Company Logo
                                                            </label>
                                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;">
                                                                    <asp:Image ID="imgLogo" runat="server" CssClass="img-responsive" />
                                                                </div>
                                                                <br />
                                                                <span class="btn btn-default btn-file">Browse
                                                            <asp:FileUpload ID="fulLogo" runat="server" />
                                                                </span>

                                                                <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" OnClick="btnUpload_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">&nbsp;</div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            Primary Business Color
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox11" CssClass="form-control" TextMode="color" Text='<%#Bind("PrimaryColor") %>' runat="server" placeholder="Hex Code 1"></asp:TextBox>
                                                        <i class="fa fa-paint-brush"></i>
                                                    </span>
                                                        </div>
                                                        <div class="form-group">
                                                            Secondary Business Color
                                                    <span class="input-icon">
                                                        <asp:TextBox ID="TextBox12" CssClass="form-control" TextMode="color" Text='<%#Bind("SecondaryColor") %>' runat="server" placeholder="Hex Code 2"></asp:TextBox>
                                                        <i class="fa fa-paint-brush"></i>
                                                    </span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-5 col-md-12">
                                                        <div class="form-group">

                                                            <div class="panel-heading">
                                                                <div class="panel-title">
                                                                    Your current Account Level is: 
                                                                </div>
                                                            </div>
                                                            <div class="panel-body">
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <div class="list-group">
                                                                            <li class="list-group-item <%=acctLevel0 %>">Basic - Free
                                                                            </li>
                                                                            <li class="list-group-item <%=acctLevel1 %>">
                                                                                <p class="links cl-effect-1 left">
                                                                                    Advanced
                                                                <a id="adv" href="#" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="setUpgradeCostAdv()">Upgrade Now</a>
                                                                                </p>
                                                                            </li>
                                                                            <li class="list-group-item <%=acctLevel2 %>">
                                                                                <p class="links cl-effect-1  left">
                                                                                    Professional
                                                                <a id="pro" href="#" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="setUpgradeCostPro()">Upgrade Now</a>
                                                                                </p>
                                                                            </li>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </fieldset>


                                        </EditItemTemplate>
                                    </asp:FormView>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="tab2">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:FormView ID="fvMain" runat="server" DataKeyNames="id" DataSourceID="SqlDataSource2" DefaultMode="Edit" Width="100%">
                                <EditItemTemplate>

                                    <div class="panel panel-transparent">
                                        <fieldset>
                                            <div class="panel-body col-sm-4 col-md-4">
                                                <p style="float: right;">
                                                    Accept Credit Cards via
                                                        <img src="assets/images/authorize.png" /><br />
                                                </p>
                                                <div class="">
                                                    <asp:CheckBox CssClass="bigCheckbox" ID="chkAuthorize" AutoPostBack="True" OnCheckedChanged="chkAuthorizeChanged" Checked='<%#Bind("AcceptAuthorize") %>' runat="server" />
                                                </div>
                                                <br />
                                            </div>
                                        </fieldset>
                                        <div class="panel-body" visible="false" id="AuthorizeDetails" runat="server">
                                            <div class="form-group">

                                                <label class="control-label">
                                                    Authorize.Net Version
                                                </label>
                                                <span class="input-icon">
                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" Text='<%#Bind("AuthNetVersion") %>' runat="server" placeholder="Email Address"></asp:TextBox><i class="fa fa-tablet"></i></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Merchant Email
                                                </label>
                                                <span class="input-icon">
                                                    <asp:TextBox ID="TextBox1" CssClass="form-control" Text='<%#Bind("AuthMerchantEmail") %>' runat="server" placeholder="Email Address"></asp:TextBox><i class="fa fa-envelope"></i></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Login ID
                                                </label>
                                                <span class="input-icon">
                                                    <asp:TextBox ID="TextBox4" CssClass="form-control" Text='<%#Bind("AuthNetLoginID") %>' runat="server" placeholder="Email Address"></asp:TextBox><i class="fa fa-user"></i></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Transaction Key
                                                </label>
                                                <span class="input-icon">
                                                    <asp:TextBox ID="TextBox5" CssClass="form-control" Text='<%#Bind("AuthNetTransKey") %>' runat="server" placeholder="Email Address"></asp:TextBox><i class="fa fa-key"></i></span>
                                            </div>
                                        </div>

                                        <fieldset>
                                            <div class="panel-body col-sm-4 col-md-4">
                                                <p style="float: right;">
                                                    Accept Payments via
                                                <img src="assets/images/paypal.png" /><br />
                                                </p>
                                                <div class="">
                                                    <asp:CheckBox CssClass="bigCheckbox" ID="chkPaypal" OnCheckedChanged="chkPayPalChanged" runat="server" Checked='<%# Bind("AcceptPaypal") %>' AutoPostBack="True" />
                                                </div>
                                            </div>
                                        </fieldset>
                                        <div id="paypalpanel" runat="server" visible="false" class="panel-body">
                                            <div class="form-group">
                                                <label class="control-label">
                                                    Paypal Email Address
                                                </label>
                                                <span class="input-icon">
                                                    <asp:TextBox ID="TextBox2" CssClass="form-control" Text='<%#Bind("PaypalEmailAddr") %>' runat="server" placeholder="Email Address"></asp:TextBox><i class="fa fa-envelope"></i></span>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="form-group width-200">
                                            Tax Rate
                                        <span class="input-icon">
                                            <asp:TextBox ID="TextBox13" CssClass="form-control" TextMode="Number" placeholder="Tax Rate" ng-model="myDecimal" ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01" Text='<%#Bind("TaxRate") %>' runat="server"></asp:TextBox>
                                            <i class="fa fa-money"></i>
                                        </span>
                                        </div>
                                    </div>

                                </EditItemTemplate>
                            </asp:FormView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            
                        </div>

                        <div class="tab-pane fade" id="tab3">

                            <script src="vendor/ckeditor/ckeditor.js"></script>
                            <script src="vendor/ckeditor/adapters/jquery.js"></script>
                            <script src="assets/js/main.js"></script>
                            <script src="assets/js/form-text-editor.js"></script>
                            <style>
                                td, th {
                                    border-width: 0px !Important;
                                }
                            </style>
                            <!-- start: PAGE TITLE -->
                            <section id="page-title">
                                <div class="row">
                                    <div class="col-sm-8">

                                        <nav class="align-right report-nav">

                                            <div class="panel-body">
                                                <p>
                                                    Choose Template:
                                                </p>
                                                <div class="btn-group" data-toggle="buttons">
                                                    <label class="btn btn-primary active">
                                                        <input type="radio" name="options" id="option1" autocomplete="off" checked>
                                                        Resume Request
                                                    </label>
                                                    <label class="btn btn-red" data-toggle="tooltip" title="Option Coming Soon">
                                                        <input type="radio" name="options" id="option2" autocomplete="off">
                                                        Interview
                                                    </label>
                                                    <label class="btn btn-red" data-toggle="tooltip" title="Option Coming Soon">
                                                        <input type="radio" name="options" id="option3" autocomplete="off">
                                                        You are Hired!
                                                    </label>
                                                </div>
                                            </div>
                                        </nav>
                                    </div>


                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <br />
                                        <asp:DetailsView ID="EmailsVw" runat="server" BorderWidth="0" DefaultMode="Edit" Width="80%" AutoGenerateRows="False" DataSourceID="SqlDataSource1" AutoGenerateEditButton="False">
                                            <Fields>
                                                <asp:TemplateField>
                                                    <EditItemTemplate>


                                                        <div class="form-group">
                                                            <label>
                                                                Subject Line
                                                            </label>
                                                            <span class="input-icon">
                                                                <asp:TextBox Text='<%# Bind("emailSubject")%>' ID="txtSubject" runat="server" placeholder="Email Subject" CssClass="form-control"></asp:TextBox>
                                                                <i class="ti-email"></i></span>
                                                        </div>
                                                        <label>
                                                            Values
                                                        </label>
                                                        <span>[CandidateFirstName] [CandidateLastName] [CompanyPhone] [CompanyAddress]

                                                        </span>

                                                        <asp:TextBox ID="txtEmailText" runat="server" Text='<%# Bind("emailText")%>' CssClass="ckeditor form-control" TextMode="MultiLine"></asp:TextBox>



                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                            </Fields>
                                        </asp:DetailsView>
                                    </div>
                                </div>
                            </section>
                            <!-- end: PAGE TITLE -->


                            <!-- end: TEXT EDITOR -->

                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ZamvAppConnectionString %>" 
							SelectCommand="SELECT * FROM [tblemailsettings] WHERE ([CompanyId] = @CompanyID)"
                                UpdateCommand="UPDATE [tblemailsettings] SET [emailText] = @emailText, [emailSubject] = @emailSubject WHERE [id] = @CompanyID">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="strType" Type="String" />
                                    <asp:Parameter Name="strText" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:CookieParameter Name="CompanyID" CookieName="CompanyId" Type="Int32" />
                                    <%--<asp:QueryStringParameter DefaultValue="1" Name="CompanyID" QueryStringField="id" Type="Int32" />--%>
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="emailText" Type="String" />
                                    <asp:Parameter Name="emailSubject" Type="String" />
                                    <asp:CookieParameter Name="CompanyID" CookieName="CompanyID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</asp:Content>

