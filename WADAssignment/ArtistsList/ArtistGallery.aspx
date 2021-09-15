<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtistGallery.aspx.cs" Inherits="WADAssignment.ArtistsList.ArtistGallery" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/artistListCss/artistGallery.css" rel="stylesheet" />

	<div>
		<h1>
			<asp:Label ID="lblGallery" runat="server" Text=""></asp:Label>
		</h1>
		<asp:Panel ID="Panel1" DefaultButton="btnSearch" runat="server">
			<asp:TextBox ID="txtSearch" placeholder="Search by artwork name..." runat="server" Height="28px" Width="332px"></asp:TextBox>
			<asp:Button ID="btnClear" runat="server" Text="X" Height="35px" Width="35px" CssClass="auto-style1" OnClick="btnClear_Click" />
			<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Height="35px" Width="120px" />

		</asp:Panel>
		<p>
			<asp:Label ID="lblResults" runat="server"></asp:Label>
		</p>

		<asp:DataList ID="dlArtistGallery" runat="server" RepeatDirection="Horizontal" CellPadding="10" CellSpacing="-1" RepeatColumns="4" DataKeyField="artworkID">
			<ItemTemplate>
				<table>
					<tr>
						<td style="width: 256px; height: 256px;">
							<asp:ImageButton CssClass="img" ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath","{0}?t="+ DateTime.Now.ToString("ddMMyyhhmmss")) %>' PostBackUrl='<%# String.Format("~/ArtistsList/Artwork.aspx?artID={0}", Eval("artworkID")) %>' />
						</td>
					</tr>
					<tr>
						<td>
							<b style="font-size: 24px;">
								<asp:HyperLink CssClass="link" ID="artworkNameLabel" runat="server" NavigateUrl='<%# String.Format("~/ArtistsList/Artwork.aspx?artID={0}", Eval("artworkID")) %>' Text='<%# Eval("artworkName") %>'></asp:HyperLink>

							</b>
						</td>
					</tr>
					<tr>
						<td>
							<a style="font-size: 18px;">RM
									<asp:Label ID="artworkPriceLabel" runat="server" Text='<%# String.Format("{0:0.00}",Eval("artworkPrice")) %>' />
							</a>
						</td>
					</tr>

				</table>
				<br />


			</ItemTemplate>
		</asp:DataList>

		<p>
			&nbsp;
		</p>
	</div>

</asp:Content>
