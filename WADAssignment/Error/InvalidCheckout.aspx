<%@ Page title="Invalid Checkout" Language="C#" MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="InvalidCheckout.aspx.cs" Inherits="WADAssignment.Error.InvalidCheckout" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="Server">
    <link href="../css/ErrorCss.css" rel="stylesheet"/>
      <div>
            <br />
               <img src="../images/invalid_checkout.png" alt="invalidCheckout" class="invalidCheckout"/>
               <h2>Error: Invalid Checkout!</h2>
               <h3>Please make sure you use the "Proceed to Checkout" button to check out.</h3>
        </div>
</asp:Content>
