using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.ArtistsList
{
	public partial class Artwork : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["artID"] != null)
			{
				if (!isArtworkIDValid())
				{
					Response.Redirect("~/Error/InvalidArtworkID.aspx");
				}


				imgArtwork.ImageUrl = getImagePath() + "?t=" + DateTime.Now.ToString("ddMMyyhhmmss");
				Page.Title = "Artwork | " + getArtworkName();
			}
			else
			{
				//user requested Artwork page without query string
				Response.Redirect("~/ArtistsList/ViewArtists.aspx");
			}
		}

		protected String getImagePath()
		{
			String artID = Request.QueryString["artID"];
			String imagePath = "";
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String getImagePath = "SELECT artworkImagePath FROM Artwork WHERE artworkID = '" + artID + "'";

				SqlCommand getPath = new SqlCommand(getImagePath, con);

				con.Open();
				String artworkImagePath = getPath.ExecuteScalar().ToString();
				con.Close();

				imagePath = artworkImagePath;
			}
			return imagePath;
		}

		protected bool isArtworkUnlisted()
		{
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String checkUnlistedArtwork = "SELECT " +
					"artworkListStatus " +
					"FROM " +
					"Artwork " +
					"WHERE " +
					"artworkID = '" + Request.QueryString["artID"] + "' ";

				SqlCommand selectArtwork = new SqlCommand(checkUnlistedArtwork, con);

				con.Open();
				object unlistedArtwork = selectArtwork.ExecuteScalar();
				con.Close();

				if (unlistedArtwork.ToString() == "Unlisted")
				{
					return true;
				}
				else
				{
					return false;
				}

			}

		}

		protected string checkListed(object artworkName)
		{
			if (artworkName == null)
			{
				return "";
			}
			else
			{
				if (isArtworkUnlisted())
				{
					return "(Unlisted) " + artworkName;
				}
				else
				{
					return artworkName + "";
				}

			}
		}

		protected bool isArtworkIDValid()
		{
			String artID = Request.QueryString["artID"];
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//search artwork database for artworkID
				String findArtworkID = "SELECT artworkID FROM Artwork WHERE artworkID = @artworkID";

				SqlCommand getArtworkID = new SqlCommand(findArtworkID, con);
				getArtworkID.Parameters.AddWithValue("@artworkID", artID);

				con.Open();
				object artworkID = getArtworkID.ExecuteScalar();
				con.Close();

				if (artworkID != null)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
		}

		protected String getArtworkName()
		{
			String artID = Request.QueryString["artID"];
			String name = "";
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String getArtworkName = "SELECT artworkName FROM Artwork WHERE artworkID = '" + artID + "'";

				SqlCommand selectArtworkName = new SqlCommand(getArtworkName, con);

				con.Open();
				String artworkName = selectArtworkName.ExecuteScalar().ToString();
				con.Close();

				name = artworkName;
			}
			return name;
		}
	}
}