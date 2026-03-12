AuthorId: Entity[str] = EntityJson(
  type='User',
  path='$.author.id',
)

AuthorName: str = JsonData(path='$.author.username')
Content: str = JsonData(path='$.content')
