using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
using System.Globalization;
namespace CWMS.Controllers
{
    public class OrderController : Controller
    {
        OrderRepository repository = new OrderRepository();
        CustomerRepository customerRepository = new CustomerRepository();
        ProductRepository productRepository = new ProductRepository();
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public ActionResult GiftCardDetails(int id,int? carId)
        {
            GiftCard giftCard = db.GiftCards.FirstOrDefault(x => x.Id == id);
            Car car = giftCard.Car;
            if (carId.HasValue)
                car = db.Cars.FirstOrDefault(x => x.Id == carId);

            ViewData["car"] = car;
            return View(giftCard);
        }
        public ActionResult SearchGiftCard(string number,int? carId)
        {
            if (carId.HasValue)
            {
                GiftCard giftCard = db.GiftCards.FirstOrDefault(x => x.Number.Trim() == number.Trim());
                if (giftCard != null)
                {
                    return RedirectToAction("GiftCardDetails", new { id = giftCard.Id, carId = carId.Value });
                }
                else
                {
                    return RedirectToAction("InitiateOrder");
                }
            }
            else
            {
                if (string.IsNullOrEmpty(number))
                {
                    return View(db.GiftCards);
                }
                else
                {
                    return View(db.GiftCards.Where(x => x.Number.Trim() == number.Trim()));
                }
            }
        }
        public ActionResult UseGiftCard(int id,int carId)
        {
            GiftCard giftCard = db.GiftCards.FirstOrDefault(x => x.Id == id);
            giftCard.GiftCardUsages.Add(new GiftCardUsage
            {
                Date = DateTime.Now,
                CarId = carId
            });
            giftCard.CurrentQuantity = giftCard.CurrentQuantity - 1;
            db.SubmitChanges();
            return RedirectToAction("GiftCardDetails", new { id = id });
        }
        [HttpPost]
        public ActionResult AddGiftCard(GiftCard giftcard)
        {
            giftcard.CurrentQuantity = giftcard.OriginalQuantity;
            db.GiftCards.InsertOnSubmit(giftcard);
            db.SubmitChanges();
            return RedirectToAction("SearchGiftCard", new { number = giftcard.Number });
        }
        public ActionResult AddGiftCard(int carId)
        {
            ViewData["car"] = customerRepository.GetCar(carId);
            ViewData["carId"] = carId;
            return View();
        }
        public ActionResult AllOrderListPrint(string startDate, string endDate)
        {
            DateTime start = DateTime.Parse(startDate,System.Globalization.CultureInfo.GetCultureInfo("th-TH"));
            DateTime end = DateTime.Parse(endDate,System.Globalization.CultureInfo.GetCultureInfo("th-TH"));
            ViewData["start"] = start;
            ViewData["end"] = end;
            return View(repository.AllOrders().Where(x => (x.OrderDate.Date >= start.Date) && (x.OrderDate.Date <= end.Date)).OrderBy(x => x.OrderDate));
        }
        public ActionResult AllOrdersList(int? startDay, int? startMonth, int? startYear,int? endDay,int? endMonth, int? endYear) 
        {
            if (!startDay.HasValue)
            {
                return View(repository.AllOrders().Where(x=>x.OrderDate.Date == DateTime.Now.Date));
            }
            else
            {
                DateTime startDate = DateTime.ParseExact(
                    startDay.ToString().PadLeft(2, '0') +
                    startMonth.ToString().PadLeft(2, '0') +
                    startYear.ToString(), "ddMMyyyy", new CultureInfo("th-TH"));
                ViewData["startDate"] = startDate;
                DateTime endDate = DateTime.ParseExact(
                    endDay.ToString().PadLeft(2, '0') +
                    endMonth.ToString().PadLeft(2, '0') +
                    endYear.ToString(), "ddMMyyyy", new CultureInfo("th-TH"));
                ViewData["endDate"] = endDate;
                return View(repository.AllOrders().Where(x=>(x.OrderDate.Date >= startDate.Date)&&(x.OrderDate.Date <= endDate.Date)).OrderByDescending(x=>x.OrderDate));
            }
        }
        public ActionResult AllUnfinishedOrdersList() { return View(repository.AllUnfinishedOrders()); }
        public ActionResult AllFinishedOrdersList() {
            ViewData["giftCards"] = db.GiftCardUsages;
            return View(repository.AllFinishedOrders()); }
        public ActionResult FinishOrder(int orderId, decimal paid)
        {
            Order order = repository.Get(orderId);
            order.Paid = paid;
            repository.Save();
            return RedirectToAction("Details", new { id = order.Id });
        }
        public ActionResult SelectServiceGroup(int id,int carId)
        {
            ViewData["productGroupId"] = id;
            ViewData["carId"] = carId;
            return PartialView("_AllServices", carId);
        }
        public ActionResult PlaceOrder(int? carId, int? appointmentDay, int? appointmentMonth, int? appointmentYear)
        {
            int orderId = 0;
            if (appointmentDay.HasValue)
            {
                DateTime appointmentDate = DateTime.ParseExact(
                    appointmentDay.ToString().PadLeft(2, '0') + appointmentMonth.ToString().PadLeft(2, '0') + appointmentYear.ToString(), "dd/mm/yyyy", CultureInfo.CurrentCulture);

                orderId = repository.InitiateOrder(carId, DateTime.Now, appointmentDate, ((List<OrderItem>)(Session["cart"])).ToList());
            }
            else
            {
                orderId = repository.InitiateOrder(carId, DateTime.Now, DateTime.Now, ((List<OrderItem>)(Session["cart"])).ToList());
            }
            Session.Clear();
            return RedirectToAction("Details", new { id = orderId });
        }
        public ActionResult Details(int id)
        {
            return View(repository.Get(id));
        }
        public ActionResult ShowProductList(int? carId)
        {
            Session.Clear();
            ViewData["carId"] = carId;
            if (carId.HasValue)
                ViewData["carRegistrationNumber"] = customerRepository.GetCar(carId.Value).RegistrationNumber;
            return PartialView("_ProductList");
        }
        [HttpPost]
        public ActionResult SearchProductList(int? carId, string s)
        {
            if (!string.IsNullOrEmpty(s))
            {
                ViewData["s"] = s;
                ViewData["carId"] = carId;
                ViewData["message"] = s;
                if (carId.HasValue)
                    ViewData["carRegistrationNumber"] = customerRepository.GetCar(carId.Value).RegistrationNumber;
                return PartialView("_ProductList");
            }
            else
            {
                ViewData["carId"] = carId;
                if (carId.HasValue)
                    ViewData["carRegistrationNumber"] = customerRepository.GetCar(carId.Value).RegistrationNumber;
                return PartialView("_ProductList");
            }
        }
        public ActionResult JobPrint(int id)
        {
            return View(repository.Get(id));
        }
        public ActionResult AddItemToShoppingCart(int productId, int? carId)
        {
            Product product = productRepository.Get(productId);
            
            if ((Session["cart"] == null)||(((List<OrderItem>)Session["cart"]).Count ==0))
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
            return PartialView("_ShoppingCart", (IEnumerable<OrderItem>)Session["cart"]);
        }
        public ActionResult RemoveItemFromShoppingCart(int index, int? carId)
        {
            List<OrderItem> orderItems = ((IEnumerable<OrderItem>)(Session["cart"])).ToList();
            orderItems.RemoveAt(index);
            Session.Add("cart", orderItems);
            if (carId.HasValue)
            {
                Car car = customerRepository.GetCar(carId.Value);
                ViewData["carId"] = car.Id;
                ViewData["carRegistrationNumber"] = car.RegistrationNumber;
            }
            return PartialView("_ShoppingCart", ((IEnumerable<OrderItem>)Session["cart"]));
        }
        [HttpPost]
        public ActionResult ChooseCarBrand(int carBrandId, string registrationNumber, string customerName)
        {
            ViewData["customerName"] = customerName;
            ViewData["carRegistrationNumber"] = registrationNumber;
            ViewData["carBrandId"] = carBrandId;
           
            CarBrand carBrand = customerRepository.GetCarBrand(carBrandId);
            ViewData["carBrandName"] = carBrand.Name;
            ViewData["carModels"] = carBrand.CarModels;
            return PartialView("_CarDetails");
        }
        public ActionResult CheckRegistrationNumber(string registrationNumber)
        {

            ViewData["carBrands"] = customerRepository.AllCarBrands();
            if (!customerRepository.CheckCarAvailable(registrationNumber))
            {
                ViewData["registrationNumber"] = registrationNumber.Replace(" ", "").Trim();
                return PartialView("_CarDetails");
            }
            else
            {
                return PartialView("_CarDetails", customerRepository.GetCar(registrationNumber.Replace(" ", "").Trim()));
            }
        }
        [HttpPost]
        public ActionResult SendToSlot(int orderId, int slotNumber)
        {
            Order order = repository.Get(orderId);
            order.SlotNumber = slotNumber;
            repository.Save();
            return RedirectToAction("Details", new { id = orderId });
        }

        public ActionResult InitiateOrder()
        {
            return View();
        }
        public ActionResult Index()
        {
            return View();
        }

    }
}
