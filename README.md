# Furniture E-Commerce Sales Analytics - SQL Project

## 📈Overview
This project demonstrates advanced SQL Server capabilities through comprehensive analysis of furniture e-commerce sales data, focusing on business intelligence insights critical for data-driven decision-making in the furniture retail industry.

## ✎Business Context
Analyzed multi-dimensional furniture sales data across office supplies, technology, and furniture categories, examining customer segments, employee performance, and geographic distribution to uncover actionable insights for revenue optimization and inventory management in the furniture retail sector.

## 🎯Key Analytics Delivered

| Query | Analysis | Business Question |
|-------|----------|-------------------|
| **Query 1** | **Quarterly Sales Trends** | How do furniture sales perform across seasons? |
| **Query 2** | **Discount Strategy Impact** | Which discount levels maximize profitability? |
| **Query 3** | **Customer Segment Performance** | What product categories drive profit by segment? |
| **Query 4** | **Employee Performance Breakdown** | How does each sales rep contribute by category? |
| **Query 5** | **Profitability Ratio Calculator** | What's the profit-to-sales ratio by employee & category? | 
| **Query 6** | **Automated Sales Reports** | What are employee sales within specific periods? |
| **Query 7** | **Geographic Profit Analysis** | How do quarterly profits compare across states? | 

### Sample Insights

**Discount Level Performance** *(Query 2 Results)*
```
Category     | Discount Level  | Total Orders | Total Profit
-------------|-----------------|--------------|-------------
Furniture    | No Discount     | 1,456        | $89,345.67
Furniture    | Low Discount    | 2,103        | $76,234.12
Furniture    | Medium Discount | 567          | $12,456.89
Technology   | No Discount     | 1,892        | $134,567.23
```

**Top Categories by Customer Segment** *(Query 3 Results)*
```
Segment     | Category        | Sales Rank | Profit Rank
------------|-----------------|------------|------------
Consumer    | Technology      | 1          | 1
Consumer    | Office Supplies | 2          | 2
Corporate   | Technology      | 1          | 1
Corporate   | Furniture       | 2          | 2
```

## ✨Technical Skills Demonstrated
- **Complex Joins**: Multi-table integration across Orders, Products, Customers, and Employees
- **Window Functions**: ROW_NUMBER() for ranking and performance segmentation
- **CTEs**: Modular query design for maintainability
- **User-Defined Functions**: Custom business logic implementation
- **Stored Procedures**: Parameterized reporting automation
- **Dynamic SQL**: Flexible pivot table generation with STRING_AGG()
- **Data Type Management**: Precise decimal casting for financial accuracy

## ·❆· Database Schema
- **ORDERS**: Transaction-level sales data (Order ID, Date, Sales, Profit, Discount)
- **PRODUCT**: Product details (ID, Name, Category)
- **CUSTOMER**: Customer information (ID, Segment, State)
- **EMPLOYEES**: Sales representative data (ID, Name)

## ➥ Business Impact
This analytical framework enables furniture retail stakeholders to make informed decisions on promotional discount strategies, product category mix optimization, regional market performance, and sales team incentives—directly supporting revenue growth and operational efficiency in the competitive furniture e-commerce market.

## 💫 Tools Used
- SQL Server
- T-SQL (CTEs, Window Functions, Dynamic SQL)
- Data aggregation and statistical analysis

<br>

*This project showcases the ability to transform raw furniture sales transaction data into strategic business intelligence using advanced SQL techniques.*
