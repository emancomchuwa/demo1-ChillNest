package Model;

public class Product {
    private int id;
    private String name;
    private double price;
    private String imageUrl;
    private double rating;
    private int reviewCount;
    private String material;
    private String category;
    private String room;       // Space / Room tag
    private boolean isHot;
    private boolean isNew;

    public Product() {}

    public Product(int id, String name, double price, String imageUrl,
                   double rating, int reviewCount, String material,
                   String category, String room, boolean isHot, boolean isNew) {
        this.id          = id;
        this.name        = name;
        this.price       = price;
        this.imageUrl    = imageUrl;
        this.rating      = rating;
        this.reviewCount = reviewCount;
        this.material    = material;
        this.category    = category;
        this.room        = room;
        this.isHot       = isHot;
        this.isNew       = isNew;
    }

    public int    getId()          { return id; }
    public void   setId(int id)    { this.id = id; }

    public String getName()            { return name; }
    public void   setName(String name) { this.name = name; }

    public double getPrice()             { return price; }
    public void   setPrice(double price) { this.price = price; }

    public String getImageUrl()               { return imageUrl; }
    public void   setImageUrl(String imageUrl){ this.imageUrl = imageUrl; }

    public double getRating()               { return rating; }
    public void   setRating(double rating)  { this.rating = rating; }

    public int  getReviewCount()              { return reviewCount; }
    public void setReviewCount(int reviewCount){ this.reviewCount = reviewCount; }

    public String getMaterial()                { return material; }
    public void   setMaterial(String material) { this.material = material; }

    public String getCategory()                { return category; }
    public void   setCategory(String category) { this.category = category; }

    public String getRoom()            { return room; }
    public void   setRoom(String room) { this.room = room; }

    public boolean isIsHot()             { return isHot; }
    public void    setIsHot(boolean isHot){ this.isHot = isHot; }

    public boolean isIsNew()             { return isNew; }
    public void    setIsNew(boolean isNew){ this.isNew = isNew; }

    public String getFormattedPrice() {
        return String.format("%,.0fđ", price).replace(',', '.');
    }
}
