UserId: Entity[str] = EntityJson(
  type='User',
  path='$.author.id',
  coerce_type=True
)

EventType: Entity[str] = EntityJson(
  type='EventType',
  path='$.event_type',
  coerce_type=True
)

GuildId: Entity[str] = EntityJson(
  type='Guild',
  path='$.guild_id',
  coerce_type=True
)

ChannelId: Entity[str] = EntityJson(
  type='Channel',
  path='$.channel_id',
  coerce_type=True
)

Content: str = JsonData(
    path='$.content',
    coerce_type=True
)

ActionName=GetActionName()
