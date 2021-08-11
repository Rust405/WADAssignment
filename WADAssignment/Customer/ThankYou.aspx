<%@ Page Language="C#" Title="Thank You!" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ThankYou.aspx.cs" Inherits="WADAssignment.Customer.ThankYou" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<div>
		<br />
		<asp:Label ID="lblThankYou" runat="server" Font-Bold="True" Font-Size="X-Large"></asp:Label>

		<br />
		<br />
		<asp:HyperLink ID="HyperLink1" runat="server" EnableTheming="True" Font-Size="Large" NavigateUrl="~/Customer/Gallery.aspx">Return to Gallery</asp:HyperLink>

	</div>
</asp:Content>
