package Controller;

import Model.User;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/auth/google/callback")
public class GoogleCallbackController extends HttpServlet {

    private static final String CLIENT_ID
            = "YOUR_GOOGLE_CLIENT_ID";

    private static final String CLIENT_SECRET
            = "YOUR_GOOGLE_CLIENT_SECRET";

    private static final String REDIRECT_URI
            = "http://localhost:9999/DauTay/auth/google/callback";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        // Dynamically load Google OAuth credentials from secured web-inf file
        String activeClientId = CLIENT_ID;
        String activeClientSecret = CLIENT_SECRET;
        try {
            java.util.Properties prop = new java.util.Properties();
            java.io.InputStream input = getServletContext().getResourceAsStream("/WEB-INF/google-config.properties");
            if (input != null) {
                prop.load(input);
                activeClientId = prop.getProperty("google.client.id", CLIENT_ID);
                activeClientSecret = prop.getProperty("google.client.secret", CLIENT_SECRET);
            }
        } catch (Exception e) {
            System.err.println(">>> Error loading google-config.properties: " + e.getMessage());
        }

        // STEP 1: GET ACCESS TOKEN
        String params
                = "code=" + code
                + "&client_id=" + activeClientId
                + "&client_secret=" + activeClientSecret
                + "&redirect_uri=" + REDIRECT_URI
                + "&grant_type=authorization_code";

        URL url = new URL("https://oauth2.googleapis.com/token");

        HttpURLConnection conn
                = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();

        BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));

        StringBuilder result = new StringBuilder();

        String line;

        while ((line = reader.readLine()) != null) {
            result.append(line);
        }

        reader.close();

        Gson gson = new Gson();

        TokenResponse tokenResponse
                = gson.fromJson(result.toString(), TokenResponse.class);

        // STEP 2: GET USER INFO
        URL userInfoUrl = new URL(
                "https://www.googleapis.com/oauth2/v2/userinfo?access_token="
                + tokenResponse.access_token);

        HttpURLConnection userConn
                = (HttpURLConnection) userInfoUrl.openConnection();

        BufferedReader userReader = new BufferedReader(
                new InputStreamReader(userConn.getInputStream(), "UTF-8"));

        StringBuilder userResult = new StringBuilder();

        while ((line = userReader.readLine()) != null) {
            userResult.append(line);
        }

        userReader.close();

        GoogleUser googleUser
                = gson.fromJson(userResult.toString(), GoogleUser.class);

        // STEP 3: Find or create user in DB, then store in session
        HttpSession session = request.getSession();

        Dal.UserDAO dao = new Dal.UserDAO();
        // Try to find existing user by email
        User user = dao.getUserByEmail(googleUser.email);

        if (user == null) {
            // First-time Google login: create user in DB
            long newId = dao.registerGoogleUser(googleUser.email, googleUser.name);
            if (newId > 0) {
                user = dao.getUserById(newId);
            }
        }

        if (user == null) {
            // Fallback: store minimal info (profile won't work but home page will)
            user = new User();
            user.setFullName(googleUser.name);
            user.setEmail(googleUser.email);
        }

        session.setAttribute("user", user);

        // Load persistent cart from database
        if (user.getId() > 0) {
            Dal.CartDAO cartDAO = new Dal.CartDAO();
            session.setAttribute("cart", cartDAO.getCartByUserId(user.getId()));
        }

        response.sendRedirect(request.getContextPath() + "/home.jsp");
    }

    class TokenResponse {

        String access_token;
    }

    class GoogleUser {

        String email;
        String name;
        String picture;
    }
}
