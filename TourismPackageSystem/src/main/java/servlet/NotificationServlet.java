package servlet;

import model.Notification;
import model.User;
import service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({
        "/send-notification",
        "/update-notification",
        "/delete-notification"
})
public class NotificationServlet extends HttpServlet {

    private final NotificationService notificationService = new NotificationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User account = (User) request.getSession().getAttribute("account");

        if (account == null || account.getRole().equals("CUSTOMER")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String path = request.getServletPath();

        if (path.equals("/send-notification")) {
            Notification notification = new Notification(
                    request.getParameter("id"),
                    request.getParameter("username"),
                    request.getParameter("title"),
                    request.getParameter("message"),
                    "ACTIVE"
            );

            notificationService.add(notification);
            response.sendRedirect("notifications-admin.jsp?sent=1");

        } else if (path.equals("/update-notification")) {
            Notification notification = new Notification(
                    request.getParameter("id"),
                    request.getParameter("username"),
                    request.getParameter("title"),
                    request.getParameter("message"),
                    "ACTIVE"
            );

            notificationService.update(notification);
            response.sendRedirect("notifications-admin.jsp?updated=1");

        } else if (path.equals("/delete-notification")) {
            notificationService.delete(request.getParameter("id"));
            response.sendRedirect("notifications-admin.jsp?deleted=1");
        }
    }
}
