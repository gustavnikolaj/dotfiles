import json
import subprocess

I3MSG = '/usr/bin/i3-msg'

result = subprocess.Popen([I3MSG, '-t', 'get_workspaces'], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
result = result.communicate()[0]
data = json.loads(result)

numbers = map(lambda x: x['num'], data)

lowest = 1

while lowest in numbers:
    lowest = lowest + 1

subprocess.call([I3MSG, 'workspace', str(lowest)])
