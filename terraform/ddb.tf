module "ddb" {
  source         = "PreetChauhan111/ddb/pc"
  version        = "1.1.0"
  name           = local.table_name
  tags           = local.table_tags
  hash_key       = "id"
  read_capacity  = 5
  write_capacity = 5
  billing_mode   = "PROVISIONED"
  table_class    = "STANDARD"
  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]
}