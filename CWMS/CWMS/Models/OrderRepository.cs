using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CWMS.Models
{
    public class OrderRepository
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        StockRepository stockRepository = new StockRepository();
        ProductRepository productRepository = new ProductRepository();

        public IEnumerable<GiftCard> AllGiftCards() { return db.GiftCards; }
        public IEnumerable<GiftCardUsage> AllSlotedGiftCardUsages()
        {
            return db.GiftCardUsages.Where(x => x.SlotNumber.HasValue);   
        }
        public IEnumerable<Order> AllUnSlotedOrders()
        {
            return db.Orders.Where(x=>x.CarId.HasValue).Where(x => x.OrderItems.Any(y => y.Product.IsService) && (!x.SlotNumber.HasValue)&&(!x.Paid.HasValue));
        }
        public IEnumerable<Order> SlotedOrder()
        {
            return db.Orders.Where(x=>x.CarId.HasValue).Where(x => x.OrderItems.Any(y => y.Product.IsService) && (x.SlotNumber.HasValue)&&(!x.Paid.HasValue)).OrderBy(x => x.SlotNumber.Value);
        }
        public Price GetPrice(int id) { return db.Prices.FirstOrDefault(x => x.Id == id); }
        public Order Get(int id)
        {
            return db.Orders.First(x => x.Id == id);
        }
        public IEnumerable<Order> AllOrders() { return db.Orders.OrderByDescending(x => x.OrderDate); }
        public IEnumerable<Order> AllUnfinishedOrders()
        {
            return db.Orders.OrderByDescending(x => x.OrderDate).Where(x =>
                !x.Paid.HasValue);
        }
        public IEnumerable<Order> AllFinishedOrders()
        {
            return db.Orders.OrderByDescending(x => x.OrderDate).Where(x =>
                x.Paid.HasValue);
        }
        public int InitiateOrder(int? carId, DateTime orderDate, DateTime appointmentDate, List<OrderItem> orderItems)
        {
            Order newOrder = new Order
            {
                CarId = carId,
                OrderDate = orderDate,
                AppointmentDate = appointmentDate,
            };
            foreach (var orderItem in orderItems)
            {
                OrderItem newOrderItem = new OrderItem
                {
                    ProductId = orderItem.ProductId,
                    Quantity = orderItem.Quantity,
                    PriceId = orderItem.PriceId,
                    TotalPrice = orderItem.Price.Amount * orderItem.Quantity
                };
                if (orderItem.Product.IsService)
                {
                    foreach(var productComponent in orderItem.Product.ProductComponents)
                    {
                        List<TempComponentStockQuantity> tempComponentStocks = stockRepository.SubtractComponentStock(productComponent.ComponentId, orderItem.Quantity);
                        foreach (var tempComponentStock in tempComponentStocks)
                        {
                            newOrderItem.OrderItemsStocks.Add(new OrderItemsStock
                            {
                                ComponentStockId = tempComponentStock.ComponentStockId,
                                Quantity = tempComponentStock.Quantity
                            });
                        }
                    }
                }
                else
                {
                    List<TempProductStockQuantity> tempProductStocks = stockRepository.SubtractProductStock(newOrderItem.ProductId, newOrderItem.Quantity);
                    foreach (var tempProductStock in tempProductStocks)
                    {
                        newOrderItem.OrderItemsStocks.Add(new OrderItemsStock
                        {
                            ProductStockId = tempProductStock.ProductStockId,
                            Quantity = tempProductStock.Quantity
                        });
                    }
                }
                newOrder.OrderItems.Add(newOrderItem);
            }
            db.Orders.InsertOnSubmit(newOrder);
            Save();
            return newOrder.Id;
        }
        public void FinishOrder(int orderId,DateTime acceptedDate,decimal paid)
        {
            Order order = Get(orderId);
            order.AcceptedDate = acceptedDate;
            order.Paid = paid;
            Save(); 
        }
        public void Save() { db.SubmitChanges(); }
    }
}