using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class PopularArtwork : System.Web.UI.UserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				lblAltText.Visible = false;

				//if there is a popular artwork
				if (getMostPopularArtworkID() != "")
				{

				}
				//if there are no artwork in order list at all
				else
				{
					imgPopularArtwork.Visible = false;
					lblAltText.Visible = true;
				}
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}

		protected String getMostPopularArtworkID()
		{
			String artworkID = "";

			
			return artworkID;
		}


	}
}