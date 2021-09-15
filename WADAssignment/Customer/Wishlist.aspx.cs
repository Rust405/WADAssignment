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
	public partial class Wishlist : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				//empty wishlist
				if (dlWishlist.Items.Count == 0)
				{
					lblEmptyWishlist.Visible = true;
					lblEmptyWishlist.Text = "Your wishlist is currently empty.";
				}
				else
				{
					lblEmptyWishlist.Visible = false;
				}


				//remove from wishlist
				if (Request.QueryString["wishlistID"] != null)
				{
					if (!isWishlistIDValid())
					{
						Response.Redirect("~/Error/InvalidWishlistID.aspx");
					}

					String wishlistID = Request.QueryString["wishlistID"];

					using (SqlConnection con = new SqlConnection(connectionString))
					{
						SqlCommand cmd = new SqlCommand("DELETE FROM Wishlist WHERE " +
							"(wishlistID='" + wishlistID + "')", con);
						con.Open();
						cmd.ExecuteNonQuery();
						con.Close();
					}
					Response.Redirect("~/Customer/Wishlist.aspx");
				}
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}

		protected bool isWishlistIDValid()
		{
			String wishlistID = Request.QueryString["wishlistID"];
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//search artwork database for artworkID
				String findWishlistID = "SELECT wishlistID FROM Wishlist WHERE wishlistID = @wishlistID";

				SqlCommand getWishlistID = new SqlCommand(findWishlistID, con);
				getWishlistID.Parameters.AddWithValue("@wishlistID", wishlistID);

				con.Open();
				object isWishlistID = getWishlistID.ExecuteScalar();
				con.Close();

				if (isWishlistID != null)
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