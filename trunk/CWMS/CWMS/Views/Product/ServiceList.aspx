<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.ProductGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ServiceList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <a id="anchor-table-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>บริการทั้งหมด</h1>        
          <table>
          <%foreach(var item in Model){ %>
            <tr>
                <th class="top" scope="col" colspan="2"><%: item.Name %></th>
            </tr>
            <%foreach(var service in item.Products.Where(x=>x.IsService)){ %>
                <tr>
                    <td><%: Html.ActionLink(service.Name,"ServiceDetails",new{productId=service.Id}) %></td>
                    <td style="width: 30px;">[ <%: Html.ActionLink("ลบ","DeleteService",new{serviceId=service.Id}) %> ]</td>
                </tr>
            <%} %>
        <%} %>
            <tr>
                <th class="top" scope="col" colspan="2">ไม่ระบุกลุ่ม</th>
            </tr>
            <%foreach (var item in (IEnumerable<CWMS.Models.Product>)ViewData["allUngroupedServices"])
              { %>
            <tr>
                <td>
                    <%: Html.ActionLink(item.Name,"ServiceDetails",new{productId =item.Id}) %>
                </td>
                <td style="width: 30px;">
                    [ <%: Html.ActionLink("ลบ","DeleteService",new{serviceId=item.Id}) %> ]
                </td>
            </tr>
            <%} %>
            </table>
          <p class="caption"></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>  
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

