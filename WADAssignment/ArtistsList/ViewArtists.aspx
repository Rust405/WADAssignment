<%@ Page Title="Artists" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewArtists.aspx.cs" Inherits="WADAssignment.Artist.ViewArtists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/custCss/viewArtist.css" rel="stylesheet"/>

	<div>
		<div class="sticky">
		<h1>Artists List</h1>
		<asp:Panel ID="Panel1" DefaultButton="btnSearch" runat="server">
			<asp:TextBox ID="txtSearch" placeholder="Search by artist name..." runat="server" Height="28px" Width="332px"></asp:TextBox>
			<asp:Button ID="btnClear" runat="server" Text="X" Height="35px" Width="35px" CssClass="auto-style1" OnClick="btnClear_Click" />
			<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Height="35px" Width="120px" />
		</asp:Panel>
		</div>
		<p>
			<asp:Label ID="lblResults" runat="server"></asp:Label>

		</p>

		<asp:GridView CssClass="gvArtistList" ID="gvArtistList" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
			<Columns>
				<asp:TemplateField HeaderText="Artist Username" SortExpression="UserName">

					<ItemTemplate>
						<asp:HyperLink CssClass="link" ID="HyperLink2"
							NavigateUrl='<%# String.Format("~/ArtistsList/ArtistGallery.aspx?artistID={0}", Eval("artistID")) %>'
							Text='<%# Bind("UserName") %>' runat="server">HyperLink</asp:HyperLink>
					</ItemTemplate>
					<HeaderStyle Font-Size="Large" />
					<ItemStyle Font-Size="X-Large" Height="48px" Width="70%" />
				</asp:TemplateField>
				<asp:TemplateField HeaderText="Artist Email" SortExpression="Email">

					<ItemTemplate>
						<asp:HyperLink ID="HyperLink1" runat="server"
							NavigateUrl='<%# Bind("Email", "mailto:{0}") %>'
							Text='<%# Bind("Email") %>'></asp:HyperLink>
					</ItemTemplate>
					<HeaderStyle Font-Size="Large" />
					<ItemStyle Font-Size="X-Large" Width="30%" />
				</asp:TemplateField>
			</Columns>
		    <FooterStyle BackColor="#cfcfcf" ForeColor="Black" />
            <HeaderStyle BackColor="#474747" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
		</asp:GridView>

		<p>
			&nbsp;
		</p>
	</div>
</asp:Content>
