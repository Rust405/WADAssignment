using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Artist
{
	public partial class UpdateArtwork : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Artist")
			{
			
			}
			else
			{
				Response.Redirect("~/Error/UnauthorizedUser.aspx");
			}
		}
	}
}