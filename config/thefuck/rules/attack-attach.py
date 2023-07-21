from thefuck.utils import for_app


def match(command):
    return ' attack ' in command


def get_new_command(command):
    return command.replace(' attack ', ' attach ')

