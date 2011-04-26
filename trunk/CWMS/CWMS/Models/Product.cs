using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CWMS.Models;

namespace CWMS.Models
{
    public partial class Product
    {
        public Price CurrentPriceEntity
        {
            get
            {
                    return this.Prices.OrderByDescending(x => x.Date).FirstOrDefault();
            }
        }
        public decimal CurrentPrice
        {
            get
            {
                return this.Prices.OrderByDescending(x => x.Date).FirstOrDefault().Amount;
            }
        }
        public decimal? CurrentServicePrice(int carModelId)
        {
            if (this.Prices.Any(x => x.CarModelId == carModelId))
            {
                return this.Prices.Where(x => x.CarModelId == carModelId).OrderByDescending(x => x.Date).FirstOrDefault().Amount;
            }
            else
            {
                return null;
            }
        }
        public Price CurrentServicePriceEntity(int carModelId)
        {
            try
            {
                return this.Prices.FirstOrDefault(x => x.CarModelId.Value == carModelId);
            }
            catch
            {
                return null;
            }
        }
        public decimal CurrentQuantity
        {
            get
            {
                return this.ProductStocks.Sum(x => x.CurrentQuantity);
            }
        }
       
    }
}