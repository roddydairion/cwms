using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
namespace CWMS.Controllers
{
    public class ProductController : Controller
    {
        ProductRepository repository = new ProductRepository();
        CustomerRepository customerRepository = new CustomerRepository();
        
        public ActionResult AddServicePrices(int productId)
        {
            ViewData["carBrands"] = customerRepository.AllCarBrands();
            return View(repository.Get(productId));
        }
        public ActionResult DeleteProduct(int productId)
        {
            try
            {
                repository.Delete(productId);   
            }
            catch
            {
            }
            return RedirectToAction("ProductList");
            
        }
        public ActionResult DeleteService(int serviceId)
        {
            try
            {
                repository.Delete(serviceId);
            }
            catch
            {
            }
            return RedirectToAction("ServiceList");
        }
        [HttpPost]
        public ActionResult AddPrice(int productId, int carModelId, decimal amount, string returnPage)
        {
            ViewData["productGroups"] = repository.AllProductGroup();
            customerRepository.AddPrice(carModelId, productId, amount);
            switch (returnPage)
            {
                case "service":
                    return RedirectToAction("ServiceDetails", new { productId = productId });
                default:
                    return RedirectToAction("ProductDetails", new { productId = productId });
            }
        }
        [HttpPost]
        public ActionResult EditPrice(int priceId, decimal amount, string returnPage)
        {
            Price price = repository.GetPrice(priceId);
            price.Amount = amount;
            repository.Save();
            switch (returnPage)
            {
                case "service" :
                    return RedirectToAction("ServiceDetails",new {productId = price.ProductId});
                default :
                    return RedirectToAction("ProductDetails", new {productId = price.ProductId});
            }
        }
        public ActionResult ProductList()
        {
            ViewData["allUngroupedProducts"] = repository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            return View(repository.AllProductGroup());
        }
        [HttpPost]
        public ActionResult EditProduct(int id, FormCollection formValues)
        {
            Product product = repository.Get(id);
            UpdateModel(product);
            repository.Save();
            ViewData["productGroups"] = repository.AllProductGroup();
            return RedirectToAction("ProductStockDetails", "Stock", new { productId = id });
        }
        public ActionResult ListProductGroup()
        {
            return View(repository.AllProductGroup());
        }
        [HttpPost]
        public ActionResult ListProductGroup(string name)
        {
            repository.AddProductGroup(name);
            return RedirectToAction("ListProductGroup");
        }
        public ActionResult DeleteProductGroup(int id)
        {
            try
            {
                repository.DeleteProductGroup(id);
            }
            catch
            {
                repository.DeleteProductGroup(id);
            }
            return RedirectToAction("ListProductGroup");
        }

        public ActionResult AddProduct()
        {
            return View(repository.AllProductGroup());
        }
        [HttpPost]
        public ActionResult AddProduct(int? productGroupId,string barcode,string name, string unit,decimal price)
        {
            try
            {
                int productId = repository.AddProduct(productGroupId,barcode,name, unit,price);
                return RedirectToAction("ProductList");
            }
            catch { return View(); }
        }
        public ActionResult AddService()
        {
            ViewData["productGroups"] = repository.AllProductGroup();
            return View();
        }
        [HttpPost]
        public ActionResult AddService(string name, string unit, int? productGroupId)
        {
            int serviceId = repository.AddService(name, unit, productGroupId);
            return RedirectToAction("ServiceDetails", new { productId = serviceId });
            
        }
        public ActionResult ServiceList()
        {
            ViewData["allUngroupedServices"] = repository.AllServices().Where(x => !x.ProductGroupId.HasValue);
            return View(repository.AllProductGroup());
        }
        [HttpPost]
        public ActionResult AddComponentToService(int productId, int componentId)
        {
            Product product = repository.Get(productId);
            product.ProductComponents.Add(new ProductComponent
            {
                ComponentId = componentId,
                Quantity = 1
            });
            repository.Save();
            return RedirectToAction("ServiceDetails", new { productId = productId });
        }
        public ActionResult ServiceDetails(int productId)
        {
            ViewData["components"] = repository.AllComponents();
            ViewData["carBrands"] = customerRepository.AllCarBrands();
            return View(repository.Get(productId));
        }
        public ActionResult AddComponent()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddComponent(string name,string unit)
        {
            int componentId = repository.AddComponent(name,unit);
            return RedirectToAction("ComponentStockDetails", "Stock", new { componentId = componentId });
        }

        public ActionResult Index()
        {
            return View();
        }

    }
}
