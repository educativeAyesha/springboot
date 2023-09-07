package com.educative.app;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductsController {
    private List<String> products = new ArrayList<>();

    public List<String> getProducts() {
        return products;
    }

    public void setProducts(List<String> orders) {
        this.products = orders;
    }

    @PostMapping("/product")
    public String handlePostRequest(String productName) {
        products.add(productName);
        return "redirect:/products";
    }
  
    @GetMapping("/products")
    public String getAllproducts(Model model) {
        model.addAttribute("products", products);
        return "order_details";
    }
    
    @GetMapping("/addProduct")
    public String addProduct() {
        return "product_form";
    }    
}
