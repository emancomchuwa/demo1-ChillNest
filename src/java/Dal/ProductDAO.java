package Dal;

import Model.Product;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ProductDAO {
    private static final List<Product> mockProducts = new ArrayList<>();

    // Category constants
    public static final String CAT_SOFA              = "Sofa";
    public static final String CAT_BED               = "Bed";
    public static final String CAT_TABLES_CHAIRS     = "Tables & Chairs";
    public static final String CAT_DECOR_LIGHTS      = "Decor Lights";
    public static final String CAT_BOOKSHELVES       = "Bookshelves";
    public static final String CAT_ROOM_DECOR        = "Room Decor";
    public static final String CAT_ARTIFICIAL_PLANTS = "Artificial Plants";
    public static final String CAT_WORKSPACE_SETUP   = "Workspace Setup";
    public static final String CAT_KITCHEN_FURNITURE = "Kitchen Furniture";

    // Room constants – match sidebar checkboxes exactly
    public static final String ROOM_BEDROOM       = "Bedroom";
    public static final String ROOM_LIVING_ROOM   = "Living Room";
    public static final String ROOM_WORKSPACE     = "Workspace";
    public static final String ROOM_GAMING_ROOM   = "Gaming Room";
    public static final String ROOM_STUDIO        = "Studio";
    public static final String ROOM_MINI_APT      = "Mini Apartment";
    public static final String ROOM_CAFE          = "Cafe";

    static {
        Random r = new Random(99999);
        int[] idBox = {1};

        String[] colors   = {"White", "Cream", "Gray", "Lavender", "Black", "Brown"};
        String[] woodMats = {"Oak Wood", "Engineered Wood", "Walnut Wood", "Rubber Wood", "Pine Wood"};
        String[] sofaMats = {"Leather", "Velvet", "Linen Fabric", "Suede"};

        // Rooms to spread across when no single room is obvious
        String[] allRooms  = {ROOM_BEDROOM, ROOM_LIVING_ROOM, ROOM_WORKSPACE,
                              ROOM_GAMING_ROOM, ROOM_STUDIO, ROOM_MINI_APT, ROOM_CAFE};
        String[] homeRooms = {ROOM_BEDROOM, ROOM_LIVING_ROOM, ROOM_MINI_APT};

        // ── 1. SOFA → Living Room / Mini Apartment (40) ─────────────
        String[] sofaNames = {
            "Modern Sofa Nova", "Luxury Sofa Velvet", "Minimal Sofa Luna",
            "Korean Sofa Haneul", "Japandi Sofa Mori", "Cozy Sofa Cloud",
            "L-Shape Sofa Grand", "Recliner Sofa Relax", "Compact Sofa Studio"
        };
        String[] sofaRooms = {ROOM_LIVING_ROOM, ROOM_MINI_APT, ROOM_STUDIO};
        for (int i = 0; i < 40; i++) {
            String mat  = sofaMats[i % sofaMats.length];
            String name = sofaNames[i % sofaNames.length] + " - " + mat + " " + colors[i % colors.length];
            add(idBox, name, 4_000_000 + r.nextInt(6_000_000), mat,
                CAT_SOFA, sofaRooms[i % sofaRooms.length], r);
        }

        // ── 2. BED → Bedroom / Mini Apartment (35) ──────────────────
        String[] bedNames = {
            "Luxury Bed Royal", "Minimal Bed Cloudy", "Korean Bed Snow",
            "Modern Bed Astro", "Platform Bed Zen", "Storage Bed Maxi",
            "Canopy Bed Dreams", "Loft Bed Studio", "Daybed Lounge"
        };
        String[] bedRooms = {ROOM_BEDROOM, ROOM_MINI_APT};
        for (int i = 0; i < 35; i++) {
            String mat  = woodMats[i % woodMats.length];
            String name = bedNames[i % bedNames.length] + " - " + mat + " " + colors[i % colors.length];
            add(idBox, name, 5_000_000 + r.nextInt(7_000_000), mat,
                CAT_BED, bedRooms[i % bedRooms.length], r);
        }

        // ── 3. TABLES & CHAIRS → spread across all rooms (40) ───────
        String[] tableNames = {
            "Dining Table Mori", "Coffee Table Nova", "Side Table Pixel",
            "Round Table Hana", "Folding Table Flex", "Bar Table Alto",
            "Accent Chair Luna", "Dining Chair Oak", "Bar Stool Metro",
            "Gaming Chair Phantom", "Office Chair Zen", "Lounge Chair Cozy"
        };
        String[] tableMats  = {"Oak Wood", "Tempered Glass", "Metal & Wood", "Engineered Wood", "Rattan"};
        String[] tableRooms = {ROOM_LIVING_ROOM, ROOM_CAFE, ROOM_WORKSPACE,
                               ROOM_GAMING_ROOM, ROOM_STUDIO, ROOM_MINI_APT};
        for (int i = 0; i < 40; i++) {
            String mat  = tableMats[i % tableMats.length];
            String name = tableNames[i % tableNames.length] + " - " + mat + " " + colors[i % colors.length];
            add(idBox, name, 800_000 + r.nextInt(5_000_000), mat,
                CAT_TABLES_CHAIRS, tableRooms[i % tableRooms.length], r);
        }

        // ── 4. DECOR LIGHTS → spread all rooms (30) ─────────────────
        String[] lampNames = {
            "Moon Lamp Aura", "Sunset Light Dreamy", "LED Strip Pixel",
            "Night Lamp Cozy", "Pendant Light Neo", "Arc Floor Lamp Grand",
            "Table Lamp Zen", "Edison Bulb Retro", "RGB Light Gaming",
            "Fairy Lights Glow", "Neon Sign Custom", "Smart Bulb Link"
        };
        String[] lampMats = {"Plastic / Metal", "Glass / Metal", "Silicone", "Bamboo / Paper"};
        for (int i = 0; i < 30; i++) {
            String mat  = lampMats[i % lampMats.length];
            String name = lampNames[i % lampNames.length] + " - " + colors[i % colors.length];
            add(idBox, name, 300_000 + r.nextInt(800_000), mat,
                CAT_DECOR_LIGHTS, allRooms[i % allRooms.length], r);
        }

        // ── 5. BOOKSHELVES → Bedroom / Workspace / Studio (30) ──────
        String[] shelfNames = {
            "Wood Shelf Mori", "Floating Shelf Nova", "Cube Bookcase Holo",
            "Ladder Shelf Studio", "Corner Shelf Arc", "Industrial Shelf Titan",
            "Mini Bookrack Cozy", "Modular Shelf System", "Display Cabinet Royal"
        };
        String[] shelfRooms = {ROOM_BEDROOM, ROOM_WORKSPACE, ROOM_STUDIO, ROOM_MINI_APT};
        for (int i = 0; i < 30; i++) {
            String mat  = woodMats[i % woodMats.length];
            String name = shelfNames[i % shelfNames.length] + " - " + mat;
            add(idBox, name, 1_200_000 + r.nextInt(3_000_000), mat,
                CAT_BOOKSHELVES, shelfRooms[i % shelfRooms.length], r);
        }

        // ── 6. ROOM DECOR → spread all rooms (40) ───────────────────
        String[] decorNames = {
            "Mirror Cloudy", "Wall Art Neo", "Cozy Carpet Nest",
            "Luxury Clock Roman", "Photo Frame Set", "Throw Pillow Soft",
            "Scented Candle Zen", "Vase Ceramic Hana", "Wall Tapestry Boho",
            "Decorative Tray Noir", "Figurine Deco", "Abstract Sculpture"
        };
        String[] decorMats = {"Various", "Ceramic", "Fabric", "Glass", "Wood"};
        for (int i = 0; i < 40; i++) {
            String mat  = decorMats[i % decorMats.length];
            String name = decorNames[i % decorNames.length] + " - " + colors[i % colors.length];
            add(idBox, name, 250_000 + r.nextInt(1_500_000), mat,
                CAT_ROOM_DECOR, allRooms[i % allRooms.length], r);
        }

        // ── 7. ARTIFICIAL PLANTS → all home rooms (25) ──────────────
        String[] plantNames = {
            "Green Plant Aura", "Mini Tree Zen", "Nature Pot Mori",
            "Leaf Decor Hoshi", "Succulent Set", "Bonsai Faux Kyoto",
            "Monstera Faux Leaf", "Cactus Decor Desert", "Hanging Plant Dew"
        };
        String[] potTypes = {"White Pot", "Ceramic Pot", "Concrete Pot", "Wicker Basket", "Terracotta Pot"};
        for (int i = 0; i < 25; i++) {
            String name = plantNames[i % plantNames.length] + " - " + potTypes[i % potTypes.length];
            add(idBox, name, 150_000 + r.nextInt(400_000), "PE Plastic",
                CAT_ARTIFICIAL_PLANTS, allRooms[i % allRooms.length], r);
        }

        // ── 8. WORKSPACE SETUP → Workspace / Gaming Room / Studio (25)
        String[] setupNames = {
            "RGB Setup Titan", "Streaming Desk Nova", "Creator Space Pixel",
            "Gaming Pack Phantom", "Minimal Desk Neo", "L-Shape Desk Pro",
            "Standing Desk Uplift", "Monitor Arm Flex", "Cable Management Box",
            "Keyboard Wrist Rest", "Desk Pad XL", "PC Tower Stand"
        };
        String[] setupRooms = {ROOM_WORKSPACE, ROOM_GAMING_ROOM, ROOM_STUDIO};
        for (int i = 0; i < 25; i++) {
            String name = setupNames[i % setupNames.length] + " - " + colors[i % colors.length];
            add(idBox, name, 500_000 + r.nextInt(15_000_000), "Various",
                CAT_WORKSPACE_SETUP, setupRooms[i % setupRooms.length], r);
        }

        // ── 9. KITCHEN FURNITURE → Cafe / Mini Apartment (25) ───────
        String[] kitchenNames = {
            "Kitchen Shelf Cozy", "Modern Dining Table Luna", "Minimal Kitchen Cabinet Nova",
            "Wood Dining Table Mori", "Kitchen Island Cart", "Bar Cabinet Alto",
            "Wine Rack Bordeaux", "Pantry Cabinet Slim", "Microwave Stand Hub"
        };
        String[] kitchenRooms = {ROOM_CAFE, ROOM_MINI_APT};
        for (int i = 0; i < 25; i++) {
            String mat  = woodMats[i % woodMats.length];
            String name = kitchenNames[i % kitchenNames.length] + " - " + mat;
            add(idBox, name, 2_000_000 + r.nextInt(5_000_000), mat,
                CAT_KITCHEN_FURNITURE, kitchenRooms[i % kitchenRooms.length], r);
        }
    }

    private static void add(int[] idBox, String name, double price,
                            String material, String category, String room, Random r) {
        int id = idBox[0]++;
        double rating = Math.min(5.0, Math.round((4.0 + r.nextDouble()) * 10) / 10.0);
        int    reviews = 10 + r.nextInt(490);
        boolean isHot  = r.nextInt(100) < 15;
        boolean isNew  = !isHot && r.nextInt(100) < 20;
        mockProducts.add(new Product(id, name, price, "", rating, reviews,
                                     material, category, room, isHot, isNew));
    }

    public List<Product> getAllProducts() { return mockProducts; }

    /** Find a single product by its ID */
    public Product getProductById(int id) {
        for (Product p : mockProducts) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    private List<Product> filterProducts(String query, String room) {
        List<Product> source = mockProducts;

        // Apply query filter (name, material, category)
        if (query != null && !query.trim().isEmpty()) {
            String lq = query.toLowerCase().trim();
            List<Product> byQuery = new ArrayList<>();
            for (Product p : source) {
                if (p.getName().toLowerCase().contains(lq)
                        || p.getMaterial().toLowerCase().contains(lq)
                        || (p.getCategory() != null && p.getCategory().toLowerCase().contains(lq))) {
                    byQuery.add(p);
                }
            }
            source = byQuery;
        }

        // Apply room filter
        if (room != null && !room.trim().isEmpty()) {
            String lr = room.toLowerCase().trim();
            List<Product> byRoom = new ArrayList<>();
            for (Product p : source) {
                if (p.getRoom() != null && p.getRoom().toLowerCase().contains(lr)) {
                    byRoom.add(p);
                }
            }
            source = byRoom;
        }

        return source;
    }

    public int getTotalProducts() { return mockProducts.size(); }

    public int getTotalProducts(String query) {
        return filterProducts(query, null).size();
    }

    public int getTotalProducts(String query, String room) {
        return filterProducts(query, room).size();
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        return getProductsByPage(null, null, page, pageSize);
    }

    public List<Product> getProductsByPage(String query, int page, int pageSize) {
        return getProductsByPage(query, null, page, pageSize);
    }

    public List<Product> getProductsByPage(String query, String room, int page, int pageSize) {
        List<Product> filtered = filterProducts(query, room);
        int start = (page - 1) * pageSize;
        int end   = Math.min(start + pageSize, filtered.size());
        if (start >= filtered.size() || start < 0) return new ArrayList<>();
        return filtered.subList(start, end);
    }
}
