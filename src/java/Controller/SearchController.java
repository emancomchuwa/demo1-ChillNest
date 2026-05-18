package Controller;

import Dal.ProductDAO;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Search query
        String query = request.getParameter("query");
        if (query == null) query = "";

        // Room filter (from Space / Room checkboxes)
        String room = request.getParameter("room");
        if (room == null) room = "";

        // Page number
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try { page = Integer.parseInt(pageStr); }
            catch (NumberFormatException e) { page = 1; }
        }

        int pageSize = 9;
        ProductDAO dao = new ProductDAO();

        int totalProducts = dao.getTotalProducts(query, room);
        int totalPages    = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;

        List<Product> products = dao.getProductsByPage(query, room, page, pageSize);

        request.setAttribute("products",      products);
        request.setAttribute("query",         query);
        request.setAttribute("room",          room);
        request.setAttribute("currentPage",   page);
        request.setAttribute("totalPages",    totalPages);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher("search.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}
