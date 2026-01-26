# fetch-available-models.sh

Fetch Bedrock foundation models across regions, filtering by providers available in all regions (via fetch-available-model-providers.sh) and optionally by streaming support.

## Prerequisites

- AWS CLI configured and logged in (SSO or static creds)
- `jq` installed
- Bedrock access in the selected regions

## Defaults

- Regions: `us-east-2 eu-west-1 ap-northeast-1`
- Profile: `staging-ireland` (or current `$AWS_PROFILE`)
- Streaming filter: `true` (only models with response streaming)
- Debug: `false`

## Usage

```bash
bash scripts/fetch-available-models.sh
```

This script uses the defaults baked into the file; it does not accept parameters.

## Examples

Run with defaults:

```bash
bash scripts/fetch-available-models.sh
```

## Behavior

- Queries Bedrock models per region using the default regions/profile in the script.
- Applies the streaming filter setting baked into the script.

## Output

- CSV: `bedrock_models.csv` with columns `region,providerName,modelName,modelId,modelLifecycle,streaming,inferenceTypesSupported`

## Common issues

- **Expired SSO token**: `aws sso login --profile <profile>`
- **Profile not found**: `aws configure list-profiles` and pick an existing profile
- **No models found**: credentials expired, region lacks Bedrock access, or filters exclude all models
