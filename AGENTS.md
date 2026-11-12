# Agent Instructions for rabbitmq

Screenful-wide context (architecture, other repos, cross-repo rules) and the
shared PR workflow come from the `screenful` Claude Code plugin
(`Screenful/screenful-agents`), enabled in `.claude/settings.json`. This file
has what is specific to rabbitmq.

RabbitMQ (3.8 management image) running as a Render web service with a Render
disk. Every Screenful service uses it through the `screenful-polljobs`
exchange.

## Files
- `Dockerfile`, `rabbitmq.conf`, `render.yaml`: the deployment.
- `monitor-queues.sh` (started by `entrypoint-with-monitor.sh`): logs the
  queue count every 10 minutes and logs `SERROR` for each queue over
  `QUEUE_ALERT_THRESHOLD` messages (default 1000). Log alerts may match the
  `SERROR` string, so don't change it.

## Safety
- A change here redeploys the broker that all services depend on. Don't
  change the image version, disk or config without being asked, and say what
  restarts.
- There is no CI. Branch from `main` and open a PR to `main`.
