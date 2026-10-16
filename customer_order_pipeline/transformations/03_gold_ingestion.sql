CREATE MATERIALIZED VIEW city_wise_sales_gold AS
SELECT 
    customer_silver.city,
    sum(order_silver.total_amount) as total_sales
FROM order_silver
JOIN customer_silver
ON order_silver.customer_id = customer_silver.customer_id
GROUP BY customer_silver.city
ORDER BY total_sales DESC;