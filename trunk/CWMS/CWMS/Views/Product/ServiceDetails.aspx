<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Product>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ServiceDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">รายละเอียดบริการ</h1>
          <div class="contactform">
            <% using (Html.BeginForm("","Product",FormMethod.Post)){ %>
              <fieldset><legend>&nbsp;รายละเอียดบริการ&nbsp;</legend>
                <%: Html.Hidden("isService",false) %>
                
                <p><label for="contact_firstname_1" class="left">กลุ่ม:</label>
                    <%if (Model.ProductGroupId.HasValue)
                      { %>
                    <%: Html.TextBoxFor(model => model.ProductGroup.Name, new { @class = "field" })%></p>
                    <%} else{%>
                    <%: Html.TextBox("x","ไม่กำหนด", new { @class = "field" })%></p>
                    <%} %>
                <p><label for="contact_firstname_1" class="left">ชื่อบริการ:</label>
                    <%: Html.TextBoxFor(model => model.Name,new{@class="field"}) %></p>
                <p><label for="contact_familyname_1" class="left">หน่วย:</label>
                    <%: Html.TextBoxFor(model => model.Unit,new{@class="field"}) %></p>
                
                <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>

        <a id="a1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>ส่วนประกอบ</h1>        
          <table>
            <tr><th class="top" scope="col">ส่วนประกอบ</th><th class="top" scope="col">จำนวน</th></tr>
            <%foreach (var item in Model.ProductComponents)
              { %>
            <tr>
                <td><%: item.Component.Name %></td>
                <td><%: item.Quantity %></td>
            </tr>
            <%} %>
          </table>
          <p class="caption"></p>








           <div class="content-1col-nobox">
          <div class="contactform">
            <% using (Html.BeginForm("AddComponentToService","Product",FormMethod.Post)){ %>
              <fieldset><legend>&nbsp;เพิ่มส่วนประกอบ&nbsp;</legend>
                <%: Html.Hidden("productId",Model.Id) %>
                <p><label for="contact_firstname_1" class="left">ส่วนประกอบ:</label>
                    <%: Html.DropDownList("componentId",new SelectList((IEnumerable<CWMS.Models.Component>)ViewData["components"], "Id", "Name"),new{@class="combo"}) %></p>
                
                <p><input type="submit" name="submit" id="submit1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>              
        </div> 


        </div> 
        <div class="corner-content-1col-bottom"></div>  
        
          <%if (Model.IsService)
            { %>
                <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>ราคา</h1>        
          <table>
            <%foreach (var carBrand in (IEnumerable<CWMS.Models.CarBrand>)ViewData["carBrands"])
              { %>
                    <tr><th class="top" scope="col" colspan="2"><%: carBrand.Name %></th></tr>
                    <%foreach (var carModel in carBrand.CarModels)
                      { %>
                    <tr>
                        <td><%: carModel.Name%></td>
                        <td>
                            <% if (Model.Prices.Any(x => x.CarModelId == carModel.Id))
                               {
                                   CWMS.Models.Price price = Model.Prices.FirstOrDefault(x => x.CarModelId == carModel.Id);%>
                                <% using (Html.BeginForm("EditPrice", "Product", FormMethod.Post))
                                   { %>
                                    <%= Html.Hidden("returnPage", "service")%>
                                    <%= Html.Hidden("priceId", price.Id)%>
                                    <%= Html.TextBox("amount", price.Amount, new { @class = "field" })%>
                                    <input type="submit" class="button" value="แก้ไข"/>
                                <%} %>
                            <%}
                               else
                               { %>
                                <% using (Html.BeginForm("AddPrice", "Product", FormMethod.Post))
                                   { %>
                                    <%= Html.Hidden("productId",Model.Id) %>
                                    <%= Html.Hidden("carModelId",carModel.Id) %>
                                    <%= Html.Hidden("returnPage", "service")%>
                                    <%= Html.TextBox("amount", "ยังไม่ได้กำหนด", new { @class = "field", @style="width: 200px;" })%>
                                    <input type="submit" class="button" value="เพิ่ม"/>
                                <%} %>
                            <%} %>
                        </td>
                    </tr>
                    <%} %>
            <%} %>
          </table>
          <p class="caption"></p>
          </div>
          <div class="corner-content-1col-bottom"></div>  
          <%} %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
