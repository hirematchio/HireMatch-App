<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctrlPayment.ascx.cs" Inherits="ctrlPayment" %>
<script>
    $(document).ready(function () {
        var acctLevel = $('#hidAcctLevel').val();
        if ((acctLevel == null) || (acctLevel == '')) {
            $('#spanPerMonth').addClass('hidden');
        }
    });
</script>

<div class="row">
    <div class="col-md-12 padding-top-20">
        <fieldset>
            <legend>Payment Method
            </legend>
            <label>
                Payment type
            </label>
            <div class="form-group">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-primary active">
                        <input type="radio" name="paymentMethod" id="option1" value="credit card">
                        <i class="fa fa-cc-visa"></i><i class="fa fa-cc-mastercard"></i>Credit Card
                    </label>
                    <label class="btn btn-red" title="Paypal coming soon">
                        <input type="radio" name="paymentMethod" id="option2" value="paypal">
                        <i class="fa fa-cc-paypal"></i>PayPal
                    </label>
                </div>
                <div class="pull-right">
                    <asp:HiddenField ID="hidCost" runat="server" />
                    <asp:HiddenField ID="hidAcctLevel" runat="server" />
                    <h1>$<asp:Label ID="lblCost" runat="server"></asp:Label></h1>
                    <span id="spanPerMonth" class="pull-left">per month</span>
                </div>
            </div>
            <div class="form-group">
                <label>
                    First Name
                </label>
                <asp:TextBox ID="txtFirst" runat="server" type="text" class="form-control" name="cardNumber" placeholder="Enter First Name"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>
                    Last Name
                </label>
                <asp:TextBox ID="txtLast" runat="server" type="text" class="form-control" name="cardNumber" placeholder="Enter Last Name"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>
                    Card Number
                </label>
                <asp:TextBox ID="txtCreditNum" runat="server" type="text" class="form-control" name="cardNumber" placeholder="Enter Card Number"></asp:TextBox>
            </div>
            <label>
                Expires
            </label>
            <div class="row">
                <div class="col-md-2 col-sm-2">
                    <div class="form-group">
                        <select id="ddlmonth" runat="server" class="cs-select cs-skin-slide">
                            <option value="" disabled>Month</option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="form-group">
                        <select id="ddlyear" runat="server" class="cs-select cs-skin-slide">
                            <option value="" disabled>Year</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <label>
                        Security code
                    </label>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <input type="text" id="securitycode" runat="server" class="form-control" name="securityCode" placeholder="Security code">
                            </div>
                        </div>
                        <asp:Button UseSubmitBehavior="false" CausesValidation="false" ID="btnPay" runat="server" class="btn btn-md btn-primary pull-right" Text="Submit Payment" OnClick="btnPay_Click" />
                        <br />
                        <br />
                        <br />
                    </div>
                </div>
            </div>
        </fieldset>

    </div>
</div>

