<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.GiftCard>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddGiftCard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="corner-content-1col-top"></div>                        
    <div class="content-1col-nobox">
    <h1 class="contact">ซื้อคูปอง</h1>
    <div class="contactform">
    <% CWMS.Models.Car car = ViewData["car"] as CWMS.Models.Car; %>
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>รายละเอียด</legend>
            <p>
                <%: Html.Hidden("Date",DateTime.Now) %>
                <label class="left">เลขที่คูปอง:</label>
                <%: Html.TextBoxFor(model => model.Number, new { @class = "field" })%>
            </p>
            <p>
                <label class="left">จำนวนครั้ง:</label>
                <%: Html.TextBoxFor(model => model.OriginalQuantity, new { @class = "field" })%>
            </p>
            <p>
                <%string customerName = "ยังไม่ระบุเจ้าของ";
                  if (car.CustomerId != null)
                      customerName = car.Customer.Name; %>
                <label class="left">รายละเอียดรถ: </label><%:Html.TextBox("xx", car.RegistrationNumber + " [" + customerName + "]",new{@class="field",@readonly="true"})%>
            </p>
            <%: Html.Hidden("CarId", car.Id) %>
            <p>
                <label class="left">ราคา</label>
            
                <%: Html.TextBoxFor(model => model.Price, new { @class = "field" })%>
            
            </p>
            
            <p>
                <input type="submit" value="เพิ่ม" class="button"/>
            </p>
        </fieldset>

    <% } %>
    </div>
    </div>
<div class="corner-content-1col-bottom"></div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="SideBar" runat="server">
</asp:Content>

