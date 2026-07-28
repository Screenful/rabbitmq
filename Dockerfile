FROM rabbitmq:3.8.0-management

COPY rabbitmq.conf /etc/rabbitmq/
COPY monitor-queues.sh /usr/local/bin/monitor-queues.sh
COPY entrypoint-with-monitor.sh /usr/local/bin/entrypoint-with-monitor.sh

ENV RABBITMQ_NODENAME=rabbit@localhost

RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf
RUN chmod +x /usr/local/bin/monitor-queues.sh /usr/local/bin/entrypoint-with-monitor.sh
RUN chown rabbitmq:rabbitmq /usr/local/bin/monitor-queues.sh /usr/local/bin/entrypoint-with-monitor.sh

ENTRYPOINT ["/usr/local/bin/entrypoint-with-monitor.sh"]
CMD ["rabbitmq-server"]

USER rabbitmq:rabbitmq
