<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Wealth Bank</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/style.css" />
</head>
<body class="bg-light">

    <header class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">
                <span style="color: var(--primary);">Wealth</span>Bank Admin
            </a>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-outline-supiri dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        ${pageContext.request.userPrincipal.name} (Admin)
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
                        <li><a class="dropdown-item rounded-2 text-danger" href="logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <div class="container py-5">
        <div class="row g-4">
            <!-- Sidebar Navigation -->
            <div class="col-lg-3">
                <div class="glass-card p-4 animate">
                    <h5 class="fw-bold mb-4 px-2">Admin Panel</h5>
                    <nav class="nav flex-column">
                        <a class="nav-link active px-2 mb-2" href="${pageContext.request.contextPath}/admin-dashboard">
                            <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                            </svg>
                            Dashboard
                        </a>
                        <a class="nav-link px-2 mb-2" href="${pageContext.request.contextPath}/admin/users">
                            <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M11 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1z" />
                                <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2zm2-1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H4z" />
                                <path d="M6 11h4v1H6v-1zm0-3h4v1H6V8zm0-3h4v1H6V5z" />
                            </svg>
                            User Management
                        </a>
                        <a class="nav-link px-2 mb-2" href="${pageContext.request.contextPath}/admin/accounts">
                            <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm2-1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z" />
                                <path d="M2 10a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-3z" />
                            </svg>
                            Account Management
                        </a>
                        <a class="nav-link px-2 mb-2 text-muted" href="#">
                            <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M1 3.5a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13a.5.5 0 0 1-.5-.5zM8 6a.5.5 0 0 1 .5.5v5.793l2.146-2.147a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 .708-.708L7.5 12.293V6.5A.5.5 0 0 1 8 6z" />
                            </svg>
                            Scheduled Tasks
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Dashboard Content -->
            <div class="col-lg-9">
                <div class="row g-4 mb-4">
                    <div class="col-md-6 animate">
                        <div class="glass-card p-4 h-100 position-relative border-0 shadow-sm"
                            style="background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: white;">
                            <h6 class="text-uppercase small opacity-75 fw-bold mb-4">Total Registered Users</h6>
                            <h1 class="mb-4 display-5 fw-bold">
                                ${totalUsers}
                            </h1>
                            <div class="d-flex align-items-center">
                                <span class="small opacity-75">Active users across the system</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 animate delay-1">
                        <div class="glass-card p-4 h-100 position-relative border-0 shadow-sm"
                            style="background: linear-gradient(135deg, #198754, #0f5132); color: white;">
                            <h6 class="text-uppercase small opacity-75 fw-bold mb-4">Total Bank Accounts</h6>
                            <h1 class="mb-4 display-5 fw-bold">
                                ${totalAccounts}
                            </h1>
                            <div class="d-flex align-items-center">
                                <span class="small opacity-75">Including Savings and Current accounts</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="glass-card p-4 animate delay-2">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0">System Summary</h5>
                    </div>
                    <div class="text-muted small">
                        Administrative functions will be expanded in future modules. Currently displaying real-time metrics for network usage and volume.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
