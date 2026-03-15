import re

from osprey.engine.executor.execution_context import ExecutionContext
from osprey.engine.udf.arguments import ArgumentsBase
from osprey.engine.udf.base import UDFBase


class ParseInvitesArguments(ArgumentsBase):
    text: str
    """Text to match against"""


class ParseInvites(UDFBase[ParseInvitesArguments, list[str]]):
    """
    Extract Discord invites code from a given text. Returns a list of invite codes. Does  not check validity apart from basic shape and length restrictions.
    """

    def execute(self, execution_context: ExecutionContext, arguments: ParseInvitesArguments) -> list[str]:
        pattern = r'(?:discord)?(?:(?:app)?\.com\/invite|\.gg(?:\/invite)?)\/(?P<code>[\w-]{2,50})'
        flags = re.IGNORECASE

        regex = re.compile(pattern, flags)

        return [m.group('code') for m in regex.finditer(arguments.text)]
