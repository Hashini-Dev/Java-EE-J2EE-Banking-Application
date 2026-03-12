<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Management Console | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body class="bg-light">

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <span style="color: var(--primary);">Wealth</span>Bank <span class="badge bg-primary ms-2 small"
                            style="font-size: 0.6rem;">Admin</span>
                    </a>
                    <a href="dashboard.jsp" class="btn btn-outline-supiri btn-sm rounded-pill">Dashboard</a>
                </div>
            </header>

            <div class="container py-5">
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                        <strong>Success!</strong> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <strong>Error!</strong> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="glass-card p-5 animate">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h2 class="fw-bold mb-3">Time Service Management</h2>
                                    <p class="text-muted mb-0">Monitor and manually trigger automated EJB background
                                        tasks.
                                        This section is restricted to administrative personnel and utilizes
                                        @RolesAllowed
                                        security.</p>
                                </div>
                                <div class="col-md-4 text-md-end">
                                    <div class="p-3 rounded-4 bg-light d-inline-block border">
                                        <span class="text-success fw-bold">System Status: </span>
                                        <span class="badge bg-success rounded-pill">Active</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Task 1: Interest Calculation -->
                    <div class="col-md-6">
                        <div class="glass-card p-4 h-100 animate delay-1">
                            <div class="d-flex align-items-center mb-4">
                                <div class="p-3 rounded-4 me-3" style="background: rgba(241, 196, 15, 0.1);">💰</div>
                                <h5 class="fw-bold mb-0">Automated Interest</h5>
                            </div>
                            <p class="text-muted small mb-4">Triggers the calculation and application of interest rates
                                across all active savings accounts. This utilizes the
                                <strong>InterestCalculationBean</strong> EJB singleton.
                            </p>

                            <div class="bg-light p-3 rounded-3 mb-4">
                                <div class="d-flex justify-content-between small mb-2">
                                    <span>Last Run:</span>
                                    <span class="fw-bold">Today, 00:00:01</span>
                                </div>
                                <div class="d-flex justify-content-between small">
                                    <span>Next Scheduled:</span>
                                    <span class="fw-bold text-primary">Tomorrow, 00:00:00</span>
                                </div>
                            </div>

                            <form action="triggerInterest" method="POST">
                                <button type="submit" class="btn btn-supiri w-100 py-3">Run Interest Calculation
                                    Now</button>
                                <p class="text-center small text-muted mt-2">Requires ADMIN privileges for manual
                                    execution.
                                </p>
                            </form>
                        </div>
                    </div>

                    <!-- Task 2: Loan Processing / Batch Transfers -->
                    <div class="col-md-6">
                        <div class="glass-card p-4 h-100 animate delay-1">
                            <div class="d-flex align-items-center mb-4">
                                <div class="p-3 rounded-4 me-3" style="background: rgba(46, 204, 113, 0.1);">📝</div>
                                <h5 class="fw-bold mb-0">Batch Loan Deposits</h5>
                            </div>
                            <p class="text-muted small mb-4">Executes batch processing for approved loan disbursements.
                                Uses
                                <strong>UserTransaction</strong> (BMT) to ensure all deposits succeed or all fail.
                            </p>

                            <div class="alert alert-info border-0 rounded-4 small py-3">
                                <strong>Note:</strong> Transaction demarcation ensures data integrity even if hardware
                                fails
                                during processing.
                            </div>

                            <form action="triggerBatch" method="POST">
                                <button type="submit" class="btn btn-outline-supiri w-100 py-3">Trigger Batch
                                    Disbursement</button>
                                <p class="text-center small text-muted mt-2">Protected by JTA Global Transaction
                                    Management.
                                </p>
                            </form>
                        </div>
                    </div>

                    <!-- System Logs / Interceptor Output -->
                    <div class="col-12">
                        <div class="glass-card p-4 animate delay-2">
                            <h5 class="fw-bold mb-4">EJB Interceptor Audit Logs</h5>
                            <div class="bg-dark rounded-4 p-4 font-monospace overflow-auto"
                                style="height: 250px; color: #00ff00; font-size: 0.8rem;">
                                <div>[INFO] 2024-02-12 14:00:01 - LoggingInterceptor: Entering method:
                                    InterestCalculationService.scheduledInterestCalculation</div>
                                <div>[INFO] 2024-02-12 14:00:02 - Processing 842 accounts...</div>
                                <div>[INFO] 2024-02-12 14:00:05 - Total interest applied: $12,482.10</div>
                                <div>[INFO] 2024-02-12 14:00:05 - LoggingInterceptor: Exiting method:
                                    InterestCalculationService.scheduledInterestCalculation (Execution Time: 4500ms)
                                </div>
                                <div class="opacity-50 mt-2">--------------------------------------------------</div>
                                <div>[INFO] 2024-02-12 14:05:22 - LoggingInterceptor: Entering method:
                                    BmtTransactionBean.processManualTransfer</div>
                                <div>[INFO] 2024-02-12 14:05:22 - UserTransaction: Begin</div>
                                <div>[INFO] 2024-02-12 14:05:23 - UserTransaction: Commit</div>
                                <div>[INFO] 2024-02-12 14:05:23 - LoggingInterceptor: Exiting method:
                                    BmtTransactionBean.processManualTransfer (Execution Time: 1200ms)</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>