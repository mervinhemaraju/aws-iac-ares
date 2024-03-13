# # Create a parameter store for item categories
# # for website Jeeyah
# resource "aws_ssm_parameter" "ssm_parameter_jeeyah_items_categories" {
#   name        = "jeeyah_items_categories"
#   type        = "StringList"
#   description = "A list of categories for the bucket items for website Jeeyah"
#   value       = join(",", local.constants.ssm.jeeyah_website.bucket_list_categories)
# }
