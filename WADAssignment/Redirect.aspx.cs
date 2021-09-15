using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment
{
	public partial class Redirect : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			//this page is for redirecting users to respective modules depending on user type
			String userName = Membership.GetUser().UserName;

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//1. search customer and artist db tables for logged in username
				String searchArtist = "SELECT artistID FROM Artist WHERE artistUsername = @artistUsername ";
				String searchCustomer = "SELECT customerID FROM Customer WHERE customerUsername = @customerUsername ";

				SqlCommand selectArtist = new SqlCommand(searchArtist, con);
				SqlCommand selectCustomer = new SqlCommand(searchCustomer, con);
				selectArtist.Parameters.AddWithValue("@artistUsername", userName);
				selectCustomer.Parameters.AddWithValue("@customerUsername", userName);

				con.Open();
				object artist = selectArtist.ExecuteScalar();
				object customer = selectCustomer.ExecuteScalar();
				con.Close();

				//2. if user is artist, set a session/cookie for user type and ID, to hide/show elements
				//3. redirect to Artist or Customer /Gallery.aspx
				if (artist != null)
				{
					Session["userType"] = "Artist";
					Session["artistID"] = artist.ToString(); //ID
					Response.Redirect("~/Artist/Gallery.aspx");
				}
				else if (customer != null)
				{
					Session["userType"] = "Customer";
					Session["customerID"] = customer.ToString(); //ID
					Response.Redirect("~/Customer/Gallery.aspx");
				}

			}
		}
	}
}