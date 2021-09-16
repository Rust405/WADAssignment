using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WADAssignment.Customer
{
	public partial class PopularArtwork : System.Web.UI.UserControl
	{

		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				lblAltText.Visible = false;

				String mostPopularArtID = getMostPopularArtworkID();

				//if there is a popular artwork
				if (mostPopularArtID != "")
				{
					//image
					imgPopularArtwork.ImageUrl = getImagePath(mostPopularArtID) + "?t=" + DateTime.Now.ToString("ddMMyyhhmmss");
					imgPopularArtwork.PostBackUrl = "~/Customer/Artwork.aspx?artID=" + mostPopularArtID;

					//name
					linkArtworkName.NavigateUrl = "~/Customer/Artwork.aspx?artID=" + mostPopularArtID;
					linkArtworkName.Text = getArtworkName(mostPopularArtID);
				}
				//if there are no artwork in order list at all
				else
				{
					imgPopularArtwork.Visible = false;
					linkArtworkName.Visible = false;
					lblAltText.Visible = true;
				}
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}

		protected String getMostPopularArtworkID()
		{
			String artworkID = "";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String getPopularArtwork = "SELECT " +
					"TOP(1) artworkID " +
					"FROM OrderList " +
					"GROUP BY artworkID " +
					"ORDER BY SUM(orderQuantity) DESC";

				SqlCommand selectPopularArtwork = new SqlCommand(getPopularArtwork, con);

				con.Open();
				object popularArtID = selectPopularArtwork.ExecuteScalar();
				con.Close();

				if (popularArtID != null)
				{
					artworkID = popularArtID.ToString();
				}
				else
				{
					artworkID = "";
				}

			}
			return artworkID;

		}

		protected String getImagePath(String artID)
		{
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

		protected String getArtworkName(String artID)
		{
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