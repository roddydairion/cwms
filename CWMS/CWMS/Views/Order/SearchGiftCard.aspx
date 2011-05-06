<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.GiftCard>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SearchGiftCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>SearchGiftCard</h2>

    <table>
        <tr>
            <th></th>
            <th>
                Number
            </th>
            <th>
                OriginalQuantity
            </th>
            <th>
                CurrentQuantity
            </th>
            <th>
                CarId
            </th>
            <th>
                Price
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
                <%: item.CarId %>
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

