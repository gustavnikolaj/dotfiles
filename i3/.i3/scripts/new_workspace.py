import json
import subprocess
import sys


I3MSG = '/usr/bin/i3-msg'


def parse():
    mode = False
    if len(sys.argv) == 2:
        if sys.argv[1] == "window":
            mode = sys.argv[1]
        else:
            sys.exit("invalid parameter given")
    return mode


def main(mode):
    result = subprocess.Popen([I3MSG, '-t', 'get_workspaces'],
                              stdout=subprocess.PIPE, stdin=subprocess.PIPE)
    result = result.communicate()[0]
    data = json.loads(result)

    numbers = map(lambda x: x['num'], data)

    lowest = 1

    while lowest in numbers:
        lowest = lowest + 1

    if mode == "window":
        subprocess.call([I3MSG, 'move container to workspace', str(lowest)])

    subprocess.call([I3MSG, 'workspace', str(lowest)])


if __name__ == '__main__':
    args = parse()
    main(args)

