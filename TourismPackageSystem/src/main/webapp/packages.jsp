<%@ page import="model.*,service.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% 
    User acc = (User) session.getAttribute("account"); 
    boolean admin = acc != null && !acc.getRole().equals("CUSTOMER"); 
    PackageService ps = new PackageService(); 
    PriceListService pls = new PriceListService(); 
    String q = request.getParameter("q"); 
    List<StandardPackage> packs = ps.searchStandard(q); 
    List<CustomPackage> customs = admin ? ps.searchCustom(q, null) : (acc != null ? ps.searchCustom(q, acc.getUsername()) : new ArrayList<CustomPackage>()); 
%>
<html>
<head>
    <title>Packages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script>
        function price(sel) {
            return parseFloat(sel.options[sel.selectedIndex].dataset.price || 0)
        }
        function calc() {
            let h = price(document.getElementById('hotel')),
                t = price(document.getElementById('transport')),
                a = price(document.getElementById('activity')),
                p = parseInt(document.getElementById('persons').value || 1);
            let single = h + t + a;
            document.getElementById('singlePrice').innerText = single.toFixed(2);
            document.getElementById('totalPrice').innerText = (single * p).toFixed(2);
        }
    </script>
</head>
<body onload="calc()">
    <jsp:include page="nav.jsp"/>
    
    <div class="container-fluid mt-4 mb-5 px-4">
        <h2 class="section-title mb-4">Packages & Customization</h2>
        
        <div class="card p-4 shadow-sm mb-5">
            <form class="row g-2 align-items-center m-0">
                <div class="col-md-10">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                        <input name="q" class="form-control border-start-0 ps-0" placeholder="Search package by ID, name, destination or user" value="<%=q==null?"":q%>">
                    </div>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100 h-100">Search Packages</button>
                </div>
            </form>
        </div>

        <% if (admin) { %>
        <div class="card shadow-sm p-4 mb-5 border-top border-4 border-success">
            <h5 class="mb-4"><i class="bi bi-plus-circle text-success me-2"></i>Add Standard Package</h5>
            <form action="add-package" method="post" class="row g-3">
                <div class="col-md-2">
                    <label class="form-label text-muted small fw-bold">Package ID</label>
                    <input name="id" class="form-control" placeholder="P001" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label text-muted small fw-bold">Package Name</label>
                    <input name="name" class="form-control" placeholder="e.g. Ella Getaway" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label text-muted small fw-bold">Destination</label>
                    <input name="destination" class="form-control" placeholder="Ella, Sri Lanka" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label text-muted small fw-bold">Duration (Days)</label>
                    <input type="number" name="duration" class="form-control" placeholder="Days" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label text-muted small fw-bold">Single Price</label>
                    <input type="number" step="0.01" name="basePrice" class="form-control" placeholder="Rs." required>
                </div>
                <div class="col-md-2">
                    <label class="form-label text-muted small fw-bold">Discount (%)</label>
                    <input type="number" step="0.01" name="discount" value="0" class="form-control" placeholder="0">
                </div>
                <div class="col-md-7">
                    <label class="form-label text-muted small fw-bold">Description</label>
                    <input name="description" class="form-control" placeholder="Brief description of the tour..." required>
                </div>
                <div class="col-md-3 mt-auto">
                    <button class="btn btn-success w-100"><i class="bi bi-check2-circle me-2"></i>Add Package</button>
                </div>
            </form>
        </div>
        <% } %>

        <div class="row g-4 mb-5">
            <% for (StandardPackage p : packs) { %>
            <div class="col-md-4">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h4 class="card-title text-primary fw-bold mb-0"><%=p.getName()%></h4>
                            <span class="badge bg-light text-dark border"><i class="bi bi-hash"></i><%=p.getId()%></span>
                        </div>
                        <p class="text-muted small mb-3">
                            <i class="bi bi-geo-alt-fill text-danger me-1"></i><%=p.getDestination()%> &bull; 
                            <i class="bi bi-clock-fill text-warning me-1 ms-2"></i><%=p.getDuration()%> Days
                        </p>
                        <p class="card-text flex-grow-1"><%=p.getDescription()%></p>
                        <div class="mt-3 pt-3 border-top">
                            <p class="mb-3">Price per person: <span class="fs-5 fw-bold text-success">Rs. <%=p.calculatePrice()%></span></p>
                            
                            <% if (acc != null && !admin) { %>
                            <form action="book-package" method="post" class="m-0 bg-light p-3 rounded">
                                <input type="hidden" name="id" value="B<%=System.currentTimeMillis()%>">
                                <input type="hidden" name="packageId" value="<%=p.getId()%>">
                                <div class="row g-2">
                                    <div class="col-7">
                                        <label class="small text-muted mb-1">Travel Date</label>
                                        <input type="date" name="travelDate" class="form-control form-control-sm" required>
                                    </div>
                                    <div class="col-5">
                                        <label class="small text-muted mb-1">Persons</label>
                                        <input type="number" name="persons" min="1" class="form-control form-control-sm" required>
                                    </div>
                                    <div class="col-12 mt-2">
                                        <button class="btn btn-primary btn-sm w-100">Book Now</button>
                                    </div>
                                </div>
                            </form>
                            <% } %>
                            
                            <% if (admin) { %>
                            <form action="delete-package" method="post" class="mt-2 m-0">
                                <input type="hidden" name="id" value="<%=p.getId()%>">
                                <button class="btn btn-outline-danger w-100" onclick="return confirm('Delete this package?');"><i class="bi bi-trash me-2"></i>Remove Package</button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <% if (acc != null && !admin) { %>
        <div class="card shadow-lg p-4 mt-5 border-top border-4 border-warning bg-light">
            <h4 class="mb-3"><i class="bi bi-magic text-warning me-2"></i>Create Customized Package</h4>
            <p class="text-muted mb-4">Select your preferred options to calculate the price. Your custom package will be generated automatically when you book.</p>
            <form action="customize-package" method="post" class="row g-3">
                <div class="col-md-2">
                    <label class="form-label fw-bold small">Package ID</label>
                    <input name="id" class="form-control bg-white" value="C<%=System.currentTimeMillis()%>" readonly>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small">Destination</label>
                    <input name="destination" class="form-control" placeholder="Type destination" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-bold small">Duration</label>
                    <input type="number" name="duration" class="form-control" placeholder="Days" required>
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-bold small">No. of Persons</label>
                    <input id="persons" oninput="calc()" type="number" name="persons" value="1" min="1" class="form-control" required>
                </div>
                
                <div class="w-100 m-0"></div> <!-- Line break -->

                <div class="col-md-4">
                    <label class="form-label fw-bold small"><i class="bi bi-building me-1"></i>Hotel Accommodation</label>
                    <select id="hotel" onchange="calc()" name="hotel" class="form-select shadow-sm">
                        <% for(String[] d:pls.byType("HOTEL")){%><option data-price="<%=d[2]%>"><%=d[1]%></option><%}%>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold small"><i class="bi bi-car-front me-1"></i>Transport Method</label>
                    <select id="transport" onchange="calc()" name="transport" class="form-select shadow-sm">
                        <% for(String[] d:pls.byType("TRANSPORT")){%><option data-price="<%=d[2]%>"><%=d[1]%></option><%}%>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold small"><i class="bi bi-activity me-1"></i>Main Activity</label>
                    <select id="activity" onchange="calc()" name="activity" class="form-select shadow-sm">
                        <% for(String[] d:pls.byType("ACTIVITY")){%><option data-price="<%=d[2]%>"><%=d[1]%></option><%}%>
                    </select>
                </div>

                <div class="col-md-12 mt-4">
                    <div class="price-box d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted">Single Person:</span> <b class="fs-5 ms-2">Rs. <span id="singlePrice">0</span></b>
                        </div>
                        <div>
                            <span class="text-muted">Total Amount:</span> <b class="fs-3 text-success ms-2">Rs. <span id="totalPrice">0</span></b>
                        </div>
                        <button class="btn btn-warning btn-lg px-5">Save Custom Package</button>
                    </div>
                </div>
            </form>
        </div>
        <% } %>

        <div class="card p-4 shadow-sm mt-5">
            <h5 class="mb-4"><i class="bi bi-collection text-info me-2"></i><%=admin?"All Customized Packages":"My Customized Packages"%></h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Name</th>
                            <th>Destination</th>
                            <th>Persons</th>
                            <th>Single Price</th>
                            <th>Total Amount</th>
                            <% if(acc!=null&&!admin){%><th>Action</th><%}%>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(CustomPackage c:customs){%>
                        <tr>
                            <td><span class="badge bg-secondary"><%=c.getId()%></span></td>
                            <td><i class="bi bi-person me-1"></i><%=c.getUsername()%></td>
                            <td class="fw-bold"><%=c.getName()%></td>
                            <td><%=c.getDestination()%></td>
                            <td><%=c.getPersons()%></td>
                            <td class="text-muted">Rs. <%=c.singlePersonPrice()%></td>
                            <td class="fw-bold text-success">Rs. <%=c.calculatePrice()%></td>
                            <% if(acc!=null&&!admin){%>
                            <td>
                                <form action="book-package" method="post" class="m-0 d-flex gap-2">
                                    <input type="hidden" name="id" value="B<%=System.currentTimeMillis()%>">
                                    <input type="hidden" name="packageId" value="<%=c.getId()%>">
                                    <input type="hidden" name="persons" value="<%=c.getPersons()%>">
                                    <input type="date" name="travelDate" class="form-control form-control-sm w-auto" required>
                                    <button class="btn btn-success btn-sm">Book</button>
                                </form>
                            </td>
                            <%}%>
                        </tr>
                        <%}%>
                        <% if(customs.isEmpty()){ %>
                        <tr><td colspan="8" class="text-center text-muted py-4">No customized packages found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>