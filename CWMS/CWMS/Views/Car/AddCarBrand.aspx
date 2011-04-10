<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddCarBrand
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">เพิ่มยี่ห้อรถ</h1>
          <div class="contactform">
            <%using(Html.BeginForm()) {%>
              <fieldset><legend>&nbsp;รายละเอียด&nbsp;</legend>
                <p><label for="contact_firstname_1" class="left">ยี่ห้อ:</label>
                    <%: Html.TextBox("name",null, new {@class="field"}) %></p>
                    <p><input type="submit" value="เพิ่ม" class="button"/></p>
                </fieldset>
            <%} %>
          </div>
          <table>
            <%foreach(CWMS.Models.CarBrand carBrand in (IEnumerable<CWMS.Models.CarBrand>)ViewData["carBrands"]){ %>
                <tr>
                    <th class="top"><%: carBrand.Name %> <%= Html.ActionLink("[ ลบ ]","DeleteCarBrand",new{id=carBrand.Id}) %></th>
                </tr>
                <%foreach(CWMS.Models.CarModel carModel in carBrand.CarModels){ %>
                    <tr><td>
                        - <%: carModel.Name %> <%= Html.ActionLink("[ ลบ ]","DeleteCarModel",new{id = carModel.Id}) %>
                        </td>
                    </tr>
                <%} %>
                <tr>
                    <td><div class="contactform">
                        <%using(Html.BeginForm("AddCarModel","Car")){ %>
                            <p>
                                <%: Html.Hidden("carBrandId",carBrand.Id) %>
                                <%: Html.TextBox("name", null, new { @class = "field2" })%>
                               
                                <input type="submit" value="เพิ่ม" class="button"/></p>
                            
                            
                        <%} %>
                    </td>
                    </div>
                </tr>
            <%} %>
          </table>             
        </div> 
        <div class="corner-content-1col-bottom"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>


