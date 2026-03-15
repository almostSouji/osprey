Import(
    rules=[
        'models/base.sml',
        'models/message/base.sml',
        'models/message/message_create.sml'
    ]
)

MentionsEveryone = RegexMatch(target=Content, pattern='@(?:everyone|here)')

MentionsEveryoneRule = Rule(
    when_all=[
        MentionsEveryone,
        ActionName=='message_create'
    ],
    description="Message mentions @everyone or @here"
)

WhenRules(
    rules_any=[MentionsEveryoneRule],
    then=[LabelAdd(entity=MessageId, label='has-everyone-mention')]
)

HasInvites = ListLength(list=InviteCodes) > 0
HasInvitesRule = Rule(
    when_all=[HasInvites],
    description="Message contains invite codes"
)

WhenRules(
    rules_any=[HasInvitesRule],
    then=[LabelAdd(entity=MessageId, label='has-invite')]
)

InviteEveryoneRule = Rule(
    when_all=[
        MentionsEveryone,
        HasInvites,
    ],
    description="Message mentions @everyone or @here and contains an invite"
)

WhenRules(
    rules_any=[InviteEveryoneRule],
    then=[
        LabelAdd(entity=MessageId, label='invite-spam'),
        LabelAdd(entity=AuthorId, label='invite-spam', expires_after=TimeDelta(days=7))
    ]
)
