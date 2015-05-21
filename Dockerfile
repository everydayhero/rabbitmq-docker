FROM rabbitmq:3.5.2

ENV RABBITMQ_PLUGINS "rabbitmq_management rabbitmq_tracing rabbitmq_management_visualiser rabbitmq_shovel"
ENV RABBITMQ_HOME /var/lib/rabbitmq
# This is required so rabbitmqctl knows where to look for the Erlang cookie
ENV HOME $RABBITMQ_HOME

RUN rabbitmq-plugins enable --offline $RABBITMQ_PLUGINS

EXPOSE 15672

RUN apt-get update && apt-get install -y ruby python --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY bin/rabbitmqadmin /usr/local/bin/
COPY bin/rabbitmq-watcher /usr/local/bin/
COPY bin/rabbitmq-server-watcher /usr/local/bin/

CMD ["rabbitmq-server-watcher"]
