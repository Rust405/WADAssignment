<%@ Page Language="C#" Title="Checkout" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="WADAssignment.Customer.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link rel="stylesheet" href="../css/custCss/checkout.css">

	<div>
		<h1>Checkout</h1>

		<table style="width: 80%; margin-left: 10%; margin-right: 10%">
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
					<asp:TextBox CssClass="addressBox" ID="txtAddress" runat="server"></asp:TextBox>

				</td>
			</tr>
			<tr>
				<th class="titles" colspan="2">Payment</th>

			</tr>
			<tr>
				<td class="fieldHead">Card Type: </td>
				<td>
					<asp:RadioButtonList ID="rblCardType" runat="server" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0" Font-Size="X-Large">
						<asp:ListItem Text='<img width="72px" height="40px" src="http://assets.stickpng.com/images/58482363cef1014c0b5e49c1.png"/>'
							Value="Visa" Selected="True" />
						<asp:ListItem Text='<img width="72px" height="40px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/MasterCard_early_1990s_logo.png/1200px-MasterCard_early_1990s_logo.png"/>'
							Value="Mastercard" />
					</asp:RadioButtonList>

				</td>
			</tr>
			<tr>
				<td class="fieldHead">Card Number:</td>
				<td>
					<table>
						<tr>
							<td>
								<asp:TextBox CssClass="cardNoBox" ID="txtCardNumber1" runat="server" MaxLength="4"></asp:TextBox>
							</td>
							<td>
								<asp:TextBox CssClass="cardNoBox" ID="txtCardNumber2" runat="server" MaxLength="4"></asp:TextBox>
							</td>
							<td>
								<asp:TextBox CssClass="cardNoBox" ID="txtCardNumber3" runat="server" MaxLength="4"></asp:TextBox>
							</td>
							<td>
								<asp:TextBox CssClass="cardNoBox" ID="txtCardNumber4" runat="server" MaxLength="4"></asp:TextBox>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td class="fieldHead">Expiry Date:
				</td>
				<td>
					<table>
						<tr>
							<td><a style="font-size: 18px; font-weight: bold;">Month</a>
								<br />
								<br />
								<asp:DropDownList ID="ddlExpiryMonth" runat="server" Font-Size="X-Large">
								</asp:DropDownList>
							</td>
							<td><a style="font-size: 18px; font-weight: bold;">Year</a>
								<br />
								<br />
								<asp:DropDownList ID="ddlExpiryYear" runat="server" Font-Size="X-Large">
								</asp:DropDownList>
							</td>
						</tr>



					</table>
				</td>
			</tr>
			<tr>
				<td class="fieldHead">Card CVV2/CVC2/4DBC: </td>
				<td>
					<asp:TextBox CssClass="card3NumBox" ID="card3Num" runat="server" MaxLength="3"></asp:TextBox>
				</td>
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
