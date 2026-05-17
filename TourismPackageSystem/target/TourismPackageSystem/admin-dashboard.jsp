<%@ page import="model.User,service.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User admin = (User) session.getAttribute("account"); 
    if (admin == null || admin.getRole().equals("CUSTOMER")) {
        response.sendRedirect("login.jsp");
        return;
    } 
    UserService us = new UserService(); 
    PackageService ps = new PackageService(); 
    BookingService bs = new BookingService(); 
    PaymentService pay = new PaymentService(); 
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="nav.jsp"/>
    
    <div class="container-fluid mt-4 mb-5">
        <div class="row">
            <div class="col-md-3">
                <div class="sidebar p-4 rounded">
                    <h5 class="text-white-50 mb-4 px-3 text-uppercase" style="font-size: 0.8rem; letter-spacing: 1px;">Menu</h5>
                    <a href="admin-dashboard.jsp" class="active"><i class="bi bi-speedometer2"></i>Dashboard</a>
                    <a href="manage-users.jsp"><i class="bi bi-people"></i>Manage Users</a>
                    <a href="packages.jsp"><i class="bi bi-box-seam"></i>Manage Packages</a>
                    <a href="price-list.jsp"><i class="bi bi-tags"></i>Customize Price List</a>
                    <a href="bookings.jsp"><i class="bi bi-calendar-check"></i>Bookings</a>
                    <a href="payments.jsp"><i class="bi bi-credit-card"></i>Payment Validation</a>
                    <a href="reviews.jsp"><i class="bi bi-star"></i>Reviews</a>
                    <a href="notifications-admin.jsp"><i class="bi bi-bell"></i>Notifications</a>
                    <a href="admin-profile.jsp"><i class="bi bi-person-circle"></i>Admin Profile</a>
                </div>
            </div>
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="section-title mb-1">LankaTrail Admin Dashboard</h2>
                        <p class="text-muted">Welcome back, logged in as <b><%=admin.displayType()%></b></p>
                    </div>
                </div>

                <% if (request.getParameter("noaccess") != null) { %>
                    <div class="alert alert-danger shadow-sm border-0"><i class="bi bi-exclamation-triangle-fill me-2"></i>Only head admin can perform that action.</div>
                <% } %>
                
                <div class="row g-4">
                    <div class="col-md-3">
                        <div class="stat text-center p-4">
                            <div class="mb-3 text-primary"><i class="bi bi-people-fill" style="font-size: 2rem;"></i></div>
                            <h3 class="mb-1"><%=us.getCustomers().size()%></h3>
                            <p class="text-uppercase text-muted" style="font-size: 0.8rem; letter-spacing: 1px;">Customers</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat text-center p-4">
                            <div class="mb-3 text-warning"><i class="bi bi-shield-lock-fill" style="font-size: 2rem;"></i></div>
                            <h3 class="mb-1"><%=us.getSubAdmins().size()%></h3>
                            <p class="text-uppercase text-muted" style="font-size: 0.8rem; letter-spacing: 1px;">Co Admins</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat text-center p-4">
                            <div class="mb-3 text-success"><i class="bi bi-box-fill" style="font-size: 2rem;"></i></div>
                            <h3 class="mb-1"><%=ps.getStandardPackages().size()%></h3>
                            <p class="text-uppercase text-muted" style="font-size: 0.8rem; letter-spacing: 1px;">Packages</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat text-center p-4">
                            <div class="mb-3 text-danger"><i class="bi bi-journal-check" style="font-size: 2rem;"></i></div>
                            <h3 class="mb-1"><%=bs.all().size()%></h3>
                            <p class="text-uppercase text-muted" style="font-size: 0.8rem; letter-spacing: 1px;">Bookings</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>