<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AllActivities.aspx.cs" Inherits="AllActivities" %>

<%@ Register Src="~/ucActivities.ascx" TagPrefix="uc1" TagName="ucActivities" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ucActivities runat="server" ID="ucActivities" />
</asp:Content>

