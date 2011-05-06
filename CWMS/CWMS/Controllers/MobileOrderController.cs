using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
namespace CWMS.Controllers
{
    public class MobileOrderController : Controller
    {
        OrderRepository repository = new OrderRepository();
        ProductRepository productRepository = new ProductRepository();
        CustomerRepository customerRepository = new CustomerRepository();
        CWMS.Models.CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        [HttpGet]
        public ActionResult SelectCar()
        {
            return View("SelectCar");
        }
        [HttpPost]
        public ActionResult SelectCar(string registrationNumber)
        {
            Session.Clear();
            if (customerRepository.CheckCarAvailable(registrationNumber))
            {
                Car car = customerRepository.GetCar(registrationNumber);
                Session.Remove("car");
                Session.Add("car", car);
                return RedirectToAction("Index");
            }
            else
            {
                ViewData["registrationNumber"] = registrationNumber;
                return View("SelectCarBrand");
            }
        }

        public ActionResult AddNewCar(string re, int carModelId)
        {
            Car newCar = new Car
            {
                CarModelId = carModelId,
                RegistrationNumber = re.Trim()
            };
            db.Cars.InsertOnSubmit(newCar);
            db.SubmitChanges();
            Session.Remove("car");
            Session.Add("car", newCar);
            return RedirectToAction("Index");
                
        }
        public ActionResult SelectCarModel(string re, int carBrandId)
        {
            ViewData["registrationNumber"] = re;
            ViewData["carBrand"] = db.CarBrands.FirstOrDefault(x => x.Id == carBrandId);
            return View("SelectCarModel", ((CarBrand)ViewData["carBrand"]).CarModels);
        }
        public ActionResult ClearSessions()
        {
            Session.Clear();
            ViewData["allproductgroups"] = productRepository.AllProductGroup();
            ViewData["allproducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            ViewData["allservices"] = productRepository.AllServices().Where(x => !x.ProductGroupId.HasValue);
          
            return View("Index");
        }
        public ActionResult ClearProductSession()
        {
            Session.Remove("cart");
            return RedirectToAction("Index");
        }
        public ActionResult ClearCarSession()
        {
            Session.Clear();
            return RedirectToAction("Index");
        }
        public ActionResult Index()
        {
            ViewData["allproductgroups"] = productRepository.AllProductGroup();
            ViewData["allproducts"] = productRepository.AllProducts().Where(x => !x.ProductGroupId.HasValue);
            ViewData["allservices"] = productRepository.AllServices().Where(x => !x.ProductGroupId.HasValue);
            return View();
        }
    /*    public ActionResult AddItemToShoppingCart(int productId)
        {
            Product product = productRepository.Get(productId);
            if(Session["cart"] == null)
            {   
                List<OrderItem> orderItems = new List<OrderItem>();
                orderItems.Add(new OrderItem{
                    Product = product,
                    Price = product.CurrentPriceEntity,
                    Quantity = 1,
                    TotalPrice = product.CurrentPrice
                });
                Session.Remove("cart");
                Session.Add("cart",orderItems);
            }
            else
            {
                if (((List<OrderItem>)Session["cart"]).Any(x => x.ProductId == productId))
                {
                    List<OrderItem> orderItems = (List<OrderItem>)Session["cart"];
                    OrderItem orderItem = orderItems.FirstOrDefault(x => x.ProductId == productId);
                    //orderItems.Remove(orderItem);
                    orderItem.Quantity += 1;
                    orderItem.TotalPrice += product.CurrentPrice;

                    
                    //orderItems.Add(orderItem);
                    Session.Remove("cart");
                    Session.Add("cart", orderItems);
                }
                else
                {
                    List<OrderItem> orderItems = (List<OrderItem>)Session["cart"];
                    orderItems.Add(new OrderItem{
                        Product = product,
                        Price = product.CurrentPriceEntity,
                        Quantity = 1,
                        TotalPrice = product.CurrentPrice});
                    Session.Remove("cart");
                    Session.Add("cart", orderItems);
                }
            }
            return RedirectToAction("Index");
        }*/
        public ActionResult AddItemToShoppingCart(int productId, int? carId)
        {
            Product product = productRepository.Get(productId);

            if ((Session["cart"] == null) || (((List<OrderItem>)Session["cart"]).Count == 0))
            {
                Price price = new Price();
                if (product.IsService)
                {
                    Car car = customerRepository.GetCar(carId.Value);
                    price = product.CurrentServicePriceEntity(car.CarModelId.Value);
                }
                else
                {
                    price = product.CurrentPriceEntity;
                }
                OrderItem orderItem = new OrderItem
                {
                    Product = product,
                    Price = price,
                    Quantity = 1,
                    TotalPrice = price.Amount * 1
                };
                List<OrderItem> orderItems = new List<OrderItem>();
                orderItems.Add(orderItem);
                Session.Add("cart", orderItems);
            }
            else
            {
                if (((List<OrderItem>)Session["cart"]).Any(x => x.ProductId == productId))
                {
                    List<OrderItem> orderItems = (List<OrderItem>)Session["cart"];
                    OrderItem orderItem = orderItems.FirstOrDefault(x => x.ProductId == productId);
                    //orderItems.Remove(orderItem);
                    Price price = new Price();
                    if (product.IsService)
                    {
                        Car car = customerRepository.GetCar(carId.Value);
                        price = product.CurrentServicePriceEntity(car.CarModelId.Value);
                    }
                    else
                    {
                        price = product.CurrentPriceEntity;
                    }
                    orderItem.Quantity += 1;
                    orderItem.TotalPrice += price.Amount;


                    //orderItems.Add(orderItem);
                    Session.Remove("cart");
                    Session.Add("cart", orderItems);
                }
                else
                {
                    List<OrderItem> orderItems = (List<OrderItem>)Session["cart"];
                    Price price = new Price();
                    if (product.IsService)
                    {
                        Car car = customerRepository.GetCar(carId.Value);
                        price = product.CurrentServicePriceEntity(car.CarModelId.Value);
                    }
                    else
                    {
                        price = product.CurrentPriceEntity;
                    }
                    orderItems.Add(new OrderItem
                    {
                        Product = product,
                        Price = price,
                        Quantity = 1,
                        TotalPrice = price.Amount
                    });
                    Session.Remove("cart");
                    Session.Add("cart", orderItems);
                }


            }
            if (carId.HasValue)
            {
                ViewData["carId"] = carId;
                ViewData["carRegistrationNumber"] = customerRepository.GetCar(carId.Value).RegistrationNumber;
            }
            return RedirectToAction("Index");
        }
        public ActionResult OrderConfirmation()
        {
            if (Session["cart"] == null)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ViewData["car"] = Session["car"];
                return View(((List<OrderItem>)Session["cart"]).AsEnumerable());
            }
        }
        public ActionResult FinishOrder()
        {   
            int? carId = null;
            if(Session["car"] != null)
                carId = ((Car)Session["car"]).Id;
            repository.InitiateOrder(carId, DateTime.Now, DateTime.Now, (List<OrderItem>)Session["cart"]);
            Session.Clear();
            return RedirectToAction("Index");
        }
    }
}
