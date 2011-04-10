<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Product>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	เพิ่มราคาบริการ
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">ราคาสำหรับ: <%: Model.Name %></h1>
          <div class="contactform">
          <%using (Html.BeginForm())
            { %>
          <%foreach (CWMS.Models.CarBrand carBrand in (IEnumerable<CWMS.Models.CarBrand>)ViewData["carBrands"])
            {%>
              <fieldset><legend><%: carBrand.Name%></legend>
              <%foreach(CWMS.Models.CarModel carModel in carBrand.CarModels){ %>
                <p><label for="contact_firstname_1" class="left"><%: carModel.Name %>:</label>
                    <%: Html.Hidden("carModelId",carModel.Id)%>
                    <% if (carModel.Prices.Any(x => x.ProductId == Model.Id))
                       { %>
                        <%: Html.TextBox("price",carModel.Prices.Where(x=>x.ProductId == Model.Id).OrderByDescending(x=>x.Date).FirstOrDefault().Amount.ToString("n2"), new { @class = "field", @readonly = "true" })%></p>
                    <%} else {%>
                        <%: Html.TextBox("price",0, new { @class = "field", @readonly = "true" })%></p>
                    <%} %>
                <%} %>
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

