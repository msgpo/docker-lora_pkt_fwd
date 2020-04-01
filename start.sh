#!/bin/sh
if [ -z "${GATEWAY_ID}" ]; then
  echo "GATEWAY_ID environment variable is required"
  exit 1
fi
envsubst < local_conf.json.tmpl > local_conf.json
if [ -n "${RESET_PIN}" ]; then
  ./reset_lgw.sh start ${RESET_PIN}
fi
exec ./lora_pkt_fwd
