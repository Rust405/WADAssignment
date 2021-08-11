<%@ Page Title="Update Artwork" MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="UpdateArtwork.aspx.cs" Inherits="WADAssignment.Artist.UpdateArtwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<style>
		.img {
			max-width: 480px;
			max-height: 480px;
			width: auto;
			height: auto;
		}

		.body {
			margin: 0;
			padding: 0;
			display: grid;
			place-content: center;
		}
		input{
			padding:8px 12px;
		}
		.header{
			width:30%;
			height:20%;
			font-weight:bold;
		}

	</style>

	<div class="body">
		<br />
		<table style="border-spacing:24px;">
			<tr>
				<td>
					<asp:Image CssClass="img" ID="imgArtwork" runat="server" />
				</td>
				<td>
					<asp:DetailsView ID="dvArtwork" runat="server" AutoGenerateRows="False" DataKeyNames="artworkID" DataSourceID="SqlDataSource1" Height="400px" Width="480px">
						<Fields>
							<asp:BoundField DataField="artworkName" HeaderText="Artwork Name" SortExpression="artworkName" >
							<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:BoundField DataField="artworkDescription" HeaderText="Artwork Description" SortExpression="artworkDescription" >
							<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Artwork Price" SortExpression="artworkPrice">
								<EditItemTemplate>
									RM <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkPrice") %>'></asp:TextBox>
								</EditItemTemplate>
								<InsertItemTemplate>
									<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("artworkPrice") %>'></asp:TextBox>
								</InsertItemTemplate>
								<ItemTemplate>
									RM <asp:Label ID="Label1" runat="server" Text='<%# String.Format("{0:0.00}",Eval("artworkPrice")) %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle CssClass="header" />
							</asp:TemplateField>
							<asp:BoundField DataField="artworkStock" HeaderText="Artwork Stock" SortExpression="artworkStock" >
							<HeaderStyle CssClass="header" />
							</asp:BoundField>
							<asp:CommandField EditText="Update" ShowEditButton="True" ButtonType="Button" >
							<ControlStyle Font-Bold="False" Font-Size="Large" />
							</asp:CommandField>
						</Fields>
					</asp:DetailsView>
				</td>

			</tr>
			<tr>
				<td>
					<asp:FileUpload ID="fuNewImage" runat="server" />
					<asp:Button ID="btnUpdateImg" runat="server" Text="Upload New Image" OnClick="btnUpdateImg_Click" />
				</td>
			</tr>
		</table>


		<p>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"  SelectCommand="SELECT [artworkName], [artworkDescription], [artworkPrice], [artworkStock], [artworkID] FROM [Artwork] WHERE ([artworkID] = @artworkID) AND ([artistID] = @artistID)" UpdateCommand="UPDATE [Artwork] SET [artworkName] = @artworkName, [artworkDescription] = @artworkDescription, [artworkPrice] = @artworkPrice, [artworkStock] = @artworkStock WHERE [artworkID] = @artworkID">
		
				<DeleteParameters>
					<asp:Parameter Name="artworkID" />
				</DeleteParameters>
				<InsertParameters>
					<asp:Parameter Name="artworkName" />
					<asp:Parameter Name="artworkDescription" />
					<asp:Parameter Name="artworkPrice" />
					<asp:Parameter Name="artworkStock" />
				</InsertParameters>
		
				<SelectParameters>
					<asp:QueryStringParameter Name="artworkID" QueryStringField="artID" Type="Int32" />
					<asp:SessionParameter Name="artistID" SessionField="artistID" />
				</SelectParameters>
				<UpdateParameters>
					<asp:Parameter Name="artworkName" Type="String" />
					<asp:Parameter Name="artworkDescription" Type="String" />
					<asp:Parameter Name="artworkPrice" Type="Double" />
					<asp:Parameter Name="artworkStock" Type="Int32" />
					<asp:Parameter Name="artworkID" Type="Int32" />
				</UpdateParameters>
			</asp:SqlDataSource>
		</p>
		<p>&nbsp;</p>
	</div>
</asp:Content>
