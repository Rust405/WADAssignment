﻿<%@ Page Language="C#" Title="Generating Email Receipt" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GenerateEmailReceipt.aspx.cs" Inherits="WADAssignment.Customer.GenerateEmailReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<div style="margin-left:10%;margin-right:10%;width:80%">
		<h1>Your order (Order ID: <asp:Label ID="lblOrderID" runat="server"></asp:Label>) has been successfully placed!</h1>
		<h3 style="text-align:left">Please wait while your receipt is being generated, you will be redirected shortly.  </h3>
		<h3 style="color: red;text-align:left">Do not close or leave this page!</h3>
	</div>
</asp:Content>