<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucActivities.ascx.cs" Inherits="ucActivities" %>

<div class="col-xs-12 col-sm-8">
    <div class="panel panel-white no-radius">
        <div class="panel-heading border-bottom">
            <h4 class="panel-title">Activities</h4>
        </div>
        <div class="panel-body">
            <ul class="timeline-xs margin-top-15 margin-bottom-15">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <li class="timeline-item success">
                            <div class="margin-left-15">
                                <asp:Image ID="imgProfile" runat="server" ImageUrl='<%#CheckProfileImage("App_Files/Company/" + c.Id + "/ProfileImg/" + Convert.ToInt32(Eval("EmpId")) + ".png") %>' CssClass="img-responsive img-max-height-30  img-circle pull-left margin-right-10 margin-bottom-10" />
                                <%--<img src='App_Files/Company/<%=c.Id %>/ProfileImg/<%#Eval("EmpId") %>.png' class="img-responsive img-max-height-30  img-circle pull-left margin-right-10 margin-bottom-10" />--%>
                                <div class="text-muted text-small">

                                    <i class="fa fa-clock-o">&nbsp;</i><%# clsAct.PrettyDate(Convert.ToDateTime(Eval("TaskDate"))) %>
                                </div>
                                <p>
                                    <a class="text-info" href="MyProfile.aspx?id=<%#Eval("EmpId") %>"><%# Eval("FirstName") %> <%# Eval("LastName") %>
                                    </a>
                                    <%# Eval("Task") %>
                                </p>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                <li id="liViewMore" runat="server" class="links cl-effect-1">
                    <br />
                    <a href="AllActivities.aspx">view more
                    </a>
                </li>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ZamvAppConnectionString %>' SelectCommand="SELECT top 10 tblActivity.Id, tblActivity.CompanyId, tblActivity.EmpId, tblActivity.Task, tblActivity.TaskDate, tblActivity.IsDeleted, tblEmployee.Id AS Expr1, tblEmployee.CompanyId AS Expr2, tblEmployee.FirstName, tblEmployee.LastName, tblEmployee.Email, tblEmployee.Password, tblEmployee.Phone, tblEmployee.AccessLevel, tblEmployee.IsConfirmed, tblEmployee.IsDeleted AS Expr3 FROM tblActivity INNER JOIN tblEmployee ON tblActivity.EmpId = tblEmployee.Id WHERE ((tblActivity.CompanyId = @CompanyId) or (tblActivity.EmpId = @EmpId)) order by tblActivity.TaskDate desc">

                    <SelectParameters>
                        <asp:CookieParameter DefaultValue="0" Name="CompanyId" CookieName="CompanyId" Type="Int32" />
                        <asp:QueryStringParameter DefaultValue="0" Name="EmpId" QueryStringField="EmpId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ul>
            <nav id="pagerNav" runat="server" class="next-back-nav">
                <asp:Label ID="lblCurrentPage" runat="server"></asp:Label>
                <br />
                <asp:LinkButton ID="lnkPrevAll" runat="server" OnClick="lnkPrevAll_Click">Back</asp:LinkButton>
                <asp:LinkButton ID="lnkNextAll" runat="server" OnClick="lnkNextAll_Click">Next</asp:LinkButton>
            </nav><br /><br /><br />
        </div>
    </div>
</div>
