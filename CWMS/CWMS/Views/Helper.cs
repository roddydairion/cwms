using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CWMS.Models;
using System.Globalization;
namespace CWMS.Views
{
    public class Helper
    {
        public string DateDropDownList(string prefix, DateTime date)
        {
            string result = "";
            result += "<select class=\"combo\" style=\"width: 50px;\" id=\"" + prefix + "Day\"" + "name=\"" + prefix + "Day\">";
            for (int i = 1; i <= 31; i++)
            {
                result += "<option value=\"" + i.ToString() + "\"";
                if (date.Day == i)
                    result += " selected";
                result += ">"+i.ToString()+"</option>";
                    
            }
            result += "</select>&nbsp;&nbsp;&nbsp;";

            result += "<select class=\"combo\" style=\"width: 100px;\" id=\"" + prefix + "Month\"" + "name=\"" + prefix + "Month\">";
            for (int i = 1; i <= 12; i++)
            {
                result += "<option value=\"" + i.ToString() + "\"";
                if (date.Month == i)
                    result += " selected";

                result += ">" + CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(i).ToString() + "</option>";

            }
            result += "</select>&nbsp;&nbsp;&nbsp;";

            result += "<select class=\"combo\" style=\"width: 60px;\" id=\"" + prefix + "Year\"" + "name=\"" + prefix + "Year\">";
            for (int i = (DateTime.Now.Year + 543) - 10; i <= (DateTime.Now.Year + 543); i++)
            {
                result += "<option value=\"" + i.ToString() + "\"";
                if ((date.Year + 543) == i)
                    result += " selected";

                result += ">" + i.ToString() + "</option>";

            }
            result += "</select>";
            return result;
        }
    }
}