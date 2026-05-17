<%@ page import="model.User" %>
<%
    User acc = (User) session.getAttribute("account");
    boolean admin = acc != null && !acc.getRole().equals("CUSTOMER");
%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand brand" href="index.jsp">LankaTrail</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="packages.jsp">Packages</a></li>
                <li class="nav-item"><a class="nav-link" href="reviews.jsp">Reviews</a></li>

                <% if (acc == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <% } else if (admin) { %>
                    <li class="nav-item"><a class="nav-link" href="admin-dashboard.jsp">Admin Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="admin-profile.jsp">Admin Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="profile.jsp">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="bookings.jsp">Bookings</a></li>
                    <li class="nav-item"><a class="nav-link" href="payments.jsp">Payments</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<div class="system-heading text-center">
    TOURIST AND LOCAL TRAVEL PACKAGE CUSTAMIZATION PLATFORM
</div>
