<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.OrderItem>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
        <h1 class="top-aligned">ยืนยันการสั่งซื้อ</h1>
        <nav class="horizontal">
		<ul class="two-piece" >
            <li>
            <%if (ViewData["car"] == null)
              {%>
                ลูกค้าเงินสด&nbsp;
            <%}
              else
              {
                  CWMS.Models.Car car = (CWMS.Models.Car)ViewData["car"];%>
                  <%try{ %>
                  [ <%: car.Customer.Name %> ]
                  <%}catch{ %>
                  [ ไม่พบชื่อลูกค้า ]
                  <%} %>
                <%try
                  { %>
                <%: car.CarModel.CarBrand.Name + "-" + car.CarModel.Name+ "-" + car.RegistrationNumber%>
                <%}
                  catch { } %>
            <%} %>
            </li>
            
            <li><a href="/MobileOrder/FinishOrder"><span style="font-size: 24px;">ยืนยันการซื้อ</span></a></li>
		</ul>
        </nav>
 
    <br />
    <table>
    <tbody>
        <%foreach(CWMS.Models.OrderItem orderItem in Model){ %>
            <tr><th scope="row"><%:orderItem.Product.Name %> (<%: orderItem.Quantity.ToString() %>)</th><td align="right"><%: orderItem.TotalPrice.ToString("n2") %> บาท</td></tr>
        <%} %>
            <tr><th scope="row">รวม</th><th scope="row" align="right"><%: Model.Sum(x=>x.TotalPrice).ToString("n2") %> บาท</th></tr>
    </tbody>
    </table>
</asp:Content>
