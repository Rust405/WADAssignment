<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="Artwork.aspx.cs" Inherits="WADAssignment.Customer.Artwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<!--Cancel auto-scroll for validation -->
	<script type="text/javascript">
		window.scrollTo = function (x, y) {
			return true;
		}
	</script>


	<link rel="stylesheet" href="../css/custCss/artwork.css">

	<div class="body">

		<span style="height: 38px; text-align: left;">
			<asp:LinkButton ID="lbWishlist" CssClass="heart" Text="❤" ToolTip="Add to Wishlist" runat="server" OnClick="lbWishlist_Click"></asp:LinkButton>
		</span>

		<table style="border-spacing: 24px;">

			<tr>
				<td>

					<asp:Image CssClass="img" ID="imgArtwork" runat="server" />
				</td>
				<td>
					<asp:DetailsView ID="dvArtwork" runat="server" AutoGenerateRows="False" DataKeyNames="artworkID" DataSourceID="SqlDataSource1" Height="400px" Width="540px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
						<AlternatingRowStyle BackColor="#DCDCDC" />
						<EditRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
						<Fields>
							<asp:TemplateField HeaderText="Artwork Name" SortExpression="artworkName">
								<EditItemTemplate>
									<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkName") %>'></asp:TextBox>
								</EditItemTemplate>
								<InsertItemTemplate>
									<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkName") %>'></asp:TextBox>
								</InsertItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label2" runat="server" Text='<%# checkListed(Eval("artworkName")) %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>
							<asp:BoundField DataField="artistUsername" HeaderText="Artist Username" SortExpression="artistUsername">
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
						<FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
						<HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
						<PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
						<RowStyle BackColor="#EEEEEE" ForeColor="Black" />
					</asp:DetailsView>

					<div class="quantityCart">
						<table>
							<tr>
								<td>
									<asp:HyperLink ID="HyperLink1" runat="server" Text="<- Return to Gallery" NavigateUrl="~/Customer/Gallery.aspx"></asp:HyperLink>
								</td>
								<td>&nbsp&nbsp Quantity:&nbsp
						<asp:TextBox ID="txtOrderQuantity" runat="server" TextMode="Number" Text="1" Width="50px"></asp:TextBox>
									<asp:RangeValidator ID="rvQuantity" runat="server" Font-Bold="True" Font-Size="Medium" MinimumValue="1" ControlToValidate="txtOrderQuantity" ForeColor="Red" Type="Integer">*</asp:RangeValidator>
								</td>
								<td>
									<asp:Button CssClass="btnATC" ID="btnAddToCart" runat="server" Text="Add To Cart" OnClick="btnAddToCart_Click" />
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph" Font-Bold="True" Font-Size="Medium" ForeColor="Red" />
								</td>
							</tr>
						</table>

					</div>
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
