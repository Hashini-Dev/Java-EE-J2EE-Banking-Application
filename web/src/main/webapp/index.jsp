<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Wealth Bank | The Future of Banking</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body>

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <span style="color: var(--primary);">Wealth</span>Bank
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav mx-auto">
                            <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                            <li class="nav-item"><a class="nav-link" href="security.jsp">Security</a></li>
                            <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                        </ul>
                        <div class="d-flex align-items-center">
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="login.jsp" class="btn btn-outline-supiri me-3">Login</a>
                                <a href="register.jsp" class="btn btn-supiri">Join Now</a>
                            </c:if>
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="dashboard.jsp" class="btn btn-supiri me-3">Dashboard</a>
                                <a href="logout" class="btn btn-outline-danger btn-sm rounded-pill">Logout</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </header>

            <main>
                <!-- Hero Section -->
                <section class="container py-5 mt-5">
                    <div class="row align-items-center">
                        <div class="col-lg-6 animate">
                            <h1 class="display-3 fw-bold mb-4">Banking That <span
                                    style="color: var(--primary);">Empowers</span> You</h1>
                            <p class="lead text-muted mb-5">Experience the next generation of financial freedom. Our
                                EJB-powered platform ensures your wealth works as hard as you do, with smart automation
                                and world-class security.</p>
                            <div class="d-flex gap-4">
                                <a href="register.jsp" class="btn btn-supiri px-5 py-3">Start Today</a>
                                <a href="#" class="btn btn-outline-supiri px-5 py-3">View Services</a>
                            </div>

                            <div class="mt-5 d-flex gap-5">
                                <div>
                                    <h4 class="fw-bold mb-0">99.9%</h4>
                                    <small class="text-muted">Uptime</small>
                                </div>
                                <div>
                                    <h4 class="fw-bold mb-0">256-bit</h4>
                                    <small class="text-muted">Encryption</small>
                                </div>
                                <div>
                                    <h4 class="fw-bold mb-0">2M+</h4>
                                    <small class="text-muted">Users</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 animate delay-1">
                            <div class="position-relative">
                                <img src="resources/woman-payment.jpeg" alt="Banking"
                                    class="img-fluid rounded-4 shadow-lg hover-scale">
                                <div class="glass-card p-4 position-absolute bottom-0 start-0 translate-middle-x ms-5 mb-5 d-none d-lg-block animate delay-2"
                                    style="width: 250px;">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-success rounded-circle p-2 me-3">
                                            <svg width="20" height="20" fill="white" viewBox="0 0 16 16">
                                                <path
                                                    d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
                                            </svg>
                                        </div>
                                        <h6 class="mb-0">Auto-Interest Applied</h6>
                                    </div>
                                    <p class="small text-muted mb-0">Your account just grew by 2.5% automatically!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Features Section -->
                <section class="bg-white py-5">
                    <div class="container py-5">
                        <div class="text-center mb-5 animate">
                            <h2 class="fw-bold">Why Choose Wealth Bank?</h2>
                            <p class="text-muted">We combine traditional trust with cutting-edge technology.</p>
                        </div>
                        <div class="row g-4">
                            <div class="col-md-4 animate delay-1">
                                <div class="glass-card p-5 text-center h-100 border-0">
                                    <div class="mb-4 d-inline-block p-4 rounded-4"
                                        style="background: rgba(0, 87, 231, 0.1);">
                                        <svg width="32" height="32" fill="var(--primary)" viewBox="0 0 16 16">
                                            <path
                                                d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zM7 11.5a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0v7zM10 11.5a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0v7z" />
                                        </svg>
                                    </div>
                                    <h4 class="fw-bold">Smart Automation</h4>
                                    <p class="text-muted">EJB Timer Services handle your interest and transfers 24/7
                                        without manual effort.</p>
                                </div>
                            </div>
                            <!-- More features can go here -->
                        </div>
                    </div>
                </section>
            </main>

            <footer class="bg-dark text-white py-5 mt-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <h3 class="fw-bold mb-4">WealthBank</h3>
                            <p class="text-muted">Secure, automated, and professional banking solutions for the digital
                                age.</p>
                        </div>
                        <div class="col-md-8 text-md-end">
                            <div class="mb-4">
                                <a href="#" class="text-white me-4">Privacy Policy</a>
                                <a href="#" class="text-white me-4">Terms of Service</a>
                                <a href="#" class="text-white">Security</a>
                            </div>
                            <p class="small text-muted">&copy; 2024 Wealth Bank. All rights reserved.</p>
                        </div>
                    </div>
                </div>
            </footer>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>