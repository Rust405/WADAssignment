using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class Checkout : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;
		private int currentYear = DateTime.Now.Year - 2000;
		private int currentMonth = DateTime.Now.Month;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				//if user calls this page directly
				if (Session["Checkout"] == null)
				{
					Response.Redirect("~/Error/InvalidCheckout.aspx");
				}

				String userName = Membership.GetUser().UserName;
				String userEmail = Membership.GetUser().Email;

				lblName.Text = userName;
				lblEmail.Text = userEmail;

				//populate card expiry date
				for (int i = 1; i <= 12; i++)
				{
					if (i < 10)
					{
						ddlExpiryMonth.Items.Add(new ListItem("0" + i, "0" + i));
					}
					else
					{
						ddlExpiryMonth.Items.Add(new ListItem(i + "", i + ""));
					}

				}

				for (int i = currentYear; i <= 99; i++)
				{
					ddlExpiryYear.Items.Add(new ListItem(i + ""));
				}

			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}


		}

		//checkout
		protected void btnCheckout_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{
				//get variables
				String customerID = Session["customerID"].ToString();
				String deliveryAddress = txtAddress.Text;
				String cardType = rblCardType.Text;
				String cardNumber = txtCardNumber.Text;

				String orderDate = DateTime.Now.ToString("dd-MM-yyyyHHmmss");
				String orderID = "";


				//receipt/purchase summary variables 
				List<String> orderedArtworkIDList = new List<String>();
				List<String> orderedArtworkOrderQuantityList = new List<String>();
				List<String> orderedArtworkPurchasePriceList = new List<String>();


				//if everything ok commit order
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
						"Payment(orderID, cardType, cardNumber ) " +
						"VALUES " +
						"( " +
						"'" + orderID + "', " +
						"'" + cardType + "', " +
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
							"(artworkID = '" + artworkID + "' )", con);
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


						#region update artworkStock command
						SqlCommand updateArtworkStock = new SqlCommand("" +
							"UPDATE " +
							"Artwork " +
							"SET " +
							"artworkStock = artworkStock - " + orderQuantity + " " +
							"WHERE " +
							"(artworkID = " + artworkID + ")"
							, con);
						#endregion
						updateArtworkStock.ExecuteNonQuery();

						#region add to receipt list
						orderedArtworkIDList.Add(artworkID);
						orderedArtworkOrderQuantityList.Add(orderQuantity);
						orderedArtworkPurchasePriceList.Add(purchasePrice);
						#endregion

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

					//destroy Checkout session variable to deny next order from accessing Checkout page directly
					Session["Checkout"] = null;

					//add receipt variables to session
					Session["Receipt|artworkIDList"] = orderedArtworkIDList;
					Session["Receipt|orderQuantityList"] = orderedArtworkOrderQuantityList;
					Session["Receipt|purchasePriceList"] = orderedArtworkPurchasePriceList;

					//generate email receipt
					Response.Redirect("~/Customer/GenerateEmailReceipt.aspx?orderID=" + orderID);
				}
			}
		}

		protected void cvExpiryMonth_ServerValidate(object source, ServerValidateEventArgs args)
		{
			//if selected year is current year
			if (currentYear == Int32.Parse(ddlExpiryYear.SelectedValue))
			{
				if (Int32.Parse(args.Value) < currentMonth)
				{
					args.IsValid = false;
				}
				else
				{
					args.IsValid = true;
				}
			}
			else
			{
				args.IsValid = true;
			}

		}

		protected void rblCardType_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (rblCardType.SelectedIndex == 0)
			{
				regexCard.ValidationExpression = "^4[0-9]{12}(?:[0-9]{3})?$";
			}
			else
			{
				regexCard.ValidationExpression = "^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$";
			}

		}

	}
}