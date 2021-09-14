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

				//if arrived here with a receipt
				if (Session["Receipt"] != null && Request.QueryString["orderID"] != null)
				{
					//display purchase summary

					


					//delete receipt session variables
					//Session["Receipt"] = null;
					//Session["Receipt|artworkNameList"] = null;
					//Session["Receipt|DeliveryAddress"] = null;
					//Session["Receipt|artworkImagePathList"] = null;
					//Session["Receipt|orderQuantityList"] = null;
					//Session["Receipt|purchasePriceList"] = null;

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