resource "aws_dynamodb_table" "jeeyah_bucket_list" {
  name         = "jeeyah-bucket-list"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "item_id"

  attribute {
    name = "item_id"
    type = "S"
  }

  attribute {
    name = "item_name"
    type = "S"
  }

  attribute {
    name = "item_category"
    type = "S"
  }

  attribute {
    name = "item_status"
    type = "S"
  }

  global_secondary_index {
    name            = "item_name_index"
    hash_key        = "item_name"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "item_status_index"
    hash_key        = "item_status"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "item_category_index"
    hash_key        = "item_category"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "mo_bizin_travay" {
  name         = "mo-bizin-travay"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "title"
    type = "S"
  }

  attribute {
    name = "posted_date"
    type = "S"
  }

  attribute {
    name = "recruiter"
    type = "S"
  }

  attribute {
    name = "link"
    type = "S"
  }

  attribute {
    name = "updated_at"
    type = "S"
  }

  global_secondary_index {
    name            = "recruiter_index"
    hash_key        = "recruiter"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "updated_at_index"
    hash_key        = "updated_at"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "posted_date_index"
    hash_key        = "posted_date"
    projection_type = "ALL"
  }
}


