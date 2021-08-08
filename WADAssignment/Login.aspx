<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WADAssignment.LoginCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Moonlight 3 Arts | Customer Login</title>

	<style type="text/css">
		body {
			margin: 0;
			padding: 0;
			display: grid;
			place-content: center;
			min-height: 100vh;
		}
	</style>

</head>
<body>
	<form id="form1" runat="server">
		<div>
			<table>
				<tr>
					<td>
						<h1>Moonlight 3 Arts</h1>
					</td>
					<td style="border: solid 2px black">

						<asp:Login ID="Login1" runat="server" TitleText="Login" DestinationPageUrl="~/Redirect.aspx" >
						</asp:Login>

					</td>
				</tr>
				<tr>
						<td></td>
					<td>Need an artist account?
						<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/RegisterArtist.aspx">Click here</asp:HyperLink>
						to register as new artist.
					</td>
				</tr>
				<tr>
					<td></td>
					<td>Need a customer account?
						<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/RegisterCustomer.aspx">Click here</asp:HyperLink>
						to register as new customer.
					</td>
				</tr>
			</table>


		</div>
	</form>
</body>
</html>
