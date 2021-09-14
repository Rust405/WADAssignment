using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment.Customer
{
	public partial class GenerateEmailReceipt : System.Web.UI.Page
	{

		private String date = DateTime.Now.ToString("dd-MM-yyyy");

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				//if arrived here with a receipt
				if (Session["Receipt"] != null && Request.QueryString["orderID"] != null)
				{
					//message
					lblOrderID.Text = Request.QueryString["orderID"];

					//get user email address
					String emailAddress = Membership.GetUser().Email;

					//send email
					try
					{
						using (MailMessage email = new MailMessage())
						{
							email.From = new MailAddress("moonlight3arts@gmail.com");

							//to address
							email.To.Add(emailAddress);

							//subject
							email.Subject = "Receipt for " + date;

							//body
							email.AlternateViews.Add(emailBody());

							email.IsBodyHtml = true;

							using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
							{
								smtp.Credentials = new System.Net.NetworkCredential("moonlight3arts@gmail.com", "Moonlight3Arts@");
								smtp.EnableSsl = true;
								smtp.Send(email);
							}
						}
						//redirect to thank you page
						Response.Redirect("/Customer/ThankYou.aspx");
					}
					catch (Exception ex)
					{
						System.Diagnostics.Debug.WriteLine(ex.Message);
					}

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

		//email body
		protected AlternateView emailBody()
		{
			String str = "";
			String orderID = Request.QueryString["orderID"];
			String deliveryAddress = Session["Receipt|DeliveryAddress"].ToString();
			List<String> orderedArtworkNameList = (List<String>)Session["Receipt|artworkNameList"];
			List<String> orderedArtworkImagePathList = (List<String>)Session["Receipt|artworkImagePathList"];
			List<String> orderedArtworkOrderQuantityList = (List<String>)Session["Receipt|orderQuantityList"];
			List<String> orderedArtworkPurchasePriceList = (List<String>)Session["Receipt|purchasePriceList"];

			//header
			str += "<h1 style=\"text-align:center\">Moonlight 3 Arts</h1>" +
				"<h2 style=\"text-align:center\"> Receipt dated " + date + " </h2>" +
				"<h3 style=\"text-align:left;margin-left:10%\">Delivery Address: " + deliveryAddress + "</h3>";

			//table
			str += "<table style=\"width:80%;margin-left:10%;margin-right:10%;border: 1px solid black;border-collapse:collapse\">";
			str += "<tr style=\"border: 1px solid black;\"><th colspan=\"5\" style=\"border: 1px solid black;text-align:center\">Order ID: " + orderID + "</th></tr>";

			//create list of images
			List<LinkedResource> image = new List<LinkedResource>();

			for (int i = 0; i < orderedArtworkImagePathList.Count; i++)
			{
				image.Add(new LinkedResource(Server.MapPath(orderedArtworkImagePathList[i]), MediaTypeNames.Image.Jpeg));
				image[i].ContentId = "Artwork" + i;
			}

			//table header
			str += "<tr style=\"border: 1px solid black;\">" +
				"<th></th>" +
				"<th style=\"border: 1px solid black;\">Artwork Name</th>" +
				"<th style=\"border: 1px solid black;\">Order Quantity</th>" +
				"<th style=\"border: 1px solid black;\">Purchase Price (RM) </th>" +
				"<th style=\"border: 1px solid black;\">Subtotal(RM)</th>" +
				"</tr>";

			double total = 0.00;

			for (int i = 0; i < orderedArtworkNameList.Count; i++)
			{
				str += "<tr style=\"border: 1px solid black;\">";

				//artwork image
				str += "<td style=\"border: 1px solid black;text-align:center\"><img src=cid:Artwork" + i + " width='100px' height='100px'/></td>";

				//artwork name
				str += "<td style=\"border: 1px solid black;text-align:center\">" + orderedArtworkNameList[i] + "</td>";

				//order quantity
				str += "<td style=\"border: 1px solid black;text-align:center\">" + orderedArtworkOrderQuantityList[i] + "</td>";

				//purchase price
				str += "<td style=\"border: 1px solid black;text-align:center\">" + String.Format("{0:#.00}", orderedArtworkPurchasePriceList[i]) + "</td>";

				//subtotal
				double subtotal = Double.Parse(orderedArtworkPurchasePriceList[i]) * Int32.Parse(orderedArtworkOrderQuantityList[i]);
				str += "<td style=\"border: 1px solid black;text-align:center\">" + String.Format("{0:#.00}", subtotal) + "</td>";


				str += "</tr>";

				total += subtotal;
			}

			//total
			str += "<tr style=\"border: 1px solid black;\">" +
				"<td style=\"border: 1px solid black;text-align:center\" colspan=\"4\"><b>Total (RM)</b></td>" +
				"<td style=\"border: 1px solid black;text-align:center\" ><b>" + String.Format("{0:#.00}", total) + "</b></td>" +
				"</tr>";

			str += "</table>";

			AlternateView AV =
			AlternateView.CreateAlternateViewFromString(str, null, MediaTypeNames.Text.Html);

			//attach/embed image
			for (int i = 0; i < image.Count; i++)
			{
				AV.LinkedResources.Add(image[i]);
			}

			return AV;
		}
	}
}