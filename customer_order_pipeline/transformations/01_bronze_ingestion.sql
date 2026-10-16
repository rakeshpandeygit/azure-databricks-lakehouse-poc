CREATE STREAMING TABLE order_bronze AS
select 
    *,
    _metadata.file_path as _file_nm, 
    current_timestamp() as _ingest_ts
from cloud_files('abfss://landing@strakeshdbdeveus001.dfs.core.windows.net/input/order','csv',map('cloudFiles.inferColumnTypes','true'));

CREATE STREAMING TABLE customer_bronze AS
select 
    *,
    _metadata.file_path as _file_nm, 
    current_timestamp() as _ingest_ts
from cloud_files('abfss://landing@strakeshdbdeveus001.dfs.core.windows.net/input/customer','csv',map('cloudFiles.inferColumnTypes','true'));

