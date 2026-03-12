Import(
    rules=['models/base.sml']
)

Require(rule='models/base.sml')

Require(
    rule='rules/message.sml',
    require_if=RegexMatch(target=ActionName, pattern='^message_')
)
