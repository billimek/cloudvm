variable "project" {
  type        = string
  description = "The name of your google-cloud project, e.g. 'free-micro-123456'"
}

variable "credentials" {
  type        = string
  description = "The location of a google cloud credentials json file, e.g. '~/.config/gcloud/legacy_credentials/me@domain.com/adc.json'"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}
