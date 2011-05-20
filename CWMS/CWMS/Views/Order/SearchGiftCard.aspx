<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.GiftCard>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	SearchGiftCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="corner-content-1col-top"></div>                        
<div class="content-1col-nobox">
    <h1 class="contact">คูปองทั้งหมด</h1>
    <div class="contactform">
        <fieldset>
        <legend>ค้นหา</legend>
        <% using(Html.BeginForm("SearchGiftCard","Order",FormMethod.Get)){%>
            <p><label for="contact_firstname_1" class="left">เลขที่:</label>
                <%: Html.TextBox("number", "", new { @class = "field" })%>
                </p>

                <p>
                <input type="submit" value="ค้นหา" class="button"/>
            </p>
            
        <%} %>
        </fieldset>
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
    <br />
    </div>
</div>    
<div class="corner-content-1col-bottom"></div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

