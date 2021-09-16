<%@ Page Title="Page Not Found(404)" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PageNotFound.aspx.cs" Inherits="WADAssignment.Error.PageNotFound" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/ErrorCss.css" rel="stylesheet">
	<div>
		<br />
		<section class="error-container">
			<span class="four"><span class="screen-reader-text">4</span></span>
			<span class="zero"><span class="screen-reader-text">0</span></span>
			<span class="four"><span class="screen-reader-text">4</span></span>
		</section>
		<p class="zoom-area">This is not the page you are looking for...</p>
		<h3 style="text-align: center">Please make sure the page you are requesting exists.</h3>
	</div>
</asp:Content>
