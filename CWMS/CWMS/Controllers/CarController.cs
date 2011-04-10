using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
namespace CWMS.Controllers
{
    public class CarController : Controller
    {
        CustomerRepository customerRepository = new CustomerRepository();
        public ActionResult DeleteCarBrand(int id)
        {
            try
            {
                customerRepository.DeleteCarBrand(id);
            }
            catch { }
            return RedirectToAction("AddCarBrand");
        }
        public ActionResult DeleteCarModel(int id)
        {
            try
            {
                customerRepository.DeleteCarModel(id);
            }
            catch { }
            return RedirectToAction("AddCarBrand");
        }
        public ActionResult AddCarBrand() {
            ViewData["carBrands"] = customerRepository.AllCarBrands();
            return View(); }
        [HttpPost]
        public ActionResult AddCarBrand(string name)
        {
            int carBrandId = customerRepository.AddCarBrand(name);
            return RedirectToAction("AddCarBrand");
        }
        public ActionResult AddCarModel(int carBrandId, string name)
        {
            customerRepository.AddCarModel(carBrandId, name);
            return RedirectToAction("AddCarBrand");
        }
        
        public ActionResult CarBrandDetails(int id)
        {
            return View(customerRepository.GetCarBrand(id));
        }
        public ActionResult Index()
        {
            return View();
        }

    }
}
