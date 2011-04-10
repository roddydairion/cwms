<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<CWMS.Models.OrderItem>>" %>

        <div class="corner-subcontent-top"></div>                        
        <div class="subcontent-box">
          <h1 class="menu">ตะกร้าสินค้า
          
          </h1>                    
          <div class="sidemenu1">
            <ul>
              <li><a href="#">รายการสินค้า
              <%if (ViewData["carId"] != null)
            {%>
                - <%: ViewData["carRegistrationNumber"] %> - <%: ViewData["carId"] %>
            <%} %>
              </a>
                <ul>
                <%decimal totalPrice = 0;
                    if (Model != null)
                  { %>
                  <%
                    int index = 0;
                        foreach (var orderItem in Model)
                    { %>
                  <li><%= Ajax.ActionLink(orderItem.Product.Name + " - " + orderItem.TotalPrice.ToString("N2"),"RemoveItemFromShoppingCart", new {index = index, carId = ViewData["carId"]} ,new AjaxOptions
                          {
                              HttpMethod = "Get",
                              UpdateTargetId = "shoppingcart",
                              LoadingElementId = "indicator"
                          })%></li> 
                  <%    index++;    
                        totalPrice = totalPrice + orderItem.TotalPrice;%>
                  <%} %> 
                  <%}
                  else
                  { %>
                    <li><a href="#">ยังไม่มีสินค้า</a></li>
                  <%} %>                        
                </ul>
              </li>
              <li><a href="#">ราคารวม - <%: totalPrice.ToString("N2") %></a></li>
              <%if (totalPrice > 0){ %>
                    <li><%= Html.ActionLink("ส่งออร์เดอร์", "PlaceOrder", new { carId = ViewData["carId"] })%></li>
              <%} %>
            </ul>
          </div>
        </div>  
        <div class="corner-subcontent-bottom"></div>