using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;

namespace CWMS.Controllers
{
    public class StockController : Controller
    {
        ProductRepository productRepository = new ProductRepository();
        SupplierRepository supplierRepository = new SupplierRepository();
        StockRepository stockRepository = new StockRepository();
        public ActionResult AddSupplier()
        {
            return View(supplierRepository.AllSuppliers());
        }
        [HttpPost]
        public ActionResult AddSupplier(string name,string address,string telephone)
        {
            supplierRepository.AddSupplier(name, address, telephone);
            return RedirectToAction("AddSupplier");
        }
        public ActionResult ProductStockDetails(int productId)
        {
            Product product = productRepository.Get(productId);
            ViewData["productGroups"] = productRepository.AllProductGroup();
            ViewData["suppliers"] = supplierRepository.AllSuppliers();
            return View(product);
        }
        public ActionResult ComponentStockDetails(int componentId)
             
        {
            ViewData["suppliers"] = supplierRepository.AllSuppliers();
            return View(productRepository.GetComponent(componentId));
        }
        public ActionResult ProductStocksList()
        {
            ViewData["suppliers"] = supplierRepository.AllSuppliers();
            ViewData["products"] = productRepository.AllProducts();
            ViewData["components"] = productRepository.AllComponents();
            return View();
        }
        [HttpPost]
        public ActionResult AddProductStock(int productId, int supplierId, decimal cost, decimal originalQuantity, string Day, string Month,string Year)
        {
            try
            {
                DateTime date = DateTime.Parse(Day + '/' + Month + '/' + Year);
                stockRepository.AddProductStock(productId, originalQuantity, date, cost, supplierId);
                ViewData["productGroups"] = productRepository.AllProductGroup();
                return RedirectToAction("ProductStockDetails", new { productId = productId });
            }
            catch
            {
                return RedirectToAction("ProductStocksList");
            }
        }
        [HttpPost]
        public ActionResult AddComponentStock(string Day, string Month,string Year,int componentId, int supplierId, decimal cost, decimal originalQuantity)
        {
            try
            {

                DateTime date = DateTime.Parse(Day + '/' + Month + '/' + Year);
                stockRepository.AddComponentStock(componentId, originalQuantity, date, cost, supplierId);
                return RedirectToAction("ComponentStockDetails", new { componentId = componentId });
            }
            catch
            {
                return RedirectToAction("ProductStockList");
            }
        }
        public ActionResult Index()
        {
            return View();
        }

    }
}
