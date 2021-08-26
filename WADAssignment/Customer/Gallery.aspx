<%@ Page Language="C#" Title="Gallery" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="WADAssignment.Customer.Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/custCss/gallery.css" rel="stylesheet" />

	<div>
		<div class="sticky">
			<h1>Gallery</h1>
			<asp:Panel ID="Panel1" DefaultButton="btnSearch" runat="server">
				<asp:TextBox ID="txtSearch" placeholder="Search by artwork name or artist username..." runat="server" Height="28px" Width="332px"></asp:TextBox>
				<asp:Button ID="btnClear" runat="server" Text="X" Height="35px" Width="35px" CssClass="auto-style1" OnClick="btnClear_Click" />
				<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Height="35px" Width="120px" />
			</asp:Panel>
		</div>
		<p>
			<asp:Label ID="lblResults" runat="server"></asp:Label>
			<asp:Label ID="lblPost" runat="server"></asp:Label>
		</p>
		<p>
			<asp:DataList ID="dlCustomerGallery" runat="server" CellPadding="10" RepeatColumns="4" RepeatDirection="Horizontal">
				<ItemTemplate>
					<table>
						<tr>
							<td style="width: 256px; height: 256px;">
								<asp:ImageButton CssClass="img" ID="artworkImage" runat="server" ImageUrl='<%# Eval("artworkImagePath") %>' PostBackUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}&artName={1}", Eval("artworkID"),Eval("artworkName")) %>' />
							</td>
						</tr>
						<tr>
							<td>
								<b style="font-size: 24px;">
									<asp:HyperLink CssClass="link" ID="artworkNameLabel" runat="server" NavigateUrl='<%# String.Format("~/Customer/Artwork.aspx?artID={0}", Eval("artworkID")) %>' Text='<%# Eval("artworkName") %>'></asp:HyperLink>

								</b>
							</td>
						</tr>
						<tr>
							<td>
								<a style="font-size: 18px;">RM
									<asp:Label ID="artworkPriceLabel" runat="server" Text='<%# String.Format("{0:0.00}", Eval("artworkPrice")) %>' />


								</a>
							</td>
						</tr>
					</table>

					<br />

					<br />
				</ItemTemplate>
			</asp:DataList>
		</p>
	</div>
</asp:Content>
