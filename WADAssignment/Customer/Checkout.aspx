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
				<td class="field">
					<asp:TextBox CssClass="addressBox" ID="txtAddress" runat="server" MaxLength="200"></asp:TextBox>

					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAddress" ErrorMessage="*&lt;br /&gt;Delivery address is required.&lt;br /&gt;&lt;br /&gt;" ForeColor="Red" Font-Bold="True" Font-Size="Medium" SetFocusOnError="True"></asp:RequiredFieldValidator>

				</td>
			</tr>

			<tr>
				<th class="titles" colspan="2">Payment</th>

			</tr>
			<tr>
				<td class="fieldHead">Card Type: </td>
				<td>
					<br />
					<asp:RadioButtonList ID="rblCardType" runat="server" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0" Font-Size="X-Large">
						<asp:ListItem Text='<img width="78px" height="36px" src="https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png"/>'
							Value="Visa" Selected="True" />
						<asp:ListItem Text='<img width="72px" height="36px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/MasterCard_early_1990s_logo.png/1200px-MasterCard_early_1990s_logo.png"/>'
							Value="Mastercard" />
					</asp:RadioButtonList>

				</td>
			</tr>
			<tr>
				<td class="fieldHead">Card Number:</td>
				<td class="field">
					<asp:TextBox ID="txtCardNumber" placeholder="9999999999999999" runat="server" CssClass="cardNoBox" MaxLength="16"></asp:TextBox>
					<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*&lt;br /&gt;Card number is invalid.&lt;br /&gt;" ControlToValidate="txtCardNumber" Font-Bold="True" Font-Size="Medium" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$" Display="Dynamic"></asp:RegularExpressionValidator>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*&lt;br /&gt;Card number is required.&lt;br /&gt;" ControlToValidate="txtCardNumber" Display="Dynamic" Font-Bold="True" Font-Size="Medium" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
				</td>
			</tr>

			<tr>
				<td class="fieldHead">Expiry Date:
				</td>
				<td class="field">
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

					<asp:CustomValidator ID="cvExpiryMonth"
						runat="server"
						ErrorMessage='<a style="padding-left:30%">*Card is expired.</a>'
						ControlToValidate="ddlExpiryMonth"
						Font-Bold="True"
						Font-Size="Medium"
						ForeColor="Red"
						OnServerValidate="cvExpiryMonth_ServerValidate" SetFocusOnError="True" ValidateEmptyText="True"></asp:CustomValidator>
				</td>
			</tr>
			<tr>
				<td class="fieldHead" style="height: 48px">CVC: </td>
				<td class="field" style="height: 48px">
					<br />
					<asp:TextBox CssClass="card3NumBox" ID="txtCVC" runat="server" MaxLength="4"></asp:TextBox>
					<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*&lt;br /&gt;CVC is invalid." ControlToValidate="txtCVC" Display="Dynamic" Font-Bold="True" Font-Size="Medium" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[0-9]{3,4}$"></asp:RegularExpressionValidator>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*&lt;br /&gt;CVC is required." ControlToValidate="txtCVC" Display="Dynamic" Font-Bold="True" Font-Size="Medium" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
				</td>
			</tr>
		</table>
		<br />
		<p style="text-align: right; margin-right: 20%;">
			<asp:Button CssClass="cancelBtn" ID="btnCancel" runat="server" Text="Cancel" PostBackUrl="~/Customer/Cart.aspx" CausesValidation="False" />
			&nbsp&nbsp
			<asp:Button CssClass="checkoutBtn" ID="btnCheckout" runat="server" Text="Checkout" OnClick="btnCheckout_Click" />
		</p>

	</div>
</asp:Content>
