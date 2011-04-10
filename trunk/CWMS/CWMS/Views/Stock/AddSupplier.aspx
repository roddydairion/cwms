<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.Supplier>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Supplier List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
          <!-- Subcell LEFT -->
            <div class="corner-content-1col-top"></div>
            <div class="content-1col-nobox">
              <h1>ผู้ป้อนสินค้า</h1>
              <table>
                <%foreach(CWMS.Models.Supplier item in (Model)){ %>
                    <tr>
                        <th class="top"><strong><%:item.Name %></strong></th>
                        <td><%:item.Address + " โทร: " + item.Telephone%></td>

                    </tr>
                <%} %>
              </table>
              <div class="contactform">
                <%using(Html.BeginForm()){ %>
                    <fieldset>
                        <legend>เพิ่มผู้ป้อนใหม่</legend>
                        <p><label for="contact_street_3a" class="left">ชื่อ:</label>
                        <%= Html.TextBox("name",null, new { @class = "field" })%></p>
                        
                        <p><label for="contact_street_3a" class="left">ที่อยู่:</label>
                        <%= Html.TextArea("address",null, new { @class = "field" })%></p>
                        
                        <p><label for="contact_street_3a" class="left">โทรศัพท์:</label>
                        <%= Html.TextBox("telephone",null, new { @class = "field" })%></p>
                    <p><input type="submit" name="submit" id="submit2" class="button" value="เพิ่มการซื้อ" tabindex="6" /></p>
                  
                    </fieldset>
                <%} %>
              </div>
              <p class="caption"></p>
            </div>
            <div class="corner-content-1col-bottom"></div>

          
    


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">

</asp:Content>

