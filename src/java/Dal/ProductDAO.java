package Dal;

import Model.Product;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ProductDAO {
    private static final List<Product> mockProducts = new ArrayList<>();
    
    static {
        int idCounter = 1;
        Random random = new Random(12345); // Seed for consistent mock generation
        
        // Colors & Materials arrays
        String[] colors = {"Trắng", "Kem", "Xám", "Tím pastel", "Đen", "Nâu"};
        String[] woodMaterials = {"Gỗ sồi", "Gỗ công nghiệp", "Gỗ óc chó", "Gỗ cao su"};
        String[] sofaMaterials = {"Da", "Vải nỉ", "Nhung", "Da lộn"};
        // 1. SOFA (40)
        String[] sofaNames = {"Modern Sofa Nova", "Luxury Sofa Velvet", "Minimal Sofa Luna", "Korean Sofa Haneul", "Japandi Sofa Mori"};
        for (int i = 0; i < 40; i++) {
            String material = sofaMaterials[i % sofaMaterials.length];
            String color = colors[i % colors.length];
            String name = sofaNames[i % sofaNames.length] + " - " + material + " " + color;
            addProduct(idCounter++, name, 4000000 + random.nextInt(6000000), "", material);
        }
        
        // 2. GIƯỜNG NGỦ (35)
        String[] bedNames = {"Luxury Bed Royal", "Minimal Bed Cloudy", "Korean Bed Snow", "Modern Bed Astro"};
        for (int i = 0; i < 35; i++) {
            String material = woodMaterials[i % woodMaterials.length];
            String color = colors[i % colors.length];
            String name = bedNames[i % bedNames.length] + " - " + material + " " + color;
            addProduct(idCounter++, name, 5000000 + random.nextInt(7000000), "", material);
        }
        
        // 3. BÀN LÀM VIỆC (35)
        String[] deskNames = {"Gaming Desk Titan", "Minimal Desk Nova", "Studio Desk Pixel", "WorkDesk Elite"};
        for (int i = 0; i < 35; i++) {
            String color = colors[i % colors.length];
            String name = deskNames[i % deskNames.length] + " - " + color;
            addProduct(idCounter++, name, 1500000 + random.nextInt(3500000), "", "Gỗ / Kim loại");
        }
        
        // 4. GHẾ (30)
        String[] chairNames = {"Comfort Chair Luna", "Gaming Chair Phantom", "Office Chair Zen", "Korean Chair Softy"};
        for (int i = 0; i < 30; i++) {
            String material = sofaMaterials[i % sofaMaterials.length];
            String color = colors[i % colors.length];
            String name = chairNames[i % chairNames.length] + " - " + material + " " + color;
            addProduct(idCounter++, name, 800000 + random.nextInt(2000000), "", material);
        }
        
        // 5. KỆ / TỦ (30)
        String[] shelfNames = {"Wood Shelf Mori", "Luxury Cabinet Royal", "Minimal Shelf Nova", "Storage Box Holo"};
        for (int i = 0; i < 30; i++) {
            String material = woodMaterials[i % woodMaterials.length];
            String name = shelfNames[i % shelfNames.length] + " - " + material;
            addProduct(idCounter++, name, 1200000 + random.nextInt(3000000), "", material);
        }
        
        // 6. ĐÈN DECOR (25)
        String[] lampNames = {"Moon Lamp Aura", "Sunset Light Dreamy", "LED Lamp Pixel", "Night Lamp Cozy"};
        for (int i = 0; i < 25; i++) {
            String color = colors[i % colors.length];
            String name = lampNames[i % lampNames.length] + " - " + color;
            addProduct(idCounter++, name, 300000 + random.nextInt(800000), "", "Nhựa / Kim loại");
        }
        
        // 7. DECOR PHÒNG (40)
        String[] decorNames = {"Mirror Cloudy", "Wall Art Neo", "Cozy Carpet Nest", "Luxury Clock Roman"};
        for (int i = 0; i < 40; i++) {
            String color = colors[i % colors.length];
            String name = decorNames[i % decorNames.length] + " - " + color;
            addProduct(idCounter++, name, 250000 + random.nextInt(1500000), "", "Đa dạng");
        }
        
        // 8. GAMING / WORKSPACE SETUP (20)
        String[] setupNames = {"RGB Setup Titan", "Streaming Desk Nova", "Creator Space Pixel", "Gaming Pack Phantom"};
        for (int i = 0; i < 20; i++) {
            String name = setupNames[i % setupNames.length] + " - Full Combo Đen";
            addProduct(idCounter++, name, 9000000 + random.nextInt(15000000), "", "Đa dạng");
        }
        
        // 9. NỘI THẤT BẾP (20)
        String[] kitchenNames = {"Kitchen Shelf Cozy", "Modern Dining Luna", "Minimal Kitchen Nova", "Wood Table Mori"};
        for (int i = 0; i < 20; i++) {
            String material = woodMaterials[i % woodMaterials.length];
            String name = kitchenNames[i % kitchenNames.length] + " - " + material;
            addProduct(idCounter++, name, 2000000 + random.nextInt(5000000), "", material);
        }
        
        // 10. CÂY DECOR (25)
        String[] plantNames = {"Green Plant Aura", "Mini Tree Zen", "Nature Pot Mori", "Leaf Decor Hoshi"};
        String[] potColors = {"Chậu Trắng", "Chậu Gốm", "Chậu Xi Măng", "Giỏ Mây"};
        for (int i = 0; i < 25; i++) {
            String pot = potColors[i % potColors.length];
            String name = plantNames[i % plantNames.length] + " - " + pot;
            addProduct(idCounter++, name, 150000 + random.nextInt(400000), "", "Nhựa PE");
        }
    }

    private static void addProduct(int id, String name, double price, String imgUrl, String material) {
        Random random = new Random(id);
        double rating = 4.0 + random.nextDouble(); // 4.0 to 5.0
        rating = Math.round(rating * 10) / 10.0;
        if (rating > 5.0) rating = 5.0;
        
        int reviewCount = 10 + random.nextInt(490);
        boolean isHot = random.nextInt(100) < 15; // 15% probability
        boolean isNew = random.nextInt(100) < 20 && !isHot; // 20% probability
        
        mockProducts.add(new Product(id, name, price, imgUrl, rating, reviewCount, material, isHot, isNew));
    }

    public List<Product> getAllProducts() {
        return mockProducts;
    }

    private List<Product> filterProducts(String query) {
        if (query == null || query.trim().isEmpty()) {
            return mockProducts;
        }
        String lowerQuery = query.toLowerCase().trim();
        List<Product> filtered = new ArrayList<>();
        for (Product p : mockProducts) {
            if (p.getName().toLowerCase().contains(lowerQuery) || p.getMaterial().toLowerCase().contains(lowerQuery)) {
                filtered.add(p);
            }
        }
        return filtered;
    }

    public int getTotalProducts() {
        return mockProducts.size();
    }
    
    public int getTotalProducts(String query) {
        return filterProducts(query).size();
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        return getProductsByPage(null, page, pageSize);
    }

    public List<Product> getProductsByPage(String query, int page, int pageSize) {
        List<Product> filtered = filterProducts(query);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, filtered.size());
        
        if (start >= filtered.size() || start < 0) {
            return new ArrayList<>(); // Return empty list if out of bounds
        }
        
        return filtered.subList(start, end);
    }
}
