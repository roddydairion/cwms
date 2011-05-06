<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.CarModel>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% CWMS.Models.CarBrand brand = ViewData["carBrand"] as CWMS.Models.CarBrand; %>
        <h1 class="top-aligned">เลือกรุ่น [ <%:brand.Name %>-<%:ViewData["registrationNumber"].ToString() %>]</h1>
        <nav>
            <ul class="list group">
                <%foreach (var item in Model)
                  { %>
                    <li class="group">
                        <%: Html.ActionLink(item.Name,"AddNewCar",new{
                        re=ViewData["registrationNumber"].ToString().Trim(),
                        carModelId = item.Id
                        })%>
                    </li>
                <%} %>
            </ul>
        </nav>
    <br />
</asp:Content>
