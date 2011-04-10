using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CWMS.Models
{
    public partial class Component
    {
        public decimal CurrentQuantity
        {
            get
            {
                return this.ComponentStocks.Sum(x => x.CurrentQuantity);
            }
        }
    }
}