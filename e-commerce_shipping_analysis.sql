--creating table
DROP TABLE IF EXISTS shipping_data;
CREATE TABLE shipping_data (
    id INT PRIMARY KEY,
    warehouse_block VARCHAR(10),
    mode_of_shipment VARCHAR(20),
    customer_care_calls INT,
    customer_rating INT,
    cost_of_the_product INT,
    prior_purchases INT,
    product_importance VARCHAR(20),
    gender CHAR(1),
    discount_offered INT,
    weight_in_gms INT,
    reached_on_time_y_n INT
);

SELECT *
FROM shipping_data
LIMIT 10;

SELECT COUNT(*)
FROM shipping_data;

---Warehouse Performance
SELECT
    warehouse_block,
    COUNT(*) AS total_orders,
    ROUND(AVG(cost_of_the_product),2) AS avg_product_cost,
    ROUND(AVG(discount_offered),2) AS avg_discount,
    ROUND(AVG(customer_rating),2) AS avg_rating,
    SUM(CASE WHEN reached_on_time_y_n = 1 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(
        SUM(CASE WHEN reached_on_time_y_n = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS late_percentage
FROM shipping_data
GROUP BY warehouse_block
ORDER BY late_percentage DESC;

--Rank Warehouses by Customer Satisfaction
SELECT
    warehouse_block,
    ROUND(AVG(customer_rating),2) AS avg_rating,
    DENSE_RANK() OVER(
        ORDER BY AVG(customer_rating) DESC
    ) AS satisfaction_rank
FROM shipping_data
GROUP BY warehouse_block;

-- Customer Segmentation using CASE
SELECT
    CASE
        WHEN prior_purchases >= 8 THEN 'Loyal'
        WHEN prior_purchases BETWEEN 4 AND 7 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(customer_rating),2) AS avg_rating,
    ROUND(AVG(cost_of_the_product),2) AS avg_spending
FROM shipping_data
GROUP BY customer_segment;

--Discount Effect on Late Deliveries
SELECT
    CASE
        WHEN discount_offered < 10 THEN 'Low Discount'
        WHEN discount_offered BETWEEN 10 AND 20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_group,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN reached_on_time_y_n = 1 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(
        AVG(customer_rating),2
    ) AS avg_rating
FROM shipping_data
GROUP BY discount_group;

--Running Total of Orders by Warehouse
SELECT
    warehouse_block,
    COUNT(*) AS orders,
    SUM(COUNT(*)) OVER(
        ORDER BY warehouse_block
    ) AS running_total
FROM shipping_data
GROUP BY warehouse_block;

--Most Expensive Products within each Warehouse
SELECT *
FROM
(
SELECT
    warehouse_block,
    id,
    cost_of_the_product,
    ROW_NUMBER() OVER(
        PARTITION BY warehouse_block
        ORDER BY cost_of_the_product DESC
    ) AS rn
FROM shipping_data
)t
WHERE rn<=3;

--Compare Shipment Modes
SELECT
    mode_of_shipment,
    COUNT(*) total_orders,
    ROUND(AVG(customer_rating),2) avg_rating,
    ROUND(AVG(discount_offered),2) avg_discount,
    ROUND(AVG(weight_in_gms),2) avg_weight,
    ROUND(AVG(cost_of_the_product),2) avg_cost
FROM shipping_data
GROUP BY mode_of_shipment;

--CTE - Warehouse Efficiency
WITH warehouse_stats AS
(
SELECT
warehouse_block,
COUNT(*) total_orders,
SUM(CASE WHEN reached_on_time_y_n=0 THEN 1 ELSE 0 END) on_time
FROM shipping_data
GROUP BY warehouse_block
)

SELECT *,
ROUND(on_time*100.0/total_orders,2) AS on_time_percentage
FROM warehouse_stats
ORDER BY on_time_percentage DESC;

--Top 10 Highest Revenue Potential Orders
SELECT
id,
warehouse_block,
cost_of_the_product,
discount_offered,
(cost_of_the_product-discount_offered) AS estimated_revenue
FROM shipping_data
ORDER BY estimated_revenue DESC
LIMIT 10;

--Average Product Cost vs Product Importance
SELECT
product_importance,
ROUND(AVG(cost_of_the_product),2) avg_cost,
ROUND(AVG(weight_in_gms),2) avg_weight
FROM shipping_data
GROUP BY product_importance;

-- Above Average Discount Orders
SELECT
id,
discount_offered,
cost_of_the_product
FROM shipping_data
WHERE discount_offered>
(
SELECT AVG(discount_offered)
FROM shipping_data
)
ORDER BY discount_offered DESC;

--Customer Rating Distribution using NTILE
SELECT
id,
customer_rating,
NTILE(4) OVER(
ORDER BY customer_rating DESC
) AS rating_quartile
FROM shipping_data;

--Warehouse Share of Total Orders
SELECT
warehouse_block,
COUNT(*) total_orders,
ROUND(
COUNT(*)*100.0/
SUM(COUNT(*)) OVER(),2
) AS market_share
FROM shipping_data
GROUP BY warehouse_block;

-- Average Customer Care Calls for Late vs On-Time Orders
SELECT
CASE
WHEN reached_on_time_y_n=1
THEN 'Late'
ELSE 'On Time'
END delivery_status,
ROUND(AVG(customer_care_calls),2) avg_calls,
ROUND(AVG(customer_rating),2) avg_rating
FROM shipping_data
GROUP BY delivery_status;

--Top Performing Warehouse Based on On-Time Delivery (CTE + Window Function)
WITH warehouse_performance AS (
    SELECT
        warehouse_block,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN reached_on_time_y_n = 0 THEN 1 ELSE 0 END) AS on_time_orders,
        ROUND(
            SUM(CASE WHEN reached_on_time_y_n = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS on_time_percentage
    FROM shipping_data
    GROUP BY warehouse_block
)
SELECT *,
       RANK() OVER (ORDER BY on_time_percentage DESC) AS performance_rank
FROM warehouse_performance;


