<%@ page import="model.User,service.UserService,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User admin = (User) session.getAttribute("account"); 
    if (admin == null || admin.getRole().equals("CUSTOMER")) {
        response.sendRedirect("login.jsp");
        return;
    } 
    boolean head = admin.getRole().equals("HEAD_ADMIN"); 
    UserService us = new UserService(); 
    String q = request.getParameter("q"); 
    List<User> customers = (q == null || q.isEmpty()) ? us.getCustomers() : us.search(q, "CUSTOMER"); 
    List<User> admins = (q == null || q.isEmpty()) ? us.getSubAdmins() : us.search(q, "SUB_ADMIN"); 
%>
<html>
<head>
    <title>Manage Users</title>
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
                    <a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i>Dashboard</a>
                    <a href="manage-users.jsp" class="active"><i class="bi bi-people"></i>Manage Users</a>
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
                    <h2 class="section-title m-0">Manage Customers and Co Admins</h2>
                </div>

                <div class="card p-4 shadow-sm mb-4">
                    <form class="row g-2 align-items-center m-0">
                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                                <input name="q" class="form-control border-start-0 ps-0" placeholder="Search by unique ID, username or email" value="<%=q==null?"":q%>">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary w-100 h-100">Search</button>
                        </div>
                    </form>
                </div>

                <% if (head) { %>
                <div class="card shadow-sm p-4 mb-5 border-top border-4 border-warning">
                    <h5 class="mb-4"><i class="bi bi-person-plus text-warning me-2"></i>Add Co Admin</h5>
                    <form action="create-subadmin" method="post" class="row g-3">
                        <div class="col-md-2">
                            <label class="form-label text-muted small fw-bold">Admin ID</label>
                            <input name="id" class="form-control" placeholder="e.g. A002" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label text-muted small fw-bold">Username</label>
                            <input name="username" class="form-control" placeholder="Username" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label text-muted small fw-bold">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label text-muted small fw-bold">NIC</label>
                            <input name="nic" class="form-control" placeholder="NIC" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label text-muted small fw-bold">Telephone</label>
                            <input name="telephone" class="form-control" placeholder="10 digits" pattern="[0-9]{10}" required>
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label text-muted small fw-bold">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                        </div>
                        <div class="col-md-12 mt-4 text-end">
                            <button class="btn btn-warning px-5"><i class="bi bi-check-circle me-2"></i>Register Co Admin</button>
                        </div>
                    </form>
                </div>
                <% } %>

                <div class="card shadow-sm p-4 mb-5">
                    <h5 class="mb-4"><i class="bi bi-shield-lock text-primary me-2"></i>Co Admin List</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>NIC</th>
                                    <th>Telephone</th>
                                    <th>Password</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (User u : admins) { %>
                                <tr>
                                    <form action="admin-update-user" method="post" class="m-0">
                                        <td>
                                            <input name="id" value="<%=u.getId()%>" class="form-control form-control-sm bg-light" readonly>
                                            <input type="hidden" name="role" value="SUB_ADMIN">
                                        </td>
                                        <td><input name="username" value="<%=u.getUsername()%>" class="form-control form-control-sm bg-light" readonly></td>
                                        <td><input type="email" name="email" value="<%=u.getEmail()%>" class="form-control form-control-sm"></td>
                                        <td><input name="nic" value="<%=u.getNic()%>" class="form-control form-control-sm"></td>
                                        <td><input name="telephone" value="<%=u.getTelephone()%>" class="form-control form-control-sm"></td>
                                        <td><input name="password" value="<%=u.getPassword()%>" class="form-control form-control-sm"></td>
                                        <td class="text-nowrap text-center">
                                            <button class="btn btn-sm btn-primary me-1" title="Update"><i class="bi bi-pencil-square"></i></button>
                                    </form>
                                            <% if (head) { %>
                                            <form action="delete-user" method="post" class="d-inline m-0">
                                                <input type="hidden" name="id" value="<%=u.getId()%>">
                                                <button class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirm('Delete this admin?');"><i class="bi bi-trash"></i></button>
                                            </form>
                                            <% } %>
                                        </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card shadow-sm p-4">
                    <h5 class="mb-4"><i class="bi bi-people text-success me-2"></i>Customer List</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>NIC</th>
                                    <th>Telephone</th>
                                    <th>Membership</th>
                                    <th>Password</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (User u : customers) { %>
                                <tr>
                                    <form action="admin-update-user" method="post" class="m-0">
                                        <td>
                                            <input name="id" value="<%=u.getId()%>" class="form-control form-control-sm bg-light" readonly>
                                            <input type="hidden" name="role" value="CUSTOMER">
                                        </td>
                                        <td><input name="username" value="<%=u.getUsername()%>" class="form-control form-control-sm bg-light" readonly></td>
                                        <td><input type="email" name="email" value="<%=u.getEmail()%>" class="form-control form-control-sm"></td>
                                        <td><input name="nic" value="<%=u.getNic()%>" class="form-control form-control-sm"></td>
                                        <td><input name="telephone" value="<%=u.getTelephone()%>" class="form-control form-control-sm"></td>
                                        <td>
                                            <select name="membershipType" class="form-select form-select-sm">
                                                <option <%=u.getMembershipType().equals("Regular")?"selected":""%>>Regular</option>
                                                <option <%=u.getMembershipType().equals("Premium")?"selected":""%>>Premium</option>
                                            </select>
                                        </td>
                                        <td><input name="password" value="<%=u.getPassword()%>" class="form-control form-control-sm"></td>
                                        <td class="text-nowrap text-center">
                                            <button class="btn btn-sm btn-primary me-1" title="Update"><i class="bi bi-pencil-square"></i></button>
                                    </form>
                                            <form action="delete-user" method="post" class="d-inline m-0">
                                                <input type="hidden" name="id" value="<%=u.getId()%>">
                                                <button class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirm('Delete this customer?');"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                </tr>
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
