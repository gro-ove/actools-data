#!/bin/zsh

node -e '
fs = require("fs");
var s = JSON.parse("" + fs.readFileSync("KunosSkins_src.json"));
var r = {};
for (var n in s){
  for (var k in s[n]){
    if (!r[k]) r[k] = [];
    for (var i of s[n][k]){
      r[k].indexOf(i) === -1 && r[k].push(i);
    }
  }
}

fs.writeFileSync("../Miscellaneous/KunosSkins.json", JSON.stringify(r))
' || read _