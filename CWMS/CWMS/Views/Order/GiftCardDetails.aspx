<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.GiftCard>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	GiftCardDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="corner-content-1col-top"></div>                        
<div class="content-1col-nobox">
    <h1 class="contact">GiftCardDetails</h1>
    <%CWMS.Models.Car car = ViewData["car"] as CWMS.Models.Car; %>
    <div class="contactform">
    <fieldset>
        <legend>รายละเอียด</legend>
        
        <p><label class="left">เลขที่</label>
        <%: Model.Number %></p>
        
        <p><label class="left">จำนวนเริ่มต้น</label>
        <%: Model.OriginalQuantity %></p>
        
        <p><label class="left">เหลือ</label>
        <%: Model.CurrentQuantity %></p>
        
        <% string customerName = "ยังไม่ระบุเจ้าของ";
           if (Model.Car.CustomerId.HasValue)
               customerName = Model.Car.Customer.Name;
                %>
        <p><label class="left">รถ</label>
        <%: car.CarModel.Name %>-<%: car.RegistrationNumber %> [ <%: customerName %> ]</p>
        
        <p><label class="left">ราคา</label>
        <%: String.Format("{0:F}", Model.Price) %></p>
        <p>
            [ <%: Html.ActionLink("ใช้คูปองใบนี้","UseGiftCard",new{id=Model.Id,carId = car.Id}) %> ] 
            [ <%: Html.ActionLink("ลบคูปอง", "DeleteGiftCard", new { id = Model.Id }) %> ]
        </p>
        
    </fieldset>
    <table>
        <tr>
            <th>รายการที่ใช้ (วันที่)</th><th>รถ</th><th>ส่งไปช่องจอด</th><th></th><th></th>
        </tr>
        <%foreach(var item in Model.GiftCardUsages) {%>
            <tr>
                <td><%: item.Date.ToShortDateString() %></td>
                <td>[<%: item.Car.CarModel.CarBrand.Name + ": " + item.Car.CarModel.Name %>] 
                    <%: item.Car.RegistrationNumber %>
                </td>
                <td>
                    <%using(Html.BeginForm("SendGiftCardToSlot","Order",FormMethod.Get)){ %>
                    <%: Html.DropDownList("slotNumber", new SelectList(System.Linq.Enumerable.Range(1, 10)), new { @class = "combo",@style="width: 100px;" })%>
                    <%: Html.Hidden("carId", car.Id) %>
                    <%: Html.Hidden("giveCardUsageId", item.Id) %>
                    <input type="submit" value="submit" />
                    <%} %>
                    
                </td>
                <td>
                    <% if (item.SlotNumber.HasValue)
                       {%>
                       <%: Html.ActionLink("นำออกจากช่องจอด ["+item.SlotNumber.Value.ToString()+"]", "RemoveGiftCardFromSlot", new { giveCardUsageId = item.Id,carId =  car.Id}, null)%>
                       <%} %>
                </td>
                <td>
                    [ <%: Html.ActionLink("ลบ", "DeleteGiftCardUsage", new { id = item.Id }) %> ]
                </td>
            </tr>
        <%} %>
    </table>
    <br />
    </div>
</div>
<div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

