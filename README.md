# WealthBank - Enterprise Banking System

![Java](https://img.shields.io/badge/Java-EE-blue?style=for-the-badge&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-8.0-orange?style=for-the-badge&logo=eclipse)
![GlassFish](https://img.shields.io/badge/GlassFish-6.0+-green?style=for-the-badge&logo=glassfish)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=for-the-badge&logo=bootstrap)

WealthBank is a robust, highly-secure enterprise banking application built using the Jakarta EE platform. It is designed to handle time-sensitive banking operations, strict transaction management, and role-based access control (RBAC).

## 🚀 Features

### Core Banking Operations
* **Multi-Account Management:** Users can hold multiple account types (Savings, Checking, Loan).
* **Fund Transfers:** Supports instant transfers between internal accounts.
* **Transaction History:** Detailed event logging and receipt generation for every financial transaction.
* **Interactive Dashboards:** Distinct, secure dashboard views for Customers and Administrators.

### Enterprise Features (EJB)
* **Automated Time Services (`@Schedule`):** Utilizes EJB Timer Services to execute automated tasks at precise intervals, such as midnight interest calculations and scheduled fund sweeps.
* **Transaction Demarcation (`@TransactionAttribute`):** Implements strong Container-Managed Transactions (CMT) to ensure absolute atomicity during transfers (either all operations succeed, or everything rolls back). Includes failbacks for programmatic UserTransactions (BMT).
* **Security Architecture (`@RolesAllowed`):** Strict, declarative role-based access control ensuring customers only see their own accounts and only administrators can access the back-office management portals.
* **Custom Application Exceptions (`@ApplicationException`):** Advanced error handling that automatically rolls back active transactions if business logic violations occur (e.g., `InsufficientBalanceException`, `DuplicateUserException`).
* **Interceptors (`@Interceptors`):** Global logging and cross-cutting concern management attached directly to sensitive EJB methods.

## 🛠️ Technology Stack

* **Backend Framework:** Java EE / Jakarta EE (EJB, CDI, JPA)
* **Database Framework:** Hibernate ORM
* **Web Tier:** Jakarta Servlets & JavaServer Pages (JSP)
* **Frontend:** HTML5, CSS3, Bootstrap 5.3 (Glass-morphism UI)
* **Database:** MySQL 8.0
* **Build Tool:** Maven
* **Application Server:** GlassFish / Payara

## ⚙️ Prerequisites

To build and run this application, you will need:
1. **Java Development Kit (JDK) 11+**
2. **Maven 3.8+**
3. **GlassFish Application Server** (or a certified Jakarta EE compatible server like WildFly/Payara)
4. **MySQL Database Server**

## 🔧 Installation & Setup

### 1. Database Configuration
1. Start your MySQL Server.
2. Create a database for the application.
3. Configure your Application Server to have a JDBC Connection Pool and Resource pointing to your MySQL database.
   * **JNDI Name:** `jdbc_banking_system` (or update `persistence.xml` to match your own JNDI resource).

### 2. Build the Project
Clone the repository and build the project using Maven:

```bash
git clone https://github.com/your-username/banking-system.git
cd banking-system
mvn clean package
```

### 3. Deploy
1. Locate the generated `.war` or `.ear` file in the `target/` directory.
2. Deploy the application archive to your configured GlassFish server.
3. Upon first deployment, Hibernate will automatically generate the required database tables (`hibernate.hbm2ddl.auto=update`).

***

*Developed by Lokuganhewage Hashini Dulanjali for Advanced Enterprise UI/UX and Backend Development Requirements.*
