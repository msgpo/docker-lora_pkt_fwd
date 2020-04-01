FROM debian:buster AS build

RUN apt update && apt install -y \
	build-essential \
	git

WORKDIR /

RUN git clone https://github.com/Lora-net/lora_gateway.git \
	&& cd lora_gateway \
	&& make

RUN git clone https://github.com/Lora-net/packet_forwarder.git \
  && cd packet_forwarder \
	&& make



FROM debian:buster

RUN apt update && apt install -y gettext-base

ENV APP_ROOT /app
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY --from=build /packet_forwarder/lora_pkt_fwd/lora_pkt_fwd $APP_ROOT/
COPY --from=build /packet_forwarder/lora_pkt_fwd/global_conf.json $APP_ROOT/
COPY --from=build /lora_gateway/reset_lgw.sh $APP_ROOT/

ENV SERVER_ADDRESS router.eu.thethings.network
ENV SERVER_PORT_UP 1700
ENV SERVER_PORT_DOWN 1700

ADD local_conf.json.tmpl $APP_ROOT/

ADD start.sh $APP_ROOT/
RUN chmod +x start.sh
CMD [ "./start.sh" ]
