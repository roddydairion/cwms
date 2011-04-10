<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Component>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ComponentStockDetails
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>คลังสินค้า - <%: Model.Name %></h1>        
          <table>
             <tr><th class="top" scope="col" style="width: 80px;">วันที่</th><th class="top" scope="col" style="width: 70px;">จำนวนซื้อ</th><th class="top" scope="col" style="width: 70px;">คงเหลือ</th><th class="top" scope="col"style="width: 100px;">ราคาซื้อ</th><th class="top" scope="col" >ผู้ป้อนสินค้า</th></tr>
           <%
                foreach (var item in Model.ComponentStocks.OrderByDescending(x=>x.Date))
              { %>
                <tr>
                    <th scope="row" class="right"><%: item.Date.ToShortDateString() %></th>
                    <td class="right">
                        <%: item.OriginalQuantity %>
                    </td>
                    <td class="right">
                        <%: item.CurrentQuantity %>
                    </td>
                    <td class="right">
                        <%: item.Cost.ToString("n2") %>
                    </td>
                    <td class="right">
                        <%: item.Supplier.Name %>
                    </td>

                </tr>
            <%} %>            
            </table>
            
            <p class="caption"/>
            
            
        </div> 
        <div class="corner-content-1col-bottom"></div> 

        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
        <h1 class="contact">เพิ่มส่วนประกอบ</h1>            
              <div class="contactform">
                <%using (Html.BeginForm("AddComponentStock", "Stock", FormMethod.Post))
                  { %>
                  <fieldset><legend>&nbsp;รายละเอียด - <%:Model.Name %>&nbsp;</legend>
                   <%: Html.Hidden("componentId",Model.Id) %>
                   <p><label for="contact_firstname_3a" class="left">ผู้ป้อน:</label>
                        <%= Html.DropDownList("supplierId", new SelectList((IEnumerable<CWMS.Models.Supplier>)ViewData["suppliers"], "Id", "Name"), new { @class = "combo" })%></p>
                    <p><label for="contact_familyname_3a" class="left">จำนวนทั้งหมด:</label>
                        <%= Html.TextBox("originalQuantity", 0, new { @class = "smallfield" })%> <%: "(" + Model.Unit + ")" %></p>
                    <p><label for="contact_street_3a" class="left">ราคาซื้อรวม:</label>
                        <%= Html.TextBox("cost", 0, new { @class = "smallfield" })%> บาท</p>
                    <p><label for="contact_street_3a" class="left">วันที่:</label>
                        <%CWMS.Views.Helper helper = new CWMS.Views.Helper(); %>
                        <%= helper.DateDropDownList("",DateTime.Now)%></p>
                    <p><input type="submit" name="submit" id="submit1" class="button" value="เพิ่มการซื้อ" tabindex="6" /></p>
                  </fieldset>
                <%} %>
              </div>
              
            </div>
        <div class="corner-content-1col-bottom"></div>  
                



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
