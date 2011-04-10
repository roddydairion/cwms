using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace CWMS.Models
{
    public partial class Customer
    {
        public IEnumerable<Order> AllOrders
        {
            get
            {
                List<Order> orders = new List<Order>();
                foreach (var car in this.Cars)
                {
                    foreach (var order in car.Orders)
                    {
                        orders.Add(order);
                    }
                }
                return orders.AsEnumerable();
            }
        }
    }
}