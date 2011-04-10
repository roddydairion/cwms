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
        public ActionResult SelectCar()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SelectCar(string registrationNumber)
        {
            if (customerRepository.CheckCarAvailable(registrationNumber))
            {
                Car car = customerRepository.GetCar(registrationNumber);
                Session.Remove("car");
                Session.Add("car", car);
                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("AddCar", new { registrationNumber = registrationNumber });
            }
        }
        public ActionResult AddCar(string registrationNumber)
        {
            ViewData["registrationNumber"] = registrationNumber.Replace(" ", "");
            return View();
        }
        public ActionResult ClearSessions()
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
        public ActionResult AddItemToShoppingCart(int productId)
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
