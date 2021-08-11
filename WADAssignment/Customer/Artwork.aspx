<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="Artwork.aspx.cs" Inherits="WADAssignment.Customer.Artwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	<style>
		.img {
			max-width: 368px;
			max-height: 368px;
			width: auto;
			height: auto;
		}

		.body {
			margin: 0;
			padding: 0;
			display: grid;
			place-content: center;
		}

		.header {
			width: 30%;
			height: 20%;
			font-weight: bold;
		}

		.btnATC {
			padding: 12px 24px;
		}

		.heart {
			font-size: 38px;
			color: red;
			text-decoration: none;
		}
	</style>
	<div class="body">

		<table style="border-spacing: 24px;">
			<tr>
				<td colspan="2" cellspacing="0" style="height: 38px; text-align: left;">
					<asp:LinkButton ID="lbWishlist" CssClass="heart" Text="❤" ToolTip="Add to Wishlist" runat="server" OnClick="lbWishlist_Click"></asp:LinkButton>
				</td>
			</tr>
			<tr>
				<td>

					<asp:Image CssClass="img" ID="imgArtwork" runat="server" />
				</td>
				<td>
					<asp:DetailsView ID="dvArtwork" runat="server" AutoGenerateRows="False" DataKeyNames="artworkID" DataSourceID="SqlDataSource1" Height="368px" Width="368px">
						<Fields>
							<asp:BoundField DataField="artworkName" HeaderText="Artwork Name" SortExpression="artworkName">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:BoundField DataField="artistUsername" HeaderText="Artist Userame" SortExpression="artistUsername">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:BoundField DataField="artworkDescription" HeaderText="Artwork Description" SortExpression="artworkDescription">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Artwork Price" SortExpression="artworkPrice">
								<ItemTemplate>
									RM
									<asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}",Eval("artworkPrice")) %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>
							<asp:BoundField DataField="artworkStock" HeaderText="Artwork Stock" SortExpression="artworkStock">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
						</Fields>
					</asp:DetailsView>
				</td>

			</tr>

			<tr>

				<td colspan="2">Quantity:&nbsp
					<asp:TextBox ID="txtOrderQuantity" runat="server" TextMode="Number" Text="1" Width="35px"></asp:TextBox>
					&nbsp&nbsp&nbsp<asp:Button CssClass="btnATC" ID="btnAddToCart" runat="server" Text="Add To Cart" OnClick="btnAddToCart_Click" />
				</td>
			</tr>
		</table>



		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT A.artworkName, A.artworkDescription, A.artworkImagePath, A.artworkPrice, A.artworkID, A.artworkStock, U.artistUsername
FROM Artwork A , Artist U
WHERE (A.artistID = U.artistID)
AND (A.artworkID = @artworkID)">
			<SelectParameters>
				<asp:QueryStringParameter Name="artworkID" QueryStringField="artID" />
			</SelectParameters>
		</asp:SqlDataSource>


	</div>
</asp:Content>
