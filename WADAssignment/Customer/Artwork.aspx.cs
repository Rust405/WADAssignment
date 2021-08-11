using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class Artwork : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{

			if (Request.QueryString["artID"] != null)
			{
				if (Session["userType"].ToString() == "Customer")
				{
					imgArtwork.ImageUrl = getImagePath();
					Page.Title = "Artwork | " + Request.QueryString["artName"];

					//check if artwork is in wishlist
					using (SqlConnection con = new SqlConnection(connectionString))
					{
						String checkWishlist = "SELECT " +
							"artworkID " +
							"FROM " +
							"Wishlist " +
							"WHERE " +
							"(artworkID = '" + Request.QueryString["artID"] + "') " +
							"AND " +
							"(customerID = '" + Session["customerID"] + "')";

						SqlCommand checkWishlistDB = new SqlCommand(checkWishlist, con);

						con.Open();
						object wishlist = checkWishlistDB.ExecuteScalar();
						con.Close();

						//if  wishlist contains artworkID
						if (wishlist != null)
						{
							lbWishlist.ForeColor = System.Drawing.Color.Red;
							lbWishlist.ToolTip = "Remove from Wishlist";
						}
						else
						{
							lbWishlist.ForeColor = System.Drawing.Color.Gray;
							lbWishlist.ToolTip = "Add to Wishlist";
						}

					}

				}
				else
				{
					Response.Redirect("~/Error/UnauthorizedUser.aspx");
				}
			}
			else
			{
				//user requested Artwork page without query string
				Response.Redirect("~/Customer/Gallery.aspx");
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

		protected void btnAddToCart_Click(object sender, EventArgs e)
		{
			String customerID = Session["customerID"].ToString();
			String artworkID = Request.QueryString["artID"];
			int orderQuantity = Int32.Parse(txtOrderQuantity.Text);

			//validate quantity


			//insert into cart table
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//add user to cart table
				SqlCommand cmd = new SqlCommand("INSERT INTO CART(customerID, artworkID, orderQuantity) VALUES(@customerID, @artworkID, @orderQuantity) ", con);

				cmd.Parameters.Add("@customerID", SqlDbType.VarChar).Value = customerID;
				cmd.Parameters.Add("@artworkID", SqlDbType.VarChar).Value = artworkID;
				cmd.Parameters.Add("@orderQuantity", SqlDbType.Int).Value = orderQuantity;

				con.Open();
				cmd.ExecuteNonQuery();
				con.Close();

			}

			//remove from wishlist if item is in wishlist
			if(lbWishlist.ForeColor == System.Drawing.Color.Red)
			{
				removeFromWishlist();
				lbWishlist.ForeColor = System.Drawing.Color.Gray;
				lbWishlist.ToolTip = "Add to Wishlist";

			}


			//message
			string script = "alert(\"" + Request.QueryString["artName"] + " added to cart!\");";
			ScriptManager.RegisterStartupScript(this, GetType(),
								  "ServerControlScript", script, true);
		}

		protected void lbWishlist_Click(object sender, EventArgs e)
		{
			String artID = Request.QueryString["artID"];

			//if artwork is not in wishlist
			if (lbWishlist.ForeColor == System.Drawing.Color.Gray)
			{
				String originalPrice = "";
				//get current price
				using (SqlConnection con = new SqlConnection(connectionString))
				{
					SqlCommand cmd = new SqlCommand("SELECT " +
						"artworkPrice " +
						"FROM " +
						"Artwork " +
						"WHERE " +
						"(artworkID = '" + artID + "')", con);

					con.Open();
					originalPrice = cmd.ExecuteScalar().ToString();
					con.Close();
				}

				//add to wishlist
				using (SqlConnection con = new SqlConnection(connectionString))
				{
					SqlCommand cmd = new SqlCommand("INSERT " +
						"INTO " +
						"Wishlist" +
						"(customerID, artworkID, originalArtworkPRice) " +
						"VALUES( " +
						 Session["customerID"] + ", " +
						 artID + ", " +
							originalPrice +
						" )", con);

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();
				}
				Response.Redirect("~/Customer/Artwork.aspx?artID=" + artID + "&artName=" + Request.QueryString["artName"]);
			}
			else
			{
				removeFromWishlist();
				Response.Redirect("~/Customer/Artwork.aspx?artID=" + artID + "&artName=" + Request.QueryString["artName"]);
			}
		}

		protected void removeFromWishlist()
		{
			String artID = Request.QueryString["artID"];
			//remove from wishlist
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				SqlCommand cmd = new SqlCommand("DELETE FROM Wishlist WHERE " +
					"(artworkID='" + artID + "') " +
					"AND " +
					"(customerID='" + Session["customerID"] + "')", con);

				con.Open();
				cmd.ExecuteNonQuery();
				con.Close();
			}
		}
	}
}