// 2>nul & node %0 "%1" "%2" "%3" "%4" "%5" || pause & goto :eof

var fs = require('fs');
var readline = require('readline');

var oo = eval('(' + fs.readFileSync(__dirname + '/Miscellaneous/Years.json') + ')');
var nn = JSON.parse('' + fs.readFileSync(process.argv[2]));

var co = [];

function combine(k){
  var o = oo[k] || (oo[k] = {});
  var n = nn[k] || (nn[k] = {});

  for (var j in n){
    if (!o[j]){
      o[j] = n[j];
    } else if (o[j] != n[j]) {
      co.push({ k: k, i: j, o: o[j], n: n[j] });
    }
  }
}

combine('cars');
combine('tracks');
combine('showrooms');

function save(){
  fs.writeFileSync(__dirname + '/Miscellaneous/Years.json', JSON.stringify(oo, null, 4).replace('    ', '\t'))
}

if (co.length > 0){
  console.log(`conflicts: ${co.length}`);

  var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  function next(){
    var cf = co[0];
    if (cf == null){
      save();
      rl.close();
      return;
    }

    rl.question(`${cf.i}: ${cf.o} → ${cf.n}? (y/n): `, a => {
      if (a == 'y'){
        nn[cf.k][cf.i] = cf.n;
        co = co.slice(1);
      } else if (a == 'n'){
        co = co.slice(1);
      } else {
        console.log('  “y" or "n”, please');
      }

      next();
    });
  }

  next();
} else {
  save();
}

// fs.copySync(process.argv[1], __dirname + '/temp.json');
