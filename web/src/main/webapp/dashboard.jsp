<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body class="bg-light">

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <span style="color: var(--primary);">Wealth</span>Bank
                    </a>
                    <div class="d-flex align-items-center">
                        <div class="me-3 d-none d-md-block">
                            <span class="text-muted small">Account ID: <span
                                    class="text-dark fw-bold">WB-88291</span></span>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-outline-supiri dropdown-toggle" type="button"
                                data-bs-toggle="dropdown">
                                ${pageContext.request.userPrincipal.name}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
                                <li><a class="dropdown-item rounded-2" href="profile.jsp">My Profile</a></li>
                                <li><a class="dropdown-item rounded-2" href="settings.jsp">Settings</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
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
                            <h5 class="fw-bold mb-4 px-2">Navigation</h5>
                            <nav class="nav flex-column">
                                <a class="nav-link active px-2 mb-2" href="dashboard.jsp">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z" />
                                    </svg>
                                    Overview
                                </a>
                                <a class="nav-link px-2 mb-2" href="transfer">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M1 3.5a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 0 1h-13a.5.5 0 0 1-.5-.5zM8 6a.5.5 0 0 1 .5.5v5.793l2.146-2.147a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 .708-.708L7.5 12.293V6.5A.5.5 0 0 1 8 6z" />
                                    </svg>
                                    Transfers
                                </a>
                                <a class="nav-link px-2 mb-2" href="accounts.jsp">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm2-1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z" />
                                        <path
                                            d="M2 10a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-3z" />
                                    </svg>
                                    Accounts
                                </a>
                                <a class="nav-link px-2" href="history.jsp">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M11 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1z" />
                                        <path
                                            d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2zm2-1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H4z" />
                                        <path d="M6 11h4v1H6v-1zm0-3h4v1H6V8zm0-3h4v1H6V5z" />
                                    </svg>
                                    Reports
                                </a>
                            </nav>
                        </div>

                        <div class="glass-card mt-4 p-4 animate delay-1 shadow-sm"
                            style="background: linear-gradient(135deg, #2c3e50, #000); color: white;">
                            <h6 class="text-uppercase small mb-3 opacity-75">Wealth Rewards</h6>
                            <p class="mb-3 fw-bold">Platinum Status Achieved!</p>
                            <div class="progress bg-secondary mb-3" style="height: 6px;">
                                <div class="progress-bar bg-accent" style="width: 85%"></div>
                            </div>
                            <small class="opacity-75">1,250 points to Diamond</small>
                        </div>
                    </div>

                    <!-- Main Dashboard Content -->
                    <div class="col-lg-9">
                        <div class="row g-4 mb-4">
                            <div class="col-md-7 animate">
                                <div class="glass-card p-4 h-100 position-relative border-0 shadow-sm"
                                    style="background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: white;">
                                    <h6 class="text-uppercase small opacity-75 fw-bold mb-4">Total Liquid Assets</h6>
                                    <h1 class="mb-4 display-5 fw-bold">$ 48,250.90</h1>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-white text-primary me-2">+ 2.4%</span>
                                        <span class="small opacity-75">Than last week</span>
                                    </div>
                                    <img src="resources/chip.png"
                                        class="position-absolute end-0 bottom-0 m-4 opacity-50" style="width: 40px;"
                                        alt="">
                                </div>
                            </div>
                            <div class="col-md-5 animate delay-1">
                                <div class="glass-card p-4 h-100 border-0 shadow-sm">
                                    <h6 class="text-uppercase small text-muted fw-bold mb-4">Scheduled for Today</h6>
                                    <div class="d-flex justify-content-between align-items-center mb-0">
                                        <h3 class="mb-0 fw-bold">$ 1,200.00</h3>
                                        <span class="text-success small">2 Tasks</span>
                                    </div>
                                    <hr class="text-muted">
                                    <div class="small">
                                        <div class="d-flex justify-content-between mb-1">
                                            <span>Interest Accrual</span>
                                            <span class="text-primary fw-bold">+$12.40</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <span>Monthly Rent</span>
                                            <span class="text-danger fw-bold">-$1,187.60</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Activity -->
                        <div class="glass-card p-4 animate delay-2">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold mb-0">Recent Activity</h5>
                                <a href="history.jsp" class="small text-primary text-decoration-none fw-bold">View
                                    All</a>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="text-muted small text-uppercase">
                                        <tr>
                                            <th>Description</th>
                                            <th>Category</th>
                                            <th>Date</th>
                                            <th class="text-end">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light p-2 rounded-3 me-3">🛍️</div>
                                                    <span class="fw-bold">Apple Store Online</span>
                                                </div>
                                            </td>
                                            <td>Shopping</td>
                                            <td class="text-muted">Feb 12, 2024</td>
                                            <td class="text-end fw-bold text-danger">-$1,299.00</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light p-2 rounded-3 me-3">💼</div>
                                                    <span class="fw-bold">Salary Credit - Tech Corp</span>
                                                </div>
                                            </td>
                                            <td>Income</td>
                                            <td class="text-muted">Feb 01, 2024</td>
                                            <td class="text-end fw-bold text-success">+$8,500.00</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light p-2 rounded-3 me-3">🔄</div>
                                                    <span class="fw-bold">Internal Transfer</span>
                                                </div>
                                            </td>
                                            <td>Savings</td>
                                            <td class="text-muted">Jan 28, 2024</td>
                                            <td class="text-end fw-bold">-$2,000.00</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>