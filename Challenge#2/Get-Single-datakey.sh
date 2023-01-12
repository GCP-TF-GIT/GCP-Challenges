#!/bin/bash
param=$1
META_FIELD=$(\
    curl "http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=json" -H "Metadata-Flavor: Google" \
    | python3 -c "import sys, json; print(json.load(sys.stdin)['attributes']['$param'])"
)
echo "METADATA=$META_FIELD"





