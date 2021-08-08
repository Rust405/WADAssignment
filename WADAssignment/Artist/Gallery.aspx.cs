using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class Gallery : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Artist")
			{
				String userName = Membership.GetUser().UserName;
				lblGallery.Text = userName + "'s Gallery";
				Page.Title = userName + "'s Gallery";
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}

		}
	}
}