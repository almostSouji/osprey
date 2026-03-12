MessageId: Entity[str] = EntityJson(
    type='Message',
    path='$.id',
)

ChannelId: Entity[str] = EntityJson(
  type='Channel',
  path='$.channel_id',
)

GuildId: Entity[str] = EntityJson(
  type='Guild',
  path='$.guild_id',
  required=False
)
