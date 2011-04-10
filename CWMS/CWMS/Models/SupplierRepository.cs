using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CWMS.Models;
namespace CWMS.Models
{
    public class SupplierRepository
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public IEnumerable<Supplier> AllSuppliers() { return db.Suppliers.OrderBy(x => x.Name); }
        public void AddSupplier(string name, string address, string telephone)
        {
            db.Suppliers.InsertOnSubmit(new Supplier
            {
                Name = name,
                Address = address,
                Telephone = telephone
            });
            db.SubmitChanges();
        }
    }
}