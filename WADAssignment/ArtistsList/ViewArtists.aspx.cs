using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class ViewArtists : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{

			#region search result
			if (Request.QueryString["search"] != null)
			{
				String searchQuery = Request.QueryString["search"];
				lblResults.Text = "Displaying result(s) for \"" + searchQuery + "\"";

				using (SqlConnection con = new SqlConnection(connectionString))
				{
					SqlCommand searchArtist = new SqlCommand("" +
						"SELECT " +
						"M.Email, M.UserName, A.artistID " +
						"FROM " +
						"vw_aspnet_MembershipUsers M, Artist A " +
						"WHERE " +
						"(A.artistUsername = M.UserName)" +
						"AND " +
						"( UPPER(A.artistUsername) LIKE @query )", con);

					searchArtist.Parameters.AddWithValue("@query", "%" + searchQuery.ToUpper() + "%");

					con.Open();
					SqlDataReader searchResult = searchArtist.ExecuteReader();
					gvArtistList.DataSource = searchResult;
					gvArtistList.DataBind();
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
					SqlCommand searchArtist = new SqlCommand("SELECT " +
					"M.Email, M.UserName, A.artistID " +
					"FROM vw_aspnet_MembershipUsers M, Artist A " +
					"WHERE " +
					"(A.artistUsername  = M.UserName)", con);

					con.Open();
					SqlDataReader artDisplay = searchArtist.ExecuteReader();
					gvArtistList.DataSource = artDisplay;
					gvArtistList.DataBind();
					con.Close();
				}


			}
			#endregion


		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			String searchQuery = txtSearch.Text;
			if (searchQuery != "")
			{
				Response.Redirect("~/ArtistsList/ViewArtists.aspx?search=" + searchQuery);
			}
			else
			{
				Response.Redirect("~/ArtistsList/ViewArtists.aspx");
			}
		}

		protected void btnClear_Click(object sender, EventArgs e)
		{
			txtSearch.Text = "";
			Response.Redirect("~/ArtistsList/ViewArtists.aspx");
		}
	}
}