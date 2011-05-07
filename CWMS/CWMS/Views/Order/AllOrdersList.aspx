<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.Order>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AllOrdersList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<% CWMS.Views.Helper helper = new CWMS.Views.Helper(); %>
    <a id="anchor-table-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>ออเดอร์ทั้งหมด</h1>   
          <div class="contactform">
          <% 
              DateTime startDate = DateTime.Now;
              DateTime endDate = DateTime.Now;
              if (ViewData["startDate"] != null)
              {
                  startDate = (DateTime)ViewData["startDate"];
                  endDate = (DateTime)ViewData["endDate"];
              }%>
            <% using (Html.BeginForm("AllOrdersList","Order",FormMethod.Get))
               { %>
                <fieldset>
                    <legend>เลือกวันที่ต้องการ</legend>
                     <p><label class="left">เริ่มจาก:</label>
                       <%= helper.DateDropDownList("start", startDate) %></p>
                           <p><label class="left">สิ้นสุด:</label>
                       
                       <%= helper.DateDropDownList("end", endDate) %></p>
                    <p><input type="submit" name="submit" id="submit2" class="button" value="แสดง" tabindex="1" />
                    <a href="<%: Url.Action("AllOrderListPrint",new{startDate=startDate.ToShortDateString(),endDate=endDate.ToShortDateString()}) %>" target="_blank">
                        <img src="/Content/img/print_icon.gif" />
                    </a>
                    </p>

                </fieldset>
            <%} %>
          </div>     
          <table>
            <tr><th class="top" scope="col">หมายเลข</th><th class="top" scope="col">ลูกค้า</th><th class="top" scope="col">วันที่รับออเดอร์</th><th class="top" scope="col">ราคารวม</th><th class="top" scope="col">ชำระแล้ว</th><th class="top" scope="col">สถานะ</th></tr>
            <%decimal totalPrice = 0;
                foreach (var item in Model)
              { %>
                <tr>
                    <th scope="row"><%= Html.ActionLink("#"+item.Id.ToString().PadLeft(8,'0'),"Details",new {id= item.Id}) %></th>
                    <td>
                        <%if(item.CarId.HasValue){ %>
                            <%try{ %>
                            <%: item.Car.Customer.Name %>
                            <%}catch{ %>
                                
                            <%} %>
                             - 
                            
                            <%: item.Car.RegistrationNumber %>
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
                </tr>
            <%} %></table>
            <table>
                <tr><th class="top" scope="col" colspan="4">ยอดรวม</th><th class="top" scope="col" colspan="2"><%: totalPrice %></th></tr>
                <tr><th class="top" scope="col" colspan="4">ชำระแล้ว</th><th class="top" scope="col" colspan="2"><%: Model.Where(x=>x.Paid.HasValue).Sum(x=>x.Paid) %></th></tr>
                <tr><th class="top" scope="col" colspan="4">ยังไม่ได้ชำระ</th><th class="top" scope="col" colspan="2"><%: totalPrice- Model.Where(x=>x.Paid.HasValue).Sum(x=>x.Paid) %></th></tr>
            </table>
            
        </div> 
        <div class="corner-content-1col-bottom"></div> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

