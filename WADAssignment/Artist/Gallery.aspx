<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="WADAssignment.Artist.Gallery" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<div>
		<style>
			.img {
				max-width: 256px;
				max-height: 256px;
				width: auto;
				height: auto;
			}

			.btnUpdate {
				padding: 4px;
			}
		</style>
		<h1>
			<asp:Label ID="lblGallery" runat="server" Text=""></asp:Label>
		</h1>
		<p>
			<asp:DataList ID="dlArtistGallery" runat="server" DataSourceID="SqlDataSource1" RepeatDirection="Horizontal" CellPadding="10" CellSpacing="-1" RepeatColumns="5" DataKeyField="artworkID">
				<ItemTemplate>
					<table>
						<tr>
							<td style="width: 256px; height: 256px;">
								<asp:Image ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath") %>' CssClass="img" />
							</td>
						</tr>
						<tr>
							<td>
								<b style="font-size: 24px;">
									<asp:Label ID="artworkNameLabel" runat="server" Text='<%# Eval("artworkName") %>' />
								</b>
							</td>
						</tr>
						<tr>
							<td>
								<a style="font-size: 18px;">RM
									<asp:Label ID="artworkPriceLabel" runat="server" Text='<%# Eval("artworkPrice") %>' />
								</a>
							</td>
						</tr>
						<tr>
							<td>
								<asp:Button CssClass="btnUpdate" ID="btnUpdate" runat="server" Text="Update" PostBackUrl='<%# String.Format("~/Artist/UpdateArtwork.aspx?artID={0}", Eval("artworkID")) %>' />
							</td>
						</tr>
					</table>


					<br />

					<br />
				</ItemTemplate>
			</asp:DataList>
		</p>
		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [artworkID], [artworkName], [artworkImagePath], [artworkPrice] FROM [Artwork] WHERE ([artistID] = @artistID)">
				<SelectParameters>
					<asp:SessionParameter Name="artistID" SessionField="artistID" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
		</p>
	</div>

</asp:Content>
