using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class Gallery : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{

			if (Session["userType"].ToString() == "Customer")
			{
			
				#region search result
				if (Request.QueryString["search"] != null)
				{
					String searchQuery = Request.QueryString["search"];
					lblResults.Text = "Displaying result(s) for \"" + searchQuery + "\""; 
					
					using (SqlConnection con = new SqlConnection(connectionString))
					{
						String selectArt = "" +
							"SELECT " +
							"A.artworkName, A.artworkImagePath, A.artworkPrice, A.artworkID " +
							"FROM Artwork A, Artist B " +
							"WHERE " +
							"( A.artistID = B.artistID ) " +
							"AND " +
							"( " +
							"( UPPER(A.artworkName) LIKE @queryArtwork ) " +
							"OR " +
							"( UPPER(B.artistUsername) LIKE @queryArtist )" +
							") " +
							"AND " +
							"(A.artworkListStatus = 'Listed')";

						SqlCommand searchArt = new SqlCommand(selectArt, con);
						searchArt.Parameters.AddWithValue("@queryArtwork", "%" + searchQuery.ToUpper() + "%");
						searchArt.Parameters.AddWithValue("@queryArtist", "%" + searchQuery.ToUpper() + "%");

						con.Open();
						SqlDataReader searchResult = searchArt.ExecuteReader();
						dlCustomerGallery.DataSource = searchResult;
						dlCustomerGallery.DataBind();
						
						//no results
						if (!searchResult.HasRows)
						{
							lblResults.Text = "No result(s) matching the query \"" + searchQuery+"\".";
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
							"artworkName, " +
							"artworkImagePath, " +
							"artworkPrice, " +
							"artworkID " +
							"FROM Artwork " +
							"WHERE " +
							"(artworkListStatus = 'Listed') " +
							"ORDER BY artworkID DESC";

						SqlCommand getArt = new SqlCommand(selectArt, con);

						con.Open();
						SqlDataReader artDisplay = getArt.ExecuteReader();
						dlCustomerGallery.DataSource = artDisplay;
						dlCustomerGallery.DataBind();
						con.Close();
					}

					//if empty gallery
					if (dlCustomerGallery.Items.Count == 0)
					{
						lblPost.Visible = true;
						btnClear.Visible = false;
						btnSearch.Visible = false;
						txtSearch.Visible = false;
						//joke condition where you're the first customer but there's no artwork
						lblPost.Text = "Seems lonely here... Why don't you try becoming an artist and post an artwork yourself? ";
					}
					else if (dlCustomerGallery.Items.Count > 0)
					{
						btnClear.Visible = true;
						btnSearch.Visible = true;
						txtSearch.Visible = true;
						lblPost.Visible = false;
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
				Response.Redirect("~/Customer/Gallery.aspx?search=" + searchQuery);
			}
			else
			{
				Response.Redirect("~/Customer/Gallery.aspx");
			}
		}

		protected void btnClear_Click(object sender, EventArgs e)
		{
			txtSearch.Text = "";
			Response.Redirect("~/Customer/Gallery.aspx");
		}
	}
}