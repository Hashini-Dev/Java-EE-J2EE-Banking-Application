<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Transfers | Wealth Bank</title>
            <link rel="stylesheet" href="css/bootstrap.css" />
            <link rel="stylesheet" href="css/style.css" />
        </head>

        <body class="bg-light">

            <header class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="dashboard.jsp">
                        <span style="color: var(--primary);">Wealth</span>Bank
                    </a>
                    <div class="d-flex align-items-center">
                        <a href="dashboard.jsp" class="btn btn-outline-supiri btn-sm rounded-pill">Back to Dashboard</a>
                    </div>
                </div>
            </header>

            <div class="container py-4">
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                        <strong>Success!</strong> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <strong>Transfer Error!</strong> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <!-- Search Bar -->
                <div class="row justify-content-center mb-4">
                    <div class="col-lg-8">
                        <div class="glass-card px-4 py-2 d-flex align-items-center">
                            <svg width="18" height="18" fill="var(--text-muted)" class="me-2" viewBox="0 0 16 16">
                                <path
                                    d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                            </svg>
                            <input type="text" class="form-control border-0 bg-transparent shadow-none"
                                placeholder="Search your templates, beneficiaries">
                        </div>
                    </div>
                </div>

                <!-- Transfer Action Buttons -->
                <div class="row justify-content-center mb-5">
                    <div class="col-lg-10">
                        <div class="transfer-actions-container animate">
                            <a href="javascript:void(0)" class="transfer-action-btn"
                                onclick="showTransferForm('SAME_BANK')">
                                <div class="transfer-icon-circle">
                                    <svg width="32" height="32" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zM5.216 14A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216z" />
                                        <path d="M4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z" />
                                    </svg>
                                </div>
                                <span class="transfer-action-label">WealthBank Transfer</span>
                            </a>
                            <a href="javascript:void(0)" class="transfer-action-btn"
                                onclick="showTransferForm('OTHER_BANK')">
                                <div class="transfer-icon-circle" style="background: var(--secondary);">
                                    <svg width="32" height="32" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
                                        <path
                                            d="M11.354 4.646a.5.5 0 0 0-.708 0L6 9.293 4.354 7.646a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l5-5a.5.5 0 0 0 0-.708z" />
                                    </svg>
                                </div>
                                <span class="transfer-action-label">Other Bank Transfer</span>
                            </a>
                            <a href="javascript:void(0)" class="transfer-action-btn">
                                <div class="transfer-icon-circle" style="background: #6c757d;">
                                    <svg width="32" height="32" fill="currentColor" viewBox="0 0 16 16">
                                        <path
                                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm7.5-6.923c-.67.204-1.335.82-1.887 1.855A7.97 7.97 0 0 0 5.145 4H7.5V1.077zM4.09 4a9.267 9.267 0 0 1 .64-1.539 6.7 6.7 0 0 1 .597-.933A7.025 7.025 0 0 0 2.255 4H4.09zm-.582 3.5c.03-.877.138-1.718.312-2.5H1.674a6.958 6.958 0 0 0-.174 2.5h2.008zM1.4 8c0 .86.06 1.693.174 2.5H3.508c-.174-.782-.282-1.623-.312-2.5H1.4zm1.106 3.5a7.024 7.024 0 0 0 2.835 2.472 6.703 6.703 0 0 1-.597-.933 9.268 9.268 0 0 1-.64-1.539H2.506zM7.5 14.923V12H5.145a7.97 7.97 0 0 0 1.468 1.068c.552 1.035 1.218 1.65 1.887 1.855zM8.5 14.923c.67-.204 1.335-.82 1.887-1.855.435-.267.925-.615 1.468-1.068H8.5v2.923zM10.855 12c.174-.782.282-1.623.312-2.5h2.008a6.957 6.957 0 0 0 .174-2.5h-2.182c.174.782.282 1.623.312 2.5h2.008v.001a6.958 6.958 0 0 1-.174 2.499h-2.008z" />
                                    </svg>
                                </div>
                                <span class="transfer-action-label">International Transfer</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Dynamic Content Area -->
                <div class="row justify-content-center">
                    <div class="col-lg-9 animate delay-1">
                        <!-- History Tabs -->
                        <nav class="nav nav-tabs-supiri">
                            <a class="nav-link active" data-bs-toggle="tab" href="#past">Past Payments</a>
                            <a class="nav-link" data-bs-toggle="tab" href="#upcoming">Upcoming Payments</a>
                            <a class="nav-link" data-bs-toggle="tab" href="#outgoing">Outgoing Fund Transfers</a>
                        </nav>

                        <!-- Tab Content -->
                        <div class="tab-content mt-4">
                            <!-- Past Payments Tab (Incoming Account Credit) -->
                            <div class="tab-pane fade show active" id="past">
                                <c:set var="hasPast" value="false" />
                                
                                <c:forEach var="item" items="${history}">
                                    <c:if test="${item.toAccount.user.id == loggedUser.id && (item.status.status == 'Success' || item.status.status == 'COMPLETED')}">
                                        <c:set var="hasPast" value="true" />
                                        <div class="history-item-card">
                                            <div class="history-item-header">
                                                <div>
                                                    <div class="history-item-title">Incoming Account Credit</div>
                                                    <div class="history-item-status">
                                                        <c:out value="${item.status.status}" default="Completed"/>
                                                    </div>
                                                    <div class="history-item-date">on
                                                        <c:out value="${item.paymentDate}" />
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <div class="history-item-amount text-success">
                                                        + $ <c:out value="${item.amount}" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="history-item-details">
                                                <div>
                                                    <div class="detail-label">To Account :</div>
                                                    <div class="detail-value">
                                                        <c:out value="${item.toAccount.accountNo}" />
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="detail-label">From Account :</div>
                                                    <div class="detail-value">
                                                        <c:out value="${item.fromAccount.accountNo}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                
                                <c:if test="${!hasPast}">
                                    <div class="text-center py-5">
                                        <img src="https://img.icons8.com/plasticine/100/000000/empty-box.png"
                                            alt="Empty">
                                        <p class="text-muted mt-3">No incoming credits found.</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Upcoming Tab (Scheduled Transfers) -->
                            <div class="tab-pane fade" id="upcoming">
                                <c:set var="hasUpcoming" value="false" />
                                <c:forEach var="item" items="${history}">
                                    <c:if test="${item.fromAccount.user.id == loggedUser.id && item.status.status == 'Pending'}">
                                        <c:set var="hasUpcoming" value="true" />
                                        <div class="history-item-card" style="border-left-color: var(--accent);">
                                            <div class="history-item-header">
                                                <div>
                                                    <div class="history-item-title">Scheduled Transfer</div>
                                                    <div class="history-item-status text-warning">
                                                        <c:out value="${item.status.status}" default="Pending"/>
                                                    </div>
                                                    <div class="history-item-date">Execution on
                                                        <c:out value="${item.paymentDate}" />
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <div class="history-item-amount 
                                                    <c:choose>
                                                        <c:when test=" ${item.fromAccount.user.id==loggedUser.id}">
                                                            text-danger</c:when>
                                                            <c:otherwise>text-success</c:otherwise>
                                                            </c:choose>">
                                                        <c:choose>
                                                            <c:when test="${item.fromAccount.user.id == loggedUser.id}">
                                                                -</c:when>
                                                            <c:otherwise>+</c:otherwise>
                                                        </c:choose>    
                                                        $
                                                        <c:out value="${item.amount}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${!hasUpcoming}">
                                    <div class="text-center py-5">
                                        <img src="https://img.icons8.com/plasticine/100/000000/calendar.png"
                                            alt="No Tasks">
                                        <p class="text-muted mt-3">No upcoming payments scheduled.</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Outgoing Tab (Instant Transfers) -->
                            <div class="tab-pane fade" id="outgoing">
                                <c:set var="hasOutgoing" value="false" />
                                <c:forEach var="item" items="${history}">
                                    <c:if test="${item.fromAccount.user.id == loggedUser.id && (item.transferType.type == 'Instant' || item.status.status == 'Success')}">
                                        <c:set var="hasOutgoing" value="true" />
                                        <div class="history-item-card">
                                            <div class="history-item-header">
                                                <div>
                                                    <div class="history-item-title">Instant Outgoing Transfer</div>
                                                    <div class="history-item-status">
                                                        <c:out value="${item.status.status}" default="Success"/>
                                                    </div>
                                                    <div class="history-item-date">Initiated on ${item.paymentDate}
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <div class="history-item-amount text-danger">- $ ${item.amount}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${!hasOutgoing}">
                                    <div class="text-center py-5">
                                        <p class="text-muted">No active instant outgoing transfers.</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal for Transfer Form -->
            <div class="modal fade" id="transferModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 glass-card">
                        <div class="modal-header border-0 pb-0">
                            <h5 class="modal-title fw-bold" id="modalTitle">Transfer Funds</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4">
                            <form action="transfer" method="POST">
                                <input type="hidden" id="transferType" name="transferType" value="SAME_BANK">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">FROM ACCOUNT</label>
                                        <select class="form-select bg-light border-0 p-3" name="fromAccount" required>
                                            <c:forEach var="acc" items="${userAccounts}">
                                                <option value="${acc.accountNo}">${acc.accountType.type} Account
                                                    (${acc.accountNo}) - Rs. ${acc.balance}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">BENEFICIARY ACCOUNT NO</label>
                                        <input type="text" class="form-control bg-light border-0 p-3"
                                            placeholder="Enter Account Number" name="toAccount" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">AMOUNT (Rs.)</label>
                                        <input type="number"
                                            class="form-control bg-light border-0 p-3 text-primary fw-bold"
                                            placeholder="0.00" name="amount" step="0.01" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small">SCHEDULE TRANSACTION?</label>
                                        <select class="form-select bg-light border-0 p-3" id="execType" name="type">
                                            <option value="INSTANT">Instant (Now)</option>
                                            <option value="SCHEDULED">Schedule for Later</option>
                                        </select>
                                    </div>
                                    <div id="dateDiv" class="col-12 d-none">
                                        <label class="form-label fw-bold small">EXECUTION DATE</label>
                                        <input type="date" class="form-control bg-light border-0 p-3"
                                            name="paymentDate">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold small">DESCRIPTION</label>
                                        <textarea class="form-control bg-light border-0 p-3" rows="2" name="description"
                                            placeholder="Reference note..."></textarea>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn btn-supiri w-100 py-3">Confirm
                                            Transaction</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                const transferModal = new bootstrap.Modal(document.getElementById('transferModal'));

                function showTransferForm(type) {
                    const title = document.getElementById('modalTitle');
                    const typeInput = document.getElementById('transferType');

                    if (type === 'SAME_BANK') {
                        title.innerText = 'WealthBank Transfer';
                        typeInput.value = 'SAME_BANK';
                    } else {
                        title.innerText = 'Other Bank Transfer';
                        typeInput.value = 'OTHER_BANK';
                    }

                    transferModal.show();
                }

                document.getElementById('execType').addEventListener('change', function () {
                    const dateDiv = document.getElementById('dateDiv');
                    if (this.value === 'SCHEDULED') {
                        dateDiv.classList.remove('d-none');
                    } else {
                        dateDiv.classList.add('d-none');
                    }
                });
            </script>
        </body>

        </html>