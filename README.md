# 🏦 End-to-End Data Warehouse Project (Banking Case Study)

## 📌 Project Overview
This project demonstrates the end-to-end implementation of a Data Warehouse (DWH) for a banking institution. It integrates data from heterogeneous sources (SQL Server, CSV, and Excel) into a centralized repository using **SSMS (SQL Server Management Studio)** and **Apache NiFi**.

The project focuses on building an **ELT (Extract, Load, Transform)** pipeline to support daily transaction reporting and customer balance analytics.

## 🛠️ Tech Stack
* **Database:** Microsoft SQL Server (2019/2022)
* **ETL Tool:** Apache NiFi
* **Language:** T-SQL
* **Architecture:** Star Schema (Fact & Dimensions)

## 📂 Repository Structure
This repository contains the individual SQL scripts used for each stage of the pipeline:

### 1. Setup & DDL (Data Definition Layer)
* `Initializing Table & Database Querry.sql` : Creates the `DWH` database and the structure for Final Tables (Dimensions & Fact).
* `Transferring sample to DWH using NIFI (staging query).sql` : Creates Staging tables for database-sourced data.
* `Initialize staging table for csv and excel.sql` : Creates Staging tables for CSV and Excel files.

### 2. Transformation Logic (ELT)
* `Filling out DimBranch.sql` : Populates the Branch dimension.
* `Filling out DimAccount.sql` : Populates the Account dimension.
* `Filling out DimCustomer.sql` : Populates the Customer dimension (with data cleaning & denormalization).
* `Filling out FactTransaction.sql` : **[CORE LOGIC]** Merges data from CSV, Excel, and DB, handles Unix Timestamp conversion, and removes duplicates.

### 3. Reporting & Analytics
* `Stored Procedure DialyTransaction.sql` : Generates daily transaction reports.
* `Stored Procedure BalancePerCustomer.sql` : Calculates dynamic customer balances.

### 4. Source Data
* `sample.bak` : Operational Database Backup.
* `transaction_csv.csv` : Raw transaction logs (CSV).
* `transaction_excel.xlsx` : Raw transaction logs (Excel).

---

## 🚀 How to Run (Step-by-Step)

To replicate this project, execute the SQL files in the following strict order to ensure dependencies are met:

### Step 1: Database Initialization
1. Restore `sample.bak` to your SQL Server.
2. Execute **`Initializing Table & Database Querry.sql`** to create the target DWH and main tables.

### Step 2: Staging Area Setup
1. Execute **`Transferring sample to DWH using NIFI (staging query).sql`**.
2. Execute **`Initialize staging table for csv and excel.sql`**.

### Step 3: Data Ingestion (NiFi)
* Run the Apache NiFi flow to ingest data from the Source DB, CSV, and Excel into the newly created `Staging_...` tables.
* *(Ensure Staging tables are populated before proceeding).*

### Step 4: Data Transformation (Populate DWH)
Run the dimension scripts first, then the fact table:
1. `Filling out DimBranch.sql`
2. `Filling out DimCustomer.sql`
3. `Filling out DimAccount.sql`
4. `Filling out FactTransaction.sql`

### Step 5: Reporting
Create the stored procedures for analysis:
1. Run `Stored Procedure DialyTransaction.sql`.
2. Run `Stored Procedure BalancePerCustomer.sql`.

---

## 🧠 Key Challenges & Solutions

### 1. Handling Heterogeneous Date Formats
* **Problem:** The source data contained mixed date formats. CSV files used `dd/mm/yyyy`, while Excel files used **Unix Timestamps** (milliseconds).
* **Solution:** The `Filling out FactTransaction.sql` script includes logic to:
    * Convert text dates using `CONVERT(DATE, ..., 103)`.
    * Transform Unix timestamps using `DATEADD(SECOND, ...)` logic.

### 2. Eliminating Data Duplication
* **Problem:** Repeated pipeline runs could introduce duplicate transaction records.
* **Solution:** Implemented **Idempotency** in the transformation logic using `WHERE NOT IN` subqueries (or `ROW_NUMBER()` ranking) to ensure only unique records enter the Fact Table.

## 📊 Sample Output
Example of running the reporting Stored Procedures:

```sql
-- Check Daily Transactions
EXEC dbo.usp_DailyTransaction '2024-01-01', '2024-01-31';

-- Check Customer Balance
EXEC dbo.usp_BalancePerCustomer 'Shelly Juwita';
```
---
*Created by Septian Rizqi Arifandi*
