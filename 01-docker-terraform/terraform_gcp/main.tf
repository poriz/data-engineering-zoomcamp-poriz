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
    project = "<Your Project ID>" 
    region  = "asia-northeast3" 
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "<Your Unique Bucket Name>"
  location      = "ASIA"
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