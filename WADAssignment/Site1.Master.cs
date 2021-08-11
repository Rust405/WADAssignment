using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment
{
	public partial class Site1 : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{

			String userType = Session["userType"].ToString();

			if (userType == "Artist")
			{
				btnGallery.Text = "My Gallery";
				btnGallery.PostBackUrl = "~/Artist/Gallery.aspx";
				btnOrders.Text = "Manage Orders";
				btnOrders.PostBackUrl = "~/Artist/ManageOrders.aspx";
				btnWishlist.Visible = false;
				btnProfile.PostBackUrl = "~/Artist/ArtistProfile.aspx";
				btnCP.Text = "Post Artwork";
				btnCP.PostBackUrl = "~/Artist/PostArtwork.aspx";
			}
			else if (userType == "Customer")
			{
				btnGallery.Text = "Gallery";
				btnGallery.PostBackUrl = "~/Customer/Gallery.aspx";
				btnOrders.Text = "My Orders";
				btnOrders.PostBackUrl = "~/Customer/MyOrders.aspx";
				btnWishlist.Visible = true;
				btnWishlist.PostBackUrl = "~/Customer/Wishlist.aspx";
				btnProfile.PostBackUrl = "~/Customer/CustomerProfile.aspx";
				btnCP.PostBackUrl = "~/Customer/Cart.aspx";
				btnCP.Text = "My Cart";

			}

		}

		protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
		{
			Session.Abandon();
			FormsAuthentication.SignOut();
			Response.Redirect("~/Login.aspx");
		}

	}
}