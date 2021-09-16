<%@ Page Title="Post Artwork" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PostArtwork.aspx.cs" Inherits="WADAssignment.Artist.PostArtwork" %>

<%@ Register TagPrefix="PostForm" TagName="Artwork" Src="~/Artist/PostArtworkForm.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">

	<link href="../css/artistCss/postArt.css" rel="stylesheet" />

	<div>
		<h1>Post Artwork</h1>

		<PostForm:Artwork ID="formPostArtwork" runat="server" />
		
	</div>

</asp:Content>
