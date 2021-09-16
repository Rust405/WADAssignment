<%@ Page title="Unauthorized User" MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UnauthorizedUser.aspx.cs" Inherits="WADAssignment.UnauthorizedUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
    <link href="../css/ErrorCss.css" rel="stylesheet"/>
        <div>
            <br />
            <img src="../images/unauthorized.jpg" alt="unautho" class="unautho"/>
            <h2>Error: You do not have access to this page!</h2>
            <h3>Try logging in with another account.</h3>
        </div>
</asp:Content>
