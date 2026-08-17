-- ===============================
-- Monthly Revenue & Order Growth
-- ===============================

SELECT FORMAT_DATE("%Y-%m", DATE(InvoiceDate)) AS Month,
       ROUND(SUM(TotalAmount), 2) AS MonthlyRevenue,
       COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM `retail_dataset.online_retail`
GROUP BY FORMAT_DATE("%Y-%m", DATE(InvoiceDate))
ORDER BY Month ASC;

-- ==============================
-- Customer Lifetime Value (CLV)
-- ==============================

SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS OrderFrequency,
       ROUND(SUM(TotalAmount), 2) AS LifetimeValue,
       ROUND(AVG(TotalAmount), 2) AS AverageOrderValue
FROM `retail_dataset.online_retail`
GROUP BY CustomerID
ORDER BY LifetimeValue DESC
LIMIT 10;

-- =====================
-- Repeat Customer Rate
-- =====================

WITH CustomerOrders AS(
  SELECT CustomerID,
         COUNT(DISTINCT InvoiceNo) AS OrderCount
  FROM retail_dataset.online_retail
  GROUP BY CustomerID
)
SELECT COUNTIF(OrderCount > 1) AS RepeatCustomers,
       COUNT(CustomerID) AS TotalCustomers,
       ROUND(COUNTIF(OrderCount > 1) * 100 / COUNT(CustomerID), 2) AS RepeatRatePercentage
FROM CustomerOrders;