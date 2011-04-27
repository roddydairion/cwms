<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="header">
        <h1>สั่งสินค้า</h1>
        <div data-role="navbar">
		<ul >
			<li>
            
            <%if(Session["car"] == null){ %>
            <a href="/MobileOrder/SelectCar" data-theme="b">
            <%}else{ %>
            <a href="/MobileOrder/SelectCar" data-theme="a">
            <%} %>
                <%if(Session["car"] == null){ %>
                    ไม่ได้เลือกรถ<br />&nbsp;
                <%} else{
                      CWMS.Models.Car car = (CWMS.Models.Car)Session["car"];%>
                      <%try
                        { %><%: car.Customer.Name%><br /><%}
                        catch { } %><%:car.RegistrationNumber %>
                <%} %>
                </a>
            </li>
            <li><a href="/MobileOrder/ClearProductSession" data-theme="b">
            <%if (Session["cart"] == null)
              {%>
                ไม่มีสินค้า<br />ในรายการ
            <%}
              else
              {%>
                สินค้า: <%= ((List<CWMS.Models.OrderItem>)Session["cart"]).Count.ToString() %> รายการ<br />
                
                <%= ((List<CWMS.Models.OrderItem>)Session["cart"]).Sum(x=>x.TotalPrice).ToString("N2") %> บาท
            <%} %>
            </a></li>
            
            <li><a href="/MobileOrder/OrderConfirmation" data-theme="e" ><span style="font-size: 24px;">สั่งสินค้า</span></a></li>
		</ul>
	</div>
    </div> 
    <br />
	<div data-role="content">
    <ul data-role="listview" data-theme="c">
    <% foreach(CWMS.Models.ProductGroup productGroup in (IEnumerable<CWMS.Models.ProductGroup>)ViewData["allproductgroups"]){ %>
            <li><%: productGroup.Name %>
                <ul>
                <%foreach (CWMS.Models.Product product in productGroup.Products)
                  { %>
                    <%if (product.IsService)
                      {
                          if (Session["car"] != null)
                          {
                              try
                              {%>
                        
                                <li><%= Html.ActionLink(product.Name, "AddItemToShoppingCart", new { productId = product.Id, carId = ((CWMS.Models.Car)Session["car"]).Id })%><span class="ui-li-count"><%: product.CurrentServicePriceEntity(((CWMS.Models.Car)Session["car"]).CarModelId.Value).Amount.ToString("n2")%> บาท</span></li>
                            <%}
                              catch
                              {%>
                                <li><%= product.Name%><span class="ui-li-count">ไม่ได้กำหนดราคา</span></li>
                                
                            <%}
                          }
                      }
                      else
                      { %>
                                    <li><%= Html.ActionLink(product.Name, "AddItemToShoppingCart", new { productId = product.Id})%><span class="ui-li-count"><%: product.CurrentPrice.ToString("n2")%> บาท</span></li>


                <%}
                  }%>
                </ul>
            <span class="ui-li-count">123</span></li> 
    </ul>
    <%} %>
    <%if(Session["car"] != null)
      { 
          CWMS.Models.Car car = Session["car"] as CWMS.Models.Car;%>
    <ul data-role="listview" data-theme="c" data-inset="false" data-filter="true">
        
        <%foreach(CWMS.Models.Product service in (IEnumerable<CWMS.Models.Product>)ViewData["allservices"]){ %>
            <li><%= Html.ActionLink(service.Name, "AddItemToShoppingCart", new { productId = service.Id, carId= car.Id })%>
            <span class="ui-li-count">
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
    <br /><br />
    <%}else
      { %>
        <ul data-role="listview" data-theme="c" data-inset="false" data-filter="true">
        
        <li><a href="#">เลือกรถก่อนเลือกบริการ</a> </li>
        
    </ul>
    <br /><br />
      <%} %>
    <ul data-role="listview" data-theme="c" data-inset="false" data-filter="true">
        <%
        foreach(CWMS.Models.Product product in (IEnumerable<CWMS.Models.Product>)ViewData["allproducts"]){ %>
            <li><%= Html.ActionLink(product.Name, "AddItemToShoppingCart", new { productId = product.Id, })%><span class="ui-li-count"><%: product.CurrentPrice.ToString("n2") %> บาท</span></li>
        <%} %>
    </ul>
    </div>
    <br />
	<div data-role="footer">
         <h4><%= Html.ActionLink("Mr. Kleane Ordering System", "ClearSessions")%> [ <a href="javascript:location.reload(true);">Refresh</a> ]</h4>
    </div> 
</asp:Content>
