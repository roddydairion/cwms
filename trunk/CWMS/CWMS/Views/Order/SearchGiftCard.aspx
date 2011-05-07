<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.GiftCard>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SearchGiftCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>ค้นหาคูปอง</h2>
    <% using(Html.BeginForm("SearchGiftCard","Order",FormMethod.Get)){%>
        เลขที่: <%: Html.TextBox("number") %>
        <p>
            <input type="submit" value="ค้นหา" />
        </p>
    <%} %>
    <table>
        <tr>
            <th></th>
            <th>
                หมายเลข
            </th>
            <th>
                จำนวนเริ่มต้น
            </th>
            <th>
                จำนวนคงเหลือ (ครั้ง)
            </th>
            <th>
                รถ
            </th>
            <th>
                ราคา
            </th>
        </tr>

    <% foreach (var item in Model.Take(10)) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("รายละเอียด", "GiftCardDetails", new { id=item.Id })%>
            </td>
            <td>
                <%: item.Number %>
            </td>
            <td>
                <%: item.OriginalQuantity %>
            </td>
            <td>
                <%: item.CurrentQuantity %>
            </td>
            <td>
                <%: item.Car.RegistrationNumber %>
            </td>
            <td>
                <%: String.Format("{0:F}", item.Price) %>
            </td>
        </tr>
    
    <% } %>

    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

