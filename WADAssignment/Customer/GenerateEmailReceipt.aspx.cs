using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class GenerateEmailReceipt : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				//if arrived here with a receipt
				if (Session["Receipt"] != null)
				{
					//message
					lblOrderID.Text = "";



					//send email


					//redirect to thank you page

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
	}
}