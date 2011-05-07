using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
namespace CWMS.Controllers
{
    public class CustomerController : Controller
    {
        CustomerRepository repository = new CustomerRepository();
        ProductRepository productRepository = new ProductRepository();
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public ActionResult EditCar(int id,FormCollection formValues)
        {
            Car car = repository.GetCar(id);
            UpdateModel(car);
            repository.Save();
            return PartialView("_CarDetails", car);
                
        }
        public ActionResult SearchCar(string s)
        {
            ViewData["allProductGroups"] = productRepository.AllProductGroup();
            ViewData["allUngroupProducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            return View("Index", repository.SearchCar(s));
        }
        public ActionResult DeleteCustomer(int id)
        {
            Customer customer = repository.GetCustomer(id);
            try
            {
                repository.DeleteCustomer(id);
                return RedirectToAction("Index");
            }
            catch {
                return RedirectToAction("Index");
            }
        }
        public ActionResult DeleteCar(int id)
        {

            Car car = repository.GetCar(id);
            int customerId = car.CustomerId.Value;
            try
            {
                repository.DeleteCar(id);
                return RedirectToAction("Details", new { id = customerId });
            }
            catch { return RedirectToAction("Details", new { id = customerId }); }
        }
        [HttpPost]
        public ActionResult AddCar(string registrationNumber, string customerName,int carModelId)
        {
            Customer customer = repository.GetCustomer(customerName);
            int carId;
            if (customer != null)
            {
                carId = repository.AddCar(registrationNumber, customer.Id,carModelId);
            }
            else
            {
                int customerId = repository.AddCustomer(customerName, "", "", "");
                carId = repository.AddCar(registrationNumber, customerId,carModelId);
            }
            return PartialView("_CarDetails", repository.GetCar(carId));

        }
        [HttpPost]
        public ActionResult AddCar2(string registrationNumber, int customerId, int carModelId)
        {
            try
            {
                Customer customer = repository.GetCustomer(customerId);

                repository.AddCar(registrationNumber, customerId, carModelId);

               
            }
            catch { }
            ViewData["allCarBrands"] = repository.AllCarBrands();
            return RedirectToAction("Details", new { id = customerId });

        }
        [HttpPost]
        public ActionResult EditCustomer(int Id, FormCollection formValues)
        {
            try
            {
                Customer customer = repository.GetCustomer(Id);
                UpdateModel(customer);
                repository.Save();
            }
            catch { }
            ViewData["allCarBrands"] = repository.AllCarBrands();
            return RedirectToAction("Details", new { id = Id });
        }

        public ActionResult AddCarToCustomer(int carId, int customerId)
        {
            Car car = db.Cars.FirstOrDefault(x => x.Id == carId);
            car.CustomerId = customerId;
            db.SubmitChanges();
            return RedirectToAction("Details", new { id = customerId });
        }
        public ActionResult Details(int id)
        {
            ViewData["allCarBrands"] = repository.AllCarBrands();
            ViewData["nullCustomerCars"] = db.Cars.Where(x => !x.CustomerId.HasValue);
            return View(repository.GetCustomer(id));
        }
        public ActionResult Search(string s)
        {
            ViewData["allProductGroups"] = productRepository.AllProductGroup();
            ViewData["allUngroupProducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            return View("Index",repository.AllCustomers().Where(x=>x.Name.Contains(s)));
        }
        public ActionResult Index()
        {
            ViewData["nullCustomerCars"] = db.Cars.Where(x => !x.CustomerId.HasValue);
            ViewData["allProductGroups"] = productRepository.AllProductGroup();
            ViewData["allUngroupProducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            
            return View(repository.AllCustomers().OrderByDescending(x=>x.Id).Take(10));
        }
        [HttpPost]
        public ActionResult Index(string name, string address, string telephone, string note)
        {
            try
            {
                repository.AddCustomer(name, note, address, telephone);
            }
            catch { }

            ViewData["allProductGroups"] = productRepository.AllProductGroup();
            ViewData["allUngroupProducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            return View(repository.AllCustomers().OrderByDescending(x=>x.Id).Take(10));
        }


    }
}
