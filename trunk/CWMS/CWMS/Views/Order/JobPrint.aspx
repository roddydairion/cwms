<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CWMS.Models.Order>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Print Job</title>
    <style type="text/css">
        body
        {
            font-family: arial,sans-serif;
        }
        table 
        { 
            background-color: #FFFFFF;
            border-collapse: collapse;
            clear: both;
            empty-cells: show;
            margin: 2em 0 0.2em 20px;
            table-layout: fixed;
            width: 620px;
            page-break-inside:auto;
        }
        th
        {
            height: 2em;
            border: 1px solid #000000;
            padding: 4px;
            background-color: #E5E5E5;
            text-align: right;
            margin: 4 1 4 1;
        }
        th.center
        {
            text-align: center;
        }
        td
        {
            border: 1px solid #000000;
            text-align: right;
            padding: 4px 2px 4px 2px;
        }
        td.center
        {
            text-align:center
        }
        td.left
        {
            text-align:left;
        }
        tr
        {
            page-break-inside:avoid; 
            page-break-after:auto;
        }
    </style>
</head>

<body>

<div style="font-size: 14px;">
<center>Job Description : <%: Model.Id.ToString().PadLeft(6,'0') %></center>
<p><b>ลูกค้า:</b> <%: Model.Car.Customer.Name %></p>
<b>รถ:</b> <%: Model.Car.RegistrationNumber%> - <%:Model.Car.CarModel.CarBrand.Name %>: <%: Model.Car.CarModel.Name %>
<table>
<tr> 
        <th class="center">รายการ</th>
        <th class="center" style="width: 50px;">จำนวน</th> 
        <th class="center" style="width: 150px;">ราคารวม</th>
    </tr>
<%foreach(var item in Model.OrderItems){
      
      %>
    <tr> 
        <td class="left"><%:item.Product.Name %></td>
        <td class="center" style="width: 30px;"><%:item.Quantity.ToString("n0") %></td> 
        <td style="width: 150px;"><%: item.TotalPrice.ToString("N2") %></td>
    </tr>
<%} %>
</table>
<p><b>ราคารวม:</b> <%: Model.TotalPrice.ToString("N2") %></p>
<p><b>เวลานัด:</b> <%: Model.AppointmentDate.ToShortDateString() + " - " + Model.AppointmentDate.ToShortTimeString()%></p>
<center>
    ขอบคุณที่ใช้บริการ<br />
    Mr. Kleane System
    
</center>

    <div class="printOption" id="printOption">
<input type="submit" value="Print" onclick="document.getElementById('printOption').style.visibility = 'hidden'; 
                window.print(); return true;" />
</div>
</body>
</html>

