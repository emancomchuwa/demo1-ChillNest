package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login-google")
public class LoginGoogleController extends HttpServlet {

    private static final String CLIENT_ID =
            "733583080314-6gj8ge2o6ouf1ckbgllapnoqggopomqd.apps.googleusercontent.com";

    private static final String REDIRECT_URI =
            "http://localhost:9999/DauTay/auth/google/callback";

    private static final String GOOGLE_LINK =
            "https://accounts.google.com/o/oauth2/auth";

    private static final String SCOPE =
            "email profile";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = GOOGLE_LINK
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&response_type=code"
                + "&scope=" + SCOPE;

        response.sendRedirect(url);
    }
}