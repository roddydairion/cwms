<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<% CWMS.Models.OrderRepository orderRepository = new CWMS.Models.OrderRepository(); %>
<% IEnumerable<CWMS.Models.Order> slotedOrders = orderRepository.SlotedOrder();
   IEnumerable<CWMS.Models.Order> unSlotedOrders = orderRepository.AllUnSlotedOrders();
   IEnumerable<CWMS.Models.GiftCardUsage> slotedUsages = orderRepository.AllSlotedGiftCardUsages();
    %>
        <div class="corner-subcontent-top"></div>                        
        <div class="subcontent-box">
          <h1 class="menu">งานในช่องจอด</h1>                    
          <div class="sidemenu1">
            <ul>
                <%for (int i = 1; i <= 10; i++)
                      {%>
              <li><a href="#">ช่องจอด: <%: i %></a>
                <ul>
                    <%foreach (var slotedOrder in slotedOrders.Where(x=>x.SlotNumber.Value == i))
                      { %>         
                  <li><%= Html.ActionLink(slotedOrder.Car.RegistrationNumber + " - " + slotedOrder.OrderItems.Where(x=>x.Product.IsService).FirstOrDefault().Product.Name, "Details","Order", new { id = slotedOrder.Id },null)%></li>
                  <%} %>   
                  <%foreach (var slotedGiftCard in slotedUsages.Where(x=>x.SlotNumber.Value == i))
                      { %>         
                  <li><%= Html.ActionLink(slotedGiftCard.Car.RegistrationNumber + " - ล้างรถด้วยคูปอง", "GiftCardDetails","Order", new { id = slotedGiftCard.GiftCardId }, null)%></li>
                  <%} %>                        
                </ul>
              </li>
              <%}%>
              <li><a href="#">ยังไม่ได้เลือกช่องจอด</a>
                <ul>
                    <%foreach (var unSlotedOrder in unSlotedOrders)
                      { %>         
                  <li><%= Html.ActionLink(unSlotedOrder.Car.RegistrationNumber + " - " + unSlotedOrder.OrderItems.Where(x=>x.Product.IsService).FirstOrDefault().Product.Name, "Details","Order", new { id = unSlotedOrder.Id },null)%></li>
                  <%} %>                          
                </ul>
              </li>
            </ul>
          </div>
        </div>  
        <div class="corner-subcontent-bottom"></div>   