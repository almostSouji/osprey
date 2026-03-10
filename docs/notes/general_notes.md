# What's what

## Kafka

- OS system for event streaming
- https://kafka.apache.org/42/getting-started/introduction/
- publish (write) events (producers)
- subscribe (read) event streams (consumers)
- store event streams durably (topics)
- process event streams as they occur and retrospectively (per-topic expiry)
- TCP protocol

Test data generator executes:

```sh
echo -e "$action" | kafka-console-producer --broker-list osprey-kafka:29092 --topic osprey.actions_input
```

Where `action` refers to the single line JSON formatted payload

Potentially best to use https://kafka.js.org/docs/configuration for a JS/TS project

## Druid

- real-time analytics database
- https://druid.apache.org/

## ETCD

- Used by Discord to distribute rules without requiring deployment

## SML

## UDF

- User Defined Functions
- Written in Python
- Can be used in Rules
- Can be used in queries? (according to docs)

## Output Sink

- Handles Rule results and applies/writes them as needed
- Kafka publisher (queue) into Druid (DB)

## Verdict

# Resources

- Discord Blog: https://discord.com/blog/osprey-open-sourcing-our-rule-engine
- Haileys Rules: https://github.com/haileyok/atproto-ruleset
