package Controller;

import Dal.ProductDAO;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        jakarta.servlet.http.HttpSession session = request.getSession();
        Model.User user = (Model.User) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("error", "Please login to view product details!");
            response.sendRedirect("login.jsp");
            return;
        }
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("search");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);
            
            if (p != null) {
                request.setAttribute("product", p);
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("search");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("search");
        }
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
