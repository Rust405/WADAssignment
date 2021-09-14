<%@ Page MasterPageFile="~/Site1.Master" Language="C#" AutoEventWireup="true" CodeBehind="Artwork.aspx.cs" Inherits="WADAssignment.ArtistsList.Artwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
	
	<link href="../css/artistListCss/artwork.css" rel="stylesheet" />

	<div class="body">

		<table>
            <tr>
                <td>

                    <asp:Image CssClass="img" ID="imgArtwork" runat="server" />
                </td>
                <td>
                    <asp:DetailsView ID="dvArtwork" runat="server" AutoGenerateRows="False" DataKeyNames="artworkID" DataSourceID="SqlDataSource1"  Height="400px" Width="480px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
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
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <FooterTemplate>
                            <h3>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Eval("artistID", "~/ArtistsList/ArtistGallery.aspx?artistID={0}") %>'>&lt;- Return to Gallery</asp:HyperLink>
                            </h3>
                        </FooterTemplate>
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    </asp:DetailsView>
                </td>

            </tr>
        </table>



		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT A.artworkName, A.artworkDescription, A.artworkImagePath, A.artworkPrice, A.artworkID, A.artworkStock, U.artistUsername, A.artistID
FROM Artwork A , Artist U
WHERE (A.artistID = U.artistID)
AND (A.artworkID = @artworkID)">
			<SelectParameters>
				<asp:QueryStringParameter Name="artworkID" QueryStringField="artID" />
			</SelectParameters>
		</asp:SqlDataSource>


	</div>
</asp:Content>
