<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account | Wealth Bank</title>
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
                                    <h2 class="display-5 fw-bold mb-4">Start Your Journey</h2>
                                    <p class="mb-5 lead opacity-75">Join over 2 million customers who trust Wealth Bank
                                        for their automated, secure daily banking needs.</p>
                                    <div class="mt-auto">
                                        <div class="glass-card p-3 border-0 bg-white bg-opacity-10">
                                            <h6 class="fw-bold mb-1">Why register?</h6>
                                            <ul class="small mb-0 opacity-75">
                                                <li>Instant Account Setup</li>
                                                <li>Zero Maintenance Fees</li>
                                                <li>Automated Savings Tools</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 p-5 bg-white">
                                <h3 class="fw-bold mb-2">Registration</h3>
                                <p class="text-muted small mb-4">Create your wealth account in minutes.</p>

                                <% if (request.getParameter("error") != null) { %>
                                <div class="alert alert-danger py-2 small mb-4">
                                    <%
                                        String error = request.getParameter("error");
                                        String message = request.getParameter("message");

                                        if ("already_exists".equals(error) && message != null) {
                                            out.print(message);
                                        } else if ("missing_fields".equals(error)) {
                                            out.print("All fields are required.");
                                        } else if ("invalid_password".equals(error)) {
                                            out.print("Invalid password format.");
                                        } else if ("invalid_email".equals(error)) {
                                            out.print("Invalid email format.");
                                        } else {
                                            out.print("Registration failed. Please try again.");
                                        }
                                    %>
                                </div>
                                <% } %>


                                <form action="${pageContext.request.contextPath}/register" method="POST">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold">First Name</label>
                                                    <input type="text" class="form-control bg-light border-0"
                                                        placeholder="John" name="firstName" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold">Last Name</label>
                                                    <input type="text" class="form-control bg-light border-0"
                                                        placeholder="Doe" name="lastName" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold">Username</label>
                                                    <input type="text" class="form-control bg-light border-0"
                                                        placeholder="johndoe88" name="username" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold">Email</label>
                                                    <input type="email" class="form-control bg-light border-0"
                                                        placeholder="john@example.com" name="email" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold">Password</label>
                                                    <input type="password" class="form-control bg-light border-0"
                                                        placeholder="••••••••" name="password" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label small fw-bold">Contact</label>
                                                    <input type="text" class="form-control bg-light border-0"
                                                        placeholder="+123..." name="contact" id="contact" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label small fw-bold">NIC</label>
                                                    <input type="text" class="form-control bg-light border-0"
                                                        placeholder="123456789V" name="nic" id="nic" required>
                                                </div>
                                                <div id="error-message" class="col-12 text-danger small"
                                                    style="display: none;">
                                                </div>
                                                <div class="col-12 mt-4">
                                                    <button type="submit" class="btn btn-supiri w-100 py-3">Create
                                                        Account</button>
                                                </div>
                                                <div class="col-12 text-center mt-3">
                                                    <p class="small text-muted mb-0">Already a member? <a
                                                            href="login.jsp"
                                                            class="text-primary fw-bold text-decoration-none">Sign In
                                                            Here</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.querySelector('form').addEventListener('submit', function (e) {
                const errorMessage = document.getElementById('error-message');
                errorMessage.style.display = 'none';
                errorMessage.textContent = '';

                const firstName = document.getElementsByName('firstName')[0].value.trim();
                const lastName = document.getElementsByName('lastName')[0].value.trim();
                const username = document.getElementsByName('username')[0].value.trim();
                const email = document.getElementsByName('email')[0].value.trim();
                const password = document.getElementsByName('password')[0].value;
                const contact = document.getElementsByName('contact')[0].value.trim();
                const nic = document.getElementsByName('nic')[0].value.trim();

                let errors = [];

                if (!firstName || !lastName || !username || !email || !password || !contact || !nic) {
                    errors.push("All fields are required.");
                }

                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    errors.push("Invalid email format.");
                }

                // Password validation: 8+ chars, upper, lower, number, special
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                if (!passwordRegex.test(password)) {
                    errors.push("Password must be at least 8 characters long and contain uppercase, lowercase, a number, and a special character (@$!%*?&).");
                }

                if (errors.length > 0) {
                    e.preventDefault();
                    errorMessage.textContent = errors.join(" ");
                    errorMessage.style.display = 'block';
                    window.scrollTo(0, 0);
                }
            });
        </script>

    </body>

    </html>