import json
import subprocess


I3MSG = '/usr/bin/i3-msg'


def parse():
    mode = False
    if len(sys.argv) == 2:
        if sys.argv[1] == "move":
            mode = sys.argv[1]
        else:
            sys.exit("invalid parameter given")
    return mode


def main():
    result = subprocess.Popen([I3MSG, '-t', 'get_workspaces'],
                              stdout=subprocess.PIPE,
                              stdin=subprocess.PIPE)
    result = result.communicate()[0]
    data = json.loads(result)

    focused = filter(lambda x: x['focused'] == True, data)[0]
    maybeNext = filter(lambda x: x['visible'] == True, data)

    if maybeNext.index(focused) + 1 == len(maybeNext):
        nextWorkspace = 0
    else:
        nextWorkspace = maybeNext.index(focused) + 1

    if mode == "move":
        output = maybeNext[nextWorkspace]['output']
        subprocess.call([I3MSG, 'move workspace to output', output])
    else:
        subprocess.call([I3MSG, 'workspace', str(maybeNext[nextWorkspace]['num'])])


if __name__ == '__main__':
    main()
