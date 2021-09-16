<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WADAssignment.LoginCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

	<link href="css/login.css" rel="stylesheet"/>

	<!--Bootstrap.css-->
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

	<link href="css/login.css" rel="stylesheet"/>

	<!--Bootstrap popper & js-->
	<script src="bootstrap/js/popper.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<title>Moonlight 3 Arts | Customer Login</title>

</head>
<body>
	<form id="form1" runat="server">
		<div class="container">
			<div class="allRow row">
				<div class="col-md-5 d-flex justify-content-center">
						<h1>Moonlight 3 Arts</h1>
				</div>

				<div class="col-md-7">
					<div class="loginCol col d-flex justify-content-center">
						<asp:Login ID="Login1" runat="server" TitleText="Login" DestinationPageUrl="~/Redirect.aspx" DisplayRememberMe="False" >
							<LayoutTemplate>
								<table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
									<tr>
										<td>
											<table cellpadding="0">
												<tr>
													<td align="center" colspan="2">
														<asp:Label ID="lblLogin" runat="server" Text="Login"></asp:Label></td>
												</tr>
												<tr>
													<td align="right">
														<asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
													</td>
													<td>
														<asp:TextBox ID="UserName" runat="server"></asp:TextBox>
														<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
													</td>
												</tr>
												<tr>
													<td align="right">
														<asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
													</td>
													<td>
														<asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
														<asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
													</td>
												</tr>
												<tr>
													<td align="center" colspan="2" style="color:Red;">
														<asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
													</td>
												</tr>
												<tr>
													<td align="right" colspan="2">
														<asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</LayoutTemplate>
						</asp:Login>
					</div>
			
						
					<div class="row mt-3">
						<div class="col d-flex justify-content-center">
							<p>Need an artist account?&nbsp;
							<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/RegisterArtist.aspx">Click here</asp:HyperLink>
							&nbsp;to register as new artist.</p>
						</div>
					</div>
					
					<div class="row">
						<div class="col d-flex justify-content-center">
							<p>Need a customer account?&nbsp;
							<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/RegisterCustomer.aspx">Click here</asp:HyperLink>
							&nbsp;to register as new customer.</p>
						</div>
					</div>
				</div>

			</div>
		</div>
	</form>
</body>
</html>

