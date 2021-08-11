<%@ Page Language="C#" Title="My Orders" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="WADAssignment.Customer.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<style>
		.gv {
			margin-left: 20%;
			margin-right: 20%;
			width: 60%;
		}

		.btnVOD {
			padding: 8px 12px;
			font-size: medium;
		}
	</style>
	<div>
		<h1>My Orders</h1>

		<asp:GridView CssClass="gv" ID="gvOrderHistory" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID" DataSourceID="SqlDataSource1" Text="View Order Details" CellSpacing="10">
			<Columns>
				<asp:BoundField DataField="orderID" HeaderText="Order ID" InsertVisible="False" ReadOnly="True" SortExpression="orderID">
					<HeaderStyle Font-Size="Medium" Height="32px" />
					<ItemStyle Font-Size="Large" Height="48px" />
				</asp:BoundField>
				<asp:BoundField DataField="orderDate" HeaderText="Order Date" SortExpression="orderDate">
					<HeaderStyle Font-Size="Medium" />
					<ItemStyle Font-Size="Large" />
				</asp:BoundField>
				<asp:BoundField DataField="orderStatus" HeaderText="Order Status" SortExpression="orderStatus">
					<HeaderStyle Font-Size="Medium" />
					<ItemStyle Font-Size="Large" />
				</asp:BoundField>
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
		</asp:GridView>

		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [orderID], [orderDate], [orderStatus], [deliveryAddress] FROM [Orders] WHERE ([customerID] = @customerID)">
				<SelectParameters>
					<asp:SessionParameter Name="customerID" SessionField="customerID" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
		</p>



	</div>
</asp:Content>
