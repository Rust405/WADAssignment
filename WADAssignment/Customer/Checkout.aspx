<%@ Page Language="C#" Title="Checkout" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="WADAssignment.Customer.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<style>
		.titles {
			text-align: left;
			padding-left: 12px;
			font-size:x-large;
		}

		table, tr, td {
			border: solid black 1px;
		}

		tr, td {
			height: 48px;
		}

		.addressBox {
			width: 80%;
			height: 60%;
			font-size: medium;
			text-align: left;
			padding-left: 12px;
		}

		.cardNoBox {
			width: 80%;
			height: 60%;
			font-size: medium;
			text-align: left;
			padding-left: 12px;
		}

		.ddlBank {
			width: 82%;
			height: 60%;
			font-size: large;
			text-align: left;
			padding-left: 12px;
		}

		.fieldHead {
			font-weight: bold;
			text-align: left;
			padding-left: 52px;
			font-size: large;
		}

		.cancelBtn {
			padding: 6px;
		}

		.checkoutBtn {
			padding: 12px 32px;
			font-size: x-large;
			font-weight: bold;
		}

		.field {
			padding-left:48px;
			text-align: left;
			font-size: medium;
		}
	</style>
	<div>
		<h1>Checkout</h1>

		<table style="width: 60%; margin-left: 20%; margin-right: 20%">
			<tr>
				<th class="titles" colspan="2">Billing Information</th>

			</tr>
			<tr>
				<td class="fieldHead">Name: </td>
				<td class="field">
					<asp:Label ID="lblName" runat="server" Text=""></asp:Label></td>
			</tr>
			<tr>
				<td class="fieldHead">E-mail: </td>
				<td class="field">
					<asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></td>
			</tr>
			<tr>
				<td class="fieldHead">Delivery Address: </td>
				<td>
					<asp:TextBox CssClass="addressBox" ID="txtAddress" runat="server"></asp:TextBox></td>
			</tr>
			<tr>
				<th class="titles" colspan="2">Payment</th>

			</tr>
			<tr>
				<td class="fieldHead">Bank: </td>
				<td>
					<asp:DropDownList CssClass="ddlBank" ID="ddlBank" runat="server">
						<asp:ListItem>Maybank</asp:ListItem>
						<asp:ListItem>CIMB Group Holdings</asp:ListItem>
						<asp:ListItem>Public Bank Berhad</asp:ListItem>
						<asp:ListItem>RHB Bank</asp:ListItem>
						<asp:ListItem>Hong Leong Bank</asp:ListItem>
						<asp:ListItem>AmBank</asp:ListItem>
						<asp:ListItem>Bank Rakyat</asp:ListItem>
						<asp:ListItem>UOB Malaysia</asp:ListItem>
						<asp:ListItem>OCBC Bank Malaysia</asp:ListItem>
						<asp:ListItem>Bank Islam Malaysia</asp:ListItem>
						<asp:ListItem>Affin Bank</asp:ListItem>
						<asp:ListItem>Alliance Bank Malaysia Berhad</asp:ListItem>
						<asp:ListItem>Standard Chartered Bank Malaysia	</asp:ListItem>
						<asp:ListItem>	Bank Simpanan Nasional (BSN)</asp:ListItem>
					</asp:DropDownList></td>
			</tr>
			<tr>
				<td class="fieldHead">Bank Number:</td>
				<td>
					<asp:TextBox CssClass="cardNoBox" placeholder="xxxx-xxxx-xxxx-xxxx" ID="txtCardNumber" runat="server"></asp:TextBox></td>
			</tr>

		</table>
		<br />
		<p style="text-align: right; margin-right: 20%;">
			<asp:Button CssClass="cancelBtn" ID="btnCancel" runat="server" Text="Cancel" PostBackUrl="~/Customer/Cart.aspx" />
			&nbsp&nbsp
			<asp:Button CssClass="checkoutBtn" ID="btnCheckout" runat="server" Text="Checkout" OnClick="btnCheckout_Click" />

		</p>

	</div>
</asp:Content>
