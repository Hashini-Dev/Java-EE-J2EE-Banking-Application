<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Secure Login | Wealth Bank</title>
        <link rel="stylesheet" href="css/bootstrap.css" />
        <link rel="stylesheet" href="css/style.css" />
    </head>

    <body class="bg-light d-flex align-items-center vh-100">

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10 col-xl-9">
                    <div class="glass-card border-0 overflow-hidden animate">
                        <div class="row g-0">
                            <div class="col-md-6 d-none d-md-block"
                                style="background: linear-gradient(135deg, var(--primary), var(--primary-dark));">
                                <div class="h-100 p-5 d-flex flex-column justify-content-center text-white">
                                    <h2 class="display-5 fw-bold mb-4">Secure Gateway</h2>
                                    <p class="mb-5 lead opacity-75">Your financial security is our top priority. Our
                                        platform uses enterprise-grade EJB security layers to protect every session.</p>
                                    <div class="mt-auto">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-white rounded-circle p-2 me-3"
                                                style="width: 40px; height: 40px;">🔑</div>
                                            <span>2FA Multi-layered check</span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-white rounded-circle p-2 me-3"
                                                style="width: 40px; height: 40px;">🛡️</div>
                                            <span>Encrypted Communication</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 p-5 bg-white">
                                <div class="text-center mb-5">
                                    <h3 class="fw-bold">Sign In</h3>
                                    <p class="text-muted small">Welcome back to Wealth Bank</p>
                                </div>
                                <% if (request.getAttribute("errorMessage") !=null) { %>
                                    <div class="alert alert-danger" role="alert">
                                        <%= request.getAttribute("errorMessage") %>
                                    </div>
                                    <% } %>

                                        <form action="${pageContext.request.contextPath}/login" method="POST">
                                            <div class="mb-4">
                                                <label class="form-label small fw-bold text-uppercase">Username</label>
                                                <input type="text"
                                                    class="form-control form-control-lg bg-light border-0 p-3"
                                                    placeholder="Enter your username" name="username" required>
                                            </div>
                                            <div class="mb-5">
                                                <label class="form-label small fw-bold text-uppercase">Password</label>
                                                <input type="password"
                                                    class="form-control form-control-lg bg-light border-0 p-3"
                                                    placeholder="••••••••" name="password" required>
                                            </div>
                                            <button type="submit" class="btn btn-supiri w-100 py-3 mb-4">Access
                                                Account</button>
                                            <div class="text-center">
                                                <p class="small text-muted mb-0">Don't have an account? <a
                                                        href="register.jsp"
                                                        class="text-primary fw-bold text-decoration-none">Join the
                                                        future</a>
                                                </p>
                                            </div>
                                        </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>

    </html>