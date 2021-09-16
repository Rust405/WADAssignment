<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PopularArtwork.ascx.cs" Inherits="WADAssignment.Customer.PopularArtwork" %>


<link href="../css/custCss/popular.css" rel="stylesheet" />

<table class="popular">
	<tr class="popular">
		<td class="popular" style="font-size:28px">Popular Artwork</td>
	</tr>
	<tr class="popular">
		<td class="popular">
			<asp:ImageButton ID="imgPopularArtwork" CssClass="imgPopular" runat="server" />

			<!-- Alt text if no artwork in order list at all-->
			<asp:Label ID="lblAltText" runat="server" Text="Become an artist and get your artworks featured!"></asp:Label>
		</td>
	</tr>
	<tr>
		<td>
			<asp:HyperLink ID="linkArtworkName" CssClass="linkPopular" runat="server" Font-Bold="True" Font-Size="X-Large">Artwork Name</asp:HyperLink>
		</td>
	</tr>


</table>
