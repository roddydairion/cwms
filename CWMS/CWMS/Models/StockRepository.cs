using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CWMS.Models
{
    public class StockRepository
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();

        public void AddComponentStock(int componentId, decimal originalQuantity, DateTime date, decimal cost, int supplierId)
        {
            ComponentStock newComponentStock = new ComponentStock
            {
                ComponentId = componentId,
                CurrentQuantity = originalQuantity,
                OriginalQuantity = originalQuantity,
                Date = date,
                Cost = cost,
                SupplierId = supplierId
            };
            db.ComponentStocks.InsertOnSubmit(newComponentStock);
            Save();
        }
        public List<TempComponentStockQuantity> SubtractComponentStock(int componentId, decimal quantity)
        {
            List<TempComponentStockQuantity> componentStocks = new List<TempComponentStockQuantity>();
            while (quantity > 0)
            {
                ComponentStock componentStock = GetAvailableComponentStock(componentId);
                if (componentStock.CurrentQuantity >= quantity)
                {
                    componentStocks.Add(new TempComponentStockQuantity
                    {
                        ComponentStockId = componentStock.Id,
                        Quantity = quantity
                    });
                    componentStock.CurrentQuantity = componentStock.CurrentQuantity - quantity;
                    Save();
                    quantity = 0;
                }
                else
                {
                    componentStocks.Add(new TempComponentStockQuantity
                    {
                        ComponentStockId = componentStock.Id,
                        Quantity = componentStock.CurrentQuantity
                    });
                    quantity = quantity - componentStock.CurrentQuantity;
                    componentStock.CurrentQuantity = 0;
                    Save();
                }
            }
            return componentStocks;
        }
        public ComponentStock GetAvailableComponentStock(int componentId)
        {
            return db.ComponentStocks.Where(x=>x.ComponentId == componentId).Where(x => x.CurrentQuantity > 0).OrderBy(x => x.Date).First();
        }

        public void AddProductStock(int productId, decimal originalQuantity, DateTime date, decimal cost, int supplierId)
        {
            ProductStock newProductStock = new ProductStock
            {
                ProductId = productId,
                CurrentQuantity = originalQuantity,
                OriginalQuantity = originalQuantity,
                Date = date,
                Cost = cost,
                SupplierId = supplierId
            };
            db.ProductStocks.InsertOnSubmit(newProductStock);
            Save();
        }
        public List<TempProductStockQuantity> SubtractProductStock(int productId, decimal quantity)
        {
            List<TempProductStockQuantity> productStocks = new List<TempProductStockQuantity>();
            while (quantity > 0)
            {
                ProductStock productStock = GetAvailableProductStock(productId);
                if (productStock.CurrentQuantity >= quantity)
                {
                    productStocks.Add(new TempProductStockQuantity
                    {
                        ProductStockId = productStock.Id,
                        Quantity = quantity
                    });
                    productStock.CurrentQuantity = productStock.CurrentQuantity - quantity;
                    Save();
                    quantity = 0;
                }
                else
                {
                    productStocks.Add(new TempProductStockQuantity
                    {
                        ProductStockId = productStock.Id,
                        Quantity = productStock.CurrentQuantity
                    });
                    quantity = quantity - productStock.CurrentQuantity;
                    productStock.CurrentQuantity = 0;
                    Save();
                }
            }

            return productStocks;
        }
        public ProductStock GetAvailableProductStock(int productId)
        {
            return db.ProductStocks.Where(x=>x.ProductId == productId).Where(x => x.CurrentQuantity > 0).OrderBy(x => x.Date).First();
        }

        public void Save() { db.SubmitChanges(); }
    }
}