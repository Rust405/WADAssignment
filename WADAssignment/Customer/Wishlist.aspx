<%@ Page Language="C#" Title="Wishlist" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="WADAssignment.Customer.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<style>
		.img {
			max-width: 256px;
			max-height: 256px;
			width: auto;
			height: auto;
		}

		.link {
			text-decoration: none;
			color: black;
		}
	</style>
	<div>
		<h1>Wishlist</h1>
		<p>
			<asp:Label ID="lblEmptyWishlist" runat="server"></asp:Label>
		</p>

		<asp:DataList ID="dlWishlist" runat="server" CellPadding="10" DataKeyField="wishlistID" DataSourceID="SqlDataSource1" RepeatColumns="5" RepeatDirection="Horizontal">
			<ItemTemplate>
				<table>
					<tr>
						<td>
							<asp:ImageButton CssClass="img" ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath") %>' PostBackUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}&artName={1}", Eval("artworkID"),Eval("artworkName")) %>' />
						</td>
					</tr>
					<tr>
						<td>
							<asp:HyperLink CssClass="link" ID="artworkNameLabel" runat="server" NavigateUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}", Eval("artworkID")) %>' Text='<%# "<a style=\"font-size:24px;font-weight:bold\">"+Eval("artworkName")+"</a>" %>'></asp:HyperLink>
						</td>
					</tr>


					<tr>
						<td>
							<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("artworkPrice").ToString() == Eval("originalArtworkPrice").ToString() ?  "<a style=\"font-size:18px\">RM "+ String.Format("{0:0.00}",Eval("artworkPrice")) + "</a>" : "<a style=\"text-decoration:line-through\">RM " + String.Format("{0:0.00}",Eval("originalArtworkPrice"))  + "</a><br />"+ "<a style=\"font-size:22px;font-weight:bold\">RM "+ String.Format("{0:0.00}",Eval("artworkPrice")) + "</a>" %>' />
						</td>
					</tr>


					<tr>
						<td>
							<asp:HyperLink ID="hlRemove" runat="server" Text="Remove from Wishlist" ToolTip="Remove from Wishlist" NavigateUrl='<%# String.Format("~/Customer/Wishlist.aspx?wishlistID={0}", Eval("wishlistID")) %>'></asp:HyperLink>
						</td>
					</tr>
				</table>
				<br />
			</ItemTemplate>
		</asp:DataList>
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT 
W.wishlistID, W.customerID, W.originalArtworkPrice, A.artworkImagePath, A.artworkName, A.artworkPrice, A.artworkID
FROM 
Wishlist W, Artwork A
WHERE 
(W.customerID = @customerID)
AND
(W.artworkID = A.artworkID)">
			<SelectParameters>
				<asp:SessionParameter Name="customerID" SessionField="customerID" Type="Int32" />
			</SelectParameters>
		</asp:SqlDataSource>
		<br />





	</div>
</asp:Content>
