# Databricks notebook source
# /// script
# [tool.databricks.environment]
# environment_version = "6"
# ///
# MAGIC %sql
# MAGIC use catalog training_dev;
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from default.city_wise_sales_gold;

# COMMAND ----------

# MAGIC %sql
# MAGIC describe extended default.city_wise_sales_gold;

# COMMAND ----------

