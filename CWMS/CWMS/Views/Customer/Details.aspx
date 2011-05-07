<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Customer>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Customer Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">แก้ไขรายละเอียดลูกค้า</h1>
          <div class="contactform">
            <% using (Html.BeginForm("EditCustomer","Customer")){ %>
              <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
              <%= Html.Hidden("Id",Model.Id) %>
                <p><label for="contact_firstname_1" class="left">ชื่อ:</label>
                    <%: Html.TextBoxFor(model => model.Name,new{@class="field"})%></p>
                <p><label for="contact_firstname_1" class="left">ที่อยู่:</label>
                    <%: Html.TextAreaFor(model => model.Address, new { @class = "field" }) %></p>
                    
                <p><label for="contact_firstname_1" class="left">โทรศัพท์:</label>
                    <%: Html.TextBoxFor(model => model.Telephone, new { @class = "field" }) %></p>
                    
                <p><label for="contact_firstname_1" class="left">หมายเหตุ:</label>
                    <%: Html.TextAreaFor(model => model.Note, new { @class = "field" }) %></p>
                <p><input type="submit" name="submit" id="submit_1" class="button" value="แก้ไขข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>   
          
           <table>
            <tr><th class="top" colspan="6">ทำรายการล่าสุด</th></tr>
            <tr><th class="top">เลขที่</th><th class="top">วันที่</th><th class="top">รถ</th><th class="top">ราคารวม</th><th class="top">ชำระแล้ว</th><th class="top">คงเหลือ</th></tr>
            <%foreach(var item in Model.AllOrders){ %>
                <tr>
                    <td><%: Html.ActionLink("#"+ item.Id.ToString().PadLeft(8,'0'),
                        "Details","Order",new{id=item.Id},null)%></td>
                    <td><%:item.OrderDate.ToShortDateString() + " " + item.OrderDate.ToShortTimeString()%></td>
                    <td><%:item.Car.RegistrationNumber %></td>
                    <td><%:item.TotalPrice.ToString("n2") %></td>
                    <td>
                    <%try{ %>
                    <%: item.Paid.Value.ToString("n2") %>
                    <%}catch{ %>
                    <b>ยังไม่ได้ชำระ</b>
                    <%} %>
                    </td>
                    <td>
                    <%try{ %>
                    <%: (item.TotalPrice - item.Paid.Value).ToString("n2") %>
                    <%}catch{ %>
                    <%: item.TotalPrice.ToString("n2") %>
                    <%} %>
                    </td>
                </tr>
            <%} %>
          </table>  

          <table>
            <tr><th class="top" colspan="2">รายการรถ</th></tr>
            <tr><th class="top">รุ่น</th><th class="top">เลขทะเบียน</th></tr>
            <%foreach(var item in Model.Cars){ %>
                <tr><td>
                
                    <%try
                      { %>
                <%: item.CarModel.CarBrand.Name%>: <%: item.CarModel.Name%>
                <%}
                      catch { }%>
                </td>
                
                
                <td style="width: 200px;"> 
                
                    <%try
                      { %>
                <%: item.RegistrationNumber%> <%: Html.ActionLink("[ ลบ ]","DeleteCar",new{id=item.Id})%>
                <%}
                      catch { }%>
                </td></tr>
            <%} %>
          </table>  
          
          <div class="contactform">
            <% using (Html.BeginForm("AddCar2","Customer")){ %>
              <fieldset><legend>&nbsp;เพิ่มรถของลูกค้า&nbsp;</legend>
              <%= Html.Hidden("customerId",Model.Id) %>
                <p><label for="contact_firstname_1" class="left">รุ่น:</label>
                    <select name="carModelId" class="combo">
                        <%foreach(var item in (IEnumerable<CWMS.Models.CarBrand>)ViewData["allCarBrands"] ){ %>
                            <optgroup label="<%:item.Name %>">
                            
                                <%foreach(var model in item.CarModels){ %>
                                    <option value="<%: model.Id %>">
                                        <%: model.Name %>
                                    </option>
                                <%} %>
                            </optgroup>
                        <%} %>
                    </select>
                
                
                </p>

                 <p><label for="contact_firstname_1" class="left">เลขทะเบียน:</label>
                    <%: Html.TextBox("registrationNumber",null, new { @class = "field" })%></p>
                    
                <p><input type="submit" name="submit" id="submit1" class="button" value="ค้นหา" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>       
          <div class="contactform">
            <% using (Html.BeginForm("AddCar2","Customer")){ %>
              <fieldset><legend>&nbsp;เพิ่มจากรายการรถที่ยังไม่มีเจ้าของ&nbsp;</legend>
              <%= Html.Hidden("customerId",Model.Id) %>
               <table>
               <%foreach(var item in ViewData["nullCustomerCars"] as IEnumerable<CWMS.Models.Car>){ %>
                <tr>
                    <td><%:item.RegistrationNumber %></td>
                    <td><%: item.CarModel.CarBrand.Name + ": " + item.CarModel.Name %></td>
                    <td><%: Html.ActionLink("เพิ่มรถ", "AddCarToCustomer", new { carId = item.Id, customerId = Model.Id }) %></td>
                </tr>
               <%} %>
               </table>
                </fieldset>
            <%} %>
          </div>      
               
        </div> 
        <div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
