<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.CarBrand>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
        <h1 class="top-aligned">เลือกยี่ห้อ [<%:ViewData["registrationNumber"].ToString() %>]</h1>
        <nav>
            <ul class="list group">
                <%foreach (var item in Model)
                  { %>
                    <li class="group">
                        <%: Html.ActionLink(item.Name,"SelectCarModel",new{
                        re=ViewData["registrationNumber"].ToString().Trim(),
                        carBrandId = item.Id
                        })%>
                    </li>
                <%} %>
            </ul>
        </nav>
    <br />
</asp:Content>
