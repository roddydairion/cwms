<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CWMS.Models.Car>" %>
<% if(Model != null) 
   { %>
   <% using (Ajax.BeginForm("EditCar","Customer",new AjaxOptions {
          HttpMethod = "Post",
          UpdateTargetId = "cardetails",
          LoadingElementId = "indicator"
      }))
      { %>
    <fieldset>
        <legend>&nbsp;รายละเอียดของรถ - เคยเข้าใช้บริการแล้ว&nbsp;</legend>
        
        <%= Html.HiddenFor(model => model.Id)%>
        <p><label class="left">ลูกค้า:</label>
        <% if(Model.CustomerId.HasValue) { %>
            <%= Html.TextBoxFor(model => Model.Customer.Name, new { @class = "field", @readonly = "true" })%></p>
        <%}else { %>
            <%= Html.TextBoxFor(model => Model.Customer.Name, new { @class = "field"})%></p>
        <%} %>
        <p><label class="left">เลขทะเบียน:</label>
            <%= Html.TextBoxFor(model => Model.RegistrationNumber, new { @class = "field", @readonly = "true"})%>
            
            </p>
        <p><label class="left">รายละเอียดรถ:</label>
            <%= Html.TextBox("details",Model.CarModel.CarBrand.Name + ": " + Model.CarModel.Name, new { @class = "field", @readonly = "true"})%></p>
            <p>
            [ <%= Ajax.ActionLink("เลือกรถคันนี้", "ShowProductList","Order", new { carId = Model.Id }, new AjaxOptions
                {
                    UpdateTargetId = "productlist",
                    HttpMethod = "Get",
                    LoadingElementId = "indicator"
                },null)%> ] 

                [ <%= Html.ActionLink("ซื้อคูปองล้างรถ", "AddGiftCard","Order", new { carId = Model.Id },null) %> ]
                <%if(Model.GiftCards.Any(x=>x.CurrentQuantity > 0)){
                      CWMS.Models.GiftCard giftCard = Model.GiftCards.FirstOrDefault(x => x.CurrentQuantity > 0);%>
                    [ <%: Html.ActionLink("ใช้คูปองหมายเลข : " + giftCard.Number.Trim(), "GiftCardDetails", "Order", new { id = giftCard.Id }, null) %> ]
                <%} %>
                
            </p>
         <% if(!Model.CustomerId.HasValue) { %>
            <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูลลูกค้า" tabindex="6" /></p>
        <%}%>
   <%} %>
    <%using(Html.BeginForm("SearchGiftCard","Order",FormMethod.Get))
      { %>
                    <%: Html.Hidden("carId", Model.Id) %>
                    <p>
                    <label class="left">ใช้คูปองหมายเลข:</label> <%: Html.TextBox("number", "", new { @class = "field" })%>
                    </p>
                    <p>
                    <input type="submit" value="ค้นหา" class="button"/>
                    </p>    
                <%} %>
        </fieldset>

<%}
   else if (ViewData["carBrandId"] == null)
   { %>
    <% using (Ajax.BeginForm("ChooseCarBrand", "Order", new AjaxOptions
       {
           HttpMethod = "Post",
           UpdateTargetId = "cardetails",
           LoadingElementId = "indicator"
       }))
       { %>
    <fieldset>
        <legend>&nbsp;รายละเอียดของรถ - ยังไม่เคยเข้าใช้บริการ&nbsp;</legend>
        <p><label class="left">ลูกค้า:</label>
            <%= Html.TextBox("customerName", ViewData["customerName"], new { @class = "field" })%></p>
        <p><label class="left">เลขทะเบียน:</label>
        <%string regNumber =  ViewData["registrationNumber"].ToString().Replace(" ","");%>
            <%= Html.TextBox("registrationNumber",regNumber , new { @class = "field", @readonly = "true" })%></p>
            <p><label class="left">ยี่ห้อ:</label>
            <%= Html.DropDownList("carBrandId", new SelectList((IEnumerable<CWMS.Models.CarBrand>)ViewData["carBrands"], "Id", "Name"), new { @class = "combo" })%></p>
        <p><input type="submit" name="submit" id="submit1" class="button" value="เลือกยี่ห้อรถ" tabindex="6" /></p>
    </fieldset>
<%  } %>
<%}
   else
   { %>
   <% using (Ajax.BeginForm("AddCar", "Customer", new AjaxOptions
      {
          HttpMethod = "Post",
          UpdateTargetId = "cardetails",
          LoadingElementId = "indicator"
      }))
      { %>
    <fieldset>
        <legend>&nbsp;รายละเอียดของรถ - ยังไม่เคยเข้าใช้บริการ&nbsp;</legend>
        <p><label class="left">ลูกค้า:</label>
            <%= Html.TextBox("customerName", ViewData["customerName"], new { @class = "field" })%></p>
        <p><label class="left">เลขทะเบียน:</label>
            <%= Html.TextBox("registrationNumber", ViewData["registrationNumber"], new { @class = "field", @readonly = "true" })%></p>
            <p><label class="left">ยี่ห้อ:</label>
            <%= Html.TextBox("carBrandName", ViewData["carBrandName"], new { @class = "field", @readonly = "true" })%></p>
        <p><label class="left">รุ่น:</label>
            <%= Html.DropDownList("carModelId", new SelectList((IEnumerable<CWMS.Models.CarModel>)ViewData["carModels"], "Id", "Name"), new { @class = "combo" })%></p>
        
        <p><input type="submit" name="submit" id="submit2" class="button" value="บันทึก" tabindex="6" /></p>
    </fieldset>
<%}
   } %>


