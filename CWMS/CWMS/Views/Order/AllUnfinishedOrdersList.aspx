<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.Order>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AllOrdersList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a id="anchor-table-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>ออเดอร์ที่ยังไม่ได้ชำระเงิน</h1>        
          <table>
            <tr><th class="top" scope="col">หมายเลข</th><th class="top" scope="col">ลูกค้า</th><th class="top" scope="col">วันที่รับออเดอร์</th><th class="top" scope="col">ราคารวม</th><th class="top" scope="col">ชำระแล้ว</th><th class="top" scope="col">สถานะ</th>
            <th>Print</th>
            </tr>
            <%decimal totalPrice = 0;
                foreach (var item in Model)
              { %>
                <tr>
                    <th scope="row"><%= Html.ActionLink("#"+item.Id.ToString().PadLeft(8,'0'),"Details",new {id= item.Id}) %></th>
                    <td>
                        <%if(item.CarId.HasValue){ %>
                            <%: item.Car.Customer.Name %> - <%: item.Car.RegistrationNumber %>
                        <%}else {%>
                            -
                        <%} %>
                    </td>
                    <td>
                        <%: item.OrderDate %>
                    </td>
                    <td>
                        <%: item.TotalPrice %>
                        <% totalPrice += item.TotalPrice; %>
                    </td>
                    <%if (item.Paid.HasValue){ %>
                    <td>
                        <%: item.Paid %>
                    </td>
                    <td>ชำระแล้ว</td>

                    <%} else {%>
                            <% using (Html.BeginForm("FinishOrder", "Order"))
                               { %>
                                <%= Html.Hidden("orderId",item.Id) %>
                                <td>
                                <%= Html.TextBox("paid", item.TotalPrice, new { @class = "field" })%>
                                </td>
                                <td>
                                <input type="submit" name="submit" id="submit1" class="button" value="เคลียร์ออเดอร์" tabindex="1"/>
                                </td>
                            <%} %>
                        <%} %>
                    </td>
                    <td>
                        <form method="get" action="/Order/JobPrint/<%:item.Id %>" target=_blank">
<input type="submit" value="Job" class="button">
</form>
                    </td>
                </tr>
            <%} %></table>
            <table>
                <th class="top" scope="col" colspan="4">ยอดรวม</th><th class="top" scope="col" colspan="2"><%: totalPrice %></th>
            </table>
        </div> 
        <div class="corner-content-1col-bottom"></div> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

