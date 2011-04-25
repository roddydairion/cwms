<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Mobile.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="header">
        <h1>เพิ่มรถใหม่</h1>
        
    </div> 
    <br />
	<div data-role="content">
        <%using(Html.BeginForm()) {%>
            <div data-role="fieldcontain">
                <label for="registrationNumber">เลขทะเบียน:</label>
                <input type="text" name="registrationNumber" id="registrationNumber" value="<%: ViewData["registrationNumber"] %>"/>
              
                <%//= Html.DropDownList("carModel","เลือกรุ่น...", %>
                <input type="submit" value="เพิ่ม" />
            </div>
        <%} %>
    </div>
    <br />
	<div data-role="footer">
         <h4>Mr. Kleane Ordering System</h4>
    </div> 
</asp:Content>
