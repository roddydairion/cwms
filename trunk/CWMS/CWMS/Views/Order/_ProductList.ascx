<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<CWMS.Models.OrderItem>>" %>
                    
          <!-- Subcell LEFT-->
          <% CWMS.Models.ProductRepository productRepository = new CWMS.Models.ProductRepository(); %>
          
         
           <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>เลือกสินค้าและบริการ
            <%if (ViewData["carRegistrationNumber"] != null)
              { %>
                - <%: ViewData["carRegistrationNumber"]%>
            <%} else {%>
                - ไม่ใช้ทะเบียนรถ
            <%} %>
          </h1>
          <div class="content-2col-nobox-leftcolumn">
            <div id="serviceslist">
                <%if (ViewData["carRegistrationNumber"] != null)
                  { %>
              <% Html.RenderPartial("_AllServices", (int)ViewData["carId"]); %>         
              <%}else{ %>
              <table>
                 <tr><th class="top" scope="col">บริการ</th><th class="top" scope="col" style="width: 80px;">ราคาต่อหน่วย</th></tr>
                 <tr><td colspan="2">ไม่สามารถเลือกใช้บริการได้</td></tr>
                 </table>
              <%} %>
            </div>
          </div>          
          <!-- Subcell RIGHT -->          
          <div class="content-2col-nobox-rightcolumn">   
          <div id="productslist">
           <%using(Ajax.BeginForm("SearchProductList",new AjaxOptions{
                HttpMethod = "Post",
                UpdateTargetId="productlist",
                LoadingElementId = "indicator"
             }))
                { %>
                    <p>
                       <%: Html.TextBox("s", null, new { @style = "border: 1px solid #C8C8C8;font-size: 100%;width: 150px;" }) %>
                       <input type="submit" name="submit" id="submit1" style="background: none repeat scroll 0 0 #E6E6E6;
    border: 1px solid #969696;
    color: #969696;
    font-size: 100%;
    text-align: center;
    width: 5em;" value="ค้นหา" tabindex="1" /></p>
                <%} %>
            <table>
              <tr><th class="top" scope="col">สินค้า</th><th class="top" scope="col" style="width: 80px;">ราคาต่อหน่วย</th></tr>
               <%
                   List<CWMS.Models.Product> products = productRepository.AllProducts().ToList();
                   string s ="";
                   if (ViewData["s"] != null)
                   {
                       s = ViewData["s"].ToString();
                   }
                  
                   string message = "";

                   if (ViewData["message"] != null)
                   {
                       message = ViewData["message"].ToString();
                   }

                   if (!string.IsNullOrEmpty(s))
                   {
                       List<CWMS.Models.Product> temp = new List<CWMS.Models.Product>();
                       foreach (var p in products.Where(x => x.Name.Contains(s)))
                       {
                           temp.Add(p);
                       }
                       foreach (var p in products.Where(x => !string.IsNullOrEmpty(x.BarCode)).Where(x=>x.BarCode.Contains(s)))
                       {
                           temp.Add(p);
                       }
                       temp.Distinct();
                       products = temp;
                   }
                   
                       foreach(var product in products){ %>
                <tr>
                    <td><%: Ajax.ActionLink(product.Name,"AddItemToShoppingCart",new {productId = product.Id, carId = ViewData["carId"]}, new AjaxOptions
                            {
                                HttpMethod = "Get",
                                UpdateTargetId = "shoppingcart",
                                LoadingElementId="indicator"
                            }) %></td>
                    <td><%: product.CurrentPrice.ToString("N2") %></td>
                </tr>
              <%} %>             
            </table>
            </div>
          </div>
           
        
         </div>
        <div class="corner-content-1col-bottom"></div>