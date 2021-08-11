<%@ Page title="Post Artwork" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PostArtwork.aspx.cs" Inherits="WADAssignment.Artist.PostArtwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<style>
		.btnPost{
			padding:8px 18px 8px 18px;
		}
	</style>
	<div>
		<h1>Post Artwork</h1>
		<table style="margin-left: auto; margin-right: auto; width: 528px; height: 354px;">
			<tr>
				<td style="text-align:left;">Artwork Name:
				</td>
				<td style="width: 342px">
					<asp:TextBox ID="txtArtworkName" runat="server" Width="216px"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td style="text-align:left;height: 29px">Artwork Description:
				</td>
				<td style="height: 29px; width: 342px;">
					<asp:TextBox ID="txtArtworkDesc" runat="server" Height="40px" Width="216px" ></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td style="text-align:left;">Artwork Price (RM):
				</td>
				<td style="width: 342px">
					<asp:TextBox ID="txtArtworkPrice" runat="server" Width="216px" ></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td style="text-align:left;height: 29px">Artwork Stock:
				</td>
				<td style="width: 342px; height: 29px">
					<asp:TextBox ID="txtArtworkStock" runat="server" TextMode="Number" Width="216px"></asp:TextBox>
				
				</td>

			</tr>
			<tr>
				<td style="text-align:left;">Upload Image:
				</td>
				<td style="width: 342px">
					<asp:FileUpload ID="fuImage" runat="server" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<br>
					<asp:Button CssClass="btnPost" ID="btnPost" runat="server" Text="Post Artwork" OnClick="btnPost_Click" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Label ID="lblSuccess" runat="server" Text=""></asp:Label>
					<asp:HyperLink ID="hlGallery" runat="server" NavigateUrl="~/Artist/Gallery.aspx">Return to My Gallery</asp:HyperLink>
					<br />
					<asp:HyperLink ID="hlPostAnother" runat="server" NavigateUrl="~/Artist/PostArtwork.aspx">Post another</asp:HyperLink>
				</td>
			</tr>
		</table>

	</div>
</asp:Content>
