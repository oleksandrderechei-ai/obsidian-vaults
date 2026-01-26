# fetch-available-model-providers.sh

Fetch Bedrock foundation model providers across regions and list providers available in all specified regions.

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
bash scripts/fetch-available-model-providers.sh [options]
```

### Options

- `-r, --regions "us-east-2 eu-west-1"` space or comma separated list
- `-p, --profile PROFILE`
- `-s, --require-streaming true|false`
- `-d, --debug true|false`
- `-h, --help`

## Examples

- Custom regions:

```bash
bash scripts/fetch-available-model-providers.sh --regions "us-east-1,us-west-2,eu-central-1"
```

- Include non-streaming models:

```bash
bash scripts/fetch-available-model-providers.sh --require-streaming false
```

- Verbose logging:

```bash
bash scripts/fetch-available-model-providers.sh --debug true
```

## Output

- CSV: `bedrock_providers.csv` with columns `region,providerName`
- Stdout: providers available in all regions (one per line)

## Common issues

- **Expired SSO token**: `aws sso login --profile <profile>`
- **Profile not found**: `aws configure list-profiles` and pick an existing profile
