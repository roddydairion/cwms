using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CWMS.Models
{
    public partial class Order
    {
        public decimal TotalPrice
        {
            get
            {
                return this.OrderItems.Sum(x => x.TotalPrice);
            }
        }
    }
}