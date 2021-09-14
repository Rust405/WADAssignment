using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net.Mime;
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
				if (Session["Receipt|artworkIDList"] != null && Session["Receipt|orderQuantityList"] != null && Session["Receipt|purchasePriceList"] != null && Request.QueryString["orderID"] != null)
				{
					//message
					lblOrderID.Text = Request.QueryString["orderID"];

					//send email
					try
					{
						using (MailMessage email = new MailMessage())
						{
							//email.From = new MailAddress("moonlight3arts@gmail.com");

							//to address
							//email.To.Add("russelllct-sm19@student.tarc.edu.my");

							//body
							//email.AlternateViews.Add(emailBody());

							//subject
							//email.Subject = "Yeet";

							//email.Body = "" +
							//	"<h1>Can you believe this email wasn't taken lol?</h1>" +
							//	"<img width=\"48px\" height=\"48px\" src=\"\" />";
							//email.IsBodyHtml = true;

							//using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
							//{
							//	smtp.Credentials = new System.Net.NetworkCredential("moonlight3arts@gmail.com", "Moonlight3Arts@");
							//	smtp.EnableSsl = true;
							//	smtp.Send(email);
							//}
						}
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
					}


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

		protected AlternateView emailBody()
		{
			String orderID = Request.QueryString["orderID"];
			List<String> orderedArtworkIDList = (List<String>)Session["Receipt|artworkIDList"];
			List<String> orderedArtworkOrderQuantityList = (List<String>)Session["Receipt|orderQuantityList"];
			List<String> orderedArtworkPurchasePriceList = (List<String>)Session["Receipt|purchasePriceList"];

			//create list of artwork names

			//create list of paths


			//template
			List<String> path = new List<String>();
			path.Add(Server.MapPath(@"~/Artwork/Autumn140921015633.jpg"));
			path.Add(Server.MapPath(@"~/Artwork/Purple City140921015736.jpg"));

			List<LinkedResource> image = new List<LinkedResource>();

			for (int i = 0; i < path.Count; i++)
			{
				image.Add(new LinkedResource(path[i], MediaTypeNames.Image.Jpeg));
				image[i].ContentId = "Artwork" + i;
			}

			string str = "";

			str += "<h1>Can you believe this email was not taken lol?</h1>";

			for (int i = 0; i < image.Count; i++)
			{
				str += "<img src=cid:Artwork" + i + " width='64px' height='64px'/>";
			}

			AlternateView AV =
			AlternateView.CreateAlternateViewFromString(str, null, MediaTypeNames.Text.Html);

			for (int i = 0; i < image.Count; i++)
			{
				AV.LinkedResources.Add(image[i]);
			}
			return AV;
		}
	}
}