#!/usr/bin/env bash
set -euo pipefail

# Defaults (overridable via params or env)
DEFAULT_REGIONS="us-east-2 eu-west-1 ap-northeast-1"
DEFAULT_PROFILE="${AWS_PROFILE:-staging-ireland}"
DEFAULT_REQUIRE_STREAMING=true
output_file="bedrock_providers.csv"

usage() {
    cat <<'EOF'
Usage: fetch-available-model-providers.sh [options]
  -r, --regions "us-east-2 eu-west-1"   Space- or comma-separated regions (default: us-east-2 eu-west-1 ap-northeast-1)
  -p, --profile PROFILE                 AWS profile to use (default: staging-ireland or current AWS_PROFILE)
  -s, --require-streaming true|false    Filter only streaming-supported models (default: true)
  -h, --help                            Show this help
EOF
}

regions_str="$DEFAULT_REGIONS"
profile="$DEFAULT_PROFILE"
require_streaming="$DEFAULT_REQUIRE_STREAMING"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -r|--regions)
            regions_str="$2"
            shift 2
            ;;
        -p|--profile)
            profile="$2"
            shift 2
            ;;
        -s|--require-streaming)
            require_streaming="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done

# Normalize regions (accept comma or space separated)
regions_str="${regions_str//,/ }"
read -r -a regions <<<"$regions_str"
if [[ ${#regions[@]} -eq 0 ]]; then
    echo "No regions provided" >&2
    exit 1
fi

require_streaming_lc=$(printf '%s' "$require_streaming" | tr '[:upper:]' '[:lower:]')
case "$require_streaming_lc" in
    true|false) REQUIRE_STREAMING="$require_streaming_lc" ;;
    *)
        echo "--require-streaming must be true or false" >&2
        exit 1
        ;;
esac

export AWS_PROFILE="$profile"

# Validate profile exists (avoids silent empty results)
if [[ -n "$profile" ]]; then
    available_profiles=$(aws configure list-profiles 2>/dev/null || true)
    if [[ -z "$available_profiles" ]] || ! printf '%s\n' "$available_profiles" | grep -Fxq "$profile"; then
        echo "AWS profile '$profile' not found. Set an existing profile with --profile or export AWS_PROFILE." >&2
        exit 1
    fi
fi

# Header: Just Region and Provider
echo "region,providerName" > "$output_file"

for region in "${regions[@]}"; do
    echo "Processing $region..."

    response=$(aws bedrock list-foundation-models --region "$region" --output json || echo "{}")

    count=$(jq -r '(.modelSummaries // []) | length' <<<"$response")
    if [[ "$count" -eq 0 ]]; then
        echo "  No models found in $region."
        continue
    fi

    # 1. Select models based on streaming filter
    # 2. Extract only region and providerName
    # 3. Use 'unique' inside JQ or 'sort | uniq' in bash to remove duplicates
    jq -r \
        --arg region "$region" \
        --argjson require_streaming "$REQUIRE_STREAMING" \
        '
        .modelSummaries[]
        | select(
            ($require_streaming == false) or (.responseStreamingSupported == true)
          )
        | [ $region, .providerName ]
        | @csv
        ' <<<"$response" | sort | uniq >> "$output_file"
done

# Show providers available in ALL regions
num_regions=${#regions[@]}
regions_str=$(IFS=','; echo "${regions[*]}")
providers_list=$(awk -F',' -v n="$num_regions" '
    NR>1 {
        gsub(/"/, "", $2)
        count[$2]++
    }
    END {
        for (p in count) {
            if (count[p] == n) print p
        }
    }
' "$output_file" | sort)

echo "Done! Saved unique providers to $output_file"
echo "Providers available in ${regions_str}:"
echo "$providers_list"