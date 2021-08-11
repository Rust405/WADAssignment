using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class OrderDetails : System.Web.UI.Page
	{

		double total = 0.00;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				if (Request.QueryString["orderID"]!=null)
				{
					
					lblOrderHead.Text = "Order ID: "+ Request.QueryString["orderID"];
				}
				else
				{
					//you know why
					Response.Redirect("~/Customer/MyOrders.aspx");
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
	}
}