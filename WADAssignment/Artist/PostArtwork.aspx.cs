using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class PostArtwork : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Artist")
			{
				if (!IsPostBack)
				{
					//reset fields
					txtArtworkName.Text = "";
					txtArtworkDesc.Text = "";
					txtArtworkPrice.Text = "";
					txtArtworkStock.Text = "1";
					lblSuccess.Text = "";
					hlGallery.Visible = false;
					hlPostAnother.Visible = false;
				}
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}

		}

		protected void btnPost_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{

				String artName = txtArtworkName.Text;
				String artDesc = txtArtworkDesc.Text;
				String artPrice = txtArtworkPrice.Text;
				String artStock = txtArtworkStock.Text;
				String artImagePath = "~/Artwork/" + artName + DateTime.Now.ToString("ddMMyyhhmmss") + ".jpg";
				String artistID = Session["artistID"].ToString();


				#region compress and upload thumbnail
				Stream strm = fuImage.PostedFile.InputStream;
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
					string targetPath = Server.MapPath("~/Artwork/" + artName + DateTime.Now.ToString("ddMMyyhhmmss") + ".jpg");
					thumbImg.Save(targetPath, image.RawFormat);
				}
				#endregion

				#region add artwork to database
				using (SqlConnection con = new SqlConnection(connectionString))
				{
					//add artwork
					SqlCommand cmd = new SqlCommand("INSERT " +
						"INTO " +
						"ARTWORK(artworkName, artworkDescription, artworkImagePath, artworkPrice, artworkStock, artistID, artworkListStatus) " +
						"VALUES(@artworkName, @artworkDescription, @artworkImagePath, @artworkPrice, @artworkStock, @artistID, @artworkListStatus) ", con);

					cmd.Parameters.Add("@artworkName", SqlDbType.VarChar).Value = artName;
					cmd.Parameters.Add("@artworkDescription", SqlDbType.VarChar).Value = artDesc;
					cmd.Parameters.Add("@artworkImagePath", SqlDbType.VarChar).Value = artImagePath;
					cmd.Parameters.Add("@artworkPrice", SqlDbType.VarChar).Value = artPrice;
					cmd.Parameters.Add("@artworkStock", SqlDbType.VarChar).Value = artStock;
					cmd.Parameters.Add("@artistID", SqlDbType.VarChar).Value = artistID;
					cmd.Parameters.Add("@artworkListStatus", SqlDbType.VarChar).Value = "Listed";

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();
				}
				#endregion


				//success message
				lblSuccess.Text = artName + " has been successfully posted!";
				hlGallery.Visible = true;
				hlPostAnother.Visible = true;
			}

		}

		protected void cvFileExtension_ServerValidate(object source, ServerValidateEventArgs args)
		{
			//get extension
			string extension = Path.GetExtension(fuImage.FileName);
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
			if (fuImage.HasFile)
			{
				if (fuImage.PostedFile.ContentLength > 4194304) //4MB
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