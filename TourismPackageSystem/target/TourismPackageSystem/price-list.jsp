<%@ page import="model.User,service.PriceListService,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User admin = (User) session.getAttribute("account"); 
    if (admin == null || admin.getRole().equals("CUSTOMER")) {
        response.sendRedirect("login.jsp");
        return;
    } 
    PriceListService ps = new PriceListService(); 
    List<String[]> list = ps.all(); 
%>
<html>
<head>
    <title>Price List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="nav.jsp"/>
    
    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-md-3">
                <div class="sidebar p-4 rounded">
                    <h5 class="text-white-50 mb-4 px-3 text-uppercase" style="font-size: 0.8rem; letter-spacing: 1px;">Menu</h5>
                    <a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i>Dashboard</a>
                    <a href="manage-users.jsp"><i class="bi bi-people"></i>Manage Users</a>
                    <a href="packages.jsp"><i class="bi bi-box-seam"></i>Manage Packages</a>
                    <a href="price-list.jsp" class="active"><i class="bi bi-tags"></i>Customize Price List</a>
                    <a href="bookings.jsp"><i class="bi bi-calendar-check"></i>Bookings</a>
                    <a href="payments.jsp"><i class="bi bi-credit-card"></i>Payment Validation</a>
                    <a href="reviews.jsp"><i class="bi bi-star"></i>Reviews</a>
                    <a href="notifications-admin.jsp"><i class="bi bi-bell"></i>Notifications</a>
                    <a href="admin-profile.jsp"><i class="bi bi-person-circle"></i>Admin Profile</a>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="section-title m-0">Customization Price List</h2>
                </div>

                <div class="card shadow-sm p-4 mb-4 border-top border-4 border-success">
                    <h5 class="mb-4"><i class="bi bi-plus-circle text-success me-2"></i>Add New Dropdown Item</h5>
                    <form action="add-price" method="post" class="row g-3 align-items-end">
                        <div class="col-md-3">
                            <label class="form-label text-muted small fw-bold">Item Type</label>
                            <select name="type" class="form-select">
                                <option>HOTEL</option>
                                <option>TRANSPORT</option>
                                <option>ACTIVITY</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label text-muted small fw-bold">Item Name</label>
                            <input name="name" class="form-control" placeholder="e.g. Jetwing Blue" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label text-muted small fw-bold">Price Per Person (Rs.)</label>
                            <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00" required>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-success w-100">Add Item</button>
                        </div>
                    </form>
                </div>

                <div class="card shadow-sm p-4">
                    <h5 class="mb-4"><i class="bi bi-list-ul text-primary me-2"></i>Current Items</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Type</th>
                                    <th>Name</th>
                                    <th>Price Per Person (Rs.)</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (String[] d : list) { %>
                                <tr>
                                    <form action="update-price" method="post" class="m-0">
                                        <td>
                                            <input name="type" value="<%=d[0]%>" class="form-control form-control-sm bg-light" readonly>
                                        </td>
                                        <td>
                                            <input type="hidden" name="oldName" value="<%=d[1]%>">
                                            <input name="name" value="<%=d[1]%>" class="form-control form-control-sm">
                                        </td>
                                        <td>
                                            <input type="number" step="0.01" name="price" value="<%=d[2]%>" class="form-control form-control-sm">
                                        </td>
                                        <td class="text-nowrap text-center">
                                            <button class="btn btn-sm btn-primary me-1" title="Update"><i class="bi bi-pencil-square"></i></button>
                                    </form>
                                            <form action="delete-price" method="post" class="d-inline m-0">
                                                <input type="hidden" name="type" value="<%=d[0]%>">
                                                <input type="hidden" name="name" value="<%=d[1]%>">
                                                <button class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirm('Delete this price item?');"><i class="bi bi-trash"></i></button>
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