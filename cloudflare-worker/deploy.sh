#!/bin/bash

# Deploy Cloudflare Worker using API
# This script deploys the OpenAI proxy worker to Cloudflare

set -e

WORKER_NAME="curatr-openai-proxy"
SCRIPT_FILE="openai-proxy.js"

echo "🚀 Deploying Cloudflare Worker: $WORKER_NAME"

# Check if CLOUDFLARE_API_TOKEN is set
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
    echo "❌ Error: CLOUDFLARE_API_TOKEN environment variable is not set"
    exit 1
fi

# Get Account ID
echo "📋 Fetching Cloudflare account ID..."
ACCOUNT_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/accounts" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" | jq -r '.result[0].id')

if [ -z "$ACCOUNT_ID" ] || [ "$ACCOUNT_ID" = "null" ]; then
    echo "❌ Error: Could not fetch account ID. Check your API token permissions."
    exit 1
fi

echo "✅ Account ID: $ACCOUNT_ID"

# Deploy Worker
echo "📦 Deploying worker script..."
curl -X PUT "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/workers/scripts/$WORKER_NAME" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/javascript" \
  --data-binary "@$SCRIPT_FILE"

echo ""
echo "✅ Worker deployed successfully!"
echo "🌐 Worker URL: https://$WORKER_NAME.$ACCOUNT_ID.workers.dev"
echo ""
echo "⚠️  Don't forget to set the OPENAI_API_KEY secret:"
echo "   wrangler secret put OPENAI_API_KEY --name $WORKER_NAME"
