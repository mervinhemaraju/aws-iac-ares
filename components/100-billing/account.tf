# Primary Contact
resource "aws_account_primary_contact" "this" {
  full_name          = "Mervin Hemaraju"
  address_line_1     = "30, Residence Jules Koening"
  city               = "Beau Bassin"
  company_name       = "Plagueworks"
  country_code       = "MU"
  district_or_county = "Plaines Wilhems"
  phone_number       = "+23058001196"
  postal_code        = "71519"
  website_url        = "https://mervinhemaraju.com"
}

# Alternate contact
resource "aws_account_alternate_contact" "this" {

  alternate_contact_type = "BILLING"

  name          = "Mervin Hemaraju"
  title         = "Mr."
  email_address = "mervin-hemaraju16@hotmail.com"
  phone_number  = "+23058001196"
}
