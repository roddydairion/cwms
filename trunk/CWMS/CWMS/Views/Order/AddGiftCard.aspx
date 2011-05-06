<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.GiftCard>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddGiftCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>ซื้อคูปอง</h2>
    <% CWMS.Models.Car car = ViewData["car"] as CWMS.Models.Car; %>
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>รายละเอียด</legend>
            
            <div class="editor-label">
                <%: Html.Label("เลขคูปอง") %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Number) %>
                <%: Html.ValidationMessageFor(model => model.Number) %>
            </div>
            
            <div class="editor-label">
                <%: Html.Label("จำนวนครั้ง") %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.OriginalQuantity) %>
                <%: Html.ValidationMessageFor(model => model.OriginalQuantity) %>
            </div>
            
            <div class="editor-label">
                <%: Html.Label( "รถ : " + car.RegistrationNumber + " [" + car.Customer.Name + "]") %>
            </div>
            <%: Html.Hidden("CarId", car.Id) %>
            <div class="editor-label">
                <%: Html.Label("ราคา") %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Price) %>
                <%: Html.ValidationMessageFor(model => model.Price) %>
            </div>
            
            <p>
                <input type="submit" value="เพิ่ม" />
            </p>
        </fieldset>

    <% } %>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

