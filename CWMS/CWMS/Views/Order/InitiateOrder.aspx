<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	InitiateOrder
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
              
        <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">สั่งงาน</h1>
          <div class="contactform">
            <% using (Ajax.BeginForm("CheckRegistrationNumber",new AjaxOptions {
                   HttpMethod = "Post",
                   UpdateTargetId = "cardetails",
                   LoadingElementId = "indicator"
               })) 
                { %>
                  <fieldset><legend>&nbsp;ค้นหาทะเบียนรถ&nbsp;</legend>
                    <p><label class="left">ทะเบียนรถ:</label>
                       <%: Html.TextBox("registrationNumber", null, new { @class = "field" }) %> 
                       <%= Ajax.ActionLink("ขายโดยไม่ใช้ทะเบียนรถ","ShowProductList",new AjaxOptions
                           {
                               HttpMethod = "Get",
                               UpdateTargetId = "productlist",
                               LoadingElementId = "indicator"
                           }) %>
                       </p>
                    <p><input type="submit" name="submit" id="submit1" class="button" value="ตรวจสอบ" tabindex="1" /></p>

                  </fieldset>
              <%} %>
              <div id="cardetails"></div>
          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>
        
        <div id="productlist">
       
        </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
    <div id="shoppingcart"><% Html.RenderPartial("_ShoppingCart"); %></div>
</asp:Content>
