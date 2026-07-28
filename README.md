# RabbitMQ on Render

This is a template repo for running a RabbitMQ instance as a **web service** on Render.

It uses the [official Dockerfile](https://hub.docker.com/_/rabbitmq) and backs RabbitMQ with a [Render disk](https://render.com/docs/disks), making it resilient to data loss in the case of restarts or deploys.

### Deployment

See https://render.com/docs/deploy-rabbitmq.

### Monitoring

The container includes a queue monitoring script that runs in the background.

It logs these lifecycle messages:
- Queue monitor started
- Queue monitor: check successfully finished

On each run, it:
- Reads all queues
- Prints the queue count as: Queue monitor: queue count=N
- Checks each queue length
- Prints an error for each queue over 1000 messages with the string SERROR

Schedule:
- First run: 20 seconds after startup
- Recurring run: every 10 minutes

Optional environment variables:
- QUEUE_ALERT_THRESHOLD (default: 1000)
- QUEUE_MONITOR_INITIAL_DELAY_SECONDS (default: 20)
- QUEUE_MONITOR_INTERVAL_SECONDS (default: 600)
