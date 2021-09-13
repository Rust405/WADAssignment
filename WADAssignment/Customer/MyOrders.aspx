<%@ Page Language="C#" Title="My Orders" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="WADAssignment.Customer.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<link rel="stylesheet" href="../css/custCss/myOrders.css"> 
	
		<h1>My Orders</h1>
		<div class="myOrders">
		<asp:GridView CssClass="gv" ID="gvOrderHistory" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID" DataSourceID="SqlDataSource1" Text="View Order Details" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
			<Columns>
				<asp:BoundField DataField="orderID" HeaderText="Order ID" InsertVisible="False" ReadOnly="True" SortExpression="orderID">
					<HeaderStyle Font-Size="Medium" Height="32px" />
					<ItemStyle Font-Size="Large" Height="48px" />
				</asp:BoundField>
				<asp:TemplateField HeaderText="Order Date" SortExpression="orderDate">
					<ItemTemplate>
						<asp:Label ID="Label1" runat="server" Text='<%# Eval("orderDate").ToString().Substring(0,10) %>'></asp:Label>
					</ItemTemplate>
					<HeaderStyle Font-Size="Medium" Width="128px" />
					<ItemStyle Font-Size="Large" />
				</asp:TemplateField>
				<asp:BoundField DataField="deliveryAddress" HeaderText="Delivery Address" SortExpression="deliveryAddress">
					<HeaderStyle Font-Size="Medium" />
					<ItemStyle Font-Size="Medium" />
				</asp:BoundField>
				<asp:TemplateField>
					<ItemTemplate>
						<asp:Button CssClass="btnVOD" PostBackUrl='<%# String.Format("~/Customer/OrderDetails.aspx?orderID={0}",Eval("orderID")) %>' ID="btnVOD" runat="server" Text="View Order Details" />
					</ItemTemplate>
				</asp:TemplateField>
			</Columns>
			<EmptyDataTemplate>

				<h3>You don't have any orders. Why don't you check out the 
				<asp:HyperLink ID="hlGallery" runat="server" Text="Gallery" NavigateUrl="~/Customer/Gallery.aspx">Gallery</asp:HyperLink>
				</h3>

			</EmptyDataTemplate>
		    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#474747" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
		</asp:GridView>

		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [orderID], [orderDate], [deliveryAddress] FROM [Orders] WHERE ([customerID] = @customerID)">
				<SelectParameters>
					<asp:SessionParameter Name="customerID" SessionField="customerID" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
		</p>



	</div>
</asp:Content>
