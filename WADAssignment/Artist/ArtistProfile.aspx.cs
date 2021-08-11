using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class ArtistProfile : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Artist")
			{
				Page.Title = "My Profile | " + Membership.GetUser().UserName;
				lblProfile.Text = "My Profile | " + Membership.GetUser().UserName;
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}

	
	}
}