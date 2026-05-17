<%@ page import="model.*,service.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User acc = (User) session.getAttribute("account"); 
    if (acc == null) {
        response.sendRedirect("login.jsp");
        return;
    } 
    boolean admin = !acc.getRole().equals("CUSTOMER"); 
    BookingService bs = new BookingService(); 
    String q = request.getParameter("q"); 
    List<Booking> list = bs.search(q, admin ? null : acc.getUsername()); 
%>
<html>
<head>
    <title>Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="nav.jsp"/>
    
    <div class="container-fluid mt-4 mb-5 px-4">
        <div class="row">
            <% if (admin) { %>
            <div class="col-md-3">
                <div class="sidebar p-4 rounded">
                    <h5 class="text-white-50 mb-4 px-3 text-uppercase" style="font-size: 0.8rem; letter-spacing: 1px;">Menu</h5>
                    <a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i>Dashboard</a>
                    <a href="manage-users.jsp"><i class="bi bi-people"></i>Manage Users</a>
                    <a href="packages.jsp"><i class="bi bi-box-seam"></i>Manage Packages</a>
                    <a href="price-list.jsp"><i class="bi bi-tags"></i>Customize Price List</a>
                    <a href="bookings.jsp" class="active"><i class="bi bi-calendar-check"></i>Bookings</a>
                    <a href="payments.jsp"><i class="bi bi-credit-card"></i>Payment Validation</a>
                    <a href="reviews.jsp"><i class="bi bi-star"></i>Reviews</a>
                    <a href="notifications-admin.jsp"><i class="bi bi-bell"></i>Notifications</a>
                    <a href="admin-profile.jsp"><i class="bi bi-person-circle"></i>Admin Profile</a>
                </div>
            </div>
            <% } %>
            
            <div class="<%=admin ? "col-md-9" : "col-12 container"%>">
                <h2 class="section-title mb-4"><%=admin ? "All Booking Details" : "My Booking History"%></h2>
                
                <div class="card p-4 shadow-sm mb-4">
                    <form class="row g-2 align-items-center m-0">
                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                                <input name="q" class="form-control border-start-0 ps-0" placeholder="Search booking by unique ID, package ID or username" value="<%=q==null?"":q%>">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary w-100 h-100">Search</button>
                        </div>
                    </form>
                </div>

                <div class="card shadow-sm p-4">
                    <h5 class="mb-4"><i class="bi bi-card-checklist text-primary me-2"></i>Bookings</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>User</th>
                                    <th>Package</th>
                                    <th>Booking Date</th>
                                    <th>Travel Date</th>
                                    <th>Persons</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Booking b : list) { %>
                                <tr>
                                    <td><span class="badge bg-secondary"><%=b.getId()%></span></td>
                                    <td><%=b.getUsername()%></td>
                                    <td>
                                        <div class="fw-bold text-primary"><%=b.getPackageName()%></div>
                                        <small class="text-muted"><%=b.getPackageId()%></small>
                                    </td>
                                    <td class="text-muted small"><%=b.getBookingDate()%></td>
                                    <form action="update-booking" method="post" class="m-0">
                                        <td>
                                            <input type="hidden" name="id" value="<%=b.getId()%>">
                                            <input type="date" name="travelDate" value="<%=b.getTravelDate()%>" class="form-control form-control-sm">
                                        </td>
                                        <td>
                                            <input type="number" name="persons" value="<%=b.getPersons()%>" min="1" class="form-control form-control-sm" style="width: 70px;">
                                        </td>
                                        <td class="fw-bold text-success">Rs. <%=b.getAmount()%></td>
                                        <td>
                                            <% 
                                                String badgeColor = "bg-secondary";
                                                if(b.getStatus().equals("CONFIRMED")) badgeColor = "bg-success";
                                                if(b.getStatus().equals("CANCELLED")) badgeColor = "bg-danger";
                                            %>
                                            <span class="badge <%=badgeColor%>"><%=b.getStatus()%></span>
                                        </td>
                                        <td class="text-nowrap text-center">
                                            <button class="btn btn-sm btn-primary me-1" title="Update Details"><i class="bi bi-arrow-repeat"></i> Update</button>
                                    </form>
                                            <form action="delete-booking" method="post" class="d-inline m-0">
                                                <input type="hidden" name="id" value="<%=b.getId()%>">
                                                <button class="btn btn-sm btn-outline-danger" title="Cancel Booking" onclick="return confirm('Cancel this booking?');"><i class="bi bi-x-circle"></i> Cancel</button>
                                            </form>
                                        </td>
                                </tr>
                                <% } %>
                                <% if(list.isEmpty()){ %>
                                <tr><td colspan="9" class="text-center text-muted py-4">No bookings found.</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>