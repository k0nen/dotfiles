def match(command):
    return "attack" in command.script.lower()

def get_new_command(command):
    return command.script.replace("attack", "attach")

enabled_by_default = True
