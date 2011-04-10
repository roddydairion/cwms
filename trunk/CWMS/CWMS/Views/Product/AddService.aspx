<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Product>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddProduct
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">เพิ่มบริการ</h1>
          <div class="contactform">
            <% using (Html.BeginForm("AddService","Product",FormMethod.Post)){ %>
              <fieldset><legend>&nbsp;รายละบริการ&nbsp;</legend>
                <%: Html.Hidden("isService",true) %>
                <p><label for="contact_firstname_1" class="left">กลุ่ม:</label>
                    <%: Html.DropDownList("productGroupId", new SelectList((IEnumerable<CWMS.Models.ProductGroup>)ViewData["productGroups"], "Id", "Name"), "ไม่จัดกลุ่ม", new { @class = "combo" }) %></p>
                <p><label for="contact_firstname_1" class="left">ชื่อบริการ:</label>
                    <%: Html.TextBox("name","",new{@class="field"}) %></p>
                <p><label for="contact_familyname_1" class="left">หน่วย:</label>
                    <%: Html.TextBox("unit","",new{@class="field"}) %></p>
                
                <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
