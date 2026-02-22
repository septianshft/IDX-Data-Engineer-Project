# 🏦 End-to-End Data Warehouse & ELT Pipeline

## 📌 Project Overview
This project demonstrates the design and implementation of a scalable **Data Warehouse (DWH)** using an **ELT (Extract, Load, Transform)** architecture. The system integrates banking transaction data from multiple heterogeneous sources (SQL Server, CSV, and Excel) into a centralized Star Schema to support daily financial reporting and customer balance analytics.

## 🛠️ Tech Stack
* **Orchestration & Ingestion:** Apache NiFi
* **Database & Warehousing:** Microsoft SQL Server (SSMS)
* **Architecture:** ELT (Extract, Load, Transform)
* **Languages:** SQL (T-SQL)

## 📂 Repository Structure
* `01_DDL_Schema_Setup.sql` : Scripts to initialize the DWH, Staging tables, and Star Schema Dimensions/Facts.
* `02_ELT_Transformation_Logic.sql` : The core transformation logic handling data cleaning, merging, and loading.
* `03_Business_Reporting.sql` : Stored Procedures for generating business insights.
* `source_data/` : Contains the sample datasets (`sample.bak`, `transaction.csv`, `transaction.xlsx`).

## 🚀 Pipeline Architecture
The project follows a robust 3-step ELT process:

1.  **Ingestion (NiFi):**
    * Extracts operational data from a Source Database (`sample.bak`).
    * Ingests raw CSV and Excel files containing transaction logs.
    * Loads raw data directly into **Staging Tables** in the DWH.
2.  **Transformation (SQL):**
    * Cleans and standardizes data (e.g., uppercasing names, joining addresses).
    * Populates **Dimension Tables**: `DimBranch`, `DimAccount`, `DimCustomer`.
    * Merges heterogeneous sources into a central **Fact Table**: `FactTransaction`.
3.  **Reporting:**
    * Exposes Stored Procedures for end-users to query daily performance and live balances.

## 🧠 Key Technical Challenges Solved
This project addresses several real-world data engineering challenges:

### 1. Heterogeneous Date Formats
* **Problem:** The source data used inconsistent date formats. CSV files used `dd/mm/yyyy`, while Excel files used **Unix Timestamps** (milliseconds).
* **Solution:** Implemented SQL transformation logic using `CONVERT(DATE, ..., 103)` for CSV and mathematical conversion (`DATEADD` + timestamp division) for Excel data.

### 2. Data Deduplication & Idempotency
* **Problem:** Running the pipeline multiple times caused duplicate transaction entries in the Fact Table.
* **Solution:** Implemented a **CTE (Common Table Expression)** with `ROW_NUMBER()` ranking to identify and filter out duplicate IDs before insertion, ensuring the pipeline is idempotent.

### 3. Customer Dimension Modeling
* **Problem:** Customer address data was normalized across `Customer`, `City`, and `State` tables.
* **Solution:** Denormalized these tables into a single `DimCustomer` table using `LEFT JOIN` to create a user-friendly dimension for reporting.

## 📊 Reporting Modules
Two Stored Procedures were created to serve business needs:
1.  **`usp_DailyTransaction`**:
    * Input: Start Date, End Date.
    * Output: Aggregated transaction count and total amount per day.
2.  **`usp_BalancePerCustomer`**:
    * Input: Customer Name.
    * Output: Calculates **Current Balance** dynamically by aggregating `Initial Balance` + `Total Deposits` - `Total Withdrawals`.

## 🏃‍♂️ How to Run
1.  Restore the `sample.bak` database to SQL Server.
2.  Execute `01_DDL_Schema_Setup.sql` to create the DWH structure.
3.  Run the Apache NiFi flow to ingest data from CSV, Excel, and Source DB into Staging tables.
4.  Execute `02_ELT_Transformation_Logic.sql` to populate Dimensions and Facts.
5.  Use `EXEC usp_DailyTransaction ...` to view reports.

---
*Created by Septian Rizqi Arifandi*
