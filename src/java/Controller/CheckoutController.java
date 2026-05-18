package Controller;

import Model.CartItem;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Force login
        if (user == null) {
            session.setAttribute("error", "Please login to place your order!");
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        
        // Gather shipping parameters
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");
        
        // Mock order object creation & details
        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
        
        // Store order details temporarily for order success page
        request.setAttribute("orderTotal", total);
        request.setAttribute("customerName", fullName);
        request.setAttribute("customerPhone", phone);
        request.setAttribute("customerAddress", address);
        request.setAttribute("paymentMethod", payment);
        
        // Clear cart in database and session
        Dal.CartDAO cartDAO = new Dal.CartDAO();
        cartDAO.clearCart(user.getId());
        session.setAttribute("cart", cartDAO.getCartByUserId(user.getId()));
        
        request.getRequestDispatcher("order-success.jsp").forward(request, response);
    }
}
