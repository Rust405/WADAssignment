﻿<%@ Page Language="C#" Title="My Cart" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="WADAssignment.Customer.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<style>
		.img {
			max-width: 224px;
			max-height: 224px;
			min-height: 144px;
			min-width: 144px;
			width: auto;
			height: auto;
		}

		.grid {
			width: 80%;
			margin-left: 10%;
			margin-right: 10%;
		}

		.link {
			text-decoration: none;
			color: black;
		}

		.removeBtn {
			padding: 8px 8px;
		}

		.cartTH {
			font-weight: bold;
			font-size: medium;
			text-align: center;
			height: 32px;
		}

		.artName {
			font-weight: bold;
			font-size: x-large;
			text-align: center;
		}

		.btnCheckout {
			font-weight: bold;
			font-size: large;
			padding: 8px 20px;
		}
	</style>
	<div>
		<h1>My Cart</h1>
		<p>
			<asp:GridView CssClass="grid" ID="gvCart" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="cartID" ShowFooter="True" OnRowDataBound="gvCart_RowDataBound">
				<Columns>
					<asp:TemplateField SortExpression="artworkImagePath">
						<ItemTemplate>
							<asp:ImageButton CssClass="img" ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath") %>' PostBackUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}&artName={1}", Eval("artworkID"),Eval("artworkName")) %>' />
						</ItemTemplate>

						<ItemStyle Height="224px" Width="224px" />

					</asp:TemplateField>

					<asp:TemplateField HeaderText="Artwork Name" SortExpression="artworkName">

						<ItemTemplate>
							<asp:HyperLink CssClass="link" ID="artworkNameLabel" runat="server" NavigateUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}", Eval("artworkID")) %>' Text='<%# Eval("artworkName") %>'></asp:HyperLink>
						</ItemTemplate>
						<HeaderStyle CssClass="cartTH" Width="25%" Font-Bold="True" Font-Size="Large" />
						<ItemStyle CssClass="artName" Width="25%" />
					</asp:TemplateField>

					<asp:TemplateField HeaderText="Artwork Price (RM)" SortExpression="artworkPrice">

						<ItemTemplate>
							<asp:Label ID="Label3" runat="server" Text='<%# String.Format("{0:0.00}", Eval("artworkPrice")) %>'></asp:Label>
						</ItemTemplate>
						<HeaderStyle CssClass="cartTH" Width="12%" Font-Bold="True" Font-Size="Large" />
						<ItemStyle Width="12%" />
					</asp:TemplateField>

					<asp:TemplateField HeaderText="Order Quantity" SortExpression="orderQuantity">
						<ItemTemplate>
							<asp:Button ID="btnMinus" runat="server" Text="-" PostBackUrl='<%# String.Format("~/Customer/Cart.aspx?cartID={0}&act=minus", Eval("cartID")) %>' />
							&nbsp<asp:Label ID="Label1" runat="server" Text='<%# Bind("orderQuantity") %>'></asp:Label>&nbsp
						<asp:Button ID="btnPlus" runat="server" Text="+" PostBackUrl='<%# String.Format("~/Customer/Cart.aspx?cartID={0}&act=plus", Eval("cartID")) %>'/>
						</ItemTemplate>
						<FooterStyle Font-Bold="True" Font-Size="Large" />
						<HeaderStyle CssClass="carTH" Width="12%" Font-Bold="True" Font-Size="Large" />
						<ItemStyle Width="12%" />
					</asp:TemplateField>

					<asp:TemplateField HeaderText="Subtotal (RM)" SortExpression="Subtotal">
						<ItemTemplate>
							<asp:Label ID="Label2" runat="server" Text='<%# String.Format("{0:0.00}", Eval("Subtotal")) %>'></asp:Label>
						</ItemTemplate>
						<FooterStyle Font-Bold="True" Font-Size="Large" />
						<HeaderStyle CssClass="cartTH" Width="12%" Font-Bold="True" Font-Size="Large" />
						<ItemStyle Width="12%" />
					</asp:TemplateField>
					<asp:TemplateField ShowHeader="False">
						<HeaderTemplate>
							<asp:Button ID="btnEmpty" runat="server" Text="Empty Cart" OnClick="emptyCart" />
						</HeaderTemplate>
						<FooterTemplate>
							<asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="btnCheckout" PostBackUrl="~/Customer/Checkout.aspx" />
						</FooterTemplate>
						<ItemTemplate>
							<asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete" Text="X" />
						</ItemTemplate>
						<ControlStyle CssClass="removeBtn" />
						<HeaderStyle Width="10%" />
						<ItemStyle Width="10%" />
					</asp:TemplateField>
				</Columns>
				<EmptyDataTemplate>
					<h3>Your cart is currently empty. Why don't you stop by the
					<asp:HyperLink ID="hlGallery" runat="server" NavigateUrl="~/Customer/Gallery.aspx">Gallery</asp:HyperLink>
						to start purchasing art? :)
					</h3>

				</EmptyDataTemplate>
			</asp:GridView>
		</p>



		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM Cart WHERE (cartID = @cartID)" SelectCommand="SELECT C.cartID, C.orderQuantity, C.artworkID, A.artworkName, A.artworkPrice, A.artworkImagePath, A.artworkPrice * C.orderQuantity as Subtotal
FROM Cart C, Artwork A
WHERE 
(C.customerID = @customerID)
AND
(C.artworkID = A.artworkID) 
">
				<DeleteParameters>
					<asp:Parameter Name="cartID" Type="Int32" />
				</DeleteParameters>
				<SelectParameters>
					<asp:SessionParameter Name="customerID" SessionField="customerID" />
				</SelectParameters>
			</asp:SqlDataSource>
		</p>
	</div>
</asp:Content>
