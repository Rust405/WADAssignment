<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="WADAssignment.Artist.ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
    <link rel="stylesheet" href="../css/artistCss/manageOrders.css"> 

	<div>
		<h1>Manage Orders</h1>
		<p cssclass="gvO">
			<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="gbO" DataKeyNames="artworkID,orderListID" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
				<Columns>
					<asp:BoundField DataField="orderID" HeaderText="Order ID" SortExpression="orderID" ReadOnly="True" />
					<asp:TemplateField HeaderText="Artwork Name" SortExpression="artworkName">
						<EditItemTemplate>
							<asp:Label ID="Label1" runat="server" Text='<%# Eval("artworkName") %>'></asp:Label>
						</EditItemTemplate>
						<ItemTemplate>
							<asp:Label ID="Label2" runat="server" Text='<%# Bind("artworkName") %>'></asp:Label>

						</ItemTemplate>
						<HeaderStyle Font-Bold="True" Font-Size="Medium" />
						<ItemStyle Font-Size="Large" />
					</asp:TemplateField>
					<asp:BoundField DataField="orderQuantity" HeaderText="Order Quantity" ReadOnly="True" SortExpression="orderQuantity">
						<HeaderStyle Font-Bold="True" Font-Size="Medium" />
						<ItemStyle Font-Size="Large" />
					</asp:BoundField>
					<asp:TemplateField HeaderText="Order Status" SortExpression="orderStatus">
						<EditItemTemplate>
							<asp:DropDownList CssClass="ddl" SelectedValue='<%# Bind("orderStatus") %>' ID="DropDownList1" runat="server">
								<asp:ListItem>Pending</asp:ListItem>
								<asp:ListItem>Shipped</asp:ListItem>
								<asp:ListItem>Completed</asp:ListItem>
								<asp:ListItem>Canceled</asp:ListItem>
								<asp:ListItem>Declined</asp:ListItem>
								<asp:ListItem>Refunded</asp:ListItem>
							</asp:DropDownList>
						</EditItemTemplate>
						<ItemTemplate>
							<asp:Label ID="Label1" runat="server" Text='<%# Bind("orderStatus") %>'></asp:Label>
						</ItemTemplate>
						<HeaderStyle Font-Bold="True" Font-Size="Medium" />
						<ItemStyle Font-Size="Large" />
					</asp:TemplateField>
					<asp:CommandField ButtonType="Button" EditText="Update Order Status" ShowEditButton="True" ControlStyle-CssClass="updateStatus">
<ControlStyle CssClass="updateStatus"></ControlStyle>

					<ItemStyle CssClass="btnUpdate" />
					</asp:CommandField>
				</Columns>
				<EmptyDataTemplate>
					<h2>There are no orders to display. </h2>
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
		</p>
		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
				SelectCommand="SELECT 
A.artworkName, L.orderQuantity, A.artworkID, L.orderStatus, L.orderListID, L.orderID
FROM
Artwork A, OrderList L
WHERE
A.artworkID = L.artworkID
AND
A.artistID = @artistID"
				UpdateCommand="UPDATE [OrderList] SET [orderStatus] = @orderStatus WHERE [orderListID] = @orderListID">

				<SelectParameters>
					<asp:SessionParameter Name="artistID" SessionField="artistID" />
				</SelectParameters>
				<UpdateParameters>
					<asp:Parameter Name="orderStatus" Type="String" />
					<asp:Parameter Name="orderListID" Type="Int32" />
				</UpdateParameters>
			</asp:SqlDataSource>

		</p>
		<p>&nbsp;</p>



	</div>
</asp:Content>
