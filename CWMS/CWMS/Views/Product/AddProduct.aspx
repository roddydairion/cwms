<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.ProductGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddProduct
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">เพิ่มสินค้าขายรายชิ้น</h1>
          <div class="contactform">
            <% using (Html.BeginForm("AddProduct","Product",FormMethod.Post)){ %>
              <fieldset><legend>&nbsp;รายละเอียดสินค้า&nbsp;</legend>
                <%: Html.Hidden("isService",false) %>
                
                <p><label for="contact_firstname_1" class="left">บาร์โค้ด:</label>
                    <%: Html.TextBox("barcode","",new{@class="field"}) %></p>
                
                <p><label for="contact_firstname_1" class="left">กลุ่มสินค้า:</label>
                    <%: Html.DropDownList("productGroupId", new SelectList(Model, "Id", "Name"), "ไม่ระบุ", new { @class = "field" })%></p>

                <p><label for="contact_firstname_1" class="left">ชื่อสินค้า:</label>
                    <%: Html.TextBox("name","",new{@class="field"}) %></p>
                <p><label for="contact_familyname_1" class="left">หน่วย:</label>
                    <%: Html.TextBox("unit","",new{@class="field"}) %></p>
                    <p><label for="contact_familyname_1" class="left">ราคาขาย:</label>
                    <%: Html.TextBox("price","",new{@class="field"}) %></p>
                
                <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
