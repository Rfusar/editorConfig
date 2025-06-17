from argparse import ArgumentParser

cmd = ArgumentParser(
    prog="<name_tool>",
    description="",
)

cmd.add_argument(
        "-","--",
        choices=[],
        action="",
        help="",
        required=False
)

args = cmd.parse_args()
