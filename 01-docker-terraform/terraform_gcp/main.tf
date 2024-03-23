terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "google" {
  # gcloud auth application-default login
  # project = "<Your Project ID>" 
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "data-lake-bucket" {
  # name          = "<Your Unique Bucket Name>"
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}
resource "google_bigquery_dataset" "demo-dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}