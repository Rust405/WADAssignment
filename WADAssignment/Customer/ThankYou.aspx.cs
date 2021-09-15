using System;
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
	public partial class ThankYou : System.Web.UI.Page
	{
		private String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;
		double total = 0.00;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{

				//if arrived here with a receipt
				if (Session["Receipt"] != null && Request.QueryString["orderID"] != null)
				{

					if (!isOrderIDValid())
					{
						Response.Redirect("~/Error/InvalidOrderID.aspx");
					}

					//display purchase summary
					lblThankYou.Text = "Thank you for your purchase " +
						"(Order ID: "+ Request.QueryString["orderID"]+ ")!<br /> " +
						"A receipt has been emailed to you at "+ Membership.GetUser().Email;

					//delete receipt session variables
					Session["Receipt"] = null;
					Session["Receipt|artworkNameList"] = null;
					Session["Receipt|DeliveryAddress"] = null;
					Session["Receipt|artworkImagePathList"] = null;
					Session["Receipt|orderQuantityList"] = null;
					Session["Receipt|purchasePriceList"] = null;

				}
				//user called this page without a receipt
				else
				{
					Response.Redirect("/Customer/Gallery.aspx");
				}



			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}



		}

		//calculate and display total
		protected void gvOD_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				total += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Subtotal"));
			}
			else if (e.Row.RowType == DataControlRowType.Footer)
			{
				e.Row.Cells[3].Text = "Total(RM): ";
				e.Row.Cells[4].Text = String.Format("{0:0.00}", total);
			}

		}

		protected bool isOrderIDValid()
		{
			String orderID = Request.QueryString["orderID"];
			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//search artwork database for artworkID
				String findOrderID = "SELECT orderID FROM Orders WHERE orderID = @orderID";

				SqlCommand getOrderID = new SqlCommand(findOrderID, con);
				getOrderID.Parameters.AddWithValue("@orderID", orderID);

				con.Open();
				object isOrderID = getOrderID.ExecuteScalar();
				con.Close();

				if (isOrderID != null)
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