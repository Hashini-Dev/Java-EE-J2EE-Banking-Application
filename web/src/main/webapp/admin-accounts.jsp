<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Management | Wealth Bank</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body class="bg-light">

    <header class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <span style="color: var(--primary);">Wealth</span>Bank Admin
            </a>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-outline-supiri dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        ${pageContext.request.userPrincipal.name} (Admin)
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
                        <li><a class="dropdown-item rounded-2 text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
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
                        <a class="nav-link px-2 mb-2" href="${pageContext.request.contextPath}/admin-dashboard">
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
                        <a class="nav-link active px-2 mb-2" href="${pageContext.request.contextPath}/admin/accounts">
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
                <div class="glass-card p-4 animate">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0">Account Management</h5>
                    </div>

                    <% if (request.getParameter("error") != null) { %>
                        <div class="alert alert-danger text-center mb-4" role="alert" style="background-color: #f8d7da; color: #842029;">
                            <%
                                String error = request.getParameter("error");
                                if ("balance_not_zero".equals(error)) {
                                    String accNo = request.getParameter("accNo") != null ? request.getParameter("accNo") : "";
                                    out.print("Error: Cannot close account " + accNo + ". Balance must be $0.00.");
                                } else {
                                    out.print("An error occurred processing the account.");
                                }
                            %>
                        </div>
                    <% } %>
                    
                    <% if (request.getParameter("success") != null) { %>
                        <div class="alert alert-success text-center mb-4" role="alert">
                            <%
                                String success = request.getParameter("success");
                                if ("deleted".equals(success)) {
                                    out.print("Account successfully closed.");
                                }
                            %>
                        </div>
                    <% } %>

                    <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-supiri text-white">Create New Account</button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="text-muted small text-uppercase">
                                <tr>
                                    <th>ID</th>
                                    <th>Account No</th>
                                    <th>Type</th>
                                    <th>Balance</th>
                                    <th>Owner</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="acc" items="${accountsList}">
                                    <tr>
                                        <td class="text-muted">${acc.id}</td>
                                        <td class="fw-bold">${acc.accountNo}</td>
                                        <td>${acc.accountType.type}</td>
                                        <td>${acc.balance}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty acc.user}">
                                                    ${acc.user.firstName} ${acc.user.lastName} <span class="text-muted small">(${acc.user.email})</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">No Owner</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-primary px-3 me-2">Edit</button>
                                            <form action="${pageContext.request.contextPath}/admin/account/delete" method="POST" class="d-inline">
                                                <input type="hidden" name="accountId" value="${acc.id}">
                                                <input type="hidden" name="accountNo" value="${acc.accountNo}">
                                                <button type="submit" class="btn btn-sm btn-danger px-3">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty accountsList}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">No accounts found.</td>
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
