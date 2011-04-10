<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.OrderItem>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="header">
        <h1>ยืนยันการสั่งซื้อ</h1>
        <div data-role="navbar">
		<ul >
            <li><a href="#" data-theme="b">
            <%if (ViewData["car"] == null)
              {%>
                ลูกค้าเงินสด<br />&nbsp;
            <%}
              else
              {
                  CWMS.Models.Car car = (CWMS.Models.Car)ViewData["car"];%>
                  <%: car.Customer.Name %>
                <br />
                
                <%: car.CarModel.CarBrand + ": " + car.RegistrationNumber %> บาท
            <%} %>
            </a></li>
            
            <li><a href="/MobileOrder/FinishOrder" data-theme="e" ><span style="font-size: 24px;">ยืนยันการซื้อ</span></a></li>
		</ul>
	</div>
    </div> 
    <br />
	<div data-role="content">
    <ul data-role="listview" data-theme="c" data-inset="false" data-filter="false">
        <%foreach(CWMS.Models.OrderItem orderItem in Model){ %>
            <li><%= Html.ActionLink(orderItem.Product.Name, "#")%><span class="ui-li-count"><%: orderItem.TotalPrice.ToString("n2") %> บาท</span></li>
        <%} %>
            <li><a href="#">รวม: <%= Model.Sum(x=>x.TotalPrice).ToString("n2") %> บาท</a></li>
    </ul>
    </div>
    <br />
	<div data-role="footer">
         <h4>Mr. Kleane Ordering System</h4>
    </div> 
</asp:Content>
