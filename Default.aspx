<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/ucActivities.ascx" TagPrefix="uc1" TagName="ucActivities" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        @import url(http://fonts.googleapis.com/css?family=Open+Sans:400,700);

        @keyframes bake-pie {
            from {
                transform: rotate(0deg) translate3d(0,0,0);
            }
        }

        body {
            font-family: "Open Sans", Arial;
            background: #EEE;
        }

        main {
            width: 400px;
            margin: 30px auto;
        }

        section {
            margin-top: 30px;
        }

        .pieID {
            display: inline-block;
            vertical-align: top;
        }

        .pie {
            height: 200px;
            width: 200px;
            position: relative;
            margin: 0 30px 30px 0;
        }

            .pie::before {
                content: "";
                display: block;
                position: absolute;
                z-index: 1;
                width: 100px;
                height: 100px;
                background: #FFF;
                border-radius: 50%;
                top: 50px;
                left: 50px;
            }

        .slice {
            position: absolute;
            width: 200px;
            height: 200px;
            clip: rect(0px, 200px, 200px, 100px);
            animation: bake-pie 1s;
        }

            .slice span {
                display: block;
                position: absolute;
                top: 0;
                left: 0;
                background-color: black;
                width: 200px;
                height: 200px;
                border-radius: 50%;
                clip: rect(0px, 200px, 200px, 100px);
            }

        .legend {
            list-style-type: none;
            padding: 0;
            margin: 0;
            background: #FFF;
            padding: 15px;
            font-size: 13px;
            border: 1px solid #DDD;
        }

            .legend li {
                width: 110px;
                height: 1.25em;
                margin-bottom: 0.7em;
                padding-left: 0.5em;
                border-left: 1.25em solid black;
            }

            .legend em {
                font-style: normal;
                float: left;
            }

            .legend span {
                float: right;
                font-weight: bold;
            }

        footer {
            position: fixed;
            bottom: 0;
            right: 0;
            font-size: 13px;
            background: #DDD;
            padding: 5px 10px;
            margin: 5px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            function sliceSize(dataNum, dataTotal) {
                return (dataNum / dataTotal) * 360;
            }
            function addSlice(sliceSize, pieElement, offset, sliceID, color) {
                $(pieElement).append("<div class='slice " + sliceID + "'><span></span></div>");
                var offset = offset - 1;
                var sizeRotation = -179 + sliceSize;
                $("." + sliceID).css({
                    "transform": "rotate(" + offset + "deg) translate3d(0,0,0)"
                });
                $("." + sliceID + " span").css({
                    "transform": "rotate(" + sizeRotation + "deg) translate3d(0,0,0)",
                    "background-color": color
                });
            }
            function iterateSlices(sliceSize, pieElement, offset, dataCount, sliceCount, color) {
                var sliceID = "s" + dataCount + "-" + sliceCount;
                var maxSize = 179;
                if (sliceSize <= maxSize) {
                    addSlice(sliceSize, pieElement, offset, sliceID, color);
                } else {
                    addSlice(maxSize, pieElement, offset, sliceID, color);
                    iterateSlices(sliceSize - maxSize, pieElement, offset + maxSize, dataCount, sliceCount + 1, color);
                }
            }
            function createPie(dataElement, pieElement) {
                var listData = [];
                $(dataElement + " span").each(function () {
                    listData.push(Number($(this).html()));
                });
                var listTotal = 0;
                for (var i = 0; i < listData.length; i++) {
                    listTotal += listData[i];
                }
                var offset = 0;
                var color = [
                    "#5cb85c",//success
                    "#eea236",//warning
                    "#e27c79",//danger
                    "#ffffff"//default
                ];
                for (var i = 0; i < listData.length; i++) {
                    var size = sliceSize(listData[i], listTotal);
                    iterateSlices(size, pieElement, offset, i, 0, color[i]);
                    $(dataElement + " li:nth-child(" + (i + 1) + ")").css("border-color", color[i]);
                    offset += size;
                }
            }

            function createPieZero(dataElement, pieElement) {
                var listTotal = 1;
                var offset = 0;
                var color = [
                    "#999999"//default
                ];
                var size = sliceSize(100, listTotal);
                iterateSlices(size, pieElement, offset, 0, 1, color[0]);
                $(dataElement + " li:nth-child(" + (4) + ")").css("border-color", color[0]);
                offset += size;
            }
            <%if(totalOutOrderCount!=0){ %>
            createPie(".pieID.legend", ".pieID.pie");
            <%}else{ %>
            $('ul.pieID.legend li:nth-child(1)').addClass('hidden');
            $('ul.pieID.legend li:nth-child(2)').addClass('hidden');
            $('ul.pieID.legend li:nth-child(3)').addClass('hidden');
            $('ul.pieID.legend li:nth-child(4)').removeClass('hidden');
            createPieZero(".pieID.legend", ".pieID.pie");
            <%} %>
        });//end ready
    </script>
    <div class="wrap-content container" id="container">
        <!-- start: DASHBOARD TITLE -->

        <!-- end: DASHBOARD TITLE -->
        <!-- start: FEATURED BOX LINKS -->
        <div class=" container-fluid container-fullw bg-white">
            <div class="row">
                <div class="col-sm-6">
                    <div class=" panel panel-white no-radius text-center">
                        <div class="panel-body">
                            <span class="fa-stack fa-2x"><i class="fa fa-square fa-stack-2x text-primary"></i><i class="fa fa-user fa-stack-1x fa-inverse"></i></span>
                            <h2>Posted Offers</h2>
                             <div class=" panel panel-white no-radius text-center col-sm-5 margin-left-20 margin-right-20 padding-25">

                                Opened
                                 <br />
                                 3
                            </div>

                            <div class=" panel panel-white no-radius text-center col-sm-5 margin-left-20 margin-right-20 padding-25">
                                Closed
                                 <br />
                                 3
                            </div>

                        </div>
                    </div>
                </div>
             <div class="col-sm-6">
                    <div class=" panel panel-white no-radius text-center">
                        <div class="panel-body">
                            <span class="fa-stack fa-2x"><i class="fa fa-square fa-stack-2x text-primary"></i><i class="fa fa-user fa-stack-1x fa-inverse"></i></span>
                            <h2>Candidates</h2>
                             <div class=" panel panel-white no-radius text-center col-sm-3 margin-left-10 margin-right-10 padding-25">

                                Pending
                                 <br />
                                 32
                            </div>

                            <div class=" panel panel-white no-radius text-center col-sm-2 margin-right-10 padding-25">
                                Verified
                                 <br />
                                 145
                            </div>
                             <div class=" panel panel-white no-radius text-center col-sm-2 margin-right-10 padding-25">
                                Rejected
                                 <br />
                                 251
                            </div>
                               <div class=" panel panel-white no-radius text-center col-sm-3  padding-25">
                                Preselected
                                 <br />
                                 3
                            </div>
                        </div>
                    </div>
                </div>
        
            </div>
        </div>
        <!-- end: FEATURED BOX LINKS -->



        <!-- start: FOURTH SECTION -->
        <div class="container-fluid container-fullw bg-white">
            <div class="row">
                <div class="col-xs-12 col-sm-4">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-white no-radius">
                                <div class="panel-body padding-20 text-center">
                                    <div class="space10">
                                        <h5 class="text-dark no-margin">My <b>HIRE</b> Token Balance</h5>
                                        <h2 class="no-margin"><small>$</small><%=totalRevenue.ToString("n2") %></h2>
                                        <span class="badge badge-success margin-top-20">Purchase HIRE</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                  
                    </div>
                </div>
                <uc1:ucActivities runat="server" ID="ucActivities" />

            </div>
        </div>
        <!-- end: FOURTH SECTION -->
    </div>
</asp:Content>

