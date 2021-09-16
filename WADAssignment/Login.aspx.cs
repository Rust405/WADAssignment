using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment
{
	public partial class LoginCustomer : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

			//code to remove returnUrl so user always goes Login.aspx -> Redirect.aspx if redirected here
			HttpContext context = HttpContext.Current;
			if (!context.User.Identity.IsAuthenticated)
			{
				if (context.Request.Url.ToString().Contains("ReturnUrl"))
				{
					HttpContext.Current.Response.Redirect("~/Login.aspx");
				}

			}
		}
	}
}