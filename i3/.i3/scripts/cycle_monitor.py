import json
import subprocess

I3MSG = '/usr/bin/i3-msg'

result = subprocess.Popen([I3MSG, '-t', 'get_workspaces'], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
result = result.communicate()[0]
data = json.loads(result)

focused = filter(lambda x: x['focused'] == True, data)[0]
maybeNext = filter(lambda x: x['visible'] == True, data)

if maybeNext.index(focused) + 1 == len(maybeNext):
    nextWorkspace = 0
else:
    nextWorkspace = maybeNext.index(focused) + 1

subprocess.call([I3MSG, 'workspace', str(maybeNext[nextWorkspace]['num'])])
