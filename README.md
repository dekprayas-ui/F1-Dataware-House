Hi there! 👋 My name is **Dimple**. I built this project to get hands-on experience with SQL and to understand how real-world data engineering actually works. I wanted to move past basic tutorials and tackle a complex, real-world dataset, and as an F1 fan, this was the perfect challenge!

This repository tracks my journey building an end-to-end data pipeline to ingest, clean, and analyze historical and modern Formula 1 racing data using **Microsoft SQL Server**. 

To keep things organized, I’m implementing the **Medallion Architecture** (Bronze ➡️ Silver ➡️ Gold) to systematically transform raw data into high-value insights.

---

## 🏗️ The Pipeline & Project Status

This repository is my central workspace and "source of truth" for all database schemas, scripts, and transformation logic. 

[Raw F1 Data] ➡️ [🟫 Bronze Layer] ➡️ [🥈 Silver Layer] ➡️ [🥇 Gold Layer] ➡️ [📊 Tableau]


### 🟫 Bronze Layer (Raw Ingestion)
* **Status:** Drafted & Saved Here
* **The Reality:** I ran into some technical hiccups when trying to deploy the DDL scripts directly to my live server. Instead of letting that stop me, I've safely version-controlled and documented all the raw table definitions right here. This ensures the raw structure is tracked and completely reproducible whenever I need to spin it up again.

### 🥈 Silver Layer (Cleaned & Conformed)
* **Status:** Completed / Active Development
* **The Process:** This is where the heavy lifting happens. Written entirely in **T-SQL (MS SQL Server)**, this layer cleans up the messy raw data. I'm focusing on deduplication, handling missing values, establishing proper primary/foreign keys, and joining core entities like `drivers`, `constructors`, `races`, and `results`.

### 🥇 Gold Layer (Analytics & Reporting)
* **Status:** *Under Development 🚀*
* **The Vision:** This will be my final analytical layer. I'll be creating aggregated star-schema data marts specifically optimized for reporting. 

---

## 🗺️ What's Next? (The Roadmap)

* **🎨 Mastering Tableau:** Right now, I am diving deep into Tableau to master advanced data visualization and dashboard design. 
* **📈 Bringing the Gold Layer to Life:** As soon as I've got a solid handle on Tableau, I'm going to build out the Gold layer views in SQL Server. From there, I'll connect them to Tableau to build interactive dashboards visualizing driver career trajectories, team performance over time, and race strategies.

---

## 🛠️ Tech Stack

* **Database Engine:** Microsoft SQL Server (T-SQL)
* **Data Architecture:** Medallion Architecture
* **Languages:** SQL, Python
* **Version Control:** Git & GitHub
* **Data Visualization:** Tableau *(Coming Soon!)*

---

## 📂 Inside the Repo

* `/bronze/`: DDL scripts and table structures for the raw data setup.
* `/silver/`: T-SQL transformation scripts for data cleaning and relationships.
* `/stored_procedures/`: Automation scripts and loading logic.

---
