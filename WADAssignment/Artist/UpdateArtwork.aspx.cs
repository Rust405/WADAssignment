using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class UpdateArtwork : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["artID"] != null)
			{
				if (Session["userType"].ToString() == "Artist")
				{
					imgArtwork.ImageUrl = getImagePath() + "?t=" + DateTime.Now.ToString("ddMMyyhhmmss");
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
			if (Page.IsValid)
			{
				//get current image path
				String imagePath = getImagePath();


				#region compress and upload new thumbnail
				Stream strm = fuNewImage.PostedFile.InputStream;
				using (var image = System.Drawing.Image.FromStream(strm))
				{
					int newWidth = 240;
					int newHeight = 240;
					var thumbImg = new Bitmap(newWidth, newHeight);
					var thumbGraph = Graphics.FromImage(thumbImg);
					thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
					thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
					thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
					var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
					thumbGraph.DrawImage(image, imgRectangle);

					//upload image
					string targetPath = Server.MapPath(imagePath);
					thumbImg.Save(targetPath, image.RawFormat);
				}
				#endregion

				//message


			}
		}

		protected void cvFileExtension_ServerValidate(object source, ServerValidateEventArgs args)
		{
			//get extension
			string extension = Path.GetExtension(fuNewImage.FileName);
			//check extension
			if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
			{
				args.IsValid = true;
			}
			//invalid extension
			else
			{
				args.IsValid = false;
			}
		}

		protected void cvMaxFileSize_ServerValidate(object source, ServerValidateEventArgs args)
		{
			if (fuNewImage.HasFile)
			{
				if (fuNewImage.PostedFile.ContentLength > 4194304) //4MB
				{
					args.IsValid = false;
				}
				else
				{
					args.IsValid = true;
				}
			}
		}

	}
}