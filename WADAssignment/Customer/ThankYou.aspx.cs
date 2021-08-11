using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class ThankYou : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				if (Request.QueryString["orderID"] != null)
				{
					
					String orderID = Request.QueryString["orderID"];
					string orderDate = DateTime.Now.ToString("dd-MM-yyyy");
					lblThankYou.Text = "" +
						"Thank you for your order (Order ID: " + orderID + ") on " + orderDate + "!"
						+ "<br />" +
						"<a style=\"font-size:medium\">You will receive your order within 8-10 business days.</a>";

				}
				else
				{
					//on the chance some smart %@# calls this page from the address bar
					Response.Redirect("~/Customer/Gallery.aspx");
				}
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}



		}
	}
}