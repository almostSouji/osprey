# Rules

## Config

`/config/ui_config.yaml` declares default summary features and optionally augments features with external links:

```yaml
ui_config:
  default_summary_features:
    - actions: ["*"]
      features: ["UserId", "EventType"]
    - actions: ["message_create"]
      features: ["GuildId", "ChannelId", "Content"]
  external_links:
    User: "https://discord.com/users/{entity_id}"
    Guild: "https://discord.com/guilds/{entity_id}"
    Channel: "https://discord.com/channels/{entity_id}"
```
