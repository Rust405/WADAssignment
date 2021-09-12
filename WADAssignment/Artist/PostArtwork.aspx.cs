using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class PostArtwork : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

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
					txtArtworkStock.Text = "";
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
			if (fuImage.HasFile)
			{
				String artName = txtArtworkName.Text;
				String artDesc = txtArtworkDesc.Text;
				String artPrice = txtArtworkPrice.Text;
				String artStock = txtArtworkStock.Text;
				String artImagePath = "~/Artwork/" + artName + DateTime.Now.ToString("ddMMyyhhmmss")+".jpg";
				String artistID = Session["artistID"].ToString();

				fuImage.PostedFile.SaveAs(Server.MapPath("~/Artwork/" + artName + DateTime.Now.ToString("ddMMyyhhmmss") + ".jpg"));

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

				lblSuccess.Text = artName + " has been successfully posted!";
				hlGallery.Visible = true;
				hlPostAnother.Visible = true;
			}
			else
			{
				//Please upload an image
			}



		}
	}
}