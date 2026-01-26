#!/usr/bin/env bash
set -euo pipefail

# --- Configuration ---
# Defaults (overridable via params or env)
DEFAULT_REGIONS="us-east-2 eu-west-1 ap-northeast-1"
DEFAULT_PROFILE="${AWS_PROFILE:-staging-ireland}"
DEFAULT_REQUIRE_STREAMING=true
output_file="bedrock_models.csv"

regions_str="$DEFAULT_REGIONS"
profile="$DEFAULT_PROFILE"
require_streaming="$DEFAULT_REQUIRE_STREAMING"

# Normalize regions (accept comma or space separated)
regions_str="${regions_str//,/ }"
read -r -a regions <<<"$regions_str"
if [[ ${#regions[@]} -eq 0 ]]; then
    echo "No regions provided" >&2
    exit 1
fi

export AWS_PROFILE="$profile"

# Validate profile exists (avoids silent empty results)
if [[ -n "$profile" ]]; then
    available_profiles=$(aws configure list-profiles 2>/dev/null || true)
    if [[ -z "$available_profiles" ]] || ! printf '%s\n' "$available_profiles" | grep -Fxq "$profile"; then
        echo "AWS profile '$profile' not found. Set an existing profile with --profile or export AWS_PROFILE." >&2
        exit 1
    fi
fi
# ---------------------

# Initialize file with the new header (added providerName and streaming)
echo "region,providerName,modelName,modelId,modelLifecycle,streaming,inferenceTypesSupported" > "$output_file"

for region in "${regions[@]}"; do
    echo "Processing $region..."

    # Fetch data (silence errors if region has no access)
    response=$(aws bedrock list-foundation-models --region "$region" --output json || echo "{}")

    # Validate we got data
    count=$(jq -r '(.modelSummaries // []) | length' <<<"$response")
    if [[ "$count" -eq 0 ]]; then
        echo "  No models found or access denied in $region. Skipping."
        continue
    fi

    # Parse with jq
    jq -r \
        --arg region "$region" \
        --argjson require_streaming "$require_streaming" \
        '
        .modelSummaries[]
        | select(
            # Logic: If require_streaming is false, allow all. 
            # If true, strictly check .responseStreamingSupported
            ($require_streaming == false) or (.responseStreamingSupported == true)
          )
                | [
                        $region,
                        .providerName,
                        .modelName,
                        .modelId,
                        .modelLifecycle.status,
                        .responseStreamingSupported,
                        (.inferenceTypesSupported // [] | join("|"))
                    ]
        | @csv
        ' <<<"$response" >> "$output_file"
done

echo "Done! Saved to $output_file"