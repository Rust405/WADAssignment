<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="WADAssignment.Customer.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/profile.css" rel="stylesheet"/>

	<div>
		<h1>
			<asp:Label ID="lblProfile" runat="server"></asp:Label>
		</h1>
		<table class="profile">
			<tr>
				<td>
					<asp:DetailsView ID="dvCustomerProfile" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataSourceID="SqlDataSource1">
						<Fields>
							<asp:BoundField DataField="UserName" HeaderText="Usermame" SortExpression="UserName">
								<HeaderStyle Font-Bold="True" Font-Size="Large" />
								<ItemStyle Font-Size="X-Large" />
							</asp:BoundField>
							<asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
								<HeaderStyle Font-Bold="True" Font-Size="Large" />
								<ItemStyle Font-Size="X-Large" />
							</asp:BoundField>
						</Fields>
					</asp:DetailsView>
				</td>
			</tr>
			<tr>
				<td>
					<asp:ChangePassword ID="ChangePassword1" runat="server" Width="100%" ContinueDestinationPageUrl="~/Customer/CustomerProfile.aspx"></asp:ChangePassword>
				</td>
			</tr>

		</table>


		<br />
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT M.Email, M.UserName 
FROM vw_aspnet_MembershipUsers M, Customer C
WHERE 
(C.customerID = @customerID)
AND
(M.UserName = C.customerUsername)">
			<SelectParameters>
				<asp:SessionParameter Name="customerID" SessionField="customerID" />
			</SelectParameters>
		</asp:SqlDataSource>

	</div>
</asp:Content>
