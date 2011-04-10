<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Order>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">ออเดอร์หมายเลข #<%: Model.Id.ToString().PadLeft(8,'0') %></h1>
          <div class="contactform">
              <fieldset><legend>&nbsp;รายละเอียดลูกค้า&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">ลูกค้า:</label>
                <%try{ %>
                    <%: Html.TextBoxFor(model => model.Car.Customer.Name, new{@class="field", @readonly="true"}) %>
                    <%}catch{ %>
                        <%: Html.TextBox("x","ไม่ระบุ",new { @class = "field", @readonly = "true" })%></p>
                    <%} %>
                    </p>
                <p><label for="contact_familyname_1" class="left">รถ:</label>
                <%try
                  { %>
                    <%: Html.TextBox("Registration", Model.Car.RegistrationNumber + " - " + Model.Car.CarModel.CarBrand.Name + ": " + Model.Car.CarModel.Name, new { @class = "field", @readonly = "true" })%></p>
                <%}
                  catch { %>
                    <%: Html.TextBox("x","ไม่ระบุ",new { @class = "field", @readonly = "true" })%></p>
                  <%}%>
                <p><label for="contact_street_1" class="left">วันที่รับออเดอร์:</label>
                    <%: Html.TextBoxFor(model => model.OrderDate, new{@class="field", @readonly="true"}) %></p>
                <p><label for="contact_postalcode_1" class="left">วันนัด:</label>
                    <%: Html.TextBoxFor(model => model.AppointmentDate, new{@class="field", @readonly="true"}) %></p>
                <p><label for="contact_postalcode_1" class="left">ราคารวม:</label>
                <%: Html.TextBoxFor(model => model.TotalPrice, new { @class = "field", @readonly = "true" })%></p>
                <%if (Model.SlotNumber.HasValue)
                  { %>
                <p><label for="contact_postalcode_1" class="left">ช่องจอด:</label>
                <%: Html.TextBoxFor(model => model.SlotNumber, new { @class = "field", @readonly = "true" })%></p>
                <%} %>
                <%if (Model.Paid.HasValue)
                  { %>
                <p><label for="contact_postalcode_1" class="left">จ่ายแล้ว:</label>
                    <%: Html.TextBoxFor(model => model.Paid, new {@class="field", @readonly = "true" })%></p>
                <%}
                  else
                  { %>
                  <% using (Html.BeginForm("FinishOrder", "Order"))
                     { %>
                     <%= Html.Hidden("orderId", Model.Id) %>
                  <p><label for="contact_postalcode_1" class="left">จ่าย:</label>
                    <%: Html.TextBox("paid",0, new { @class = "field" })%></p>
                    <p><input type="submit" name="submit" id="submit1" class="button" value="ชำระเงิน" tabindex="1" /></p>
                    <%} %>
                <%} %>
               </fieldset>
               <%if (!Model.SlotNumber.HasValue)
                 { %>
                    <% using (Html.BeginForm("SendToSlot", "Order", FormMethod.Post))
                       {%>
                    <fieldset>
                        <legend>ส่งรถไปช่องจอด</legend>
                        <%: Html.Hidden("orderId", Model.Id) %>
                        <p><label for="contact_firstname_1" class="left">ช่องจอดที่:</label>
                        <%: Html.DropDownList("slotNumber",new SelectList(Enumerable.Range(1,10)),new{@class="combo"}) %></p>
                        <p><input type="submit" name="submit" id="submit2" class="button" value="ส่งไปช่องจอด" tabindex="1" /></p>

                    </fieldset>
                    <%} %>
               <%} %>

          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>

        <a id="anchor-table-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>รายการสินค้า</h1>        
          <table>
            <tr><th class="top" scope="col" style="width: 20px;">#</th><th class="top" scope="col">สินค้า</th><th class="top" scope="col">ราคาต่อหน่วย</th><th class="top" scope="col" style="width: 40px;">จำนวน</th><th class="top" scope="col">ราคารวม</th></tr>
                <% decimal totalPrice = 0;
                   int index = 1;
                    foreach (var item in Model.OrderItems)
                   { %>
                    <tr>
                        <td><%:index %></td>
                        <td><%: item.Product.Name %></td>
                        <td><%: item.Price.Amount %></td>
                        <td><%: item.Quantity%></td>
                        <th scope="col"><%: item.TotalPrice %></th>
                        <% totalPrice += item.TotalPrice;
                           index++; %>
                    </tr>
                <%} %>
                <tr><th colspan="4">ราคารวม</th><th scope="col"><%: totalPrice %></th></tr>
           </table>
        </div> 
        <div class="corner-content-1col-bottom"></div> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

