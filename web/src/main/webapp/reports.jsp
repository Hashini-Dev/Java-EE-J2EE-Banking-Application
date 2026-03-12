<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Reports | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body class="bg-light">

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="dashboard">
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
                                <a class="nav-link px-2 mb-2" href="accounts">
                                    <svg class="me-2" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M0 3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3zm2-1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z" />
                                        <path
                                            d="M2 10a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-3z" />
                                    </svg>
                                    Accounts
                                </a>
                                <a class="nav-link active px-2" href="reports">
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

                    <!-- Main Reports Content -->
                    <div class="col-lg-9 text-dark">
                        <div class="glass-card p-4 animate h-100">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold mb-0">Transaction Reports</h4>
                                <div>
                                    <button class="btn btn-outline-primary btn-sm me-2">
                                        <svg width="14" height="14" fill="currentColor" class="me-2 mb-1"
                                            viewBox="0 0 16 16">
                                            <path
                                                d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z" />
                                            <path
                                                d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z" />
                                        </svg>
                                        Export CSV
                                    </button>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle mt-2">
                                    <thead class="text-muted small text-uppercase">
                                        <tr>
                                            <th>Reference / Description</th>
                                            <th>Category</th>
                                            <th>Execution Date</th>
                                            <th>Status</th>
                                            <th class="text-end">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${history}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="bg-light p-2 rounded-3 me-3">
                                                            <c:choose>
                                                                <c:when test="${item.transferType.id == 1}">⚡</c:when>
                                                                <c:when test="${item.transferType.id == 2}">📅</c:when>
                                                                <c:otherwise>🔄</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div>
                                                            <span class="fw-bold d-block">${item.description}</span>
                                                            <small
                                                                class="text-muted font-monospace">TR-${item.id}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.transferType.id == 1}">Instant</c:when>
                                                        <c:when test="${item.transferType.id == 2}">Scheduled</c:when>
                                                        <c:otherwise>Manual Transfer</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-muted">${item.paymentDate}</td>
                                                <td>
                                                    <span class="badge rounded-pill 
                                                <c:choose>
                                                    <c:when test=" ${item.status.status=='COMPLETED' }">bg-success
                                                        bg-opacity-10 text-success</c:when>
                                                        <c:when test="${item.status.status == 'PENDING'}">bg-warning
                                                            bg-opacity-10 text-warning</c:when>
                                                        <c:otherwise>bg-secondary bg-opacity-10 text-secondary
                                                        </c:otherwise>
                                                        </c:choose> border-0 fw-bold">
                                                        ${item.status.status}
                                                    </span>
                                                </td>
                                                <td class="text-end fw-bold <c:choose><c:when test="
                                                    ${item.fromAccount.user.id==loggedUser.id}">text-danger</c:when>
                                                    <c:otherwise>text-success</c:otherwise>
                                                    </c:choose>">
                                                    <c:choose>
                                                        <c:when test="${item.fromAccount.user.id == loggedUser.id}">
                                                            -
                                                        </c:when>
                                                        <c:otherwise>
                                                            +
                                                        </c:otherwise>
                                                    </c:choose>Rs ${item.amount}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty history}">
                                            <tr>
                                                <td colspan="5" class="text-center text-muted py-5">
                                                    <div class="my-4">
                                                        <svg width="48" height="48" fill="var(--text-muted)"
                                                            class="mb-3 opacity-50" viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd"
                                                                d="M15.817.113A.5.5 0 0 1 16 .5v14a.5.5 0 0 1-.402.49l-5 1a.5.5 0 0 1-.196 0L5.5 15.01l-4.902.98A.5.5 0 0 1 0 15.5v-14a.5.5 0 0 1 .402-.49l5-1a.5.5 0 0 1 .196 0L10.5.99l4.902-.98a.5.5 0 0 1 .415.103zM10 1.91l-4-.8v12.98l4 .8V1.91zm1 12.98 4-.8V1.11l-4 .8v12.98zm-6-.8V1.11l-4 .8v12.98l4-.8z" />
                                                        </svg>
                                                        <br>
                                                        No transaction reports found.
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
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