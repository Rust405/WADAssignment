<%@ Page Title="Update Artwork" MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UpdateArtwork.aspx.cs" Inherits="WADAssignment.Artist.UpdateArtwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link rel="stylesheet" href="../css/artistCss/updateArtwork.css">

	<div class="body">
		<br />
		<table style="border-spacing: 24px;">
			<tr>
				<td>
					<asp:Image CssClass="img" ID="imgArtwork" runat="server" />
				</td>
				<td>
					<asp:DetailsView ID="dvArtwork" runat="server" AutoGenerateRows="False" DataKeyNames="artworkID" DataSourceID="SqlDataSource1" Height="400px" Width="480px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
						<AlternatingRowStyle BackColor="#DCDCDC" />
						<EditRowStyle BackColor="#cfcfcf" Font-Bold="True" ForeColor="Black" />
						<Fields>
							<asp:BoundField DataField="artworkName" HeaderText="Artwork Name" SortExpression="artworkName">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:BoundField DataField="artworkDescription" HeaderText="Artwork Description" SortExpression="artworkDescription">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Artwork Price" SortExpression="artworkPrice">
								<EditItemTemplate>
									RM
									<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkPrice") %>'></asp:TextBox>
								</EditItemTemplate>
								<InsertItemTemplate>
									<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkPrice") %>'></asp:TextBox>
								</InsertItemTemplate>
								<ItemTemplate>
									RM
									<asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}",Eval("artworkPrice")) %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>
							<asp:BoundField DataField="artworkStock" HeaderText="Artwork Stock" SortExpression="artworkStock">
								<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Artwork Status" SortExpression="artworkListStatus">
								<EditItemTemplate>
									<asp:DropDownList CssClass="ddl" SelectedValue='<%# Bind("artworkListStatus") %>' ID="DropDownList1" runat="server">
										<asp:ListItem>Listed</asp:ListItem>
										<asp:ListItem>Unlisted</asp:ListItem>
									</asp:DropDownList>
								</EditItemTemplate>
								<InsertItemTemplate>
									<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("artworkListStatus") %>'></asp:TextBox>
								</InsertItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label2" runat="server" Text='<%# Bind("artworkListStatus") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>
							<asp:TemplateField>
								<EditItemTemplate>
									<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
									&nbsp;<asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Update" />
								</ItemTemplate>
								<ControlStyle CssClass="btnUpdate" Font-Bold="False" Font-Size="Large" />
							</asp:TemplateField>
						</Fields>
						<FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
						<HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
						<PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
						<RowStyle BackColor="#EEEEEE" ForeColor="Black" />
					</asp:DetailsView>
				</td>

			</tr>
			<tr>
				<td>
					<asp:HyperLink ID="HyperLink1" runat="server" Text="<- Return to Gallery" NavigateUrl="~/Artist/Gallery.aspx"></asp:HyperLink>
				</td>
				<td>
					<asp:FileUpload ID="fuNewImage" runat="server" />
					<asp:Button ID="btnUpdateImg" runat="server" Text="Upload New Image" OnClick="btnUpdateImg_Click" CssClass="btnUpdateImg" />
				</td>
			</tr>
		</table>


		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [artworkName], [artworkDescription], [artworkPrice], [artworkStock], [artworkID], [artworkListStatus] FROM [Artwork] WHERE ([artworkID] = @artworkID) AND ([artistID] = @artistID)" UpdateCommand="UPDATE [Artwork] SET [artworkName] = @artworkName, [artworkDescription] = @artworkDescription, [artworkPrice] = @artworkPrice, [artworkStock] = @artworkStock , [artworkListStatus] = @artworkListStatus WHERE [artworkID] = @artworkID">

				<SelectParameters>
					<asp:QueryStringParameter Name="artworkID" QueryStringField="artID" Type="Int32" />
					<asp:SessionParameter Name="artistID" SessionField="artistID" />
				</SelectParameters>
				<UpdateParameters>
					<asp:Parameter Name="artworkName" Type="String" />
					<asp:Parameter Name="artworkDescription" Type="String" />
					<asp:Parameter Name="artworkPrice" Type="Double" />
					<asp:Parameter Name="artworkStock" Type="Int32" />
					<asp:Parameter Name="artworkListStatus" />
					<asp:Parameter Name="artworkID" Type="Int32" />
				</UpdateParameters>
			</asp:SqlDataSource>
		</p>
	</div>
</asp:Content>
