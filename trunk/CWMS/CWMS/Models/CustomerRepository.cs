using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CWMS.Models
{
    public class CustomerRepository
    {
        CWMSDataClassesDataContext db = new CWMSDataClassesDataContext();
        public void DeleteCarBrand(int id)
        {
            db.CarBrands.DeleteOnSubmit(db.CarBrands.FirstOrDefault(x => x.Id == id));
            Save();
        }
        public void DeleteCarModel(int id)
        {
            db.CarModels.DeleteOnSubmit(db.CarModels.FirstOrDefault(x => x.Id == id));
            Save();
        }
        public void DeleteCustomer(int id)
        { 
            Customer customer = this.GetCustomer(id);
            db.Cars.DeleteAllOnSubmit(customer.Cars);
            db.Customers.DeleteOnSubmit(customer);
            Save();
        }

        public void DeleteCar(int id)
        {
            db.Cars.DeleteOnSubmit(this.GetCar(id));
            db.SubmitChanges();
        }
        public IEnumerable<Customer> AllCustomers()
        {
            return db.Customers.OrderBy(x => x.Name);
        }
        public int AddCarBrand(string name)
        {
            CarBrand newCarBrand = new CarBrand
            {
                Name = name
            };
            db.CarBrands.InsertOnSubmit(newCarBrand);
            Save();
            return newCarBrand.Id;
        }
        public int AddCarModel(int carBrandId, string name)
        {
            CarModel newCarModel = new CarModel
            {
                CarBrandId = carBrandId,
                Name = name
            };
            db.CarModels.InsertOnSubmit(newCarModel);
            Save();
            return newCarModel.Id;
        }
        public int AddPrice(int carModelId, int productId, decimal amount)
        {
            Price newPrice = new Price{
                CarModelId = carModelId,
                ProductId = productId,
                Amount = amount,
                Date = DateTime.Now,
            };
            db.Prices.InsertOnSubmit(newPrice);
            Save();
            return newPrice.Id;
        }

        public IEnumerable<CarBrand> AllCarBrands() { return db.CarBrands.OrderBy(x => x.Name); }
        public CarBrand GetCarBrand(int id) { return db.CarBrands.First(x => x.Id == id); }

        public Car GetCar(int id) { return db.Cars.FirstOrDefault(x => x.Id == id); }
        public bool CheckCarAvailable(string registrationNumber)
        {
            return db.Cars.Any(x => x.RegistrationNumber == registrationNumber.Replace(" ", "").Trim());
        }
        public Car GetCar(string registrationNumber)
        {
            return db.Cars.FirstOrDefault(x => x.RegistrationNumber == registrationNumber.Replace(" ","").Trim());
        }
        public int AddCar(string registrationNumber, int? customerId,int carModelId)
        {
            Car newCar = new Car
            {
                RegistrationNumber = registrationNumber.Replace(" ", "").Trim(),
                CustomerId = customerId,
                CarModelId = carModelId
            };
            db.Cars.InsertOnSubmit(newCar);
            Save();
            return newCar.Id;
        }
        public Customer GetCustomer(string customerName) { return db.Customers.FirstOrDefault(x => x.Name == customerName); }
        public Customer GetCustomer(int id) { return db.Customers.FirstOrDefault(x => x.Id == id); }
        public int AddCustomer(string name, string note, string address, string telephone)
        {
            Customer newCustomer = new Customer
            {
                Name = name,
                Note = note,
                Address = address,
                Telephone = telephone
            };
            db.Customers.InsertOnSubmit(newCustomer);
            Save();
            return newCustomer.Id;
        }
        public IEnumerable<Customer> SearchCar(string registrationNumber)
        {
            return db.Customers.Where(x => x.Cars.Any(y => y.RegistrationNumber.Replace(" ", "").Trim() == registrationNumber.Replace(" ", "").Trim()));
        }
        public void Save() { db.SubmitChanges(); }
    }
}