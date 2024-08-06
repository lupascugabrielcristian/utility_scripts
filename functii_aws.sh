# Show entriy of MTGProxyShop table, filtered by RequestTime column containing "2024-08-04"
aws dynamodb scan --table-name MTGProxyShop --filter-expression  "contains(RequestTime, :keyword)" --expression-attribute-values '{":keyword":{"S":"2024-08-04"}}' | jq '.Items[] | {F: .From.S, N: .Name.S, T: .RequestTime.S}'

# Scan table ArtMedicaContactForm
aws dynamodb scan --table-name ArtMedicaContactForm
