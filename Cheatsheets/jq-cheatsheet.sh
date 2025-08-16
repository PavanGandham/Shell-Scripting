Jq cheatsheet
jq '.results[] | select(.name == "John") | {age}'      # Get age for 'John'
jq '.results[] | select(.name | contains("Jo"))'       # Get complete records for all names with 'Jo'
jq '.results[] | select(.name | test("Joe\s+Smith"))'  # Get complete records for all names matching PCRE regex 'Joe\+Smith'

jq -ne  #  Do not exit if jq is not able to parse a line