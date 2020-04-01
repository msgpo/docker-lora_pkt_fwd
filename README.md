### Running
`docker run --privileged --env GATEWAY_ID=<gateway id> wnagele/lora_pkt_fwd`

### Environment variables
Use `RESET_PIN` to configure a GPIO pin wired to the reset of the concentrator. If set a hard reset of the concentrator will be performed when the container starts up.

For configuration of the gateway you can adjust `SERVER_ADDRESS`, `SERVER_PORT_UP` and `SERVER_PORT_DOWN`.
