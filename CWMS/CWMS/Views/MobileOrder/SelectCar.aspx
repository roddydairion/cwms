<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="header">
        <h1>ค้นหารถ</h1>
        
    </div> 
    <br />
	<div data-role="content">
        <%using(Html.BeginForm()) {%>
            <div data-role="fieldcontain">
                <label for="search">ค้นหาทะเบียน:</label>
                <input type="search" name="registrationNumber" id="registrationNumber" />
                <input type="submit" value="ค้นหา" />
            </div>
        <%} %>
    </div>
    <br />
	<div data-role="footer">
         <h4>Mr. Kleane Ordering System</h4>
    </div> 
</asp:Content>
