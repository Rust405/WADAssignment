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
	public partial class Gallery : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Artist")
			{
				String userName = Membership.GetUser().UserName;
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
							"artworkName, artworkImagePath, artworkPrice, artworkID, artworkListStatus " +
							"FROM Artwork " +
							"WHERE " +
							"( artistID = '" + Session["artistID"] + "' ) " +
							"AND " +
							"( UPPER(artworkName) LIKE @query )";

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
						lblPost.Visible = false;
						hlPost.Visible = false;
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
							"artworkName, artworkImagePath, artworkPrice, artworkID, artworkListStatus " +
							"FROM " +
							"Artwork " +
							"WHERE " +
							"artistID = '" + Session["artistID"] + "' " +
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
						lblPost.Visible = true;
						hlPost.Visible = true;
						btnClear.Visible = false;
						btnSearch.Visible = false;
						txtSearch.Visible = false;
						lblPost.Text = "Seems lonely here... Why don't you try ";
					}
					else if (dlArtistGallery.Items.Count > 0)
					{
						btnClear.Visible = true;
						btnSearch.Visible = true;
						txtSearch.Visible = true;
						lblPost.Visible = false;
						hlPost.Visible = false;
					}
				}
				#endregion

			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}

		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			String searchQuery = txtSearch.Text;
			if (searchQuery != "")
			{
				Response.Redirect("~/Artist/Gallery.aspx?search=" + searchQuery);
			}
			else
			{
				Response.Redirect("~/Artist/Gallery.aspx");
			}
		}

		protected void btnClear_Click(object sender, EventArgs e)
		{
			txtSearch.Text = "";
			Response.Redirect("~/Artist/Gallery.aspx");
		}

		protected string checkListed(object artworkName, object artworkListStatus)
		{
			if (artworkName == null || artworkListStatus == null)
			{
				return "";
			}
			else
			{
				if (artworkListStatus.ToString() == "Unlisted")
				{
					return "<span style=\"color:lightgray\">(Unlisted) " + artworkName + "</span>";
				}
				else
				{
					return artworkName + "";
				}

			}
		}


	}
}