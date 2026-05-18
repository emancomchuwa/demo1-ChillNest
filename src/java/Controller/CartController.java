package Controller;

import Dal.ProductDAO;
import Model.CartItem;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Model.User user = (Model.User) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("error", "Please login to manage your shopping cart!");
            response.sendRedirect("login.jsp");
            return;
        }
        
        Dal.CartDAO cartDAO = new Dal.CartDAO();
        long userId = user.getId();
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }
        
        if (action.equalsIgnoreCase("add")) {
            String idStr = request.getParameter("id");
            String qtyStr = request.getParameter("qty");
            int id = Integer.parseInt(idStr);
            int qty = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;
            
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);
            if (p != null) {
                CartItem item = new CartItem(p.getId(), p.getName(), p.getPrice(), p.getMaterial(), p.getCategory(), qty);
                cartDAO.addCartItem(userId, item);
            }
            
            // Sync session
            session.setAttribute("cart", cartDAO.getCartByUserId(userId));
            
            String redirect = request.getParameter("redirect");
            if (redirect != null && redirect.equals("checkout")) {
                response.sendRedirect("checkout");
            } else {
                response.sendRedirect("cart");
            }
            return;
        } 
        
        else if (action.equalsIgnoreCase("update")) {
            String idStr = request.getParameter("id");
            String qtyStr = request.getParameter("qty");
            int id = Integer.parseInt(idStr);
            int qty = Integer.parseInt(qtyStr);
            
            cartDAO.updateCartItemQty(userId, id, qty);
            
            // Sync session
            session.setAttribute("cart", cartDAO.getCartByUserId(userId));
            response.sendRedirect("cart");
            return;
        } 
        
        else if (action.equalsIgnoreCase("remove")) {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            
            cartDAO.removeCartItem(userId, id);
            
            // Sync session
            session.setAttribute("cart", cartDAO.getCartByUserId(userId));
            response.sendRedirect("cart");
            return;
        } 
        
        else if (action.equalsIgnoreCase("clear")) {
            cartDAO.clearCart(userId);
            
            // Sync session
            session.setAttribute("cart", cartDAO.getCartByUserId(userId));
            response.sendRedirect("cart");
            return;
        }
        
        // view action - sync session first
        session.setAttribute("cart", cartDAO.getCartByUserId(userId));
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
