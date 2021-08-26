﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class Checkout : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;


		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				String userName = Membership.GetUser().UserName;
				String userEmail = Membership.GetUser().Email;

				lblName.Text = userName;
				lblEmail.Text = userEmail;

			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}


		}

		//checkout
		protected void btnCheckout_Click(object sender, EventArgs e)
		{
			//get variables
			String customerID = Session["customerID"].ToString();
			String deliveryAddress = txtAddress.Text;
			String bankName = ddlBank.Text;
			String cardNumber = txtCardNumber.Text;
			String orderDate = DateTime.Now.ToString("dd-MM-yyyyHHmmss");
			String orderID;

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				#region insert into Orders command
				SqlCommand insertOrder = new SqlCommand("INSERT " +
					"INTO  " +
					"Orders(orderDate, customerID, deliveryAddress) " +
					"VALUES ( " +
					"'" + orderDate + "', " +
					customerID + ", " +
					"'" + deliveryAddress + "'" +
					" )", con);
				#endregion
				insertOrder.ExecuteNonQuery();

				#region get orderID of created order command
				SqlCommand selectOrderID = new SqlCommand("SELECT " +
					"orderID " +
					"FROM Orders " +
					"WHERE " +
					"(orderDate = '" + orderDate + "') " +
					"AND " +
					"(customerID = " + customerID + ")", con);

				#endregion
				orderID = selectOrderID.ExecuteScalar().ToString();

				#region insert into Payment command
				SqlCommand insertPayment = new SqlCommand("INSERT " +
					"INTO " +
					"Payment(orderID, bankName, cardNumber ) " +
					"VALUES " +
					"( " +
					"'" + orderID + "', " +
					"'" + bankName + "', " +
					"'" + cardNumber + "' ) ", con);
				#endregion
				insertPayment.ExecuteNonQuery();

				#region get all cartID related to order
				SqlCommand getCartIDList = new SqlCommand("SELECT " +
					"cartID " +
					"FROM " +
					"Cart " +
					"WHERE " +
					"customerID = " + customerID, con);
				#endregion
				SqlDataReader drCartIDList = getCartIDList.ExecuteReader();

				#region compile cart
				List<String> cartIDList = new List<String>();
				while (drCartIDList.Read())
				{
					//add cartID to List
					String cartID = (drCartIDList.GetInt32(drCartIDList.GetOrdinal("cartID"))).ToString();
					cartIDList.Add(cartID);
				}
				drCartIDList.Close();
				#endregion

				#region foreach cart_item in cart
				foreach (String cartID in cartIDList)
				{
					#region select artworkID
					SqlCommand selectArtworkID = new SqlCommand("SELECT " +
						"artworkID " +
						"FROM " +
						"Cart " +
						"WHERE " +
						"(cartID =  " + cartID + ")" +
						"AND " +
						"(customerId = " + customerID + ")", con);
					#endregion
					String artworkID = selectArtworkID.ExecuteScalar().ToString();

					#region select orderQuantity
					SqlCommand selectOrderQuantity = new SqlCommand("SELECT " +
						"orderQuantity " +
						"FROM " +
						"Cart " +
						"WHERE " +
						"(cartID =  " + cartID + ")" +
						"AND " +
						"(customerID = " + customerID + ")", con);
					#endregion
					String orderQuantity = selectOrderQuantity.ExecuteScalar().ToString();

					#region select purchasePrice
					SqlCommand selectPurchasePrice = new SqlCommand("" +
						"SELECT " +
						"artworkPrice " +
						"FROM " +
						"Artwork " +
						"WHERE " +
						"(artworkID = " + artworkID + ")", con);
					#endregion
					String purchasePrice = selectPurchasePrice.ExecuteScalar().ToString();

					#region insert into OrderList command
					SqlCommand insertOrderList = new SqlCommand("" +
						"INSERT INTO " +
						"OrderList(orderID, artworkID, orderStatus, orderQuantity, purchasePrice) " +
						"VALUES (" +
						"'" + orderID + "', " +
						"'" + artworkID + "', " +
						" 'Pending', " +
						"'" + orderQuantity + "', " +
						"'" + purchasePrice + "'" +
						")", con);
					#endregion
					insertOrderList.ExecuteNonQuery();

					#region select current artworkStock
					SqlCommand selectArtworkStock = new SqlCommand("" +
						"SELECT " +
						"artworkStock " +
						"FROM " +
						"Artwork " +
						"INNER JOIN " +
						"Cart " +
						"ON " +
						"(Artwork.artworkID = Cart.artworkID)" +
						"WHERE " +
						"(cartID='" + cartID + "') " +
						"AND " +
						"(customerID='" + customerID + "')", con);
					#endregion
					String artworkStock = selectArtworkStock.ExecuteScalar().ToString();

					//set new stock
					int newStock = Int32.Parse(artworkStock) - Int32.Parse(orderQuantity);

					#region update artworkStock command
					SqlCommand updateArtworkStock = new SqlCommand("" +
						"UPDATE " +
						"Artwork " +
						"SET " +
						"artworkStock = " + newStock + " " +
						"WHERE " +
						"(artworkID = " + artworkID + ")"
						, con);
					#endregion
					updateArtworkStock.ExecuteNonQuery();

				}
				#endregion

				#region Empty/Delete Cart command
				SqlCommand deleteCart = new SqlCommand("" +
					"DELETE " +
					"FROM " +
					"Cart " +
					"WHERE " +
					"(CustomerID = " + customerID + ")", con);
				#endregion
				deleteCart.ExecuteNonQuery();

				con.Close();
			}

			Response.Redirect("~/Customer/ThankYou.aspx?&orderID=" + orderID);

		}
	}
}