using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.ArtistsList
{
	public partial class ArtistGallery : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString["artistID"] != null)
			{

				if (!isArtistIDValid())
				{
					Response.Redirect("~/Error/InvalidArtistID.aspx");
				}

				String artistID = Request.QueryString["artistID"];

				//get artist username
				String userName;
				using (SqlConnection con = new SqlConnection(connectionString))
				{

					SqlCommand selectArtistUsername = new SqlCommand("SELECT " +
						"artistUsername " +
						"FROM Artist " +
						"WHERE " +
						"artistID='" + artistID + "' ", con);

					con.Open();
					object result = selectArtistUsername.ExecuteScalar();
					con.Close();
					userName = result.ToString();
				}

				lblGallery.Text = userName + "'s Gallery";
				Page.Title = userName + "'s Gallery";

				#region search result
				if (Request.QueryString["search"] != null)
				{
					String searchQuery = Request.QueryString["search"];
					lblResults.Text = "Displaying result(s) for \"" + searchQuery + "\"";

					using (SqlConnection con = new SqlConnection(connectionString))
					{
						String selectArt = "" +
							"SELECT " +
							"artworkName, artworkImagePath, artworkPrice, artworkID " +
							"FROM Artwork " +
							"WHERE " +
							"( artistID = '" + artistID + "' ) " +
							"AND " +
							"( UPPER(artworkName) LIKE @query ) " +
							"AND " +
							"artworkListStatus = 'Listed'";

						SqlCommand searchArt = new SqlCommand(selectArt, con);
						searchArt.Parameters.AddWithValue("@query", "%" + searchQuery.ToUpper() + "%");

						con.Open();
						SqlDataReader searchResult = searchArt.ExecuteReader();
						dlArtistGallery.DataSource = searchResult;
						dlArtistGallery.DataBind();
						//no results
						if (!searchResult.HasRows)
						{
							lblResults.Text = "No result(s) matching the query \"" + searchQuery + "\".";
						}
						con.Close();
					}

				}
				#endregion

				#region default result
				else
				{
					lblResults.Visible = false;
					using (SqlConnection con = new SqlConnection(connectionString))
					{
						String selectArt = "SELECT " +
							"artworkName, artworkImagePath, artworkPrice, artworkID " +
							"FROM " +
							"Artwork " +
							"WHERE " +
							"artistID = '" + artistID + "' " +
							"AND " +
							"artworkListStatus = 'Listed'" +
							"ORDER BY artworkID DESC";

						SqlCommand getArt = new SqlCommand(selectArt, con);

						con.Open();
						SqlDataReader artDisplay = getArt.ExecuteReader();
						dlArtistGallery.DataSource = artDisplay;
						dlArtistGallery.DataBind();
						con.Close();
					}

					//if empty artist gallery
					if (dlArtistGallery.Items.Count == 0)
					{
						lblResults.Visible = true;
						lblResults.Text = "This artist has no artwork posted or listed.";
						btnClear.Visible = false;
						btnSearch.Visible = false;
						txtSearch.Visible = false;
					}
					else if (dlArtistGallery.Items.Count > 0)
					{
						btnClear.Visible = true;
						btnSearch.Visible = true;
						txtSearch.Visible = true;

					}
				}
				#endregion

			}
			else
			{
				//user requested ArtistGallery page without query string
				Response.Redirect("~/ArtistsList/ViewArtists.aspx");
			}
		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			String searchQuery = txtSearch.Text;
			String artistID = Request.QueryString["artistID"];
			if (searchQuery != "")
			{
				Response.Redirect("~/ArtistsList/ArtistGallery.aspx?artistID=" + artistID + " &search=" + searchQuery);
			}
			else
			{
				Response.Redirect("~/ArtistsList/ArtistGallery.aspx?artistID=" + artistID);
			}
		}

		protected void btnClear_Click(object sender, EventArgs e)
		{
			String artistID = Request.QueryString["artistID"];
			txtSearch.Text = "";
			Response.Redirect("~/ArtistsList/ArtistGallery.aspx?artistID=" + artistID);
		}

		protected bool isArtistIDValid()
		{
			String artistID = Request.QueryString["artistID"];

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//search artist database for artistID
				String findArtistID = "SELECT artistID FROM Artist WHERE artistID = @artistID";

				SqlCommand getArtistID = new SqlCommand(findArtistID, con);
				getArtistID.Parameters.AddWithValue("@artistID", artistID);

				con.Open();
				object artworkID = getArtistID.ExecuteScalar();
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

	}
}