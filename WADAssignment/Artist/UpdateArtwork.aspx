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

							<asp:TemplateField HeaderText="Artwork Name" SortExpression="artworkName">
								<EditItemTemplate>
									<asp:TextBox ID="txtArtworkName" runat="server" Text='<%# Bind("artworkName") %>'></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtArtworkName" ErrorMessage="*&lt;br /&gt;Artwork name is required" Font-Bold="True" Font-Size="Medium" ForeColor="#FF3300"></asp:RequiredFieldValidator>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label3" runat="server" Text='<%# Bind("artworkName") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>


							<asp:TemplateField HeaderText="Artwork Description" SortExpression="artworkDescription">
								<EditItemTemplate>
									<asp:TextBox ID="txtArtworkDesc" runat="server" Text='<%# Bind("artworkDescription") %>'></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtArtworkDesc" ErrorMessage="*&lt;br /&gt;Artwork description is required" Font-Bold="True" Font-Size="Medium" ForeColor="Red"></asp:RequiredFieldValidator>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label4" runat="server" Text='<%# Bind("artworkDescription") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>


							<asp:TemplateField HeaderText="Artwork Price" SortExpression="artworkPrice">
								<EditItemTemplate>
									RM
									<asp:TextBox ID="txtArtworkPrice" runat="server" Text='<%# Bind("artworkPrice") %>'></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtArtworkPrice" ErrorMessage="*&lt;br /&gt;Artwork price is required" Font-Bold="True" Font-Size="Medium" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtArtworkPrice" Font-Bold="True" ErrorMessage="*&lt;br /&gt;Price or format is invalid. Correct format: &quot;0.00&quot;" ForeColor="Red" ValidationExpression="\d{1,3}.\d{2}" Display="Dynamic"></asp:RegularExpressionValidator>
								</EditItemTemplate>
								<ItemTemplate>
									RM
									<asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}",Eval("artworkPrice")) %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>


							<asp:TemplateField HeaderText="Artwork Stock" SortExpression="artworkStock">
								<EditItemTemplate>
									<asp:TextBox ID="txtArtworkStock" runat="server" Text='<%# Bind("artworkStock") %>' TextMode="Number"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtArtworkStock" Display="Dynamic" ErrorMessage="*&lt;br /&gt;Artwork stock is required" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
									<asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtArtworkStock" ErrorMessage="*&lt;br /&gt;Artwork stock can only be 0-9999" Font-Bold="True" Font-Size="Medium" ForeColor="Red" MaximumValue="9999" MinimumValue="0" Type="Integer" Display="Dynamic"></asp:RangeValidator>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label5" runat="server" Text='<%# Bind("artworkStock") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>


							<asp:TemplateField HeaderText="Artwork Status" SortExpression="artworkListStatus">
								<EditItemTemplate>
									<asp:DropDownList CssClass="ddl" SelectedValue='<%# Bind("artworkListStatus") %>' ID="DropDownList1" runat="server">
										<asp:ListItem>Listed</asp:ListItem>
										<asp:ListItem>Unlisted</asp:ListItem>
									</asp:DropDownList>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="Label2" runat="server" Text='<%# Bind("artworkListStatus") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>

							<asp:TemplateField>
								<EditItemTemplate>
									<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="X" />
									&nbsp;<asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Save Changes" />
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
					<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="fuNewImage" ErrorMessage="*&lt;br /&gt; Image for artwork thumbnail is required" Font-Bold="True" Font-Size="Medium" Font-Underline="False" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:CustomValidator ID="cvFileExtension" runat="server" ControlToValidate="fuNewImage" Display="Dynamic" ErrorMessage="*&lt;br /&gt;Invalid file format" Font-Bold="True" Font-Size="Medium" ForeColor="Red" OnServerValidate="cvFileExtension_ServerValidate"></asp:CustomValidator>
					<asp:CustomValidator ID="cvMaxFileSize" runat="server" ErrorMessage="*&lt;br /&gt;Max image file size: 4MB" ControlToValidate="fuNewImage" Font-Bold="True" Font-Size="Medium" ForeColor="Red" OnServerValidate="cvMaxFileSize_ServerValidate" Display="Dynamic"></asp:CustomValidator>
					<br />
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
