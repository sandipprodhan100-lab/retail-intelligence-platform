# Azure Data Factory README

This folder will hold ADF deployment artifacts.

## MVP Pipelines

- `PL_RETAIL_EXTRACT_PRODUCT`
- `PL_RETAIL_EXTRACT_CUSTOMER`
- `PL_RETAIL_EXTRACT_STOCK`
- `PL_RETAIL_EXTRACT_ORDER_HEADER`
- `PL_RETAIL_EXTRACT_ORDER_LINE`

## MVP Load Strategy

Start with full load from PostgreSQL to ADLS Gen2.

Later, add incremental load using `updated_at`.

## Target ADLS Folder Structure

```text
/retail/raw/product/load_date=YYYY-MM-DD/
/retail/raw/customer/load_date=YYYY-MM-DD/
/retail/raw/stock/load_date=YYYY-MM-DD/
/retail/raw/order_header/load_date=YYYY-MM-DD/
/retail/raw/order_line/load_date=YYYY-MM-DD/
```

## Validation

1. Trigger each ADF pipeline.
2. Confirm successful run status.
3. Confirm files exist in ADLS Gen2.
4. Confirm file row counts match PostgreSQL table counts.
