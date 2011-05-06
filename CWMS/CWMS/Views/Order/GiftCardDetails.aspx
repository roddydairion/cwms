<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.GiftCard>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	GiftCardDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>GiftCardDetails</h2>

    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">หมายเลข</div>
        <div class="display-field"><%: Model.Number %></div>
        
        <div class="display-label">จำนวนเริ่มต้น</div>
        <div class="display-field"><%: Model.OriginalQuantity %></div>
        
        <div class="display-label">เหลือ</div>
        <div class="display-field"><%: Model.CurrentQuantity %></div>
        
        <div class="display-label">รถ</div>
        <div class="display-field"><%: Model.Car.RegistrationNumber %> [ <%: Model.Car.Customer.Name %> ]</div>
        
        <div class="display-label">ราคา</div>
        <div class="display-field"><%: String.Format("{0:F}", Model.Price) %></div>
        <p>
            <%: Html.ActionLink("ใช้คูปองใบนี้","UseGiftCard",new{id=Model.Id}) %>
        </p>
        
    </fieldset>
    <table>
        <tr>
            <th>รายการที่ใช้ (วันที่)</th>
        </tr>
        <%foreach(var item in Model.GiftCardUsages) {%>
            <tr>
                <td><%: item.Date.ToShortDateString() %></td>
            </tr>
        <%} %>
    </table>

    <p>

        <%: Html.ActionLink("Edit", "Edit", new { id=Model.Id }) %> |
        <%: Html.ActionLink("Back to List", "Index") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

