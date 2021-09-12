﻿using System;
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

					#region disable ordering if out of stock
					//check stock if empty
					if (dvArtwork.Rows[4].Cells[1].Text != "Out of Stock")
					{
						int stock = Int32.Parse(dvArtwork.Rows[4].Cells[1].Text);
						if (stock == 0)
						{
							dvArtwork.Rows[4].Cells[1].Text = "Out of Stock";
							//disable add to cart
							btnAddToCart.Enabled = false;
							btnAddToCart.BackColor = System.Drawing.Color.LightGray;
							//disable quantity
							txtOrderQuantity.Enabled = false;
						}
					}
					#endregion

					setValidation();
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

		protected void setValidation()
		{
			//if artwork is in cart
			if (isArtwrokInCart())
			{
				//if sotck == cartQuantity
				if (dvArtwork.Rows[4].Cells[1].Text == getQuantityFromCart().ToString())
				{
					btnAddToCart.Text = "Maximum order quantity reached.";
					//disable add to cart
					btnAddToCart.Enabled = false;
					btnAddToCart.BackColor = System.Drawing.Color.LightGray;
					//disable quantity
					txtOrderQuantity.Enabled = false;

					rvQuantity.MaximumValue = "1";
				}
				//if stock < cartQuantity
				else if(Int32.Parse(dvArtwork.Rows[4].Cells[1].Text) < getQuantityFromCart()){
					btnAddToCart.Text = "Order quantity in cart exceeded stock.";
					//disable add to cart
					btnAddToCart.Enabled = false;
					btnAddToCart.BackColor = System.Drawing.Color.LightGray;
					//disable quantity
					txtOrderQuantity.Enabled = false;

					rvQuantity.MaximumValue = "1";
				}
				else
				{
					//max quantity is stock - cartQuantity
					int max = Int32.Parse(dvArtwork.Rows[4].Cells[1].Text) - getQuantityFromCart();
					rvQuantity.MaximumValue = max.ToString();
					rvQuantity.ErrorMessage = "Order quantity can only be between 1 and " + max;
				}
			}
			//else artwork not in cart
			else
			{
				//max quantity is stock
				rvQuantity.MaximumValue = dvArtwork.Rows[4].Cells[1].Text;
				rvQuantity.ErrorMessage = "Order quantity can only be between 1 and " + dvArtwork.Rows[4].Cells[1].Text;
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

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//if artwork is not in cart
				if (!isArtwrokInCart())
				{
					//add user and artwork to cart table
					SqlCommand cmd = new SqlCommand("INSERT INTO CART(customerID, artworkID, orderQuantity) VALUES(@customerID, @artworkID, @orderQuantity) ", con);

					cmd.Parameters.Add("@customerID", SqlDbType.VarChar).Value = customerID;
					cmd.Parameters.Add("@artworkID", SqlDbType.VarChar).Value = artworkID;
					cmd.Parameters.Add("@orderQuantity", SqlDbType.Int).Value = orderQuantity;

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();

				}
				//artwork already in cart, update quantity
				else
				{
					SqlCommand cmd = new SqlCommand("" +
						"UPDATE Cart " +
						"SET orderQuantity = orderQuantity + " + orderQuantity + " " +
						"WHERE customerID = " + customerID + " " +
						"AND artworkID = " + artworkID, con);

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();
				}

			}

			//remove from wishlist if item is in wishlist
			if (lbWishlist.ForeColor == System.Drawing.Color.Red)
			{
				removeFromWishlist();
				lbWishlist.ForeColor = System.Drawing.Color.Gray;
				lbWishlist.ToolTip = "Add to Wishlist";

			}

			//message
			string script = "alert(\"" + Request.QueryString["artName"] + " added to cart!\");";
			ScriptManager.RegisterStartupScript(this, GetType(),
								  "ServerControlScript", script, true);

			txtOrderQuantity.Text = "1";
			setValidation();
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

		protected bool isArtwrokInCart()
		{
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String checkExistingArtwork = "SELECT " +
					"* " +
					"FROM " +
					"Cart " +
					"WHERE " +
					"artworkID = '" + Request.QueryString["artID"] + "' " +
					"AND " +
					"customerID = '" + Session["customerID"].ToString() + "' ";

				SqlCommand selectCart = new SqlCommand(checkExistingArtwork, con);

				con.Open();
				object existingArtwork = selectCart.ExecuteScalar();
				con.Close();

				if (existingArtwork != null)
				{
					return true;
				}
				else
				{
					return false;
				}

			}

		}

		protected int getQuantityFromCart()
		{
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String checkOrderQuantity = "SELECT " +
					"orderQuantity " +
					"FROM " +
					"Cart " +
					"WHERE " +
					"artworkID = '" + Request.QueryString["artID"] + "' " +
					"AND " +
					"customerID = '" + Session["customerID"].ToString() + "' ";

				SqlCommand selectCart = new SqlCommand(checkOrderQuantity, con);

				con.Open();
				object orderQuantity = selectCart.ExecuteScalar();
				con.Close();

				return (int)orderQuantity;
			}

		}

	}
}