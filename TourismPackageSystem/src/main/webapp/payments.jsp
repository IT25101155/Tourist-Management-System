<%@ page import="model.*,service.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User acc = (User) session.getAttribute("account"); 
    if (acc == null) {
        response.sendRedirect("login.jsp");
        return;
    } 
    boolean admin = !acc.getRole().equals("CUSTOMER"); 
    PaymentService ps = new PaymentService(); 
    BookingService bs = new BookingService(); 
    String q = request.getParameter("q"); 
    List<Payment> list = ps.search(q, admin ? null : acc.getUsername()); 
    String bid = request.getParameter("bookingId"); 
    Booking selected = bid == null ? null : bs.getById(bid); 
%>
<html>
<head>
    <title>Payments</title>
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
                    <a href="bookings.jsp"><i class="bi bi-calendar-check"></i>Bookings</a>
                    <a href="payments.jsp" class="active"><i class="bi bi-credit-card"></i>Payment Validation</a>
                    <a href="reviews.jsp"><i class="bi bi-star"></i>Reviews</a>
                    <a href="notifications-admin.jsp"><i class="bi bi-bell"></i>Notifications</a>
                    <a href="admin-profile.jsp"><i class="bi bi-person-circle"></i>Admin Profile</a>
                </div>
            </div>
            <% } %>
            
            <div class="<%=admin ? "col-md-9" : "col-12 container"%>">
                <h2 class="section-title mb-4"><%=admin ? "Payment Validation Panel" : "My Payments"%></h2>

                <% if (request.getParameter("pending") != null) { %>
                <div class="alert alert-warning shadow-sm border-0 mb-4">
                    <i class="bi bi-info-circle-fill me-2"></i> Payment submitted. Status is pending until admin validation.
                </div>
                <% } %>

                <% if (!admin) { %>
                <div class="card shadow-lg p-4 mb-5 border-top border-4 border-primary">
                    <h5 class="mb-4"><i class="bi bi-upload text-primary me-2"></i>Upload Payment Slip</h5>
                    <form action="make-payment" method="post" enctype="multipart/form-data" class="row g-3 align-items-end">
                        <div class="col-md-2">
                            <label class="form-label fw-bold small text-muted">Payment ID</label>
                            <input name="id" class="form-control bg-light" value="P<%=System.currentTimeMillis()%>" readonly required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold small text-muted">Booking ID</label>
                            <input name="bookingId" class="form-control" placeholder="Booking ID" value="<%=bid==null?"":bid%>" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold small text-muted">Amount Due</label>
                            <input class="form-control bg-light text-success fw-bold" value="Rs. <%=selected==null?"Auto":selected.getAmount()%>" readonly>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold small text-muted">Method</label>
                            <select name="method" class="form-select">
                                <option>CARD</option>
                                <option>ONLINE</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-muted">Upload Slip Image</label>
                            <input type="file" name="slip" class="form-control" accept="image/*,.pdf" required>
                        </div>
                        <div class="col-md-12 mt-4 text-end">
                            <button class="btn btn-success px-4"><i class="bi bi-send me-2"></i>Submit For Validation</button>
                        </div>
                    </form>
                    <p class="text-muted small mt-3"><i class="bi bi-info-square me-1"></i> Amount automatically comes from selected booking/package if ID is valid.</p>
                </div>
                <% } %>

                <div class="card p-4 shadow-sm mb-4">
                    <form class="row g-2 align-items-center m-0">
                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                                <input name="q" class="form-control border-start-0 ps-0" placeholder="Search payment by ID, booking ID, username, status" value="<%=q==null?"":q%>">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary w-100 h-100">Search</button>
                        </div>
                    </form>
                </div>

                <div class="card shadow-sm p-4">
                    <h5 class="mb-4"><i class="bi bi-receipt text-secondary me-2"></i>Payment Records</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>User</th>
                                    <th>Booking Ref</th>
                                    <th>Amount</th>
                                    <th>Method</th>
                                    <th>Status</th>
                                    <th>Slip</th>
                                    <th>Admin Note</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Payment p : list) { %>
                                <tr>
                                    <td><span class="badge bg-secondary"><%=p.getId()%></span></td>
                                    <td><i class="bi bi-person me-1"></i><%=p.getUsername()%></td>
                                    <td class="fw-bold"><%=p.getBookingId()%></td>
                                    <td class="fw-bold text-success">Rs. <%=p.getAmount()%></td>
                                    <td><%=p.getMethod()%></td>
                                    <td>
                                        <span class="badge <%=p.getStatus().equals("APPROVED")?"bg-success":p.getStatus().equals("REJECTED")?"bg-danger":"bg-warning text-dark"%> px-3 py-2"><%=p.getStatus()%></span>
                                    </td>
                                    <td>
                                        <a href="files/<%=p.getSlipFile()%>" target="_blank" class="btn btn-sm btn-outline-secondary" title="View Slip"><i class="bi bi-image"></i> View</a>
                                    </td>
                                    <td class="text-muted small"><%=p.getAdminNote()%></td>
                                    <td>
                                        <% if (admin && p.getStatus().equals("PENDING")) { %>
                                        <form action="validate-payment" method="post" class="m-0 bg-light p-2 rounded d-flex gap-2 align-items-center">
                                            <input type="hidden" name="id" value="<%=p.getId()%>">
                                            <input name="note" class="form-control form-control-sm" placeholder="Admin note" style="width:120px;">
                                            <button name="status" value="APPROVED" class="btn btn-success btn-sm" title="Approve"><i class="bi bi-check-lg"></i></button>
                                            <button name="status" value="REJECTED" class="btn btn-danger btn-sm" title="Reject"><i class="bi bi-x-lg"></i></button>
                                        </form>
                                        <% } else if (admin && p.getStatus().equals("REJECTED")) { %>
                                        <form action="delete-rejected-payment" method="post" class="m-0">
                                            <input type="hidden" name="id" value="<%=p.getId()%>">
                                            <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Remove</button>
                                        </form>
                                        <% } else if (!admin && p.getStatus().equals("REJECTED")) { %>
                                        <a class="btn btn-warning btn-sm" href="payments.jsp?bookingId=<%=p.getBookingId()%>"><i class="bi bi-arrow-clockwise"></i> Pay Again</a>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                                <% if(list.isEmpty()){ %>
                                <tr><td colspan="9" class="text-center text-muted py-4">No payments found.</td></tr>
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