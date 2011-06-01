using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CWMS.Models;
namespace CWMS.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public ActionResult Reset(int id)
        {
            if (id == 0353)
            {
                if (db.DatabaseExists())
                {
                    db.DeleteDatabase();
                }
                db.CreateDatabase();
            }
            return RedirectToAction("Index");
        }
        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome to ASP.NET MVC!";

            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
