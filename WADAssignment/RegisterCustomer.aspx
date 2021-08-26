<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterCustomer.aspx.cs" Inherits="WADAssignment.RegisterCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

	<!--Bootstrap.css-->
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
	
	<link href="css/regCustomer.css" rel="stylesheet"/>

	<!--Bootstrap popper & js-->
	<script src="bootstrap/js/popper.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<title>Moonlight 3 Arts | Register Customer</title>

	
</head>
<body>
	<form id="form1" runat="server">
		<div class="container">
			<div class="allRow row">
				<div class="col-md-5 d-flex justify-content-center">
						<h1>Moonlight 3 Arts<br/><a style="font-size: 50px">Customer Registration</a></h1>
				</div>	

				<div class="col-md-7">
					<div class="customerCol col d-flex justify-content-center">
						<asp:CreateUserWizard ID="CreateUserWizard1" runat="server" CreateUserButtonText="Register Customer" ContinueDestinationPageUrl="~/Login.aspx" OnCreatedUser="CreateUserWizard1_CreatedUser">
							<WizardSteps>
								<asp:CreateUserWizardStep runat="server" />
								<asp:CompleteWizardStep runat="server" />
							</WizardSteps>
						</asp:CreateUserWizard>
					</div>

					<div class="row mt-3">
						<div class="col d-flex justify-content-center">
							<p>Not a customer?&nbsp;
							<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/RegisterArtist.aspx">Click here</asp:HyperLink>
							&nbsp;to register a new artist account.</p>
						</div>
					</div>
					
					<div class="row">
						<div class="col d-flex justify-content-center">
							<p>Already have an account?&nbsp;
							<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx">Click here</asp:HyperLink>
							&nbsp;to login.</p>
						</div>
					</div>
				</div>

			</div>
		</div>			
	</form>
</body>
</html>
