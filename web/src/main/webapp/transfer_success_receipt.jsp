<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Transfer Success | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body class="bg-light d-flex align-items-center vh-100">

            <div class="container text-center">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="glass-card p-5 animate">
                            <div class="mb-4">
                                <div class="bg-success rounded-circle d-inline-block p-4 mb-4 animate delay-1"
                                    style="width: 100px; height: 100px;">
                                    <svg width="50" height="50" fill="white" viewBox="0 0 16 16">
                                        <path
                                            d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
                                    </svg>
                                </div>
                                <h2 class="fw-bold">Payment Sent!</h2>
                                <p class="text-muted">Your transaction was processed successfully via the secure EJB
                                    core.</p>
                            </div>

                            <div class="bg-light p-4 rounded-4 text-start mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted small">Transaction ID:</span>
                                    <span class="fw-bold small">WB-TXN-${transfer.id}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted small">To Account:</span>
                                    <span class="fw-bold small">${transfer.toAccount.accountNo}
                                        (${transfer.toAccount.accountType.type})</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted small">Total Amount:</span>
                                    <span class="fw-bold text-success">Rs. ${transfer.amount}</span>
                                </div>
                            </div>

                            <div class="d-grid gap-3">
                                <a href="dashboard.jsp" class="btn btn-supiri py-3">Back to Dashboard</a>
                                <button onclick="window.print()" class="btn btn-outline-supiri py-3">Print PDF
                                    Receipt</button>
                            </div>
                        </div>

                        <p class="mt-4 text-muted small animate delay-2">Wealth Bank - Secure, Automated, Elite.</p>
                    </div>
                </div>
            </div>

        </body>

        </html>