<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<CWMS.Models.Order>>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>AllOrderListPrint</title>
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
        tr
        {
            page-break-inside:avoid; 
            page-break-after:auto;
        }
    </style>
</head>

<body>

<div style="font-size: 14px;">
<%DateTime start = (DateTime)ViewData["start"];
  DateTime end = (DateTime)ViewData["end"]; %>
<center><h2>สรุปรายงานการขาย</h2></center>

<center><h3>

<%if(start.Date == end.Date){ %>
ประจำวันที่ <%:start.ToLongDateString() %>
<%} else if((start.Date.Month == end.Date.Month)&&(start.Day == 1)&&(end.Day == DateTime.DaysInMonth(end.Year,end.Month))){%>
    ประจำเดือน <%= System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(start.Month) %> <%= start.Year+543 %> 
<%} else {%>
    ระหว่างวันที่ <%: start.ToLongDateString() %> ถึง <%:end.ToLongDateString() %>
<%} %> 

</h3></center>

    <table>

    <thead>
        <tr>
            <th>
                เลขที่
            </th>
            <th>
                วันที่
            </th>
            <th>เวลา</th>
            <th style="width: "30%";>
                ลูกค้า
            </th>
            <th>
                ราคารวม
            </th>
            <th>
                ชำระแล้ว
            </th>
            <th>
                คงเหลือ
            </th>
        </tr>
        </thead>

    <% 
        decimal totalPrice = 0;
        decimal paid = 0;
        decimal remain = 0;
    
        %>
        <tbody>
        <%    
        foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: item.Id.ToString().PadLeft(8,'0') %>
            </td>
            <td>
                <%: item.OrderDate.ToShortDateString() %>
            </td>
            <td>
                <%: item.OrderDate.ToShortTimeString() %>
            </td>
            <td>
                <%try
                  { %>
                    <%: item.Car.RegistrationNumber%>
                <%}catch{ %>
                -
                <%} %>
            </td>
            <td>
                <%try
                  { %>
                    <%: item.TotalPrice.ToString("N2")%>
                <%
                      totalPrice += item.TotalPrice;
                    }catch{ %>
                <%} %>
            </td>
            <td>
                <%
           decimal x = 0;
                    try
                  { %>
                    <%: item.Paid.Value.ToString("N2")%>
                <%
                      paid += item.Paid.Value;
                    x = item.Paid.Value;
                    }
                  catch{ %>
                  0.00
                <%} %>
            </td>
            <td>
                <%: (item.TotalPrice-x).ToString("N2") %>
                <%remain += (item.TotalPrice - x); %>
            </td>
        </tr>
    
    <% } %>
    </tbody>
        <tr>
            <th colspan="4" class="center">รวม</th>
            <th><%:totalPrice.ToString("N2") %></th>
            <th><%:paid.ToString("N2") %></th>
            <th><%:remain.ToString("N2") %></th>
        </tr>
    </table>
    </div>
    <div class="printOption" id="printOption">
<input type="submit" value="Print" onclick="document.getElementById('printOption').style.visibility = 'hidden'; 
                window.print(); return true;" />
</div>
</body>
</html>

