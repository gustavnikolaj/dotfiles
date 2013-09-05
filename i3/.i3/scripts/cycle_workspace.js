var exec = require('child_process').exec;

exec('i3-msg -t get_workspaces', function (error, stdout, stderr) {
  var workspaces = JSON.parse(stdout),
      current = workspaces.filter(function (x) { return x.focused })[0],
      maybeNext = workspaces.filter(function (x) { return x.output === current.output });
      next = ( maybeNext.indexOf(current) + 1 === maybeNext.length) ? 0 : maybeNext.indexOf(current) + 1;

  exec('i3-msg workspace ' + maybeNext[next].num);
});
