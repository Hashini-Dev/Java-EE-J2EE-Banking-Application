<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Accounts | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
            <style>
                .account-card {
                    border-left: 4px solid var(--primary);
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                }

                .account-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05) !important;
                }
            </style>
        </head>

        <body class="bg-light">

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <span style="color: var(--primary);">Wealth</span>Bank
                    </a>
                    <div class="d-flex align-items-center">
                        <div class="me-3 d-none d-md-block">
                            <span class="text-muted small">Account ID: <span class="text-dark fw-bold">
                                    <c:choose>
                                        <c:when test="${not empty userAccount}">
                                            ${userAccount.accountNo}
                                        </c:when>
                                        <c:otherwise>
                                            No Account
                                        </c:otherwise>
                                    </c:choose>
                                </span></span>
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
                                <a class="nav-link px-2 mb-2" href="dashboard">
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
                                <a class="nav-link active px-2 mb-2" href="accounts">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm2-1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z" />
                                        <path
                                            d="M2 10a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-3z" />
                                    </svg>
                                    Accounts
                                </a>
                                <a class="nav-link px-2" href="reports">
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

                    <!-- Main Accounts Content -->
                    <div class="col-lg-9 text-dark">
                        <div class="glass-card p-4 animate h-100">
                            <h4 class="fw-bold mb-4">Your Bank Accounts</h4>

                            <div class="row g-4">
                                <c:choose>
                                    <c:when test="${not empty userAccounts}">
                                        <c:forEach var="item" items="${userAccounts}">
                                            <div class="col-md-6">
                                                <div class="glass-card account-card p-4 border-0 shadow-sm">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <h5 class="fw-bold mb-0 text-primary">${item.accountType.type}
                                                        </h5>
                                                        <span class="badge bg-light text-dark border">Active</span>
                                                    </div>
                                                    <p class="text-muted small mb-1">Account Number</p>
                                                    <p
                                                        class="fw-bold fs-5 font-monospace mb-4 d-flex align-items-center">
                                                        ${item.accountNo}
                                                        <button class="btn btn-sm text-secondary ms-2 p-0"
                                                            title="Copy Account Number"
                                                            onclick="navigator.clipboard.writeText('${item.accountNo}')">
                                                            <svg width="16" height="16" fill="currentColor"
                                                                viewBox="0 0 16 16">
                                                                <path fill-rule="evenodd"
                                                                    d="M4 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 5a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-1h1v1a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h1v1z" />
                                                            </svg>
                                                        </button>
                                                    </p>

                                                    <div class="d-flex justify-content-between align-items-end">
                                                        <div>
                                                            <p class="text-muted small mb-1">Available Balance</p>
                                                            <h3 class="mb-0 fw-bold">Rs. ${item.balance}</h3>
                                                        </div>
                                                        <div class="text-end">
                                                            <p class="text-muted small mb-1">Interest Rate</p>
                                                            <span
                                                                class="text-success fw-bold">${item.interestRate}%</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-12">
                                            <div class="alert alert-info border-0 shadow-sm" role="alert">
                                                You do not currently have any active accounts.
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="mt-5 text-center">
                                <button class="btn btn-outline-primary px-4 py-2 opacity-75">
                                    <svg width="16" height="16" fill="currentColor" class="me-2 mb-1"
                                        viewBox="0 0 16 16">
                                        <path
                                            d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4" />
                                    </svg>
                                    Request New Account
                                </button>
                                <p class="text-muted small mt-2">New accounts are subject to review by branch
                                    administration.</p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>