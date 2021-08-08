<%@ Page title="Post Artwork" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PostArtwork.aspx.cs" Inherits="WADAssignment.Artist.PostArtwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<div>
		<h1>Post Artwork</h1>
		<table style="margin-left: auto; margin-right: auto;">
			<tr>
				<td>Artwork Name:
				</td>
				<td>
					<asp:TextBox ID="txtArtworkName" runat="server"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td style="height: 29px">Artwork Description:
				</td>
				<td style="height: 29px">
					<asp:TextBox ID="txtArtworkDesc" runat="server" Height="40px" ></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td>Artwork Price: RM
				</td>
				<td>
					<asp:TextBox ID="txtArtworkPrice" runat="server" ></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td>Artwork Stock:
				</td>
				<td>
					<asp:TextBox ID="txtArtworkStock" runat="server" TextMode="Number"></asp:TextBox>
				
				</td>

			</tr>
			<tr>
				<td>Upload Image:
				</td>
				<td>
					<asp:FileUpload ID="fuImage" runat="server" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<br>
					<asp:Button ID="btnPost" runat="server" Text="Post Artwork" OnClick="btnPost_Click" /></td>
			</tr>

		</table>

	</div>
</asp:Content>
