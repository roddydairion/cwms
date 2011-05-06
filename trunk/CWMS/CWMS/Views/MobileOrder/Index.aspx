<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="top-aligned">สั่งสินค้า</h1>
        <nav class="horizontal">
		    <ul class="three-piece">
			<li>
            
            <%if(Session["car"] == null){ %>
            <a href="/MobileOrder/SelectCar">
            <%}else{ %>
            <a href="/MobileOrder/SelectCar">
            <%} %>
                <%if(Session["car"] == null){ %>
                    ไม่ได้เลือกรถ
                <%} else{
                      CWMS.Models.Car car = (CWMS.Models.Car)Session["car"];%>
                      <%try
                        { %><%: car.Customer.Name%><%}
                        catch { } %><%:car.RegistrationNumber %>
                <%} %>
                </a>
            </li>
            <li><a href="/MobileOrder/ClearProductSession">
            <%if (Session["cart"] == null)
              {%>
                ไม่มีสินค้าในรายการ
            <%}
              else
              {%>
                สินค้า: <%= ((List<CWMS.Models.OrderItem>)Session["cart"]).Count.ToString() %> รายการ 
                
                <%= ((List<CWMS.Models.OrderItem>)Session["cart"]).Sum(x=>x.TotalPrice).ToString("N2") %> บาท
            <%} %>
            </a></li>
            
            <li><a href="/MobileOrder/OrderConfirmation"><span style="font-size: 24px;">สั่งสินค้า</span></a></li>
		</ul>
        </nav>


   
    <%if(Session["car"] != null)
      { 
          CWMS.Models.Car car = Session["car"] as CWMS.Models.Car;%>
          <h2>รายการบริการ [
          <%try{ %>
          <%: car.CarModel.CarBrand + ": " + car.CarModel.CarBrand.Name %>
          <%}catch{ %>
            ยังไม่ได้ใส่รุ่นรถ
          <%} %>
          ]</h2>
    <nav>
    <ul class="list group">
        
        <%foreach(CWMS.Models.Product service in (IEnumerable<CWMS.Models.Product>)ViewData["allservices"]){ %>
            <li class="group"><%= Html.ActionLink(service.Name, "AddItemToShoppingCart", new { productId = service.Id, carId= car.Id })%>
            <span>
            <%//if (service.CurrentServicePrice(((CWMS.Models.Car)Session["car"]).CarModelId.Value).HasValue)
              
              try            {%>
                <%: service.CurrentServicePriceEntity(car.CarModelId.Value).Amount.ToString("n2")%> บาท
                <%}
              catch
              { %>
              ไม่กำหนดราคา
                <%} %>
            
            </span></li>
        <%} %>
    </ul>
    </nav>
    <br />
    <%}else
      { %>
        
        <h2>เลือกรถก่อนเลือกบริการ</h2>
        
    <br />
      <%} %>
</asp:Content>
