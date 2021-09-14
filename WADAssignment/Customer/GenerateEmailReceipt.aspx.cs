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

		private String date = DateTime.Now.ToString("dd-MM-yyyy");

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userType"].ToString() == "Customer")
			{
				//if arrived here with a receipt
				if (Session["Receipt|artworkNameList"] != null && Session["Receipt|artworkImagePathList"] != null && Session["Receipt|orderQuantityList"] != null && Session["Receipt|purchasePriceList"] != null && Request.QueryString["orderID"] != null)
				{
					//message
					lblOrderID.Text = Request.QueryString["orderID"];

					//get user email address
					String emailAddress = "russelllct-sm19@student.tarc.edu.my";

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
							email.Body = "";
							email.AlternateViews.Add(emailBody());

							email.IsBodyHtml = true;

							using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
							{
								smtp.Credentials = new System.Net.NetworkCredential("moonlight3arts@gmail.com", "Moonlight3Arts@");
								smtp.EnableSsl = true;
								smtp.Send(email);
							}
						}
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
					}


					//redirect to thank you page
					Console.WriteLine("Sent!");

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
			List<String> orderedArtworkNameList = (List<String>)Session["Receipt|artworkNameList"];
			List<String> orderedArtworkImagePathList = (List<String>)Session["Receipt|artworkImagePathList"];
			List<String> orderedArtworkOrderQuantityList = (List<String>)Session["Receipt|orderQuantityList"];
			List<String> orderedArtworkPurchasePriceList = (List<String>)Session["Receipt|purchasePriceList"];

			//header
			str += "<h1>Moonlight 3 Arts</h1>";
			str += "<h2>Receipt dated " + date + "</h2>";

			//table
			str += "<table>";
			str += "<tr><td colspan=\"4\" style=\"text-align:center\">Order ID: " + orderID + "</td></tr>";

			//create list of images
			List<LinkedResource> image = new List<LinkedResource>();

			for (int i = 0; i < orderedArtworkImagePathList.Count; i++)
			{
				image.Add(new LinkedResource(orderedArtworkImagePathList[i], MediaTypeNames.Image.Jpeg));
				image[i].ContentId = "Artwork" + i;
			}

			//table header
			str += "<tr>" +
				"<th></th>" +
				"<th>Artwork Name</th>" +
				"<th>Order Quantity</th>" +
				"<th>Purchase Price (RM) </th>" +
				"<th>Subtotal(RM)</th>" +
				"</tr>";

			double total = 0.00;

			for (int i = 0; i < orderedArtworkNameList.Count; i++)
			{
				str += "<tr>";

				//artwork image
				str += "<td><img src=cid:Artwork" + i + " width='64px' height='64px'/></td>";

				//artwork name
				str += "<td>" + orderedArtworkNameList[i] + "</td>";

				//order quantity
				str += "<td>" + orderedArtworkOrderQuantityList[i] + "</td>";

				//purchase price
				str += "<td>" + orderedArtworkPurchasePriceList[i] + "</td>";

				//subtotal
				double subtotal = Double.Parse(orderedArtworkPurchasePriceList[i]) * Int32.Parse(orderedArtworkOrderQuantityList[i]);
				str += "<td>" + String.Format("{0:#.00}", subtotal) + "</td>";
				str += "</tr>";

				total += subtotal;
			}

			//total
			str += "<tr>" +
				"<td colspan=\"4\">Total</td>" +
				"<td>" + String.Format("{0:#.00}", total) + "</td>" +
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