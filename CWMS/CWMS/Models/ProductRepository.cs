using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CWMS.Models;

namespace CWMS.Models
{
    public class ProductRepository
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public void DeleteProductGroup(int id)
        {
            try
            {
                db.ProductGroups.DeleteOnSubmit(this.GetProductGroup(id));
                this.Save();
            }
            catch { }
        }
        public IEnumerable<ProductGroup> AllProductGroup() { return db.ProductGroups.OrderBy(x => x.Name); }
        public ProductGroup GetProductGroup(int id) { return db.ProductGroups.FirstOrDefault(x => x.Id == id); }
        public void AddProductGroup(string name)
        {
            db.ProductGroups.InsertOnSubmit(new ProductGroup
            {
                Name = name
            });
            Save();
        }
        public int AddProduct(int? productGroupId,string barcode,string name, string unit,decimal price)
        {
            Product newProduct = new Product
            {
                Name = name,
                Unit = unit,
                IsService = false,
                BarCode = barcode,
                ProductGroupId = productGroupId
            };

           newProduct.Prices.Add(new Price
            {
                Amount = price,
                Date = DateTime.Now
            });
            db.Products.InsertOnSubmit(newProduct);
            Save();
            return newProduct.Id;
        }
        public int AddComponent(string name, string unit)
        {
            Component newComponent = new Component
            {
                Name = name,
                Unit = unit
            };
            db.Components.InsertOnSubmit(newComponent);
            Save();
            return newComponent.Id;
        }
        public int AddService(string name, string unit,int? productGroupId)
        {
            Product newService = new Product
            {
                Name = name,
                Unit = unit,
                IsService = true,
                ProductGroupId = productGroupId
            };
            db.Products.InsertOnSubmit(newService);
            
            Save();
            return newService.Id;
        }
        public Component GetComponent(int id) { return db.Components.FirstOrDefault(x => x.Id == id); }
        public IEnumerable<Product> AllProducts() { return db.Products.Where(x=>!x.IsService); }
        public IEnumerable<Product> AllServices() { return db.Products.Where(x => x.IsService); }
        public IEnumerable<Product> AllProductsAndServices() { return db.Products; }
        public IEnumerable<Component> AllComponents() { return db.Components; }
        public Product Get(int id) { return db.Products.FirstOrDefault(x => x.Id == id); }
        public Price GetPrice(int id) { return db.Prices.FirstOrDefault(x => x.Id == id); }
        public void Delete(int id)
        {
            Product product = Get(id);
            db.ProductComponents.DeleteAllOnSubmit(product.ProductComponents);
            db.Prices.DeleteAllOnSubmit(product.Prices);
            db.Products.DeleteOnSubmit(product);
            Save();
        }
        public void Save() { db.SubmitChanges(); }
       
    }
}