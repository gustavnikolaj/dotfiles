var exec = require('child_process').exec;

exec('i3-msg -t get_workspaces', function (error, stdout, stderr) {

  var workspaces = JSON.parse(stdout),
      workspace_numbers = [],
      lowest = 1;

  workspaces.forEach(function (x) { workspace_numbers.push(x.num); });

  while (workspace_numbers.indexOf(lowest) !== -1){ lowest++; }

  exec('i3-msg workspace ' + lowest);

});
