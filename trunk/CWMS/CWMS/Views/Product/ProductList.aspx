<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.ProductGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ServiceList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <a id="anchor-table-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>สินค้าทั้งหมด</h1>        
          <table>
          <%foreach(var item in Model){ %>
            <tr>
                <th class="top" scope="col" colspan="4">กลุ่ม: <%: item.Name%></th>
            </tr>
            <%foreach(var product in item.Products.Where(x=>!x.IsService)){ %>
                <tr>
                    <td>
                    <%try
                      { %>
                    <%= Html.ActionLink(product.BarCode, "ProductStockDetails", "Stock", new { productId = product.Id }, null)%>
                    <%}
                      catch { } %>
                    </td>
                    <td><%= Html.ActionLink(product.Name,"ProductStockDetails","Stock",new{productId=product.Id},null)%></td>
                    <td align="right" style="text-align: right; width: 30px;">
                    <%try
                      { %>
                    <%= product.CurrentPrice.ToString("n2")%> บาท
                    <%}
                      catch { }%>
                    </td>
                    <td style="width: 30px;">[ <%: Html.ActionLink("ลบ","DeleteProduct",new{productId=product.Id}) %> ]</td>
                </tr>
            <%} %>
            <%} %>
            <tr>
                <th class="top" scope="col" colspan="4">ไม่ระบุกลุ่ม</th>
            </tr>
            <%foreach(var item in (IEnumerable<CWMS.Models.Product>)ViewData["allUngroupedProducts"]){ %>
            <tr>
                <td>
                <%try
                  { %>
                <%= Html.ActionLink(item.BarCode, "ProductStockDetails", "Stock", new { productId = item.Id }, null)%>
                <%}
                  catch { } %>
                </td>
                <td>

                <%= Html.ActionLink(item.Name,"ProductStockDetails","Stock",new{productId=item.Id},null)%></td>
                <td align="right" style="text-align: right; width: 30px;">
                <%try
                  { %>
                    <%= item.CurrentPrice.ToString("n2")%> บาท
                    <%}
                  catch { }%>
                    </td>
                <td width="20%">[ <%: Html.ActionLink("ลบ","DeleteProduct",new{productId=item.Id}) %> ]</td>
                
                
            </tr>
            <%} %>
            </table>
          <p class="caption"></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>  
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

