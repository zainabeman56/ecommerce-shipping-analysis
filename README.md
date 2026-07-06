📦 E-Commerce Shipping Performance Analysis
📌 Project Overview

This project analyzes an E-Commerce Shipping dataset using PostgreSQL (pgAdmin) for SQL analysis and Python (Jupyter Notebook) for data exploration and visualization.
The objective is to understand shipping performance, customer behavior, warehouse efficiency, delivery delays, discounts, customer segmentation, and other business insights through SQL queries and Python visualizations.

The project demonstrates how SQL and Python can work together in a real-world data analytics workflow.

🎯 Objectives
Analyze shipping performance across warehouses
Evaluate delivery delays
Study customer purchasing behavior
Compare shipment modes
Analyze discount impact on deliveries
Rank warehouse performance
Segment customers based on purchase history
Generate business insights using SQL and Python
🛠️ Tools & Technologies
Tool	Purpose
PostgreSQL (pgAdmin 4)	Database Management
SQL	Data Analysis
Python	Data Processing
Jupyter Notebook	Analysis & Visualization
Pandas	Data Manipulation
NumPy	Numerical Operations
Matplotlib	Data Visualization
Seaborn	Statistical Visualization
SQLAlchemy	PostgreSQL Connection
📂 Dataset

The dataset contains information about e-commerce shipping orders including:

Warehouse Block
Shipment Mode
Customer Care Calls
Customer Rating
Product Cost
Prior Purchases
Product Importance
Gender
Discount Offered
Product Weight
Delivery Status

Dataset Size

Rows: 10,999
Columns: 12

The dataset contains:

No missing values
No duplicate records

This allowed the analysis to focus directly on business insights.

📊 SQL Analysis Performed

The project includes advanced SQL queries covering:

Warehouse Performance Analysis
Customer Satisfaction Ranking
Customer Segmentation
Discount Impact Analysis
Shipment Mode Comparison
Warehouse Efficiency Ranking
Top Revenue Orders
Product Importance Analysis
Customer Rating Quartiles
Warehouse Market Share
Customer Care Call Analysis
Window Functions
Common Table Expressions (CTEs)
Aggregate Functions
Ranking Functions
Conditional Logic
CASE Statements
📈 Python Analysis

Python was used for:

Connecting PostgreSQL database
Reading SQL query results
Data validation
Statistical summaries
Feature engineering
Visualization

Libraries used:

Pandas
NumPy
Matplotlib
Seaborn
SQLAlchemy
📉 Visualizations

The project includes multiple business-oriented visualizations:

Warehouse Performance
Customer Segmentation
Discount Effect
Shipment Mode Comparison
Warehouse Efficiency Ranking
Top Revenue Orders
Product Importance Analysis
Warehouse Market Share
Product Weight vs Late Delivery
Customer Rating Quartiles
Customer Care Calls Analysis
Correlation Heatmap
🔍 Key Insights

Some important findings include:

Warehouse performance varies in terms of late deliveries and customer ratings.
Customer segmentation highlights purchasing behavior among new, regular, and loyal customers.
Higher discounts are associated with significantly higher late delivery rates.
Shipment modes differ in average cost, weight, and customer ratings.
Product weight influences delivery performance.
Customer ratings alone do not fully explain delivery delays.
Warehouse efficiency rankings help identify operational performance differences.

▶️ How to Run This Project
1. Clone the repository
git clone https://github.com/yourusername/e-commerce-shipping-analysis.git
2. Install required libraries
pip install -r requirements.txt
3. Import the dataset into PostgreSQL

Create the database and import the CSV dataset into PostgreSQL using pgAdmin.

4. Run SQL queries

Execute the SQL file inside PostgreSQL.

5. Open Jupyter Notebook

Run the notebook to reproduce the analysis and visualizations.

📚 Skills Demonstrated
SQL
PostgreSQL
Data Cleaning
Data Exploration
Business Analysis
Data Visualization
Python
Pandas
NumPy
Matplotlib
Seaborn
SQLAlchemy
Analytical Thinking
