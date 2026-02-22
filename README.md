# 🏗️ End-to-End Data Warehouse & ELT Pipeline

## 📌 Project Overview
This project demonstrates the design and implementation of an end-to-end Data Warehouse (DWH) using an **ELT (Extract, Load, Transform)** architecture. The goal is to integrate banking transaction data from multiple heterogeneous sources (SQL Server Database, CSV, and Excel) into a centralized Data Warehouse with a Star Schema design to support daily reporting and customer balance analytics.

## 🛠️ Tech Stack
* **Database:** Microsoft SQL Server (SSMS)
* **Data Integration / Pipeline:** Apache NiFi
* **Languages:** SQL
* **Data Sources:** Relational Database (`.bak`), CSV, Excel

## 📂 Repository Structure
* `sample.bak` : The source operational database backup.
* `transaction_csv.csv` : Raw transaction data from an external branch.
* `transaction_excel.xlsx` : Raw transaction data containing Unix timestamp formats.
* `1_DDL_DWH_Schema.sql` : Scripts to create Staging, Dimension, and Fact tables.
* `2_ELT_Stored_Procedure.sql` : The core transformation logic to populate the DWH.
* `3_Reporting_Analytics.sql` : Stored Procedures for business reporting.

## 🚀 Pipeline Architecture (ELT)
The project follows a 3-step ELT process:

1. **Extract:** * Restored the operational `sample` database.
   * Configured **Apache NiFi** to extract data from the source database, CSV file, and Excel file.
2. **Load:** * NiFi loads the raw, unprocessed data directly into `Staging_...` tables within the `DWH` database using `ExecuteSQL` and `PutDatabaseRecord` processors.
3. **Transform (In-Database):** * Created a Stored Procedure (`sp_PopulateDWH`) to clean, transform, and merge the staging data into standard **Dimension** (`DimBranch`, `DimAccount`, `DimCustomer`) and **Fact** (`FactTransaction`) tables.

## 🧠 Key Challenges Solved
During the transformation phase, several data quality issues were addressed:
* **Heterogeneous Date Formats:** Handled date conversion from standard `dd/mm/yyyy` (CSV) and converted **Unix Timestamps** (Excel) into standard human-readable SQL `DATE` formats using mathematical manipulation (`DATEADD`).
* **Data Deduplication:** Implemented idempotency using `ROW_NUMBER() OVER(PARTITION BY...)` and `CTE` to prevent Primary Key violations and duplicate transaction entries when the pipeline runs multiple times.
* **Data Standardization:** Applied `UPPER()` functions and consolidated customer address dimensions (joining Customer, City, and State).

## 📊 Reporting & Analytics
Created Stored Procedures to answer specific business requirements:
1. **`usp_DailyTransaction`**: Generates a summary of total transactions and amounts within a specific date range.
2. **`usp_BalancePerCustomer`**: Calculates the real-time active balance for a specific customer by dynamically aggregating historical deposits and withdrawals against their initial balance.

## 🏃‍♂️ How to Run
1. Restore `sample.bak` in SQL Server.
2. Create an empty database named `DWH`.
3. Run `1_DDL_DWH_Schema.sql` to build the table structures.
4. Setup Apache NiFi flows to route the CSV, Excel, and Source DB data into the Staging tables.
5. Execute `sp_PopulateDWH` to transform the data.
6. Execute the reporting stored procedures to view results.
