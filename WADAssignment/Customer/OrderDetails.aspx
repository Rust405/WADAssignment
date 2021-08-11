<%@ Page Title="Order Details" MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="WADAssignment.Customer.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<style>
		.gv {
			margin-left: 15%;
			margin-right: 15%;
			width: 70%;
		}

		.img {
			max-width: 224px;
			max-height: 224px;
			min-height: 144px;
			min-width: 144px;
			width: auto;
			height: auto;
		}

		.link {
			text-decoration: none;
			color: black;
		}

		.artName {
			font-weight: bold;
			font-size: x-large;
			text-align: center;
		}
		.odTH {
			font-weight: bold;
			font-size: medium;
			text-align: center;
			height: 32px;
		}
	</style>
	<div>

		<h1><asp:Label ID="lblOrderHead" runat="server"></asp:Label></h1>
		<br />
		<br />
		<asp:GridView OnRowDataBound="gvOD_RowDataBound" CssClass="gv" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ShowFooter="True">
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
					<HeaderStyle CssClass="odTH" Width="32%" />
					<ItemStyle CssClass="artName" Width="32%" />
				</asp:TemplateField>
				<asp:TemplateField HeaderText="Artwork Price (RM)" SortExpression="artworkPrice">

					<ItemTemplate>
						<asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}", Eval("artworkPrice")) %>'></asp:Label>
					</ItemTemplate>
					<HeaderStyle CssClass="odTH" />
					<ItemStyle Font-Size="Large" />
				</asp:TemplateField>
				<asp:BoundField DataField="OrderQuantity" HeaderText="Order Quantity" SortExpression="OrderQuantity" >
				<FooterStyle Font-Bold="True" Font-Size="Large" />
				<HeaderStyle CssClass="odTH" />
				<ItemStyle Font-Size="Large" />
				</asp:BoundField>
				<asp:TemplateField HeaderText="Subtotal (RM)" SortExpression="Subtotal">

					<ItemTemplate>
						<asp:Label ID="Label2" runat="server" Text='<%# String.Format("{0:0.00}", Eval("Subtotal")) %>'></asp:Label>
					</ItemTemplate>
					<FooterStyle Font-Bold="True" Font-Size="Large" />
					<HeaderStyle CssClass="odTH" Width="12%" />
					<ItemStyle Width="12%" Font-Size="Large" />
				</asp:TemplateField>
			</Columns>
		
		</asp:GridView>
		<br />
		<br />
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT A.ArtworkID, A.artworkName, A.artworkImagePath, A.artworkPrice, L.OrderQuantity, A.artworkPrice*L.OrderQuantity AS Subtotal
FROM Artwork A, OrderList L, Orders O
WHERE 
(O.orderID = L.orderID)
AND
(A.artworkID = L.artworkID)
AND
(O.customerID = @customerID)
AND 
(O.orderID = @orderID)
">
			<SelectParameters>
				<asp:SessionParameter Name="customerID" SessionField="customerID" />
				<asp:QueryStringParameter Name="orderID" QueryStringField="orderID" />
			</SelectParameters>
		</asp:SqlDataSource>
		<br />
		<br />

	</div>
</asp:Content>
