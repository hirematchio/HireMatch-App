<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" %>

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
                background: #EEE;
                border-radius: 50%;
                top: 50px;
                left: 50px;
            }

            .pie::after {
                content: "";
                display: block;
                width: 120px;
                height: 2px;
                background: rgba(0,0,0,0.1);
                border-radius: 50%;
                box-shadow: 0 0 3px 4px rgba(0,0,0,0.1);
                margin: 220px auto;
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
            box-shadow: 1px 1px 0 #DDD, 2px 2px 0 #BBB;
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
            //createPie(".pieID.legend", ".pieID.pie");

        });//end ready
    </script>
    <div class="container-fluid container-fullw bg-white">
        <div class="row">
            <div class="col-sm-12">
                <h5 class="over-title margin-bottom-15">Line <span class="text-bold">Chart</span></h5>
                <div class="row">
                    <div class="col-sm-6">
                        <canvas id="lineChart" class="full-width"></canvas>
                    </div>
                    <div class="col-sm-6">
                        <p class="margin-bottom-20">
                            A line chart is a way of plotting data points on a line.
												Often, it is used to show trend data, and the comparison of two data sets.
                        </p>
                        <p>
                            The line chart requires an array of labels for each of the data points. This is shown on the X axis. The data for line charts is broken up into an array of datasets. Each dataset has a colour for the fill, a colour for the line and colours for the points and strokes of the points. These colours are strings just like CSS. You can use RGBA, RGB, HEX or HSL notation.
                        </p>
                        <p>
                            The label key on each dataset is optional, and can be used when generating a scale for the chart.
                        </p>
                        <p class="margin-top-20">
                            <div id="lineLegend" class="chart-legend"></div>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid container-fullw">
        <div class="row">
            <div class="col-sm-12">
                <h5 class="over-title margin-bottom-15">Pie <span class="text-bold">Chart</span></h5>
                <div class="row">
                    <div class="col-sm-4">

                        <p>
                            Pie and doughnut charts are probably the most commonly used chart there are. They are divided into segments, the arc of each segment shows the proportional value of each piece of data.
                        </p>
                        <p>
                            They are excellent at showing the relational proportions between data.
                        </p>
                        <p>
                            Pie and doughnut charts are effectively the same class in Chart.js, but have one different default value - their <code>percentageInnerCutout</code>. This equates what percentage of the inner should be cut out. This defaults to <code>0</code> for pie charts, and <code>50</code> for doughnuts.
                        </p>
                        <p class="margin-top-20">
                            <div id="pieLegend" class="chart-legend"></div>
                        </p>
                    </div>

                    <div class="col-sm-8">
                        <div class="text-center margin-bottom-15">
                            <h2>Orders</h2>
                            <section>
                                <div class="pieID pie">
                                </div>
                                <ul class="pieID legend">
                                    <li>
                                        <em>New</em>
                                        <span>1</span>
                                    </li>
                                    <li>
                                        <em>Out</em>
                                        <span>2</span>
                                    </li>
                                    <li>
                                        <em>Due</em>
                                        <span>1</span>
                                    </li>
                                    <li class="hidden">
                                        <em>No orders</em>
                                        <span>0</span>
                                    </li>
                                </ul>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

