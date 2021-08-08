<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterCustomer.aspx.cs" Inherits="WADAssignment.RegisterCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

	<style type="text/css">
		body {
			margin: 0;
			padding: 0;
			display: grid;
			place-content: center;
			min-height: 100vh;
		}
	</style>
	<title>Moonlight 3 Arts | Register Customer</title>
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


						<asp:CreateUserWizard ID="CreateUserWizard1" runat="server" CreateUserButtonText="Register Customer" ContinueDestinationPageUrl="~/Login.aspx" OnCreatedUser="CreateUserWizard1_CreatedUser">
							<WizardSteps>
								<asp:CreateUserWizardStep runat="server" />
								<asp:CompleteWizardStep runat="server" />
							</WizardSteps>
						</asp:CreateUserWizard>


					</td>
				</tr>
				<tr>
					<td></td>
					<td>Not a customer?
						<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/RegisterArtist.aspx">Click here</asp:HyperLink>
						to register a new artist account.
					</td>
				</tr>
				<tr>
					<td></td>
					<td>Already have an account?
						<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx">Click here</asp:HyperLink>
						to login.
					</td>
				</tr>
			</table>

		</div>
	</form>
</body>
</html>
