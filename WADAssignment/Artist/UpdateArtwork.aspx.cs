using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class UpdateArtwork : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["artID"] != null)
			{
				if (Session["userType"].ToString() == "Artist")
				{
					imgArtwork.ImageUrl = getImagePath();
					Page.Title = "Update Artwork | " + Request.QueryString["artName"];
				}
				else
				{
					Response.Redirect("~/Error/UnauthorizedUser.aspx");
				}
			}
			else
			{
				Response.Redirect("~/Artist/Gallery.aspx");
			}
		}

		protected String getImagePath()
		{
			String artID = Request.QueryString["artID"];
			String imagePath = "";
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//1. search customer and artist db tables for logged in username
				String getImagePath = "SELECT artworkImagePath FROM Artwork WHERE artworkID = '" + artID + "'";

				SqlCommand getPath = new SqlCommand(getImagePath, con);

				con.Open();
				String artworkImagePath = getPath.ExecuteScalar().ToString();
				con.Close();

				imagePath = artworkImagePath;
			}
			return imagePath;
		}

		protected void btnUpdateImg_Click(object sender, EventArgs e)
		{

			if (fuNewImage.HasFile)
			{
				String imagePath = getImagePath();
				fuNewImage.PostedFile.SaveAs(Server.MapPath(imagePath));
			}
			else
			{
				//Please upload an image
			}



		}
	}
}