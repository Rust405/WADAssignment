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
	public partial class Cart : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		double total = 0.00;
		protected void Page_Load(object sender, EventArgs e)
		{

			if (Session["userType"].ToString() == "Customer")
			{

				if (Request.QueryString["cartID"] != null && Request.QueryString["act"] != null)
				{
					String cartID = Request.QueryString["cartID"];
					String act = Request.QueryString["act"];

					using (SqlConnection con = new SqlConnection(connectionString))
					{
						//get current quantity
						String getQuantity = "SELECT orderQuantity FROM Cart WHERE cartID = '" + cartID + "'";

						SqlCommand getOrderQuantity = new SqlCommand(getQuantity, con);

						con.Open();
						int orderQuantity = Int32.Parse(getOrderQuantity.ExecuteScalar().ToString());
						con.Close();

						switch (act)
						{
							case "plus":
								orderQuantity += 1;
								break;
							case "minus":
								if (orderQuantity > 1)
								{
									orderQuantity -= 1;
								}
								break;
						}

						//update quantity
						String updateQuantity = "UPDATE Cart SET orderQuantity = " + orderQuantity + " WHERE cartID = '"+ cartID + "'";
						SqlCommand update = new SqlCommand(updateQuantity, con);
						con.Open();
						update.ExecuteNonQuery();
						con.Close();
						gvCart.DataBind();

						Response.Redirect("~/Customer/Cart.aspx");
					}

				}

			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}

		//calculate and display total
		protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				total += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Subtotal"));
			}
			else if (e.Row.RowType == DataControlRowType.Footer)
			{
				e.Row.Cells[3].Text = "Total (RM): ";
				e.Row.Cells[4].Text = String.Format("{0:0.00}", total);
			}

		}

		//empty cart function
		protected void emptyCart(object sender, EventArgs e)
		{
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				String selectRecord = "DELETE FROM Cart WHERE (customerID = '" + Session["customerID"] + "')";

				SqlCommand checkForRecords = new SqlCommand(selectRecord, con);

				con.Open();
				checkForRecords.ExecuteNonQuery();
				con.Close();
				gvCart.DataBind();
				Response.Redirect("~/Customer/Cart.aspx");
			}
		}

	}

}
