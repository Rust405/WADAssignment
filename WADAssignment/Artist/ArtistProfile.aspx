<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtistProfile.aspx.cs" Inherits="WADAssignment.Artist.ArtistProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/profile.css" rel="stylesheet" />

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
					<asp:ChangePassword ID="ChangePassword1" runat="server" ContinueDestinationPageUrl="~/Artist/ArtistProfile.aspx">
						<ChangePasswordTemplate>
							<table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
								<tr>
									<td>
										<table cellpadding="0" style="width: 100%;">
											<tr>
												<td align="center" colspan="2">Change Your Password</td>
											</tr>
											<tr>
												<td align="right">
													<asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
												</td>
												<td>
													<asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
													<asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
												</td>
											</tr>
											<tr>
												<td align="right">
													<asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
												</td>
												<td>
													<asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
													<asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
												</td>
											</tr>
											<tr>
												<td align="right">
													<asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
												</td>
												<td>
													<asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
													<asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
												</td>
											</tr>
											<tr>
												<td align="center" colspan="2">
													<asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword1"></asp:CompareValidator>
												</td>
											</tr>
											<tr>
												<td align="center" colspan="2" style="color: Red;">
													<asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td>
													<asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
												</td>
												<td align="right">
													<asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password" ValidationGroup="ChangePassword1" />
												</td>

											</tr>
										</table>
									</td>
								</tr>
							</table>
						</ChangePasswordTemplate>
					</asp:ChangePassword>
				</td>
			</tr>

		</table>





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
