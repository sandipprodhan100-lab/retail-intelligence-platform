# Fabric and Power BI README

This section documents the manual MVP setup for Fabric and Power BI.

## MVP Fabric Objects

- Retail Fabric Workspace
- Retail Lakehouse
- Bronze tables over ADLS Gen2 data
- Semantic model
- Power BI report

## Bronze Tables

- `bronze_product`
- `bronze_customer`
- `bronze_stock`
- `bronze_order_header`
- `bronze_order_line`

## Power BI Report Pages

- Sales Overview
- Product Performance
- Customer Orders
- Stock Availability
- Payment Status
- Refund Monitoring

## Validation

1. Confirm ADLS Gen2 files are visible from Fabric.
2. Create Lakehouse shortcut or ingestion table.
3. Confirm row counts match raw files.
4. Build simple visuals.
5. Refresh report successfully.
