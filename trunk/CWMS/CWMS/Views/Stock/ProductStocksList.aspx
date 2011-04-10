<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AllOrdersList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<% CWMS.Views.Helper helper = new CWMS.Views.Helper(); %>
    <div class="content-1col-box">
          <!-- Subcell LEFT -->
          <div class="content-2col-box-leftcolumn">
    <a id="anchor-table-3"></a>
            <div class="corner-content-2col-top"></div>
            <div class="content-2col-box">
              <h1>สินค้า</h1>
              <table>
                <tr><th class="top" scope="col">สินค้า</th><th class="top" scope="col" style="width: 50px;">คงเหลือ</th></tr>
                <%foreach(CWMS.Models.Product item in (IEnumerable<CWMS.Models.Product>)ViewData["products"]){ %>
                    <tr>
                        <td><%= Html.ActionLink(item.Name, "ProductStockDetails", new { productId = item.Id })%></td>
                        <td><%: item.CurrentQuantity %></td>

                    </tr>
                <%} %>
              </table>
              <p class="caption"></p>
            </div>
            <div class="corner-content-2col-bottom"></div>

            
            <div class="corner-content-2col-top"></div>          
            <div class="content-2col-box">
              <h1 class="contact">เพิ่มสินค้า</h1>            
              <div class="contactform">
                    <%using (Html.BeginForm("AddProductStock","Stock",FormMethod.Post)){ %>
                  <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
                    <p><label for="contact_firstname_3a" class="left">เลือกสินค้า:</label>
                        <%=  Html.DropDownList("productId",new SelectList((IEnumerable<CWMS.Models.Product>)ViewData["products"],"Id","Name"),new{@class="combo"}) %></p>
                    <p><label for="contact_firstname_3a" class="left">ผู้ป้อน:</label>
                        <%= Html.DropDownList("supplierId",new SelectList((IEnumerable<CWMS.Models.Supplier>)ViewData["suppliers"],"Id","Name"),new{@class="combo"}) %></p>
                    <p><label for="contact_familyname_3a" class="left">จำนวนทั้งหมด:</label>
                        <%= Html.TextBox("originalQuantity",0,new{@class="field"}) %></p>
                    <p><label for="contact_street_3a" class="left">ราคาซื้อรวม:</label>
                        <%= Html.TextBox("cost",0,new{@class="field"}) %></p>
                    <p>
                        <%= helper.DateDropDownList("",DateTime.Now)%></p>
                    <p><input type="submit" name="submit" id="submit_3a" class="button" value="เพิ่มการซื้อ" tabindex="6" /></p>
                  </fieldset>
                <%} %>
              </div>              
            </div>
            <div class="corner-content-2col-bottom"></div>

    </div>
    <div class="content-2col-box-rightcolumn">
    <div class="corner-content-2col-top"></div>
            <div class="content-2col-box">
              <h1>ส่วนประกอบ</h1>
              <table>
                <tr><th class="top" scope="col">ส่วนประกอบ</th><th class="top" scope="col" style="width: 50px;">คงเหลือ</th></tr>
                <%foreach (var item in (IEnumerable<CWMS.Models.Component>)ViewData["components"])
                  { %>
                    <tr>
                        <td><%= Html.ActionLink(item.Name, "ComponentStockDetails", new { componentId = item.Id })%></td>
                        <td><%: item.CurrentQuantity %></td>
                    </tr>
                <%} %>             
              </table>
              <p class="caption"></p>
            </div>
            <div class="corner-content-2col-bottom"></div>



            <div class="corner-content-2col-top"></div>          
            <div class="content-2col-box">
              <h1 class="contact">เพิ่มส่วนประกอบ</h1>            
              <div class="contactform">
                <%using (Html.BeginForm("AddComponentStock", "Stock", FormMethod.Post))
                  { %>
                  <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
                    <p><label for="contact_firstname_3a" class="left">เลือกส่วนประกอบ:</label>
                        <%=  Html.DropDownList("componentId", new SelectList((IEnumerable<CWMS.Models.Component>)ViewData["components"], "Id", "Name"), new { @class = "combo" })%></p>
                    <p><label for="contact_firstname_3a" class="left">ผู้ป้อน:</label>
                        <%= Html.DropDownList("supplierId", new SelectList((IEnumerable<CWMS.Models.Supplier>)ViewData["suppliers"], "Id", "Name"), new { @class = "combo" })%></p>
                    <p><label for="contact_familyname_3a" class="left">จำนวนทั้งหมด:</label>
                        <%= Html.TextBox("originalQuantity", 0, new { @class = "field" })%></p>
                    <p><label for="contact_street_3a" class="left">ราคาซื้อรวม:</label>
                        <%= Html.TextBox("cost", 0, new { @class = "field" })%></p>
                    <p>
                        
                        <%= helper.DateDropDownList("", DateTime.Now)%></p>
                    <p><input type="submit" name="submit" id="submit1" class="button" value="เพิ่มการซื้อ" tabindex="6" /></p>
                  </fieldset>
                <%} %>
              </div>              
            </div>
            <div class="corner-content-2col-bottom"></div>

    </div>
    


    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">

</asp:Content>

