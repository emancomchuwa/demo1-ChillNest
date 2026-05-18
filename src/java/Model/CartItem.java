package Model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int    productId;
    private String name;
    private double price;
    private String material;
    private String category;
    private int    quantity;

    public CartItem() {}

    public CartItem(int productId, String name, double price, String material, String category, int quantity) {
        this.productId = productId;
        this.name      = name;
        this.price     = price;
        this.material  = material;
        this.category  = category;
        this.quantity  = quantity;
    }

    public int    getProductId()            { return productId; }
    public void   setProductId(int id)      { this.productId = id; }

    public String getName()                 { return name; }
    public void   setName(String name)      { this.name = name; }

    public double getPrice()                { return price; }
    public void   setPrice(double price)    { this.price = price; }

    public String getMaterial()             { return material; }
    public void   setMaterial(String m)     { this.material = m; }

    public String getCategory()             { return category; }
    public void   setCategory(String c)     { this.category = c; }

    public int    getQuantity()             { return quantity; }
    public void   setQuantity(int quantity) { this.quantity = quantity; }

    public double getSubtotal()             { return price * quantity; }

    public String getFormattedPrice() {
        return String.format("%,.0fđ", price).replace(',', '.');
    }

    public String getFormattedSubtotal() {
        return String.format("%,.0fđ", getSubtotal()).replace(',', '.');
    }
}
