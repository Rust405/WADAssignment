<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testemail.aspx.cs" Inherits="WADAssignment.testemail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        	<asp:Button ID="btnSend" runat="server" OnClick="btnSend_Click" Text="Send email" />
        </div>
    </form>
</body>
</html>
