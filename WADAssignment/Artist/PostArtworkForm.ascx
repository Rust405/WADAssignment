﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PostArtworkForm.ascx.cs" Inherits="WADAssignment.Artist.PostArtworkForm" %>
<table style="margin-left: auto; margin-right: auto; width: 528px; height: 354px;">
			<tr>
				<td style="text-align: left; width: 319px;">Artwork Name:
				</td>
				<td style="width: 342px">
					<asp:TextBox ID="txtArtworkName" runat="server" Width="216px" MaxLength="30"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtArtworkName" ErrorMessage="*&lt;br /&gt;Artwork name is required" Font-Bold="True" Font-Size="Medium" ForeColor="#FF3300"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td style="text-align: left; height: 29px; width: 319px;">Artwork Description:
				</td>
				<td style="height: 29px; width: 342px;">
					<asp:TextBox ID="txtArtworkDesc" runat="server" Height="40px" Width="216px" MaxLength="420"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtArtworkDesc" ErrorMessage="*&lt;br /&gt;Artwork description is required" Font-Bold="True" Font-Size="Medium" ForeColor="Red"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td style="text-align: left; width: 319px;">Artwork Price (RM):
				</td>
				<td style="width: 342px">
					<asp:TextBox ID="txtArtworkPrice" runat="server" Width="216px"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtArtworkPrice" ErrorMessage="*&lt;br /&gt;Artwork price is required" Font-Bold="True" Font-Size="Medium" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

					<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtArtworkPrice" Font-Bold="True" ErrorMessage="*&lt;br /&gt;Price or format is invalid. Correct format: &quot;0.00&quot;" ForeColor="Red" ValidationExpression="\d{1,3}.\d{2}" Display="Dynamic"></asp:RegularExpressionValidator>

				</td>
			</tr>
			<tr>
				<td style="text-align: left; height: 29px; width: 319px;">Artwork Stock:
				</td>
				<td style="width: 342px; height: 29px">
					<asp:TextBox ID="txtArtworkStock" runat="server" TextMode="Number" Width="90px">1</asp:TextBox>

					<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtArtworkStock" Display="Dynamic" ErrorMessage="*&lt;br /&gt;Artwork stock is required" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
					<asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtArtworkStock" ErrorMessage="*&lt;br /&gt;Artwork stock can only be 1-9999" Font-Bold="True" Font-Size="Medium" ForeColor="Red" MaximumValue="9999" MinimumValue="1" Type="Integer" Display="Dynamic"></asp:RangeValidator>

				</td>

			</tr>
			<tr>
				<td style="text-align: left; width: 319px;">Upload Image<br />
					(JPG/JPEG/PNG):
				</td>
				<td style="width: 342px">
					<asp:FileUpload ID="fuImage" runat="server" />
					<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="fuImage" ErrorMessage="*&lt;br /&gt; Image for artwork thumbnail is required" Font-Bold="True" Font-Size="Medium" Font-Underline="False" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:CustomValidator ID="cvFileExtension" runat="server" ControlToValidate="fuImage" Display="Dynamic" ErrorMessage="*&lt;br /&gt;Invalid file format" Font-Bold="True" Font-Size="Medium" ForeColor="Red" OnServerValidate="cvFileExtension_ServerValidate"></asp:CustomValidator>
					<asp:CustomValidator ID="cvMaxFileSize" runat="server" ErrorMessage="*&lt;br /&gt;Max image file size: 4MB" ControlToValidate="fuImage" Font-Bold="True" Font-Size="Medium" ForeColor="Red" OnServerValidate="cvMaxFileSize_ServerValidate" Display="Dynamic"></asp:CustomValidator>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<br>
					<asp:Button CssClass="btnPost" ID="btnPost" runat="server" Text="Post Artwork" OnClick="btnPost_Click" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Label ID="lblSuccess" runat="server" Text=""></asp:Label><br />
					<asp:HyperLink ID="hlGallery" runat="server" NavigateUrl="~/Artist/Gallery.aspx">Return to My Gallery</asp:HyperLink>
					<br /><br />
					<asp:HyperLink ID="hlPostAnother" runat="server" NavigateUrl="~/Artist/PostArtwork.aspx">Post another</asp:HyperLink>
				</td>
			</tr>
		</table>