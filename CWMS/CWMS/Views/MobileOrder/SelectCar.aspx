<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
        <h1 class="top-aligned">ค้นหารถ</h1>
        
	<div class="box-flat">
        <%using(Html.BeginForm()) {%>
                <label for="search">ค้นหาทะเบียน:</label>
                <input type="text" name="registrationNumber" id="registrationNumber" />
                <input type="submit" value="ค้นหา" />

        <%} %>
    </div>
    <br />
</asp:Content>
