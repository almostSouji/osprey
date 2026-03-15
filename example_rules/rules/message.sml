Import(
    rules=[
        'models/base.sml',
        'models/message/base.sml'
    ]
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

Require(
    rule='models/message/message_create.sml',
    require_if=ActionName in ["message_create", "message_update"]
)

Require(
    rule='rules/message_create.sml',
    require_if=ActionName in ["message_create", "message_update"]
)
