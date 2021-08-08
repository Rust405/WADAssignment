using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WADAssignment
{
	public partial class RegisterCustomer : System.Web.UI.Page
	{
		public String connectionString = ConfigurationManager.ConnectionStrings["SalesAndGallery"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
		{
			String customerName = CreateUserWizard1.UserName;

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				//add user to artist table
				SqlCommand cmd = new SqlCommand("INSERT INTO Customer(customerUsername) VALUES(@customerName) ", con);

				cmd.Parameters.Add("@customerName", SqlDbType.VarChar).Value = customerName;

				con.Open();
				cmd.ExecuteNonQuery();
				con.Close();
			}
		}
	}
}