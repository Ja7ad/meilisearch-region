#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed. Please install curl to run this script."
    exit 1
fi

# Define variables (use environment variables or defaults)
HOST=${HOST:-}
API_KEY=${API_KEY:-}

# Function to conditionally add the Authorization header
function get_auth_header() {
    if [[ -z "$API_KEY" ]]; then
        echo ""
    else
        echo "-H 'Authorization: Bearer $API_KEY'"
    fi
}

# Get the Authorization header
AUTH_HEADER=$(get_auth_header)

# Example curl commands with conditional Authorization header

# Create countries index
echo "Creating countries index..."
curl -s -X POST "$HOST/indexes" \
    $AUTH_HEADER \
    -H 'Content-Type: application/json' \
    --data-binary '{
        "uid": "countries",
        "primaryKey": "id"
    }'

# Update countries index settings
echo "Updating countries index settings..."
curl -s --location --request PATCH "$HOST/indexes/countries/settings" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '{
        "filterableAttributes": [
            "name",
            "iso3",
            "numeric_code",
            "iso2",
            "phone_code",
            "capital",
            "currency",
            "currency_symbol",
            "native",
            "tld",
            "region",
            "region_id",
            "subregion_id",
            "nationality",
            "timezones.zoneName",
            "timezones.gmtOffsetName",
            "_geo"
        ],
        "searchableAttributes": [
           "name",
            "iso3",
            "iso2",
            "capital",
            "native",
            "region",
            "translations.cn",
            "translations.de",
            "translations.es",
            "translations.fa",
            "translations.fr",
            "translations.hr",
            "translations.it",
            "translations.ja",
            "translations.kr",
            "translations.nl",
            "translations.pl",
            "translations.pt",
            "translations.pt-BR",
            "translations.ru",
            "translations.tr",
            "translations.uk"
        ],
        "sortableAttributes": [
             "name",
             "iso3",
            "iso2",
            "native",
            "id"
        ],
        "pagination": {
            "maxTotalHits": 250
        }
    }'

# Upload countries documents
echo "Uploading countries documents..."
curl -s --location --request PUT "$HOST/indexes/countries/documents" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '@./countries.json'

# Create states index
echo "Creating states index..."
curl -s --location "$HOST/indexes" \
    $AUTH_HEADER \
    -H 'Content-Type: application/json' \
    --data '{
        "uid": "states",
        "primaryKey": "id"
    }'

# Update states index settings
echo "Updating states index settings..."
curl -s --location --request PATCH "$HOST/indexes/states/settings" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '{
        "filterableAttributes": [
            "name",
            "country_id",
            "country_code",
            "country_name",
            "state_code",
            "_geo"
        ],
        "searchableAttributes": [
           "name"
        ],
        "sortableAttributes": [
             "name",
             "id"
        ],
        "pagination": {
            "maxTotalHits": 6000
        }
    }'

# Upload states documents
echo "Uploading states documents..."
curl -s --location --request PUT "$HOST/indexes/states/documents" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '@./states.json'

# Create cities index
echo "Creating cities index..."
curl -s --location "$HOST/indexes" \
    $AUTH_HEADER \
    -H 'Content-Type: application/json' \
    --data '{
        "uid": "cities",
        "primaryKey": "id"
    }'

# Update cities index settings
echo "Updating cities index settings..."
curl -s --location --request PATCH "$HOST/indexes/cities/settings" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '{
        "filterableAttributes": [
            "name",
            "country_id",
            "country_code",
            "country_name",
            "state_code",
            "state_id",
            "state_name",
            "id",
            "_geo"
        ],
        "searchableAttributes": [
           "name"
        ],
        "sortableAttributes": [
             "name",
             "id"
        ],
        "pagination": {
            "maxTotalHits": 200000
        }
    }'

# Upload cities documents
echo "Uploading cities documents..."
curl -s --location --request PUT "$HOST/indexes/cities/documents" \
    -H 'Content-Type: application/json' \
    $AUTH_HEADER \
    --data '@./cities.json'
