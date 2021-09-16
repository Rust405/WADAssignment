<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PopularArtwork.ascx.cs" Inherits="WADAssignment.Customer.PopularArtwork" %>


<table>
	<tr>
		<th>Popular Artwork</th>
	</tr>
	<tr>
		<td>
			<asp:ImageButton ID="imgPopularArtwork" runat="server" />

			<!-- Alt text if no artwork in order list at all-->
			<asp:Label ID="lblAltText" runat="server" Text="Become an artist! <br /> Get your artworks featured!"></asp:Label>
		</td>
	</tr>
	<tr>
		<td>
			<asp:HyperLink  ID="linkArtworkName" runat="server" Text="Artwork Name"></asp:HyperLink>
		</td>
	</tr>

</table>