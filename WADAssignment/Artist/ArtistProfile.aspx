<%@ Page  Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtistProfile.aspx.cs" Inherits="WADAssignment.Artist.ArtistProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	
	<div>
			<style>
		.profile {
			width: 80%;
			margin-left: 10%;
			margin-right: 10%;
			border:solid black 1px;
		}
		#ContentPlaceHolder1_ChangePassword1{
			height:180px;
			margin-left: 40%;
			margin-right: 20%;
			text-align:center;
		}
	</style>
	<div>
		<h1>
			<asp:Label ID="lblProfile" runat="server"></asp:Label>
		</h1>
		<table class="profile">
			<tr>
				<td>
					<asp:DetailsView ID="dvArtistProfile" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataSourceID="SqlDataSource1">
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
					<asp:ChangePassword ID="ChangePassword1" runat="server" Width="100%"></asp:ChangePassword>
				</td>
			</tr>

		</table>





	</div>
	</div>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT M.Email, M.UserName 
FROM vw_aspnet_MembershipUsers M, Artist A
WHERE 
(A.artistID = @artistID)
AND
(M.UserName = A.artistUsername)">
		<SelectParameters>
			<asp:SessionParameter Name="artistID" SessionField="artistID" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
