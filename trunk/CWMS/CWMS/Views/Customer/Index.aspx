<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.Customer>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Customer List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">เพิ่มลูกค้า</h1>
          <div class="contactform">
            <% using (Html.BeginForm()){ %>
              <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">ชื่อ:</label>
                    <%: Html.TextBox("name",null, new { @class = "field" }) %></p>
                    
                <p><label for="contact_firstname_1" class="left">ที่อยู่:</label>
                    <%: Html.TextArea("address",null, new { @class = "field" }) %></p>
                    
                <p><label for="contact_firstname_1" class="left">โทรศัพท์:</label>
                    <%: Html.TextBox("telephone",null, new { @class = "field" }) %></p>
                    
                <p><label for="contact_firstname_1" class="left">หมายเหตุ:</label>
                    <%: Html.TextArea("note",null, new { @class = "field" }) %></p>
                <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>   
          
          <table>
            <tr><th class="top" colspan="3">รายชื่อลูกค้า</th></tr>
            <%foreach(var item in Model){ %>
                <tr><td>
                <%try
                  { %>
                <%: Html.ActionLink(item.Name, "Details", new { id = item.Id })%>
                <%}
                  catch { } %>
                &nbsp;<%= Html.ActionLink("[ ลบ ]","DeleteCustomer",new{id=item.Id}) %>
                
                </td>
                <td style="width: 200px;">ทะเบียนรถ: |  
                <%foreach(var car in item.Cars){ %>
                    <%try
                      { %>
                        <%: car.RegistrationNumber.Replace(" ", "") %> |
                    <%}catch{ %>
                    <%} %>
                <%} %>
                </td>
                
                
                <td style="width: 200px;">โทร: 
                <%if(!string.IsNullOrEmpty(item.Telephone)){ %>
                <%: item.Telephone %>
                <%} %>
                </td></tr>
            <%} %>
          </table>  
          
          <table>
            <tr><th class="top" colspan="2">รายการรถที่ยังไม่ได้เพิ่มข้อมูลลูกค้า</th></tr>
            <%foreach (var item in ViewData["nullCustomerCars"] as IEnumerable<CWMS.Models.Car>)
              { %>
                <tr><td>
                <%try
                  { %>
                <%: item.RegistrationNumber%>
                <%}
                  catch { } %>
                
                </td>
                <td style="width: 200px;">
                <%: item.CarModel.CarBrand.Name %>: <%: item.CarModel.Name %>
                </td>
                </tr>
            <%} %>
          </table>  

          <div class="contactform">
            <% using (Html.BeginForm("Search","Customer")){ %>
              <fieldset><legend>&nbsp;ค้นหาลูกค้า&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">ชื่อ:</label>
                    <%: Html.TextBox("s",null, new { @class = "field" }) %></p>
                    
                <p><input type="submit" name="submit" id="submit1" class="button" value="ค้นหา" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>            
        
        <div class="contactform">
            <% using (Html.BeginForm("SearchCar","Customer")){ %>
              <fieldset><legend>&nbsp;ค้นหารถ&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">เลขทะเบียน:</label>
                    <%: Html.TextBox("s",null, new { @class = "field" }) %></p>
                    
                <p><input type="submit" name="submit" id="submit2" class="button" value="ค้นหา" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>   
          </div>
        <div class="corner-content-1col-bottom"></div> 

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
