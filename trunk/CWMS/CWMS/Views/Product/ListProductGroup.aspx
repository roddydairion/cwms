<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.ProductGroup>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Add Product Group
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">เพิ่มกลุ่มบริการ</h1>
          <div class="contactform">
            <% using (Html.BeginForm()){ %>
              <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">ชื่อ:</label>
                    <%: Html.TextBox("name",null, new { @class = "field" }) %></p>
                
                
                <p><input type="submit" name="submit" id="submit_1" class="button" value="บันทึกข้อมูล" tabindex="6" /></p>
              </fieldset>
            <%} %>
          </div>   
          
          <table>
            <tr><th class="top">กลุ่มสินค้าและบริการ</th></tr>
            <%foreach(var item in Model){ %>
                <tr><td><%: item.Name %> [ <%= Html.ActionLink("ลบ", "DeleteProductGroup", new { id = item.Id }) %> ]</td></tr>
            <%} %>
          </table>           
        </div> 
        <div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>
