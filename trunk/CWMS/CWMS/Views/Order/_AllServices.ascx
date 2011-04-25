<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<int>" %>
<% CWMS.Models.ProductRepository productRepository = new CWMS.Models.ProductRepository();
   CWMS.Models.CustomerRepository customerRepository = new CWMS.Models.CustomerRepository();%>
    <table>
    <%CWMS.Models.Car car = customerRepository.GetCar(Model);
        if(ViewData["productGroupId"] != null){
          CWMS.Models.ProductGroup productGroup = productRepository.GetProductGroup((int)ViewData["productGroupId"]);%>
        <tr>
            <th class="top" scope="col" colspan="2"><b>กลุ่ม: <%: productGroup.Name %></b> - <%= Ajax.ActionLink("กลับ", "ShowProductList", new { carId = Model }, new AjaxOptions
                                                                                                 {
                                                                                                     UpdateTargetId = "productlist",
                                                                                                     HttpMethod = "Get",
                                                                                                     LoadingElementId = "indicator"
                                                                                                 })%></th></tr>
            <tr><th class="top" scope="col">บริการ</th><th class="top" scope="col" style="width: 80px;">ราคาต่อหน่วย</th>
        </tr>
        <%foreach(CWMS.Models.Product product in productGroup.Products){ %>
            <tr>
            <td><%: Ajax.ActionLink(product.Name,"AddItemToShoppingCart",new {productId = product.Id, carId = ViewData["carId"]}, new AjaxOptions
                            {
                                HttpMethod = "Get",
                                UpdateTargetId = "shoppingcart",
                                LoadingElementId = "indicator"
                            }) %></td>
            
            <td><%: product.Prices.FirstOrDefault().Amount %></td></tr>
        <%} %>
    <%}else{ %>
        <tr>
            <th class="top" scope="col">บริการ</th><th class="top" scope="col" style="width: 80px;">ราคาต่อหน่วย</th>
        </tr>
         <% foreach(var product in productRepository.AllServices().Where(x=>!x.ProductGroupId.HasValue)){ %>
            <tr>
                <td><%: Ajax.ActionLink(product.Name,"AddItemToShoppingCart",new {productId = product.Id, carId = ViewData["carId"]}, new AjaxOptions
                            {
                                HttpMethod = "Get",
                                UpdateTargetId = "shoppingcart",
                                LoadingElementId = "indicator"
                            }) %></td>
                <td>
                <%try
                  {
                      decimal? price = product.CurrentServicePrice(car.CarModelId.Value);
                      if (price.HasValue)
                      {%>
                <%: price.Value.ToString("n2")%>
                <%}
                      else
                      { %>
                    <%: Html.ActionLink("เพิ่มราคา","ServiceDetails","Product",new{productId=product.Id},null) %>
                <%}
                  }
                  catch {%>
                  ไม่มีราคา
                  <% }%>
                
                
                </td>
            </tr>
         <%} %>
         <% foreach(var productGroup in productRepository.AllProductGroup()){ %>
            <tr>
                <td colspan="2"><%: Ajax.ActionLink("กลุ่ม: "+ productGroup.Name,"SelectServiceGroup",new {id = productGroup.Id,carId = Model},new AjaxOptions
                                    {
                                        HttpMethod = "Get",
                                        UpdateTargetId = "serviceslist",
                                        LoadingElementId = "indicator"
                                    }) 
                                        %></td>
            </tr>
         <%} %>
        
    <%} %>

        
   

    </table>


