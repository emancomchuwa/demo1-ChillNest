package Dal;

import Model.CartItem;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends DBContext {

    public CartDAO() {
        super();
        createTableIfNotExists();
    }

    /**
     * Create cart_items table in MS SQL Server if it does not exist yet.
     * This provides self-healing schema functionality out of the box.
     */
    private void createTableIfNotExists() {
        if (connection == null) return;
        String checkSql = "IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='cart_items' AND xtype='U')\n" +
                          "CREATE TABLE cart_items (\n" +
                          "    id BIGINT PRIMARY KEY IDENTITY(1,1),\n" +
                          "    user_id BIGINT FOREIGN KEY REFERENCES users(id) ON DELETE CASCADE,\n" +
                          "    product_id INT NOT NULL,\n" +
                          "    name NVARCHAR(255) NOT NULL,\n" +
                          "    price DOUBLE PRECISION NOT NULL,\n" +
                          "    material NVARCHAR(100),\n" +
                          "    category NVARCHAR(100),\n" +
                          "    quantity INT NOT NULL\n" +
                          ");";
        try (PreparedStatement st = connection.prepareStatement(checkSql)) {
            st.executeUpdate();
            System.out.println(">>> SUCCESS: Checked/Created database table 'cart_items'.");
        } catch (SQLException e) {
            System.err.println(">>> ERROR: Failed to create table 'cart_items': " + e.getMessage());
        }
    }

    /**
     * Retrieve all cart items for a specific user
     */
    public List<CartItem> getCartByUserId(long userId) {
        List<CartItem> cart = new ArrayList<>();
        if (connection == null) return cart;
        
        String sql = "SELECT * FROM cart_items WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setLong(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("material"),
                        rs.getString("category"),
                        rs.getInt("quantity")
                    );
                    cart.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("getCartByUserId error: " + e.getMessage());
        }
        return cart;
    }

    /**
     * Add a cart item or update its quantity if it already exists
     */
    public void addCartItem(long userId, CartItem item) {
        if (connection == null) return;
        
        // Check if item already exists in DB
        String checkSql = "SELECT quantity FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement checkSt = connection.prepareStatement(checkSql)) {
            checkSt.setLong(1, userId);
            checkSt.setInt(2, item.getProductId());
            try (ResultSet rs = checkSt.executeQuery()) {
                if (rs.next()) {
                    // Exists -> Update quantity
                    int newQty = rs.getInt("quantity") + item.getQuantity();
                    String updateSql = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND product_id = ?";
                    try (PreparedStatement updateSt = connection.prepareStatement(updateSql)) {
                        updateSt.setInt(1, newQty);
                        updateSt.setLong(2, userId);
                        updateSt.setInt(3, item.getProductId());
                        updateSt.executeUpdate();
                    }
                    return;
                }
            }
        } catch (SQLException e) {
            System.err.println("addCartItem check error: " + e.getMessage());
        }
        
        // Does not exist -> Insert new row
        String insertSql = "INSERT INTO cart_items (user_id, product_id, name, price, material, category, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement insertSt = connection.prepareStatement(insertSql)) {
            insertSt.setLong(1, userId);
            insertSt.setInt(2, item.getProductId());
            insertSt.setString(3, item.getName());
            insertSt.setDouble(4, item.getPrice());
            insertSt.setString(5, item.getMaterial());
            insertSt.setString(6, item.getCategory());
            insertSt.setInt(7, item.getQuantity());
            insertSt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("addCartItem insert error: " + e.getMessage());
        }
    }

    /**
     * Update quantity of a cart item
     */
    public void updateCartItemQty(long userId, int productId, int quantity) {
        if (connection == null) return;
        
        if (quantity <= 0) {
            removeCartItem(userId, productId);
            return;
        }
        
        String sql = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quantity);
            st.setLong(2, userId);
            st.setInt(3, productId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("updateCartItemQty error: " + e.getMessage());
        }
    }

    /**
     * Remove a cart item
     */
    public void removeCartItem(long userId, int productId) {
        if (connection == null) return;
        
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setLong(1, userId);
            st.setInt(2, productId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("removeCartItem error: " + e.getMessage());
        }
    }

    /**
     * Clear all cart items for a user
     */
    public void clearCart(long userId) {
        if (connection == null) return;
        
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setLong(1, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("clearCart error: " + e.getMessage());
        }
    }
}
