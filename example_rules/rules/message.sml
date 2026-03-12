Import(
    rules=[
        'models/base.sml',
        'models/message/base.sml'
    ]
)

Require(
    rule='models/message/message_create.sml',
    require_if=ActionName in ["message_create", "message_update"]
)

MessageDeleteRule = Rule(
    when_all=[ActionName == 'message_delete'],
    description="Message delete action"
)

WhenRules(
    rules_any=[MessageDeleteRule],
    then=[
        LabelAdd(entity=MessageId, label='deleted')
    ]
)
