# BigQuery dataset for holding the cleaned data
module "bigquery" {
  source     = "./modules/bigquery"
  dataset_id = "fooddataset"
  tables = [{
    table_id            = "foodtable"
    deletion_protection = false
    schema              = <<EOF
[
  {
    "name": "customer_id",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "date",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "timestamp",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "order_id",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "items",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "amount",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "mode",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "restaurant",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "status",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "ratings",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "feedback",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "new_col",
    "type": "STRING",
    "mode": "NULLABLE"
  }
  
]
EOF
  }]
}

# GCS bucket for holding the raw data
module "gcs" {
  source                      = "./modules/gcs"
  name                        = "rawfooddatabucket"
  location                    = "US"
  versioning                  = true
  contents                    = []
  force_destroy               = true
  uniform_bucket_level_access = true
  cors = [
    {
      max_age_seconds = "3600"
      method          = ["GET", "POST"]
      origin          = ["*"]
      response_header = ["Content-Type"]
    }
  ]
}

# Cloud Composer environment for data processing
module "composer_env" {
  source        = "./modules/composer"
  name          = "test-environment"
  location      = var.location
  image_version = "composer-3-airflow-2"
}