Import(
  rules=[
    'models/base.sml',
  ]
)

ContainsHello = Rule(
  when_all=[
    TextContains(text=Content, phrase='hello')
  ],
  description='Post contains the word "hello"',
)

WhenRules(
  rules_any=[ContainsHello],
  then=[
    LabelAdd(entity=UserId, label='meow'),
  ],
)
