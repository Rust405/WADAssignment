<%@ Page Title="Order Details" MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="WADAssignment.Customer.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<link rel="stylesheet" href="../css/custCss/orderDetails.css"> 

	<div>

		<h1><asp:Label ID="lblOrderHead" runat="server"></asp:Label></h1>
		<asp:GridView OnRowDataBound="gvOD_RowDataBound" CssClass="gv" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ShowFooter="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
			<Columns>
				<asp:TemplateField SortExpression="artworkImagePath">
					<ItemTemplate>
						<asp:ImageButton CssClass="img" ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath","{0}?t="+ DateTime.Now.ToString("ddMMyyhhmmss")) %>' PostBackUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}", Eval("artworkID")) %>' />
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
				<asp:TemplateField HeaderText="Purchase Price(RM)" SortExpression="purchasePrice">
					
					<ItemTemplate>
						<asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}", Eval("purchasePrice")) %>'></asp:Label>
					</ItemTemplate>
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
				<asp:BoundField DataField="orderStatus" HeaderText="Order Status" SortExpression="orderStatus" />
			</Columns>
		
		    <FooterStyle BackColor="#cfcfcf" ForeColor="Black" />
            <HeaderStyle BackColor="#474747" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
		
		</asp:GridView>
		<br />
		<br />
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT A.ArtworkID, A.artworkName, A.artworkImagePath, L.purchasePrice, L.OrderQuantity, L.orderStatus, L.purchasePrice*L.OrderQuantity AS Subtotal
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
